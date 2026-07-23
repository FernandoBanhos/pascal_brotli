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
 unit created for handled the library
}

unit brotlilib;

{$IFDEF FPC}
 {$MODE DELPHI}
{$ENDIF}

{.$DEFINE LINKLIB}

{$IFDEF LINKLIB}
  {$IFDEF WIN32}
    {$LINKLIB 'libbrotli_win32.a'}
  {$ENDIF}
  {$IFDEF WIN64}
    {$LINKLIB 'libbrotli_win64.a'}
  {$ENDIF}
{$ELSE}
  {$PACKRECORDS C}
{$ENDIF}

interface

uses
  {$IFNDEF MSWINDOWS}
    {$IFDEF MSWINDOWS}
      Windows,
    {$ENDIF}
    {$IFDEF FPC}
      DynLibs,
    {$ENDIF}
  {$ENDIF}
  Classes, SysUtils, SyncObjs;

{$IFNDEF LINKLIB}
const
  {$IFDEF MSWINDOWS}
    BrotliCommon = 'brotlicommon.dll';
    BrotliEnc = 'brotlienc.dll';
    BrotliDec = 'brotlidec.dll';
  {$ENDIF}
  {$IFDEF LINUX}
    BrotliCommon = 'brotlicommon.so';
    BrotliEnc = 'brotlienc.so';
    BrotliDec = 'brotlidec.so';
  {$ENDIF}
{$ENDIF}

{$IFNDEF FPC}
const
  NilHandle = HMODULE(0);
{$ENDIF}

type
  {$IFNDEF FPC}
    TLibHandle = HMODULE;
  {$ENDIF}

  TBrotliEncoderMode = (BROTLI_MODE_GENERIC, BROTLI_MODE_TEXT, BROTLI_MODE_FONT);

  TBrotliEncoderOperation = (BROTLI_OPERATION_PROCESS, BROTLI_OPERATION_FLUSH,
                             BROTLI_OPERATION_FINISH, BROTLI_OPERATION_EMIT_METADATA);

  TBrotliEncoderParameter = (BROTLI_PARAM_MODE, BROTLI_PARAM_QUALITY, BROTLI_PARAM_LGWIN,
                             BROTLI_PARAM_LGBLOCK, BROTLI_PARAM_DISABLE_LITERAL_CONTEXT_MODELING,
                             BROTLI_PARAM_SIZE_HINT, BROTLI_PARAM_LARGE_WINDOW,
                             BROTLI_PARAM_NPOSTFIX, BROTLI_PARAM_NDIRECT,
                             BROTLI_PARAM_STREAM_OFFSET);

  TBrotliDecoderResult = (BROTLI_DECODER_RESULT_ERROR, BROTLI_DECODER_RESULT_SUCCESS,
                          BROTLI_DECODER_RESULT_NEEDS_MORE_INPUT,
                          BROTLI_DECODER_RESULT_NEEDS_MORE_OUTPUT);

  TBrotliDecoderParameter = (BROTLI_DECODER_PARAM_DISABLE_RING_BUFFER_REALLOCATION,
                             BROTLI_DECODER_PARAM_LARGE_WINDOW);

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
    {$IFNDEF LINKLIB}
      class var FCritSession : TCriticalSection;
      class var FHandleCommon: TLibHandle;
      class var FHandleEncode: TLibHandle;
      class var FHandleDecode: TLibHandle;
      class function InternalLoadCommon(const ACommon: TFileName): TLibHandle; static;
      class function InternalLoadEncode(const AEncode: TFileName): TLibHandle; static;
      class function InternalLoadDecode(const ADecode: TFileName): TLibHandle; static;
    {$ENDIF}
  public
    class procedure Init; static;
    class procedure Done; static;

    {$IFNDEF LINKLIB}
      class procedure Load(const ACommon, AEncode, ADecode: TFileName); static;
      class procedure Unload; static;
    {$ENDIF}
    class function IsLoaded: Boolean; static;
    class procedure Check; static;

    {$IFNDEF LINKLIB}
      class property HandleCommon: TLibHandle read FHandleCommon;
      class property HandleEncode: TLibHandle read FHandleEncode;
      class property HandleDecode: TLibHandle read FHandleDecode;
    {$ENDIF}
  end;

const
  BROTLI_DEFAULT_MODE = TBrotliEncoderMode.BROTLI_MODE_GENERIC;
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

