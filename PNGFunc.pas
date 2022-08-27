unit PNGFunc;

interface
uses ExtCtrls, pngimage;

procedure InitPNG(w, h: integer);
procedure AssignPNG(img: TImage);
procedure PixelPNG(r, g, b, a: byte; x, y: integer);
procedure ShowPNG;

var
  PNG: TPNGImage;
  alpha: PByteArray;
  alphawidth: integer;
  pic: TImage;

implementation

procedure InitPNG(w, h: integer);
begin
  PNG.Free; // Clear previous PNG.
  PNG := TPNGImage.CreateBlank(COLOR_RGBALPHA,8,w,h); // Create 32-bit PNG.
  alpha := PNG.AlphaScanline[0]; // Pointer for alpha channel.
  alphawidth := Longint(PNG.AlphaScanline[1])-Longint(alpha); // Size of alpha for one line.
end;

procedure AssignPNG(img: TImage);
begin
  pic := img;
end;

procedure PixelPNG(r, g, b, a: byte; x, y: integer);
begin
  if (x < PNG.Width) and (y < PNG.Height) then // Check pixel is on the image.
    begin
    PNG.Pixels[x,y] := r+(g shl 8)+(b shl 16); // Write RGB values.
    alpha[(y*alphawidth)+x] := a; // Write alpha value.
    end;
end;

procedure ShowPNG;
begin
  pic.Picture := nil; // Reset image.
  pic.Width := PNG.Width;
  pic.Height := PNG.Height;
  pic.Canvas.Draw(0,0,PNG); // Draw on screen.
end;

end.