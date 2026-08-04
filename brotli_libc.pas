unit brotli_libc;

{$mode ObjFPC}{$H+}

interface

implementation

function memchr(const Ptr: Pointer; Value: Integer; Num: NativeUInt): Pointer; cdecl; public name 'memchr'; alias:'_memchr';
var
  P: PByte;
begin
  P := Ptr;
  while Num <> 0 do
  begin
    if P^ = Byte(Value) then
      Exit(P);
    Inc(P);
    Dec(Num);
  end;
  Result := nil;
end;

procedure exit(Code: Integer); cdecl; public name 'exit'; alias:'_exit';
begin
  system.Halt(Code);
end;

function log2(x: Double): Double; cdecl; public name 'log2'; alias:'_log2';
begin
  Result := Ln(x) / Ln(2.0);
end;

function memset(dest: Pointer; ch: LongInt; count: SizeUInt): Pointer; cdecl; public name 'memset'; alias:'_memset';
begin
  Result := dest;
  FillChar(dest^, count, ch);
end;

function memcpy(dest, src: Pointer; count: SizeUInt): Pointer; cdecl; public name 'memcpy'; alias:'memmove'; alias:'_memcpy'; alias:'_memmove';
begin
  Result:=dest;
  Move(src^, dest^, count);
end;

function calloc(num, size: SizeUInt): Pointer; cdecl; public name 'calloc'; alias:'_calloc';
begin
  Result:=AllocMem(num*size);
end;

function malloc(size: SizeUInt): Pointer; cdecl; public name 'malloc'; alias:'_malloc';
begin
  GetMem(Result, size);
end;

procedure free(ptr: Pointer); cdecl; public name 'free'; alias:'_free';
begin
  FreeMem(ptr);
end;

function udivdi3(num, den: uint64): uint64; cdecl; public alias: '___udivdi3';
begin
  Result := num div den;
end;

function divdi3(num, den: int64): int64; cdecl; public alias: '___divdi3';
begin
  Result := num div den;
end;

{$PUSH}
{$ASMMODE att}
procedure __chkstk; assembler; nostackframe; public name '__chkstk'; alias:'___chkstk_ms';
asm
{$IFDEF WIN64}
  push %rax
  push %rcx
  neg  %rax                // rax = frame low address
  add  %rsp, %rax          // "
  mov  %gs:(0x10), %rcx    // rcx = stack low address
  jmp  .L0
  .L0: sub  $0x1000, %rcx  // extend stack into guard page
  mov  %eax, (%rcx)        // commit page (two instruction bytes)
  .L1: cmp  %rax, %rcx
  ja   .L1
  pop  %rcx
  pop  %rax
  ret
{$ENDIF}
{$IFDEF WIN32}
  push %eax
  push %ecx
  neg  %eax                // eax = frame low address
  add  %esp, %eax          // "
  mov  %fs:(0x08), %ecx    // ecx = stack low address
  jmp  .L1
  .L0:	sub  $0x1000, %ecx // extend stack into guard page
  mov  %eax, (%ecx)        // commit page (two instruction bytes)
  .L1:	cmp  %eax, %ecx
  ja   .L0
  sub  %esp, %eax
  pop  %ecx
  pop  %eax
  ret
{$ENDIF}
end;
{$POP}

end.

