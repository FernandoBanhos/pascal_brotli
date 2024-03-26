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
 unit created for handled the livrary
}

unit brotlilib;

{$IFDEF FPC}
 {$MODE DELPHI}
 {$PACKRECORDS C}
{$ENDIF}

interface

uses
  {$IFDEF MSWINDOWS}
    Windows,
  {$ENDIF}
  {$IFDEF FPC}
    DynLibs,
  {$ENDIF}
  Classes, SysUtils, SyncObjs;

const
  {$IFDEF MSWINDOWS}
    BrotliCommon = 'brotlicommon.dll';
    BrotliEnc = 'brotlienc.dll';
    BrotliDec = 'brotlidec.dll';
  {$ENDIF}
  {$IFDEF LINUX};
    BrotliCommon = 'brotlicommon.so';
    BrotliEnc = 'brotlienc.so';
    BrotliDec = 'brotlidec.so';
  {$ENDIF}

type
  TBrotliSize = {$IFDEF CPU386} Integer {$ELSE} Int64 {$ENDIF};

  TBrotliEncoderMode = (BROTLI_MODE_GENERIC, BROTLI_MODE_TEXT, BROTLI_MODE_FONT);
  TBrotliEncoderOperation = (BROTLI_OPERATION_PROCESS, BROTLI_OPERATION_FLUSH,
                             BROTLI_OPERATION_FINISH, BROTLI_OPERATION_EMIT_METADATA);
  TBrotliEncoderParameter = (BROTLI_PARAM_MODE, BROTLI_PARAM_QUALITY, BROTLI_PARAM_LGWIN,
                             BROTLI_PARAM_LGBLOCK, BROTLI_PARAM_DISABLE_LITERAL_CONTEXT_MODELING,
                             BROTLI_PARAM_SIZE_HINT, BROTLI_PARAM_LARGE_WINDOW,
                             BROTLI_PARAM_NPOSTFIX, BROTLI_PARAM_NDIRECT,
                             BROTLI_PARAM_STREAM_OFFSET);



  TBrotliVersion = record
    Major: Cardinal;
    Minor: Cardinal;
    Patch: Cardinal;
  end;

  brotli_alloc_func = procedure(opaque : Pointer; size : integer);
  brotli_free_func = procedure(opaque, address : Pointer);

  PBrotliEncoderState = ^TBrotliEncoderState;
  TBrotliEncoderState = record
    alloc_func : brotli_alloc_func;
    free_func : brotli_free_func;
    opaque : Pointer;
  end;

  { TBrotli }

  TBrotli = record
  private
    class var FInitialized : boolean;
    class var FCritSession : TCriticalSection;
    class var FHandleCommon: TLibHandle;
    class var FHandleEncode: TLibHandle;
    class var FHandleDecode: TLibHandle;
    class function InternalLoadCommon(const ACommon: TFileName): TLibHandle; static;
    class function InternalLoadEncode(const AEncode: TFileName): TLibHandle; static;
    class function InternalLoadDecode(const ADecode: TFileName): TLibHandle; static;

  public
    class procedure Init; static;
    class procedure Done; static;

    class procedure Load(const ACommon, AEncode, ADecode: TFileName); static;
    class procedure Unload; static;
    class function IsLoaded: Boolean; static;
    class procedure Check; static;

    class property HandleCommon: TLibHandle read FHandleCommon;
    class property HandleEncode: TLibHandle read FHandleEncode;
    class property HandleDecode: TLibHandle read FHandleDecode;
  end;

const
  BROTLI_DEFAULT_MODE = Ord(TBrotliEncoderMode.BROTLI_MODE_GENERIC);
  BROTLI_DEFAULT_QUALITY = 11;
  BROTLI_DEFAULT_WINDOW = 22;
  BROTLI_MAX_INPUT_BLOCK_BITS = 24;
  BROTLI_MAX_QUALITY = 11;
  BROTLI_MAX_WINDOW_BITS = 24;
  BROTLI_MIN_INPUT_BLOCK_BITS = 16;
  BROTLI_MIN_QUALITY = 0;
  BROTLI_MIN_WINDOW_BITS = 10;

  BROTLI_FALSE = 0;
  BROTLI_TRUE = 1;

