unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  bufstream, brotlistream;

type

  { TForm1 }

  TForm1 = class(TForm)
    bCompress: TSpeedButton;
    bDecompress: TSpeedButton;
    btarget: TSpeedButton;
    esource: TEdit;
    etarget: TEdit;
    imgList: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    diagOpen: TOpenDialog;
    bSource: TSpeedButton;
    procedure bCompressClick(Sender: TObject);
    procedure bDecompressClick(Sender: TObject);
    procedure bSourceClick(Sender: TObject);
    procedure btargetClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.bCompressClick(Sender: TObject);
var
  fl : TFileStream;
  brotli : TBrotliCompressionStream;
  filebuf : TBufferedFileStream;

  buffer : TBytes;
  vcount : integer;
begin
  fl := TFileStream.Create(esource.Text, fmOpenRead or fmShareDenyWrite);
  filebuf := TBufferedFileStream.Create(etarget.Text, fmCreate);

  if fl.Size > 10485760 then // 1MB
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

procedure TForm1.bDecompressClick(Sender: TObject);
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

procedure TForm1.bSourceClick(Sender: TObject);
begin
  if diagOpen.Execute then
    esource.Text := diagOpen.FileName;
end;

procedure TForm1.btargetClick(Sender: TObject);
begin
  if diagOpen.Execute then
    etarget.Text := diagOpen.FileName;
end;

end.