{$IFNDEF LINKLIB}
var
  // encode
  BrotliEncoderCreateInstance: function(const alloc_func, free_func, opaque: Pointer): Pointer; cdecl;
  BrotliEncoderDestroyInstance: procedure(const state: Pointer); cdecl;
  BrotliEncoderSetParameter: function(const state: Pointer;
                                      const BrotliEncoderParameter: integer;
                                      const Value: Cardinal): Integer; cdecl;
  BrotliEncoderMaxCompressedSize: function (const InputSize: Integer): Integer; cdecl;
  BrotliEncoderCompress: function(const quality: Integer; const lgwin: Integer;
                                   const mode: Integer; const input_size: NativeUInt;
                                   const input_buffer: Pointer; out encoded_size: NativeUInt;
                                   const encoded_buffer: Pointer): Integer; cdecl;
  BrotliEncoderCompressStream : function(state: Pointer;
                                         op: integer;
                                         var available_in: NativeUInt;
                                         next_in: Pointer;
                                         var available_out: NativeUInt;
                                         next_out: Pointer;
                                         total_out: Pointer): Integer; cdecl;
  BrotliEncoderTakeOutput : function(const state : Pointer;
                                     var size : NativeUInt) : Pointer; cdecl;
  BrotliEncoderHasMoreOutput : function(const state : pointer) : Integer; cdecl;
  BrotliEncoderIsFinished : function(const state : pointer) : Integer; cdecl;
  BrotliEncoderVersion: function : Cardinal; cdecl;

  // decode
  BrotliDecoderCreateInstance: function(const alloc_func, free_func, opaque: Pointer): Pointer; cdecl;
  BrotliDecoderAttachDictionary: function(const state: Pointer; dict_type : Pointer;
                                          data_size : NativeUInt; data : Pointer) : Integer; cdecl;
  BrotliDecoderDestroyInstance: procedure(const state: Pointer); cdecl;
  BrotliDecoderSetParameter: function(const state: Pointer;
                                      const BrotliDecoderParameter: integer;
                                      const Value: Cardinal): Integer; cdecl;

  BrotliDecoderDecompress : function(encoded_size: NativeUInt; const encoded_buffer:
                                      pointer; var decoded_size: NativeUInt;
                                      decoded_buffer: pointer): Integer; cdecl;

  BrotliDecoderDecompressStream : function(const state: Pointer;
                                           var available_in: NativeUInt;
                                           next_in: Pointer;
                                           var available_out: NativeUInt;
                                           next_out: Pointer;
                                           total_out: Pointer): integer; cdecl;
  BrotliDecoderGetErrorCode : function(const state: Pointer) : Integer; cdecl;
  BrotliDecoderHasMoreOutput : function(const state: Pointer) : Integer; cdecl;
  BrotliDecoderErrorString : function(const errorcode : integer) : PChar; cdecl;
  BrotliDecoderIsUsed : function(const state: Pointer) : Integer; cdecl;
  BrotliDecoderTakeOutput : function(const state: Pointer; var size : NativeUInt) : Pointer; cdecl;
  BrotliDecoderVersion: function: Cardinal; cdecl;

  // common
  BrotliGetDictionary: procedure; cdecl;
{$ELSE}
  function BrotliEncoderCreateInstance(const alloc_func, free_func, opaque: Pointer): Pointer; cdecl; external name 'BrotliEncoderCreateInstance';
  procedure BrotliEncoderDestroyInstance(const state: Pointer); cdecl; external name 'BrotliEncoderDestroyInstance';
  function BrotliEncoderSetParameter(const state: Pointer;
                                     const BrotliEncoderParameter: integer;
                                     const Value: Cardinal): Integer; cdecl; external name 'BrotliEncoderSetParameter';
  function BrotliEncoderMaxCompressedSize(const InputSize: Integer): Integer; cdecl; external name 'BrotliEncoderMaxCompressedSize';
  function BrotliEncoderCompress(const quality: Integer; const lgwin: Integer;
                                 const mode: Integer; const input_size: NativeUInt;
                                 const input_buffer: Pointer; out encoded_size: NativeUInt;
                                 const encoded_buffer: Pointer): Integer; cdecl; external name 'BrotliEncoderCompress';
   function BrotliEncoderCompressStream(state: Pointer;
                                        op: integer;
                                        var available_in: NativeUInt;
                                        next_in: Pointer;
                                        var available_out: NativeUInt;
                                        next_out: Pointer;
                                        total_out: Pointer): Integer; cdecl; external name 'BrotliEncoderCompressStream';
  function BrotliEncoderTakeOutput(const state : Pointer;
                                   var size : NativeUInt) : Pointer; cdecl; external name 'BrotliEncoderTakeOutput';
  function BrotliEncoderHasMoreOutput(const state : pointer) : Integer; cdecl; external name 'BrotliEncoderHasMoreOutput';
  function BrotliEncoderIsFinished(const state : pointer) : Integer; cdecl; external name 'BrotliEncoderIsFinished';
  function BrotliEncoderVersion: Cardinal; cdecl; external name 'BrotliEncoderVersion';

  // decode
  function BrotliDecoderCreateInstance(const alloc_func, free_func, opaque: Pointer): Pointer; cdecl; external name 'BrotliDecoderCreateInstance';
  function BrotliDecoderAttachDictionary(const state: Pointer; dict_type : Pointer;
                                         data_size : NativeUInt; data : Pointer) : Integer; cdecl; external name 'BrotliDecoderAttachDictionary';
  procedure BrotliDecoderDestroyInstance(const state: Pointer); cdecl; external name 'BrotliDecoderDestroyInstance';
  function BrotliDecoderSetParameter(const state: Pointer;
                                     const BrotliDecoderParameter: integer;
                                     const Value: Cardinal): Integer; cdecl; external name 'BrotliDecoderSetParameter';

  function BrotliDecoderDecompress(encoded_size: NativeUInt; const encoded_buffer:
                                   pointer; var decoded_size: NativeUInt;
                                   decoded_buffer: pointer): Integer; cdecl; external name 'BrotliDecoderDecompress';

  function BrotliDecoderDecompressStream(const state: Pointer;
                                         var available_in: NativeUInt;
                                         next_in: Pointer;
                                         var available_out: NativeUInt;
                                         next_out: Pointer;
                                         total_out: Pointer): integer; cdecl; external name 'BrotliDecoderDecompressStream';
  function BrotliDecoderGetErrorCode(const state: Pointer) : Integer; cdecl; external name 'BrotliDecoderGetErrorCode';
  function BrotliDecoderHasMoreOutput(const state: Pointer) : Integer; cdecl; external name 'BrotliDecoderHasMoreOutput';
  function BrotliDecoderErrorString(const errorcode : integer) : PChar; cdecl; external name 'BrotliDecoderErrorString';
  function BrotliDecoderIsUsed(const state: Pointer) : Integer; cdecl; external name 'BrotliDecoderIsUsed';
  function BrotliDecoderTakeOutput(const state: Pointer; var size : NativeUInt) : Pointer; cdecl; external name 'BrotliDecoderTakeOutput';
  function BrotliDecoderVersion: Cardinal; cdecl; external name 'BrotliDecoderVersion';

  // common
  procedure BrotliGetDictionary; cdecl; external name 'BrotliGetDictionary';
{$ENDIF}

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
{$IFNDEF LINKLIB}
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
    BrotliDecoderAttachDictionary := GetProcAddress(FHandleDecode, 'BrotliDecoderAttachDictionary');
    BrotliDecoderDestroyInstance := GetProcAddress(FHandleDecode, 'BrotliDecoderDestroyInstance');
    BrotliDecoderSetParameter := GetProcAddress(FHandleDecode, 'BrotliDecoderSetParameter');
    BrotliDecoderDecompressStream := GetProcAddress(FHandleDecode, 'BrotliDecoderDecompressStream');
    BrotliDecoderVersion := GetProcAddress(FHandleDecode, 'BrotliDecoderVersion');
    BrotliDecoderDecompress := GetProcAddress(FHandleDecode, 'BrotliDecoderDecompress');
    BrotliDecoderGetErrorCode := GetProcAddress(FHandleDecode, 'BrotliDecoderGetErrorCode');
    BrotliDecoderHasMoreOutput := GetProcAddress(FHandleDecode, 'BrotliDecoderHasMoreOutput');
    BrotliDecoderErrorString := GetProcAddress(FHandleDecode, 'BrotliDecoderErrorString');
    BrotliDecoderIsUsed := GetProcAddress(FHandleDecode, 'BrotliDecoderIsUsed');
    BrotliDecoderTakeOutput := GetProcAddress(FHandleDecode, 'BrotliDecoderTakeOutput');

    Result := FHandleDecode;
  finally
    FCritSession.Release;
  end;