var
  // encode
  BrotliEncoderCreateInstance: function(const alloc_func, free_func, opaque: Pointer): Pointer; cdecl;
  BrotliEncoderDestroyInstance: procedure(const state: Pointer); cdecl;
  BrotliEncoderSetParameter: function(const state: Pointer;
                                      const BrotliEncoderParameter: TBrotliEncoderParameter;
                                      const Value: Cardinal): Integer; cdecl;
  BrotliEncoderMaxCompressedSize: function (const InputSize: Integer): Integer; cdecl;
  BrotliEncoderCompress: function(const quality: Integer; const lgwin: Integer;
                                   const mode: Integer; const input_size: TBrotliSize;
                                   const input_buffer: Pointer; out encoded_size: TBrotliSize;
                                   const encoded_buffer: Pointer): Integer; cdecl;
  BrotliEncoderCompressStream : function(state: Pointer;
                                         op: Integer;
                                         var available_in: TBrotliSize;
                                         next_in: Pointer;
                                         var available_out: TBrotliSize;
                                         next_out: Pointer;
                                         total_out: Pointer): Integer; cdecl;
  BrotliEncoderTakeOutput : function(const state : Pointer;
                                     var size : TBrotliSize) : Pointer; cdecl;
  BrotliEncoderHasMoreOutput : function(const state : pointer) : Integer; cdecl;
  BrotliEncoderIsFinished : function(const state : pointer) : Integer; cdecl;
  BrotliEncoderVersion: function : Cardinal; cdecl;

  // decode
  BrotliDecoderCreateInstance: function(const alloc_func, free_func, opaque: Pointer): Pointer; cdecl;
  BrotliDecoderDestroyInstance: procedure(const state: Pointer); cdecl;
  BrotliDecoderSetParameter: function(const state: Pointer;
                                      const BrotliDecoderParameter: Integer;
                                      const Value: Cardinal): Integer; cdecl;

  BrotliDecoderDecompress : function(encoded_size: TBrotliSize; const encoded_buffer:
                                      pointer; var decoded_size: TBrotliSize;
                                      decoded_buffer: pointer): Integer; cdecl;

  BrotliDecoderDecompressStream : function(const state: Pointer;
                                           var available_in: TBrotliSize;
                                           var next_in: Pointer;
                                           var available_out: TBrotliSize;
                                           var next_out: Pointer;
                                           total_out: Pointer): Integer; cdecl;
  BrotliDecoderGetErrorCode : function(const state: Pointer) : Integer; cdecl;
  BrotliDecoderErrorString : function(const errorcode : integer) : PChar; cdecl;
  BrotliDecoderVersion: function: Cardinal; cdecl;

  // common
  BrotliGetDictionary: procedure; cdecl;

  //utils
  function BrotliEncoderVersionStr : string;
  function BrotliDecoderVersionStr : string;

implementation

function ParseVersion(const AVersion: Cardinal): TBrotliVersion;
begin
  Result.Major := AVersion shr 24;
  Result.Minor := AVersion and $FFF000 shr 12;
  Result.Patch := AVersion and $FFF;
end;

function BrotliVersionString(const AVersion: TBrotliVersion): string;
begin
  Result := Format('%d.%d.%d', [AVersion.Major, AVersion.Minor, AVersion.Patch]);
end;

function BrotliEncoderVersionStr : string;
begin
  Result := BrotliVersionString(ParseVersion(BrotliEncoderVersion));
end;

function BrotliDecoderVersionStr : string;
begin
  Result := BrotliVersionString(ParseVersion(BrotliDecoderVersion));
end;

{ TBrotli }

class function TBrotli.InternalLoadCommon(const ACommon: TFileName): TLibHandle;
begin
  FCritSession.Acquire;
  try
    if FHandleCommon <> NilHandle then
      Exit(FHandleCommon);
    FHandleCommon := SafeLoadLibrary(ACommon);
    if FHandleCommon = NilHandle then
      Exit(NilHandle);

    BrotliGetDictionary := GetProcAddress(FHandleCommon, 'BrotliGetDictionary');

    Result := FHandleCommon;
  finally
    FCritSession.Release;
  end;
end;

class function TBrotli.InternalLoadEncode(const AEncode: TFileName): TLibHandle;
begin
  FCritSession.Acquire;
  try
    if FHandleEncode <> NilHandle then
      Exit(FHandleEncode);
    FHandleEncode := SafeLoadLibrary(AEncode);
    if FHandleEncode = NilHandle then
      Exit(NilHandle);

    BrotliEncoderSetParameter := GetProcAddress(FHandleEncode, 'BrotliEncoderSetParameter');
    BrotliEncoderCreateInstance := GetProcAddress(FHandleEncode, 'BrotliEncoderCreateInstance');
    BrotliEncoderDestroyInstance := GetProcAddress(FHandleEncode, 'BrotliEncoderDestroyInstance');
    BrotliEncoderMaxCompressedSize := GetProcAddress(FHandleEncode, 'BrotliEncoderMaxCompressedSize');
    BrotliEncoderCompress := GetProcAddress(FHandleEncode, 'BrotliEncoderCompress');
    BrotliEncoderCompressStream := GetProcAddress(FHandleEncode, 'BrotliEncoderCompressStream');
    BrotliEncoderTakeOutput := GetProcAddress(FHandleEncode, 'BrotliEncoderTakeOutput');
    BrotliEncoderHasMoreOutput := GetProcAddress(FHandleEncode, 'BrotliEncoderHasMoreOutput');
    BrotliEncoderIsFinished := GetProcAddress(FHandleEncode, 'BrotliEncoderIsFinished');
    BrotliEncoderVersion := GetProcAddress(FHandleEncode, 'BrotliEncoderVersion');

    Result := FHandleEncode;
  finally
    FCritSession.Release;
  end;
