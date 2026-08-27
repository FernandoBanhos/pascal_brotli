unit brotli_libc;

interface

function _malloc(size: NativeUInt): Pointer; cdecl;
procedure _free(p: Pointer); cdecl;
function _calloc(count, size: NativeUInt): Pointer; cdecl;
procedure _memcpy(dest, src: Pointer; n: NativeUInt); cdecl;
procedure _memmove(dest, src: Pointer; n: NativeUInt); cdecl;
procedure _memset(dest: Pointer; val: Integer; n: NativeUInt); cdecl;
function _memchr(s: Pointer; c: Integer; n: NativeUInt): Pointer; cdecl;
function _log2(x: Double): Double; cdecl;
procedure _exit(status: Integer); cdecl;
procedure __chkstk_ms; cdecl;

implementation

function _malloc(size: NativeUInt): Pointer; cdecl;
begin
  Result := AllocMem(size);
end;

procedure _free(p: Pointer); cdecl;
begin
  if p <> nil then
    FreeMem(p);
end;

function _calloc(count, size: NativeUInt): Pointer; cdecl;
begin
  Result := AllocMem(count * size);
end;

procedure _memcpy(dest, src: Pointer; n: NativeUInt); cdecl;
begin
  Move(src^, dest^, n);
end;

procedure _memmove(dest, src: Pointer; n: NativeUInt); cdecl;
var
  i: NativeUInt;
begin
  if n = 0 then
    Exit;
  if (NativeUInt(dest) < NativeUInt(src)) or
     (NativeUInt(dest) >= NativeUInt(src) + n) then
    Move(src^, dest^, n)
  else
    for i := n downto 1 do
      PByte(NativeUInt(dest) + i - 1)^ :=
        PByte(NativeUInt(src) + i - 1)^;
end;

procedure _memset(dest: Pointer; val: Integer; n: NativeUInt); cdecl;
begin
  FillChar(dest^, n, val);
end;

function _memchr(s: Pointer; c: Integer; n: NativeUInt): Pointer; cdecl;
var
  i: NativeUInt;
begin
  for i := 0 to n - 1 do
    if PByte(NativeUInt(s) + i)^ = Byte(c) then
      Exit(Pointer(NativeUInt(s) + i));
  Result := nil;
end;

function _log2(x: Double): Double; cdecl;
begin
  if x <= 0 then
    Result := 0
  else
    Result := Ln(x) / Ln(2.0);
end;

procedure _exit(status: Integer); cdecl;
begin
  Halt(status);
end;

procedure __chkstk_ms; cdecl;
begin
  // no-op
end;

end.

