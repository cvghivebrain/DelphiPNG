program Project1;

uses
  Forms,
  Generic in 'Generic.pas' {Form1},
  PNGFunc in 'PNGFunc.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
