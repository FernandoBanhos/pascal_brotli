program brotli_console;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp, brotlistream, bufstream
  { you can add units after this };

type

  { TBrotli }

  TBrotli = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
    procedure Compress; virtual;
    procedure Decompress; virtual;
  end;

{ TBrotli }

procedure TBrotli.DoRun;
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
  Terminate;
end;

constructor TBrotli.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TBrotli.Destroy;
begin
  inherited Destroy;
end;

procedure TBrotli.WriteHelp;
begin
  { add your help code here }
  Writeln('Usage:');
  WriteLn(' -h[elp] - To display this screen');
  WriteLn(' -c[ompress] - Compress a file');
  WriteLn(' -d[ecompress] - Decompress a file');
end;

procedure TBrotli.Compress;
var
  fl : TFileStream;
  brotli : TBrotliCompressionStream;
  filebuf : TBufferedFileStream;

  buffer : TBytes;
  vcount : integer;
begin
  fl := TFileStream.Create(Params[2], fmOpenRead or fmShareDenyWrite);
  filebuf := TBufferedFileStream.Create(Params[3], fmCreate);

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
  fl := TFileStream.Create(Params[2], fmOpenRead or fmShareDenyWrite);
  filebuf := TBufferedFileStream.Create(Params[3], fmCreate);

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

var
  Application: TBrotli;
begin
  Application:=TBrotli.Create(nil);
  Application.Title:='Brotli Console Demo';
  Application.Run;
  Application.Free;
end.

