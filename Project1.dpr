program Project1;

uses
  FastMM4 in 'FastMM4.pas',
  Forms,
  UMain in 'UMain.pas' {MainForm},
  Unit2 in 'Unit2.pas' {Form2},
  Crc32 in 'Crc32.pas',
  ULogPer in 'ULogPer.pas' {FormLP},
  moverserv in 'moverserv.pas',
  UFtp in 'UFtp.pas' {FTPparam};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Mover';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TForm2, Form2);
  Application.ShowMainForm:=False;
  Application.Run;
end.
