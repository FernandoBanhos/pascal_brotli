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
  { TBrotliCompress }

  TBrotliCompress = class
  private
    FLevel : integer;
    FBufferMaxSize : Int64;
  protected
    function InternalDecompress(AStream : TStream) : TStream;
    function InternalCompress(AStream : TStream) : TStream;
  public
    constructor Create(const ALevel : integer = 5; const ABufferMaxSize : Int64 = 2097152);
    function CompressFile(AFileName : TFileName) : TStream;
    function CompressStream(AStream : TStream) : TStream ;

    function DecompressFile(AFileName : TFileName) : TStream;
    function DecompressStream(AStream : TStream) : TStream ;
  published
    property Level : integer read FLevel write FLevel;
  end;

  { TCustomBrotliStream }

  TCustomBrotliStream = class(TStream)
  private
    FSource : TStream;
  public
    constructor Create(ASource: TStream);
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
  end;

  { TBrotliCompressionStream }

  TBrotliCompressionStream = class(TCustomBrotliStream)
  protected
    FState: Pointer;
    FLevel: integer;
    FRawWritten: Int64;
    FCompressedWritten: Int64;
  public
    constructor Create(ALevel: integer; ADest: TStream);
    destructor Destroy; override;

    procedure Flush;
    function Write(const ABuffer; ACount: Longint): Longint; override;
  end;

  { TBrotliDecompressionStream }

  TBrotliDecompressionStream = class(TCustomBrotliStream)
  private
    FState: Pointer;
    FRawRead: int64;
    FLastResult : integer;
    FInput : Pointer;
    FNextIn : Pointer;
    FAvailableIn : NativeUInt;
    FTotalInput : NativeUInt;
    FMoreOutput : boolean;
  public
    constructor Create(ASource: TStream);
    destructor Destroy; override;
    function Read(var ABuffer; ACount: Longint): Longint; override;
  end;


implementation

{ TBrotliCompress }

function TBrotliCompress.InternalDecompress(AStream: TStream): TStream;
var
  vState : Pointer;
  vInput, vOutput : Pointer;
  vNextIn, vNextOut : Pointer;
  vResult : integer;
  vFileBufferSize : Integer;
  vAvailableIn, vAvailableOut, vOut : NativeUInt;
  vDecompressOK, vMoreOutput : boolean;
begin
  Result := TMemoryStream.Create;

  vFileBufferSize := FBufferMaxSize;
  if vFileBufferSize > AStream.Size then
    vFileBufferSize := AStream.Size;

  GetMem(vInput, vFileBufferSize);

  vOut := vFileBufferSize * 2;
  GetMem(vOutput, vOut);

  try
    vState := BrotliDecoderCreateInstance(nil, nil, nil);
    while AStream.Position < AStream.Size do
    begin
      vAvailableIn := AStream.Read(vInput^, vFileBufferSize);

      vNextIn := vInput;

      vMoreOutput := True;
      vDecompressOK := True;
      while (vDecompressOK and ((vAvailableIn > 0) or vMoreOutput)) do
      begin
        vAvailableOut := vOut;
        vNextOut := vOutput;

        vResult := BrotliDecoderDecompressStream(vState, vAvailableIn, @vNextIn,
                                                 vAvailableOut, @vNextOut, nil);
        vDecompressOK := vResult <> Ord(BROTLI_DECODER_RESULT_ERROR);
        vMoreOutput := BrotliDecoderHasMoreOutput(vState) = BROTLI_TRUE;

        if vDecompressOK then
          Result.Write(vOutput^, vOut - vAvailableOut);
      end;
    end;
    BrotliDecoderDestroyInstance(vState);
  finally
    Freemem(vInput);
    Freemem(vOutput);
  end;
end;

function TBrotliCompress.InternalCompress(AStream: TStream): TStream;
var
  vState : Pointer;
  vInput, vOutput : Pointer;
  vNextIn, vNextOut : Pointer;

  vFileBufferSize : Integer;
  vAvailableIn, vAvailableOut : NativeUInt;
  vOperation : TBrotliEncoderOperation;
  vCompressOK, vMoreOutput : boolean;
