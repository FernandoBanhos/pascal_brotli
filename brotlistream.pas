{
  _                      _     _   _ 
 | |                    | |   | | (_)
 | |__    _ __    ___   | |_  | |  _ 
 | '_ \  | '__|  / _ \  | __| | | | |
 | |_) | | |    | (_) | | |_  | | | |
 |_.__/  |_|     \___/   \__| |_| |_|
                                     
 https://www.brotli.org
         
 Copyright (C) 2024 -  Fernando Castelano Banhos
 fernbanhos@gmail.com
 
 vs 1.0
 date: March 15, 2024		 
}

unit brotlistream;

interface

uses
  Classes, SysUtils, BrotliLib;

type
  TBrotliStream = record
    next_in : Pbyte;      { next input byte }
    avail_in : cardinal;  { number of bytes available at next_in }
    total_in : NativeInt; { total nb of input bytes read so far }

    next_out : Pbyte;      { next output byte should be put there }
    avail_out : cardinal;  { remaining free space at next_out }
    total_out : NativeInt; { total nb of bytes output so far }
  end;

  { TBrotliCompress }

  TBrotliCompress = class
  private
    FLevel : integer;
  protected
    function InternalCompress(AStream : TStream) : TStream;
    function InternalDecompress(AStream : TStream) : TStream;

    function InternalCompress2(AStream : TStream) : TStream;
  public
    constructor Create(const ALevel : integer = 5);
    function CompressFile(AFileName : TFileName) : TStream;
    function CompressStream(AStream : TStream) : TStream ;

    function DecompressFile(AFileName : TFileName) : TStream;
    function DecompressStream(AStream : TStream) : TStream ;
  published
    property Level : integer read FLevel write FLevel;
  end;

  { TCustomBrotliStream }

  TCustomBrotliStream = class(TOwnerStream)
  protected
    FStream: TBrotliStream;
    FBuffer: Pointer;
    FOnProgress: TNotifyEvent;
    procedure Progress(ASender: TObject);
    property OnProgress:Tnotifyevent read FOnProgress write FOnProgress;
  public
    constructor Create(AStream: TStream);
    destructor Destroy; override;
  end;

  { TBrotliCompressionStream }

  TBrotliCompressionStream = class(TCustomBrotliStream)
  private
    procedure ClearOutBuffer;
  protected
    FState: Pointer;
    FRawWritten: int64;
    FCompressedWritten: int64;
  public
    constructor Create(ALevel: integer; ADest: TStream);
    destructor Destroy; override;

    function Write(const ABuffer; ACount: Longint): Longint; override;
    procedure Flush;

    property OnProgress;
  end;

  { TBrotliDecompressionStream }

  TBrotliDecompressionStream = class(TCustomBrotliStream)
  protected
    FState: Pointer;
    FRawRead: int64;
    FCompressedRead: int64;
    procedure Reset;
    procedure InitDescompress;
    function GetPosition: int64; override;
  public
    constructor Create(ASource: TStream);
    destructor Destroy; override;
    function Read(var ABuffer; ACount: Longint): Longint; override;
    function Seek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64;  override;
    property OnProgress;
  end;


implementation

const
  BrotliBufSize = 16384;     {Size of the buffer used for temporarily storing
                            data from the child stream.}

{ TBrotliCompress }

function TBrotliCompress.InternalCompress(AStream: TStream): TStream;
var
  vOutSize: LongWord;
  vRes : integer;
begin
  Result := TMemoryStream.Create;

  Result.Size := AStream.Size;
  vOutSize := Result.Size;

  AStream.Position := 0;
  Result.Position := 0;

  vRes := BrotliEncoderCompress(FLevel, BROTLI_DEFAULT_WINDOW,
                                BROTLI_DEFAULT_MODE, AStream.Size,
                                TMemoryStream(AStream).Memory,
                                vOutSize, TMemoryStream(Result).Memory);

  if vRes = BROTLI_TRUE then
  begin
    AStream.Position := 0;
    Result.Position := 0;
    Result.Size := vOutSize;
  end;
