unit Generic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, ExtCtrls, StdCtrls, pngimage, PNGFunc;

type
  TForm1 = class(TForm)
    imgMain: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
begin
  InitPNG(320,224); // Create 320x224 32-bit PNG.
  AssignPNG(imgMain); // Assign PNG to image on form.

  // Draw pixels here.
  for i := 0 to (PNG.Width*PNG.Height)-1 do PixelPNG(255,0,0,i div PNG.Width,i mod PNG.Width,i div PNG.Width); // Test pattern.

  MovePNG(20,20); // Change position of PNG.
  ShowPNG; // Display PNG on form.
  SavePNG('test.png');
end;

end.
