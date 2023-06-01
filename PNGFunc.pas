unit PNGFunc;

interface
uses SysUtils, Dialogs, ExtCtrls, pngimage;

procedure InitPNG(w, h: integer);
procedure AssignPNG(img: TImage);
procedure PixelPNG(r, g, b, a: byte; x, y: integer);
procedure MovePNG(x, y: integer);
procedure ShowPNG;
procedure LoadPNG(f: string);
procedure SavePNG(f: string);

var
  PNG: TPNGImage = nil;
  alpha: PByteArray;
  alphawidth: integer;
  pic: TImage;

implementation

{ Create a blank 32-bit PNG. }

procedure InitPNG(w, h: integer);
begin
  if Assigned(PNG) then PNG.Free; // Clear previous PNG.
  PNG := TPNGImage.CreateBlank(COLOR_RGBALPHA,8,w,h); // Create 32-bit PNG.
  alpha := PNG.AlphaScanline[0]; // Pointer for alpha channel.
  alphawidth := Longint(PNG.AlphaScanline[1])-Longint(alpha); // Size of alpha for one line.
end;

{ Assign PNG to TImage object. }

procedure AssignPNG(img: TImage);
begin
  pic := img;
end;

{ Draw a single pixel on the PNG. }

procedure PixelPNG(r, g, b, a: byte; x, y: integer);
begin
  if (PNG.Header.ColorType = COLOR_RGBALPHA) and (x < PNG.Width) and (y < PNG.Height) then // Check pixel is on the image.
    begin
    PNG.Pixels[x,y] := r+(g shl 8)+(b shl 16); // Write RGB values.
    alpha[(y*alphawidth)+x] := a; // Write alpha value.
    end;
end;

{ Change position of PNG/TImage on screen. }

procedure MovePNG(x, y: integer);
begin
  pic.Left := x;
  pic.Top := y;
end;

{ Display the PNG on screen. }

procedure ShowPNG;
begin
  pic.Picture := nil; // Reset image.
  pic.Width := PNG.Width;
  pic.Height := PNG.Height;
  pic.Canvas.Draw(0,0,PNG); // Draw on screen.
end;

{ Load PNG from file. }

procedure LoadPNG(f: string);
begin
  if Assigned(PNG) then PNG.Free; // Clear previous PNG.
  if FileExists(f) then
    begin
    PNG := TPNGImage.Create; // Create empty PNG.
    PNG.LoadFromFile(f); // Load file.
    end
  else ShowMessage('File not found.');
end;

{ Save PNG to file. }

procedure SavePNG(f: string);
begin
  if Assigned(PNG) then PNG.SaveToFile(f); // Save PNG to file.
end;

end.