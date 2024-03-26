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

implementation

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
  vAvailableIn, vAvailableOut, vIn : TBrotliSize;
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
      Exit
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

      if (BrotliEncoderCompressStream(vState, vOperation, vAvailableIn, vInput,
                                      vAvailableOut, vOutput, nil)) = BROTLI_TRUE then
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

end.