end;

function TBrotliCompress.InternalDecompress(AStream: TStream): TStream;
var
  vOutSize: LongWord;
  vRes, vMult : integer;
begin
  Result := TMemoryStream.Create;

  vMult := 2;

  repeat
    Result.Size := AStream.Size * vMult;
    vOutSize := Result.Size;

    AStream.Position := 0;
    Result.Position := 0;

    vRes := BrotliDecoderDecompress(AStream.Size, TMemoryStream(AStream).Memory,
                                    vOutSize, TMemoryStream(Result).Memory);

    if vRes = BROTLI_TRUE then
    begin
      AStream.Position := 0;
      Result.Position := 0;
      Result.Size := vOutSize;
    end;
    vMult := vMult + 1;
  until vRes = BROTLI_TRUE;
end;

function TBrotliCompress.InternalCompress2(AStream: TStream): TStream;
var
  vState : Pointer;
  vInput, vOutput : Pointer;

  vFileBufferSize : Integer;
  vAvailableIn, vAvailableOut, vIn, vTotal : TBrotliSize;
  vOperation : integer;
begin
  Result := TMemoryStream.Create;
  Result.Size := AStream.Size;

  AStream.Position := 0;
  Result.Position := 0;

  vState := BrotliEncoderCreateInstance(nil, nil, nil);
  try
    vFileBufferSize := 65536;

    if BrotliEncoderSetParameter(vState, BROTLI_PARAM_QUALITY, 5) = 0 then
      Exit;
    if BrotliEncoderSetParameter(vState, BROTLI_PARAM_LGWIN, 22) = 0 then
      Exit;
    if BrotliEncoderSetParameter(vState, BROTLI_PARAM_STREAM_OFFSET, 65536) = 0 then
      Exit;

    vAvailableOut := 0;
    GetMem(vInput, vFileBufferSize);

    while (True) do
    begin
      vAvailableIn := AStream.Read(vInput^, vFileBufferSize);
      vIn := vAvailableIn;

      vAvailableOut := vAvailableOut + vFileBufferSize;
      GetMem(vOutput, vAvailableOut);

      if AStream.Position >= AStream.Size then
        vOperation := 2  //BROTLI_OPERATION_FINISH
      else
        vOperation := 0; //BROTLI_OPERATION_PROCESS;

      if (BrotliEncoderCompressStream(vState, BROTLI_OPERATION_PROCESS, vAvailableIn, vInput,
                                      vAvailableOut, vOutput, vTotal)) = BROTLI_TRUE then
      begin
        if vAvailableIn = 0 then
          Result.Write(vOutput^, vIn - vAvailableOut);
      end;

      Freemem(vOutput);

      if BrotliEncoderIsFinished(vState) = BROTLI_TRUE then
        Break;
    end;
  finally
    BrotliEncoderDestroyInstance(vState);
  end;
end;

constructor TBrotliCompress.Create(const ALevel: integer);
begin
  inherited Create;
  if ALevel > BROTLI_MAX_QUALITY then
    FLevel := BROTLI_MAX_QUALITY
  else if ALevel < BROTLI_MIN_QUALITY then
    FLevel := BROTLI_MIN_QUALITY
  else
    FLevel := ALevel;
end;

function TBrotliCompress.CompressStream(AStream : TStream) : TStream;
var
  vStream : TCustomMemoryStream;
  vFree : Boolean;
begin
  if AStream.InheritsFrom(TCustomMemoryStream) then
  begin
    vStream := TCustomMemoryStream(AStream);
    vFree := False;
  end
  else
  begin
    vStream := TMemoryStream.Create;
    vFree := True;
  end;

  try
    if vFree then
      vStream.CopyFrom(AStream, AStream.Size);
    Result := InternalCompress(vStream);
  finally
    if vFree then
      FreeAndNil(vStream);
  end;
end;

