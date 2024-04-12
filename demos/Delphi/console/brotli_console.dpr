program brotli_console;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils,
  Classes,
  brotlistream;

type
  TBrotli = class(TObject)
  protected
    function HasOption(Const C : Char; Const S : String) : Boolean;
  public
    procedure Run;
    procedure WriteHelp; virtual;
    procedure Compress; virtual;
    procedure Decompress; virtual;
  end;

var
  Application: TBrotli;

{ TBrotli }

procedure TBrotli.Compress;
var
  fl : TFileStream;
  brotli : TBrotliCompressionStream;
  filebuf : TBufferedFileStream;

  buffer : TBytes;
  vcount : integer;
begin
  fl := TFileStream.Create(ParamStr(2), fmOpenRead or fmShareDenyWrite);
  filebuf := TBufferedFileStream.Create(ParamStr(3), fmCreate);

  if fl.Size > 10485760 then // 10MB
    SetLength(buffer, 10485760)
  else
    SetLength(buffer, fl.Size);

  try
    brotli := TBrotliCompressionStream.Create(5, filebuf);
    repeat
      vcount := fl.Read(buffer[0], Length(buffer));
      brotli.Write(buffer[0], vcount);
    until vcount = 0;
  finally
    fl.Free;
    brotli.Free;
    filebuf.Free;
  end;
end;

procedure TBrotli.Decompress;
var
  fl : TFileStream;
  brotli : TBrotliDecompressionStream;
  filebuf : TBufferedFileStream;

  buffer : TBytes;
  vcount : integer;
begin
  fl := TFileStream.Create(ParamStr(2), fmOpenRead or fmShareDenyWrite);
  filebuf := TBufferedFileStream.Create(ParamStr(3), fmCreate);

  if fl.Size > 10485760 then // 10MB
    SetLength(buffer, 10485760)
  else
    SetLength(buffer, fl.Size);

  try
    brotli := TBrotliDecompressionStream.Create(fl);
    repeat
      vcount := brotli.Read(buffer[0], Length(buffer));
      filebuf.Write(buffer[0], vcount);
    until vcount = 0;
  finally
    fl.Free;
    brotli.Free;
    filebuf.Free;
  end;
end;

function TBrotli.HasOption(const C: Char; const S: String): Boolean;
var
  i : integer;
begin
  i := 1;
  Result := False;
  while i <= ParamCount do begin
    if SameText(ParamStr(i), '-'+C) or
       SameText(ParamStr(i), '-'+S) then begin
      Result := True;
      Break;
    end;
    i := i + 1;
  end;
end;

procedure TBrotli.Run;
begin
  // parse parameters
  if HasOption('h', 'help') then
    WriteHelp
  else if HasOption('c', 'compress') and (ParamCount = 3) then
    Compress
  else if HasOption('d', 'decompress') and (ParamCount = 3) then
    Decompress
  else
    WriteLn('Invalid option or argument');

  { add your program here }

  // stop program loop
end;

procedure TBrotli.WriteHelp;
begin
  { add your help code here }
  Writeln('Usage:');
  WriteLn(' -h[elp] - To display this screen');
  WriteLn(' -c[ompress] - Compress a file');
  WriteLn(' -d[ecompress] - Decompress a file');
end;

begin
  try
    Application := TBrotli.Create;
    Application.Run;
    Application.Free;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