end;
{$ENDIF}

class procedure TBrotli.Init;
begin
  if FInitialized then
    Exit;

  FInitialized := True;

  {$IFNDEF LINKLIB}
    FCritSession := TCriticalSection.Create;
    InternalLoadCommon(BrotliCommon);
    InternalLoadEncode(BrotliEnc);
    InternalLoadDecode(BrotliDec);
  {$ENDIF}
end;

class procedure TBrotli.Done;
begin
  {$IFNDEF LINKLIB}
    FCritSession.Acquire;
    try
      Unload;
    finally
      FCritSession.Release;
      FCritSession.Free;
    end;
  {$ENDIF}
end;

{$IFNDEF LINKLIB}
class procedure TBrotli.Load(const ACommon, AEncode, ADecode: TFileName);
begin
    if (ACommon = '') or (AEncode = '') or (ADecode = '') then
      raise EArgumentException.Create('Brotli has 3 libraries');

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
{$ENDIF}

class function TBrotli.IsLoaded: Boolean;
begin
  {$IFNDEF LINKLIB}
    FCritSession.Acquire;
    try
      Result := (FHandleCommon <> NilHandle) and
                (FHandleEncode <> NilHandle) and
                (FHandleDecode <> NilHandle);
    finally
      FCritSession.Release;
    end;
  {$ELSE}
    Result := True;
  {$ENDIF}
end;

class procedure TBrotli.Check;
begin
  {$IFNDEF LINKLIB}
    if FHandleCommon = NilHandle then
      raise Exception.CreateFmt('Library %s not found', [BrotliCommon]);

    if FHandleEncode = NilHandle then
      raise Exception.CreateFmt('Library %s not found', [BrotliEnc]);

    if FHandleDecode = NilHandle then
      raise Exception.CreateFmt('Library %s not found', [BrotliDec]);
  {$ENDIF}
end;

initialization
  TBrotli.FInitialized := False;
  TBrotli.Init;

finalization
  TBrotli.Done;

end.