function TBrotliCompress.DecompressFile(AFileName: TFileName): TStream;
var
  vStream : TMemoryStream;
begin
  vStream := TMemoryStream.Create;
  try
    vStream.LoadFromFile(AFileName);
    vStream.Position := 0;
    Result := InternalDecompress(vStream);
  finally
    FreeAndNil(vStream);
  end;
end;

function TBrotliCompress.DecompressStream(AStream: TStream): TStream;
var
  vStream : TCustomMemoryStream;
  vFree : Boolean;
begin
  if AStream.InheritsFrom(TCustomMemoryStream) then
  begin
    vStream := TCustomMemoryStream(AStream);
    vFree := False;
  end
  else
  begin
    vStream := TMemoryStream.Create;
    vFree := True;
  end;

  try
    if vFree then
      vStream.CopyFrom(AStream, AStream.Size);
    Result := InternalDecompress(vStream);
  finally
    if vFree then
      FreeAndNil(vStream);
  end;
end;

function TBrotliCompress.CompressFile(AFileName: TFileName) : TStream;
var
  vStream : TMemoryStream;
begin
  vStream := TMemoryStream.Create;
  try
    vStream.LoadFromFile(AFileName);
    vStream.Position := 0;
    Result := InternalCompress(vStream);
  finally
    FreeAndNil(vStream);
  end;
end;

{ TCustomBrotliStream }

procedure TCustomBrotliStream.Progress(ASender: TObject);
begin
  if FOnProgress <> nil then
    FOnProgress(ASender);
end;

constructor TCustomBrotliStream.Create(AStream: TStream);
begin
  Assert(AStream <> nil);
  inherited Create(AStream);
  Getmem(FBuffer,BrotliBufSize);
end;

destructor TCustomBrotliStream.Destroy;
begin
  Freemem(FBuffer);
  inherited Destroy;
end;

{ TBrotliCompressionStream }

procedure TBrotliCompressionStream.ClearOutBuffer;
begin
  { Flush the buffer to the stream and update progress }
  FSource.WriteBuffer(FBuffer^, BrotliBufSize - FStream.avail_out);
  Inc(FCompressedWritten, BrotliBufSize - FStream.avail_out);
  Progress(Self);
  { reset output buffer }
  FStream.next_out := FBuffer;
  FStream.avail_out := BrotliBufSize;
end;

constructor TBrotliCompressionStream.Create(ALevel: integer; ADest: TStream);
begin
  inherited Create(ADest);
  FStream.next_out := FBuffer;
  FStream.avail_out := BrotliBufSize;

  if ALevel < BROTLI_MIN_QUALITY then
    ALevel := BROTLI_MIN_QUALITY
  else if ALevel > BROTLI_MAX_QUALITY then
    ALevel := BROTLI_MAX_QUALITY;

  FState := BrotliEncoderCreateInstance(nil, nil, nil);
  if FState <> nil then
  begin
    if BrotliEncoderSetParameter(FState, BROTLI_PARAM_QUALITY, ALevel) = BROTLI_FALSE then
      raise Exception.Create('Error Assigned BROTLI_PARAM_QUALITY');
    if BrotliEncoderSetParameter(FState, BROTLI_PARAM_STREAM_OFFSET, 4096) = BROTLI_FALSE then
      raise Exception.Create('Error Assigned BROTLI_PARAM_STREAM_OFFSET');
  end
  else
  begin
    raise Exception.Create('Error create encode instance');
  end;
end;

destructor TBrotliCompressionStream.Destroy;
begin
  try
    Flush;
  finally
    BrotliEncoderDestroyInstance(FState);
    inherited Destroy;
  end;
end;

function TBrotliCompressionStream.Write(const ABuffer; ACount: Longint): Longint;
var
  vLastAvail: Longint;