end;

class function TBrotli.InternalLoadDecode(const ADecode: TFileName): TLibHandle;
begin
  FCritSession.Acquire;
  try
    if FHandleDecode <> NilHandle then
      Exit(FHandleDecode);
    FHandleDecode := SafeLoadLibrary(ADecode);
    if FHandleDecode = NilHandle then
      Exit(NilHandle);

    BrotliDecoderCreateInstance := GetProcAddress(FHandleDecode, 'BrotliDecoderCreateInstance');
    BrotliDecoderDestroyInstance := GetProcAddress(FHandleDecode, 'BrotliDecoderDestroyInstance');
    BrotliDecoderSetParameter := GetProcAddress(FHandleDecode, 'BrotliDecoderSetParameter');
    BrotliDecoderDecompressStream := GetProcAddress(FHandleDecode, 'BrotliDecoderDecompressStream');
    BrotliDecoderVersion := GetProcAddress(FHandleDecode, 'BrotliDecoderVersion');
    BrotliDecoderDecompress := GetProcAddress(FHandleDecode, 'BrotliDecoderDecompress');
    BrotliDecoderGetErrorCode := GetProcAddress(FHandleDecode, 'BrotliDecoderGetErrorCode');
    BrotliDecoderErrorString := GetProcAddress(FHandleDecode, 'BrotliDecoderErrorString');

    Result := FHandleDecode;
  finally
    FCritSession.Release;
  end;
end;

class procedure TBrotli.Init;
begin
  if FInitialized then
    Exit;

  FInitialized := True;

  FCritSession := TCriticalSection.Create;
  InternalLoadCommon(BrotliCommon);
  InternalLoadEncode(BrotliEnc);
  InternalLoadDecode(BrotliDec);
end;

class procedure TBrotli.Done;
begin
  FCritSession.Acquire;
  try
    Unload;
  finally
    FCritSession.Release;
    FCritSession.Free;
  end;
end;

class procedure TBrotli.Load(const ACommon, AEncode, ADecode: TFileName);
begin
  if (ACommon = '') or (AEncode = '') or (ADecode = '') then
    raise EArgumentException.Create('Lib Brotli possui 3 livrarias');

  InternalLoadCommon(ACommon);
  InternalLoadEncode(AEncode);
  InternalLoadDecode(ADecode);
end;

class procedure TBrotli.Unload;
begin
  FCritSession.Acquire;
  try
    if (FHandleCommon <> NilHandle) and (not FreeLibrary(FHandleCommon)) then
      Exit;

    if (FHandleEncode <> NilHandle) and (not FreeLibrary(FHandleEncode)) then
      Exit;

    if (FHandleDecode <> NilHandle) and (not FreeLibrary(FHandleDecode)) then
      Exit;

    FHandleCommon := NilHandle;
    FHandleEncode := NilHandle;
    FHandleDecode := NilHandle;

    BrotliEncoderCreateInstance := nil;
    BrotliEncoderDestroyInstance := nil;
    BrotliEncoderSetParameter := nil;
    BrotliEncoderMaxCompressedSize := nil;
    BrotliEncoderCompress := nil;
    BrotliEncoderCompressStream := nil;
    BrotliEncoderTakeOutput := nil;
    BrotliEncoderHasMoreOutput := nil;
    BrotliEncoderIsFinished := nil;
    BrotliEncoderVersion := nil;

    // decode
    BrotliDecoderCreateInstance := nil;
    BrotliDecoderDestroyInstance:= nil;
    BrotliDecoderSetParameter := nil;
    BrotliDecoderDecompress := nil;
    BrotliDecoderDecompressStream := nil;
    BrotliDecoderGetErrorCode := nil;
    BrotliDecoderErrorString := nil;
    BrotliDecoderVersion := nil;

    // common
    BrotliGetDictionary := nil;
  finally
    FCritSession.Release;
  end;
end;

class function TBrotli.IsLoaded: Boolean;
begin
  FCritSession.Acquire;
  try
    Result := (FHandleCommon <> NilHandle) and
              (FHandleEncode <> NilHandle) and
              (FHandleDecode <> NilHandle);
  finally
    FCritSession.Release;
  end;
end;

class procedure TBrotli.Check;
begin
  if FHandleCommon = NilHandle then
    raise Exception.CreateFmt('Biblioteca %s não encontrada', [BrotliCommon]);

  if FHandleEncode = NilHandle then
    raise Exception.CreateFmt('Biblioteca %s não encontrada', [BrotliEnc]);

  if FHandleDecode = NilHandle then
    raise Exception.CreateFmt('Biblioteca %s não encontrada', [BrotliDec]);
end;

initialization
  TBrotli.FInitialized := False;
  TBrotli.Init;

finalization
  TBrotli.Done;

end.

