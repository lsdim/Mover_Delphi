unit UFtp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TFTPparam = class(TForm)
    GroupBox1: TGroupBox;
    eUser: TLabeledEdit;
    ePass: TLabeledEdit;
    eDir: TLabeledEdit;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    eHost: TLabeledEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTPparam: TFTPparam;

implementation

uses
  UMain;

{$R *.dfm}

procedure TFTPparam.BitBtn1Click(Sender: TObject);
var
  ftp: string;
begin
  if Trim(eHost.Text) = '' then begin
    Application.MessageBox('Не вказано адресу FTP сервера!','Увага!',MB_ICONWARNING);
    Exit;
  end;


  if eUser.Text='' then
    ftp:='ftp@'+eHost.Text
  else
    ftp:= 'ftp@'+eHost.Text+';'+eUser.Text+';'+ePass.Text;
    MainForm.SG2.Cells[1,MainForm.SG2.Row]:= ftp + '\'+eDir.Text;

 Close();
end;

end.