begin
  FStream.next_in := @ABuffer;
  FStream.avail_in := ACount;
  vLastAvail := ACount;
  while FStream.avail_in <> 0 do
  begin
    if FStream.avail_out = 0 then
      ClearOutBuffer;
    Inc(FRawWritten, vLastAvail - FStream.avail_in);
    vLastAvail := FStream.avail_in;

    if BrotliEncoderCompressStream(FState, BROTLI_OPERATION_PROCESS,
                                   FStream.avail_in, FStream.next_in,
                                   FStream.avail_out, FStream.next_out,
                                   FStream.total_out) = BROTLI_FALSE then
      raise Exception.Create('Encoder error');
  end;
  Inc(FRawWritten,vLastAvail - FStream.avail_in);
  Write := ACount;
end;

procedure TBrotliCompressionStream.Flush;
begin
  repeat
    if FStream.avail_out = 0 then
      ClearOutBuffer;

    if BrotliEncoderCompressStream(FState, BROTLI_OPERATION_FINISH,
                                   FStream.avail_in, FStream.next_in,
                                   FStream.avail_out, FStream.next_out,
                                   FStream.total_out) = BROTLI_FALSE then
      Break
    else
      raise Exception.Create('Encoder finish error');
  until False;
end;

{ TBrotliDecompressionStream }

procedure TBrotliDecompressionStream.Reset;
var
  err:smallint;
begin
  FSource.Seek(-FCompressedRead, soFromCurrent);
  FRawRead := 0;
  FCompressedRead := 0;
//  inflateEnd(Fstream);
  InitDecompress;
end;

procedure TBrotliDecompressionStream.InitDescompress;
begin
  FState := BrotliDecoderCreateInstance(nil, nil, nil);
  if FState = nil then
    raise Exception.Create('Decoder não create');
end;

function TBrotliDecompressionStream.GetPosition: int64;
begin
  Result := FRawRead;
end;

constructor TBrotliDecompressionStream.Create(ASource: TStream);
begin
  inherited Create(Asource);
  InitDescompress;
end;

destructor TBrotliDecompressionStream.Destroy;
begin
  BrotliDecoderDestroyInstance(FState);
  inherited Destroy;
end;

function TBrotliDecompressionStream.Read(var ABuffer; ACount: Longint): Longint;
var
  vLastAvail: Longint;
begin
  FStream.next_out := @ABuffer;
  FStream.avail_out := ACount;
  vLastAvail := ACount;
  while FStream.avail_out <> 0 do
  begin
    if FStream.avail_in = 0 then
    begin
      Fstream.next_in := FBuffer;
      FStream.avail_in := FSource.Read(FBuffer^, BrotliBufSize);
      Inc(FCompressedRead, FStream.avail_in);
      Inc(FRawRead, vLastAvail - FStream.avail_out);
      vLastAvail := FStream.avail_out;
      Progress(Self);
    end;
{
    err:=inflate(Fstream,Z_NO_FLUSH);
      if err=Z_STREAM_END then
        break;
      if err<>Z_OK then
        raise Edecompressionerror.create(zerror(err));
}
  end;
  Dec(FCompressedRead, FStream.avail_in);
  Inc(FRawRead, vLastAvail - FStream.avail_out);
  Read := ACount - FStream.avail_out;
end;

function TBrotliDecompressionStream.Seek(const AOffset: Int64;
  AOrigin: TSeekOrigin): Int64;
var
  vBuf, vOff: int64;
begin
  vOff := Offset;
  if AOrigin = soCurrent then
    Inc(vOff, FRawRead)
  else if (AOrigin = soEnd) or (vOff < 0) then
    raise Exception.Create('Decompress seek falhou');

  Seek := vOff;

  if vOff < FRawRead then
    Reset
  else
    Dec(vOff, FRawRead);

  while vOff > 0 do
  begin
    vBuf := vOff;
    if vBuf > BrotliBufSize then
      vBuf := BrotliBufSize;
    if Read(FBuffer^, vBuf) <> vBuf then
      raise Exception.Create('Decompress seek falhou');
    Dec(vOff, vBuf);
  end;
end;

end.

