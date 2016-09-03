program BindingToUI;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form1},
  uBinding in 'Source\uBinding.pas',
  uTestBinding in 'Source\Test\uTestBinding.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
