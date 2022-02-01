unit Generic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, ExtCtrls, StdCtrls, pngimage;

type
  TForm1 = class(TForm)
    imgMain: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ShowPNG(w, h: integer);
    procedure PixelPNG(r, g, b, a: byte; x, y: integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  PNG: TPNGImage;
  alpha: PByteArray;
  alphawidth: integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  ShowPNG(320,224); // Show test pattern.
end;

procedure TForm1.ShowPNG(w, h: integer);
var i: integer;
begin
  PNG.Free; // Clear previous PNG.
  PNG := TPNGImage.CreateBlank(COLOR_RGBALPHA,8,w,h); // Create 32-bit PNG.
  alpha := PNG.AlphaScanline[0]; // Pointer for alpha channel.
  alphawidth := Longint(PNG.AlphaScanline[1])-Longint(alpha); // Size of alpha for one line.

  // Draw pixels here.
  for i := 0 to (w*h)-1 do PixelPNG(255,0,0,i div w,i mod w,i div w); // Test pattern.

  imgMain.Picture := nil; // Reset image.
  imgMain.Width := w;
  imgMain.Height := h;
  imgMain.Canvas.Draw(0,0,PNG); // Draw on screen.
end;

procedure TForm1.PixelPNG(r, g, b, a: byte; x, y: integer);
begin
  PNG.Pixels[x,y] := r+(g shl 8)+(b shl 16); // Write RGB values.
  alpha[(y*alphawidth)+x] := a; // Write alpha value.
end;

end.
