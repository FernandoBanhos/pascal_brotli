unit brotli_libc;

interface

implementation

{$IFNDEF FPC}
  // === Shims de libc para o linker do Delphi (Win32) ===

  function malloc(size: NativeUInt): Pointer; cdecl;
  begin
    Result := AllocMem(size);
  end;

  procedure free(p: Pointer); cdecl;
  begin
    if p <> nil then
      FreeMem(p);
  end;

  function calloc(count, size: NativeUInt): Pointer; cdecl;
  begin
    Result := AllocMem(count * size);
  end;

  procedure memcpy(dest, src: Pointer; n: NativeUInt); cdecl;
  begin
    Move(src^, dest^, n);
  end;

  procedure memmove(dest, src: Pointer; n: NativeUInt); cdecl;
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

  procedure memset(dest: Pointer; val: Integer; n: NativeUInt); cdecl;
  begin
    FillChar(dest^, n, val);
  end;

  function memchr(s: Pointer; c: Integer; n: NativeUInt): Pointer; cdecl;
  var
    i: NativeUInt;
  begin
    for i := 0 to n - 1 do
      if PByte(NativeUInt(s) + i)^ = Byte(c) then
        Exit(Pointer(NativeUInt(s) + i));
    Result := nil;
  end;

  function log2(x: Double): Double; cdecl;
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

  // Probe de pilha — apenas retorna (Delphi já gerencia a pilha)
  procedure __chkstk_ms; cdecl;
  begin
    // no-op
  end;

{$ENDIF}

end.