begin
  // code: https://github.com/google/brotli/issues/484

  Result := TMemoryStream.Create;
  Result.Size := AStream.Size;

  vFileBufferSize := FBufferMaxSize;
  if vFileBufferSize > AStream.Size then
    vFileBufferSize := AStream.Size;

  GetMem(vInput, vFileBufferSize);
  GetMem(vOutput, vFileBufferSize);

  try
    while AStream.Position < AStream.Size do
    begin
      vAvailableIn := AStream.Read(vInput^, vFileBufferSize);

      vState := BrotliEncoderCreateInstance(nil, nil, nil);
      try
        if BrotliEncoderSetParameter(vState, Ord(BROTLI_PARAM_QUALITY), FLevel) = 0 then
          Exit;
        if BrotliEncoderSetParameter(vState, Ord(BROTLI_PARAM_LGWIN), 22) = 0 then
          Exit;
        if BrotliEncoderSetParameter(vState, Ord(BROTLI_PARAM_STREAM_OFFSET), AStream.Position - vAvailableIn) = 0 then
          Exit;

        if AStream.Position >= AStream.Size then
          vOperation := BROTLI_OPERATION_FINISH
        else
          vOperation := BROTLI_OPERATION_FLUSH;

        vNextIn := vInput;

        vCompressOK := True;
        vMoreOutput := True;
        while (vCompressOK and ((vAvailableIn > 0) or vMoreOutput)) do
        begin
          vAvailableOut := vFileBufferSize;
          vNextOut := vOutput;

          vCompressOK := BrotliEncoderCompressStream(vState, Ord(vOperation),
                                                     vAvailableIn, @vNextIn,
                                                     vAvailableOut, @vNextOut, nil) = BROTLI_TRUE;
          vMoreOutput := BrotliEncoderHasMoreOutput(vState) = BROTLI_TRUE;
          Result.Write(vOutput^, vFileBufferSize - vAvailableOut);
        end;
      finally
        BrotliEncoderDestroyInstance(vState);
      end;
    end;
  finally
    Result.Size := Result.Position;
    Freemem(vInput);
    Freemem(vOutput);
  end;
end;

constructor TBrotliCompress.Create(const ALevel: integer; const ABufferMaxSize : Int64);
begin
  inherited Create;
  if ALevel > BROTLI_MAX_QUALITY then
    FLevel := BROTLI_MAX_QUALITY
  else if ALevel < BROTLI_MIN_QUALITY then
    FLevel := BROTLI_MIN_QUALITY
  else
    FLevel := ALevel;

  FBufferMaxSize := ABufferMaxSize;
end;

function TBrotliCompress.CompressStream(AStream : TStream) : TStream;
begin
  AStream.Position := 0;
  Result := InternalCompress(AStream);
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
  vStream : TFileStream;
begin
  vStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    vStream.Position := 0;
    Result := InternalCompress(vStream);
  finally
    FreeAndNil(vStream);
  end;
end;

{ TCustomBrotliStream }

constructor TCustomBrotliStream.Create(ASource: TStream);
begin
  Assert(ASource <> nil);
  inherited Create;
  FSource := ASource;
end;

function TCustomBrotliStream.Seek(const Offset: Int64;
  Origin: TSeekOrigin): Int64;
begin
  if (Offset = 0) and (Origin = soCurrent) then
    Result := FSource.Position
  else
    inherited;
end;

{ TBrotliCompressionStream }

constructor TBrotliCompressionStream.Create(ALevel: integer; ADest: TStream);
begin
  inherited Create(ADest);

  if ALevel < BROTLI_MIN_QUALITY then
    FLevel := BROTLI_MIN_QUALITY
  else if ALevel > BROTLI_MAX_QUALITY then
    FLevel := BROTLI_MAX_QUALITY
  else
    FLevel := ALevel;

  FRawWritten := 0;
end;

destructor TBrotliCompressionStream.Destroy;
begin
  Flush;
  inherited Destroy;
end;

procedure TBrotliCompressionStream.Flush;
var
  vAvailableIn, vAvailableOut: NativeUInt;
  vOutput, vNextOut : Pointer;
  vOperation : TBrotliEncoderOperation;
  vCompressOK : boolean;
begin
  if not TBrotli.IsLoaded then
    Exit;

  vAvailableIn := 0;
  vOperation := BROTLI_OPERATION_FINISH;
  vAvailableOut := 1024;
  vOutput := GetMemory(vAvailableOut);
  vNextOut := vOutput;

  FState := BrotliEncoderCreateInstance(nil, nil, nil);
  try
    if BrotliEncoderSetParameter(FState, Ord(BROTLI_PARAM_QUALITY), FLevel) = 0 then
      Exit;
    if BrotliEncoderSetParameter(FState, Ord(BROTLI_PARAM_LGWIN), 22) = 0 then
      Exit;
    if BrotliEncoderSetParameter(FState, Ord(BROTLI_PARAM_STREAM_OFFSET), FRawWritten) = 0 then
      Exit;

    vCompressOK := BrotliEncoderCompressStream(FState, Ord(vOperation),
                                               vAvailableIn, nil,
                                               vAvailableOut, @vNextOut, nil) = BROTLI_TRUE;

    if vCompressOK then
      FSource.Write(vOutput^, 1024 - vAvailableOut)
    else
      raise Exception.Create('Error on finished compress');
  finally
    BrotliEncoderDestroyInstance(FState);
  end;
