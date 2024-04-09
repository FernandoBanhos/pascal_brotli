unit umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, brotlistream;

type
  TfMain = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    esource: TEdit;
    etarget: TEdit;
    btarget: TSpeedButton;
    bCompress: TSpeedButton;
    bDecompress: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure bCompressClick(Sender: TObject);
    procedure bDecompressClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

procedure TfMain.bCompressClick(Sender: TObject);
var
  fl : TFileStream;
  brotli : TBrotliCompressionStream;
  filebuf : TBufferedFileStream;

  buffer : TBytes;
  vcount : integer;
begin
  fl := TFileStream.Create(esource.Text, fmOpenRead or fmShareDenyWrite);
  filebuf := TBufferedFileStream.Create(etarget.Text, fmCreate);

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

procedure TfMain.bDecompressClick(Sender: TObject);
var
  fl : TFileStream;
  brotli : TBrotliDecompressionStream;
  filebuf : TBufferedFileStream;

  buffer : TBytes;
  vcount : integer;
begin
  fl := TFileStream.Create(esource.Text, fmOpenRead or fmShareDenyWrite);
  filebuf := TBufferedFileStream.Create(etarget.Text, fmCreate);

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

end.