end;

function TBrotliCompressionStream.Write(const ABuffer; ACount: Longint): Longint;
var
  vOutput : Pointer;
  vNextIn, vNextOut : Pointer;
  vAvailableIn, vAvailableOut : NativeUInt;
  vCompressOK, vMoreOutput : boolean;
  vOperation : TBrotliEncoderOperation;
begin
  TBrotli.Check;

  if ACount > High(NativeUInt) then
  begin
    raise Exception.CreateFmt('The buffer size cannot exceed %d',[High(NativeUInt)]);
    Exit;
  end;

  vAvailableIn := ACount;
  Getmem(vOutput, ACount);

  FState := BrotliEncoderCreateInstance(nil, nil, nil);
  try
    if FState = nil then
      Exit;
    if BrotliEncoderSetParameter(FState, Ord(BROTLI_PARAM_QUALITY), FLevel) = 0 then
      Exit;
    if BrotliEncoderSetParameter(FState, Ord(BROTLI_PARAM_LGWIN), 22) = 0 then
      Exit;
    if BrotliEncoderSetParameter(FState, Ord(BROTLI_PARAM_STREAM_OFFSET), FRawWritten) = 0 then
      Exit;

    FRawWritten := FRawWritten + vAvailableIn;
    vOperation := BROTLI_OPERATION_FLUSH;

    vNextIn := @ABuffer;

    vCompressOK := True;
    vMoreOutput := True;
    while (vCompressOK and ((vAvailableIn > 0) or vMoreOutput)) do
    begin
      vAvailableOut := ACount;
      vNextOut := vOutput;

      vCompressOK := BrotliEncoderCompressStream(FState, Ord(vOperation),
                                                 vAvailableIn, @vNextIn,
                                                 vAvailableOut, @vNextOut, nil) = BROTLI_TRUE;
      vMoreOutput := BrotliEncoderHasMoreOutput(FState) = BROTLI_TRUE;
      FSource.Write(vOutput^, ACount - vAvailableOut);
    end;
  finally
    BrotliEncoderDestroyInstance(FState);
    Freemem(vOutput);
  end;
  Result := ACount;
end;

{ TBrotliDecompressionStream }

constructor TBrotliDecompressionStream.Create(ASource: TStream);
begin
  inherited Create(ASource);

  FState := BrotliDecoderCreateInstance(nil, nil, nil);
  if FState = nil then
    raise Exception.Create('Decoder not created');

  FLastResult := Ord(BROTLI_DECODER_RESULT_NEEDS_MORE_INPUT);
  FMoreOutput := False;
end;

destructor TBrotliDecompressionStream.Destroy;
begin
  BrotliDecoderDestroyInstance(FState);

  if FInput <> nil then
    Freemem(FInput);

  inherited Destroy;
end;

function TBrotliDecompressionStream.Read(var ABuffer; ACount: Longint): Longint;
var
  vNextOut : Pointer;
  vAvailableOut : NativeUInt;
  vDecompressOK : boolean;
  vError : integer;
  vErrorStr : String;
begin
  Result := 0;

  TBrotli.Check;

  if ACount > High(NativeUInt) then
  begin
    raise Exception.CreateFmt('The buffer size cannot exceed %d', [High(NativeUInt)]);
    Exit;
  end;

  if (FLastResult = Ord(BROTLI_DECODER_RESULT_NEEDS_MORE_INPUT)) and
     (not FMoreOutput) then
  begin
    FTotalInput := ACount;

    if FInput <> nil then
      Freemem(FInput);

    GetMem(FInput, FTotalInput);

    FAvailableIn := FSource.Read(FInput^, FTotalInput);
    FNextIn := FInput;
  end
  else if (FSource.Position >= FSource.Size) and (not FMoreOutput) then
  begin
    Exit;
  end;

  vDecompressOK := True;

  vAvailableOut := ACount;
  vNextOut := @ABuffer;

  FLastResult := BrotliDecoderDecompressStream(FState, FAvailableIn, @FNextIn,
                                               vAvailableOut, @vNextOut, nil);
  vDecompressOK := FLastResult <> Ord(BROTLI_DECODER_RESULT_ERROR);
  FMoreOutput := BrotliDecoderHasMoreOutput(FState) = BROTLI_TRUE;

  if not vDecompressOK then
  begin
    vError := BrotliDecoderGetErrorCode(FState);
    vErrorStr := BrotliDecoderErrorString(vError);
    raise Exception.CreateFmt('%d %s',[vError, vErrorStr]);
  end
  else
  begin
    Result := ACount - vAvailableOut;
    FRawRead := FRawRead + Result;
  end;
end;

end.

