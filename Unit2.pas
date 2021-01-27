unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls,FileCtrl, Grids, inifiles,
  XPMan, Menus, Crc32, JvExControls, JvComCtrls, Mask;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    ComboBox3: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    Tim1: TDateTimePicker;
    Tim2: TDateTimePicker;
    ComboBox4: TComboBox;
    LabeledEdit3: TLabeledEdit;
    CheckBox8: TCheckBox;
    Bevel2: TBevel;
    Bevel5: TBevel;
    RadioGroup1: TRadioGroup;
    XPManifest1: TXPManifest;
    Bevel6: TBevel;
    GroupBox2: TGroupBox;
    Bevel8: TBevel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    RG2: TRadioGroup;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    SG1: TStringGrid;
    Label6: TLabel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Label7: TLabel;
    SG2: TStringGrid;
    Button4: TButton;
    Button3: TButton;
    Button5: TButton;
    ip1: TJvIPAddress;
    chFTP: TCheckBox;
    GroupBox3: TGroupBox;
    ePass: TLabeledEdit;
    eUser: TLabeledEdit;
    eHost: TLabeledEdit;
    function ZPT (ip:string):boolean;
    function outTcp(stan:integer):string;
//    function inStan(stan:string):string;
    function Chesum(s: string): Longint;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure Tim1Change(Sender: TObject);
    procedure Tim2Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure SG1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure SG2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chFTPClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form2: TForm2;

implementation

uses UMain;

    type
      tcp_type=record
    ip:string;
    dir:string;
  end;



{$R *.dfm}

procedure UPv530;
  var
  ini:TMemIniFile; 
begin
  ini:=tmeminifile.Create(extractfilepath(application.ExeName)+'Properties.ini');
  try
    try

      ini.WriteInteger('IN_TCP','count',0);
      ini.WriteInteger('OUT_TCP','count',0);

      ini.UpdateFile;
      MainForm.addlog('Дані по заявках успішно поновлено для роботи в новій версії',1);

    except on e:exception do
      MainForm.addlog('Помилка при переході на нову версію'+#13#10+e.ClassName+' викликало помилку '+e.Message,0);
    end;
  finally
    ini.free;
  end;
end;

procedure UPv(version:string);
begin
  if version='5.2.0' then
    UPv530;

end;

function outStan(stan:string):string;
begin
result:='0';
  if stan='З''єднано'then
      result:='1';
  if stan='Вдало'then
      result:='2';
  if stan='Невдало'then
      result:='3';
  if stan='Не з''єднано'then
      result:='4';
end;

{function Tform2.inStan(stan:string):string;
begin
result:='0';
  if stan='Очікування'then
      result:='1';
  if stan='Прийнято'then
      result:='2';
  if stan='Відхилено'then
      result:='3';
  if stan='Не відправлено'then
      result:='4';
end;
}

procedure sendZ(chek,ip,dir,mask,k,ininame:string);
var
msg:string;
ini:tmeminifile;
begin
try
try
ini:=tmeminifile.Create(ininame);
    MainForm.TcpClient1.RemoteHost:=ip;
    MainForm.TcpClient1.RemotePort:='30000';
    MainForm.TcpClient1.Active:=true;
    if MainForm.TcpClient1.Connect then begin
      MainForm.TcpClient1.Sendln('tcpZ');
      msg:=MainForm.TcpClient1.Receiveln;
      if msg='ok' then begin
        MainForm.TcpClient1.Sendln(chek+';'+ip+';'+dir+';'+mask);
        MainForm.TcpClient1.Disconnect;
        ini.WriteInteger('OUT_TCP','stan_'+k,1);
      end else begin
      ini.WriteInteger('OUT_TCP','stan_'+k,4);
      MainForm.TcpClient1.Disconnect;
      end;
    end else begin
      ini.WriteInteger('OUT_TCP','stan_'+k,4);
      MainForm.TcpClient1.Disconnect;
    end;
except on e:exception do
    application.MessageBox(pchar(e.classname+' error - '+e.Message),'mover',mb_iconerror+mb_ok);
end;

ini.UpdateFile;
finally
ini.Free;
end;

end;

function TForm2.outTcp(stan:integer):string;
begin
  case stan of
    1:
      result:='З''єднано';
    2:
      result:='Вдало';
    3:
      result:='Невдало';
    4:
      result:='Не з''єднано';
    else
      result:='Невідомий стан';
  end;

end;

function tform2.Chesum(s: string): Longint;
 var
   i: integer;
   L: integer;
 begin
   Result := 0;
   l := Length(s);
   if l > 0 then
   begin
     for i := 1 to l do
       Inc(Result, Ord(s[i]));
   end;
 end;

procedure TForm2.chFTPClick(Sender: TObject);
begin
if chFTP.Checked then begin
    CheckBox8.Checked:=False;
    groupbox2.Enabled:=true;
    groupbox3.Enabled:=true;
    eUser.Enabled:=True;
    ePass.Enabled:=True;
    ip1.Enabled:=false;
    eHost.Enabled:=true;

    if form2.Active then
      eHost.SetFocus;
//    if eHost.Text='' then
//      eHost.Color:=clred
  end
  else begin
    eHost.Enabled:=false;
    eUser.Enabled:=False;
    ePass.Enabled:=False;
    eHost.Color:=clWindow;
  end;
end;

function tcp_str(s:string):tcp_type;
var
i:integer;
begin
  if (s[1]='\')and((s[2]='\')) then begin
    s:=copy(s,3,maxint);
    i:=pos('\',s);
    result.ip:=copy(s,1,i-1);
    result.dir:=copy(s,i+1,maxint);
  end
  else begin
    result.ip:='';
    result.dir:='';
  end;
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
var
open:TOpenDialog;
dir:string;
begin
if (combobox2.ItemIndex=1)or(combobox2.ItemIndex=2) then begin
      dir:=labelededit2.Text;
      SelectDirectory ('Оберіть папку місця призначення...', '', dir);
      if dir<>'' then
      labelededit2.Text:=dir;
    end;
    if (combobox2.ItemIndex=4) or (combobox2.ItemIndex=5) then begin
      open:=TOpenDialog.Create(self);
      try
      open.Filter:='Додатки (*.exe)|*.exe | Всі файли (*.*)|*.*';
      if open.execute then begin
        labelededit2.Text:=open.FileName;
      end;
      finally
        open.Free;
      end;
    end;
    if (combobox2.ItemIndex=7) then begin
      application.MessageBox('Як початкову назву можна використовувати теги:'+#13#10#13#10+'<*> - назва файлу з розширенням'+#13#10#13#10+'<*.> -  назва файлу без розширення'+#13#10#13#10+'<.*> - лише розширення','Mover',mb_iconInformation+mb_Ok);
    end;
 {   if (stringgrid1.Cells[4,stringgrid1.Row]='7') then begin
      MessageDlg('Для перейменування файлу використовуйте символ "%"'+#13#10+#13#10+'Наприклад:'+#13#10+'[старі символи]%[нові символи]', mtInformation, [mbOK], 0);
    end;
  }  
end;

procedure TForm2.ComboBox2Change(Sender: TObject);
begin
  if (combobox2.ItemIndex=3) or (combobox2.ItemIndex=8) then begin
    labelededit2.Enabled:=false;
    speedbutton1.Enabled:=false;
    labelededit2.EditLabel.Caption:='Шлях:';
    labelededit2.Width:=bevel5.Width-34;
    labelededit3.Visible:=false;
    radioGroup1.Enabled:=false;
    checkbox8.Enabled:=false;
    eUser.Enabled:=False;
    ePass.Enabled:=False;
    eHost.Enabled:=False;
    chFTP.Enabled:=False;
    ip1.Enabled:=false;
    labelededit2.ShowHint:=false;
  end;
  if (combobox2.ItemIndex=0) or(combobox2.ItemIndex=1) or (combobox2.ItemIndex=2)or(combobox2.ItemIndex=4) or (combobox2.ItemIndex=5) then begin
    labelededit2.Enabled:=true;
    speedbutton1.Enabled:=true;
    labelededit2.EditLabel.Caption:='Шлях:';
    labelededit2.Width:=bevel5.Width-34;
    labelededit3.Visible:=false;
    checkbox8.Enabled:=false;
    chFTP.Enabled:=False;
    radioGroup1.Enabled:=false;
    ip1.Enabled:=false;
    eUser.Enabled:=False;
    ePass.Enabled:=False;
    eHost.Enabled:=False;
    labelededit2.ShowHint:=false;
    if (combobox2.ItemIndex=1) or (combobox2.ItemIndex=2) then begin
      checkbox8.Enabled:=true;
      chFTP.Enabled:=True;
      radioGroup1.Enabled:=true;
      if checkbox8.Checked then
        ip1.Enabled:=true;
      if chFTP.Checked then begin
        eUser.Enabled:=true;
        ePass.Enabled:=True;
        eHost.Enabled:=true;
      end;

    end;
  end;
  if (combobox2.ItemIndex=6) then begin
    labelededit2.Enabled:=true;
    speedbutton1.Enabled:=false;
    labelededit2.EditLabel.Caption:='Текст повідомлення:';
    labelededit2.Width:=bevel5.Width-34;
    labelededit3.Visible:=false;
    checkbox8.Enabled:=false;
    chFTP.Enabled:=False;
    eUser.Enabled:=False;
    ePass.Enabled:=False;
    eHost.Enabled:=False;
    radioGroup1.Enabled:=false;
    ip1.Enabled:=false;
    labelededit2.ShowHint:=false;
  end;
  if (combobox2.ItemIndex=7) then begin
    labelededit2.Enabled:=true;
    speedbutton1.Enabled:=true;
    labelededit2.EditLabel.Caption:='Початкова назва:';
    labelededit2.Width:=((bevel5.Width-34) div 2)-14;
    labelededit3.Left:=labelededit2.Left+labelededit2.Width+27;
    labelededit3.Width:=labelededit2.Width;
    labelededit3.Visible:=true;
    label5.Left:=labelededit2.Left+labelededit2.Width+7;
    checkbox8.Enabled:=false;
    chFTP.Enabled:=False;
    eUser.Enabled:=False;
    ePass.Enabled:=False;
    eHost.Enabled:=False;
    radioGroup1.Enabled:=false;
    ip1.Enabled:=false;
    labelededit2.ShowHint:=true;

  end;

end;

procedure TForm2.ComboBox3Change(Sender: TObject);
begin
if (combobox3.ItemIndex=0) then begin
  checkbox1.Checked:=true;
  checkbox1.Enabled:=false;
  checkbox2.Checked:=true;
  checkbox2.Enabled:=false;
  checkbox3.Checked:=true;
  checkbox3.Enabled:=false;
  checkbox4.Checked:=true;
  checkbox4.Enabled:=false;
  checkbox5.Checked:=true;
  checkbox5.Enabled:=false;
  checkbox6.Checked:=true;
  checkbox6.Enabled:=false;
  checkbox7.Checked:=true;
  checkbox7.Enabled:=false;
end
else begin
  checkbox1.Enabled:=true;
  checkbox2.Enabled:=true;
  checkbox3.Enabled:=true;
  checkbox4.Enabled:=true;
  checkbox5.Enabled:=true;
  checkbox6.Enabled:=true;
  checkbox7.Enabled:=true;

end;


end;

procedure TForm2.ComboBox4Change(Sender: TObject);
begin
if (combobox4.ItemIndex=0) then begin
  tim1.Enabled:=false;
  tim2.Enabled:=false;
  tim2.Visible:=true;
  label1.Enabled:=false;
  label4.Enabled:=false;
  label4.Visible:=true;
  label1.Caption:='з:';
end;
if (combobox4.ItemIndex=1) then begin
  tim1.Enabled:=true;
  tim2.Visible:=false;
  label1.Enabled:=true;
  label4.Visible:=false;
  label1.Caption:='о:';
end;
if (combobox4.ItemIndex=2) then begin
  tim1.Enabled:=true;
  tim2.Enabled:=true;
  tim2.Visible:=true;
  label1.Enabled:=true;
  label4.Enabled:=true;
  label4.Visible:=true;
  label1.Caption:='з:';
end;

end;

procedure TForm2.Tim1Change(Sender: TObject);
begin
  if tim1.Time>tim2.Time then
    tim2.Time:=tim1.Time;

end;

procedure TForm2.Tim2Change(Sender: TObject);
begin
  if tim1.Time>tim2.Time then
    tim1.Time:=tim2.Time;
end;

function TForm2.ZPT (ip:string):boolean;
var
  msg:string;
begin
  result:=False;
  try
         MainForm.TcpClient1.RemoteHost:=ip;
        MainForm.TcpClient1.RemotePort:='30000';
        MainForm.TcpClient1.Active:=true;
        if MainForm.TcpClient1.Connect then begin
          MainForm.TcpClient1.Sendln('tcpZ');
          msg:=MainForm.TcpClient1.Receiveln;
          if msg='ok' then
            result:=True;
          MainForm.TcpClient1.Disconnect;
        end;
        MainForm.TcpClient1.Active:=false;   
    except
      MainForm.TcpClient1.Disconnect;
      MainForm.TcpClient1.Active:=false;
    end;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
var
  mask, ftp :string;
  ini:tmeminifile;
  i:integer;

begin
try
//----------------------0-------------------------------------------------------

  if pagecontrol1.ActivePageIndex=0 then
  if (checkbox8.Checked)and(ip1.Text='0.0.0.0')and((combobox2.ItemIndex=1)or(combobox2.ItemIndex=2)) then begin
    application.MessageBox('Невірна IP адреса отримувача','Mover',mb_iconWarning+mb_ok);
    exit; end
  else begin

    if combobox1.itemindex=-1 then
      MainForm.SG1.Cells[1,MainForm.SG1.Row]:=combobox1.Text
    else
      MainForm.SG1.Cells[1,MainForm.SG1.Row]:=inttostr(combobox1.itemindex+1);

    //MainForm.StringGrid1.Cells[1,MainForm.StringGrid1.Row]:=inttostr(combobox1.itemindex+1);

      MainForm.SG1.Cells[4,MainForm.SG1.Row]:=inttostr(combobox2.itemindex);
    if ((combobox2.itemindex=1)or(combobox2.itemindex=2))and (radioGroup1.ItemIndex=1) then
      MainForm.SG1.Cells[4,MainForm.SG1.Row]:=MainForm.SG1.Cells[4,MainForm.SG1.Row]+'.1';

    if combobox2.itemindex=7 then
      MainForm.SG1.Cells[2,MainForm.SG1.Row]:=labelededit2.Text+'%'+labelededit3.Text
    else
    if ((combobox2.itemindex=0)or(combobox2.itemindex=1)or(combobox2.itemindex=2))and(checkbox8.checked or chFTP.Checked) then begin
      if checkbox8.checked then      
        MainForm.SG1.Cells[2,MainForm.SG1.Row]:='\\'+ip1.Text+'\'+labelededit2.Text;
      if chFTP.Checked then  begin
        if eUser.Text='' then
          ftp:='ftp@'+eHost.Text
        else
          ftp:= 'ftp@'+eHost.Text+';'+eUser.Text+';'+ePass.Text;
        MainForm.SG1.Cells[2,MainForm.SG1.Row]:= ftp + '\'+labelededit2.Text;
      end;
    end
    else
      MainForm.SG1.Cells[2,MainForm.SG1.Row]:=labelededit2.Text;

      mask:=trim(labelededit1.Text);

    if combobox3.ItemIndex=1 then begin
      if checkbox1.Checked then
        mask:=mask+'<пн>';
      if checkbox2.Checked then
        mask:=mask+'<вт>';
      if checkbox3.Checked then
        mask:=mask+'<ср>';
      if checkbox4.Checked then
        mask:=mask+'<чт>';
      if checkbox5.Checked then
        mask:=mask+'<пт>';
      if checkbox6.Checked then
        mask:=mask+'<сб>';
      if checkbox7.Checked then
        mask:=mask+'<нд>';
    end;

    if combobox4.ItemIndex=1 then
      mask:=mask+'<'+formatdatetime('hh":"nn',tim1.Time)+'>';
    if combobox4.ItemIndex=2 then begin
      mask:=mask+'<'+formatdatetime('hh":"nn',tim1.Time)+'>';
      mask:=mask+'<'+formatdatetime('hh":"nn',tim2.Time)+'>';
    end;

    //-------------RECURS-----------------
    if rg2.ItemIndex=1 then
      mask:=mask+'<RECUR>';

    //--------FTP--------------
    if ((combobox2.itemindex=0)or(combobox2.itemindex=1)or(combobox2.itemindex=2))and(chFTP.checked) then
      mask:=mask+'<FTP>';

    //--------TCP--------------
    if ((combobox2.itemindex=0)or(combobox2.itemindex=1)or(combobox2.itemindex=2))and(checkbox8.checked) then begin
      mask:=mask+'<TCP>';
        try

          if ZPT(ip1.Text) then
            application.MessageBox(pChar('З''єднання з "'+ip1.Text+'" пройшло успішно!'),'Mover',mb_iconInformation+mb_ok)
          else
            application.MessageBox(pChar('Не вдлось з''єднатись з "'+ip1.Text+'" !'
            +#13#10+ 'Можливо на тому комп''ютері не запущена програма.'),'Mover',MB_ICONERROR+mb_ok);

        except
        end;

    end; 
    //--------end-TCP----------
    MainForm.SG1.Cells[3,MainForm.SG1.Row]:=mask;

  end;
//------------------------------end-0----------------------------------------------------

//--------------------------------1------------------------------------------------------
  if pagecontrol1.ActivePageIndex=1 then begin
    try
      try
        ini:=tmeminifile.create(extractfilepath(application.exename)+'Properties.ini');

        if (SG1.Cells[1,1]<>'') then begin
          for i:=1 to SG1.RowCount-1 do begin
            ini.WriteString('OUT_TCP','ip_'+inttostr(i),SG1.Cells[1,i]);
            ini.WriteString('OUT_TCP','dir_'+inttostr(i),SG1.Cells[3,i]);
            ini.WriteString('OUT_TCP','mask_'+inttostr(i),SG1.Cells[2,i]);
            ini.WriteString('OUT_TCP','time_'+inttostr(i),SG1.Cells[4,i]);
            ini.WriteString('OUT_TCP','stan_'+inttostr(i),SG1.Cells[5,i]);
          end;
          ini.Writeinteger('OUT_TCP','count',SG1.rowcount-1);
        end else
          ini.Writeinteger('OUT_TCP','count',0);


        if Pos('(',MainForm.Button7.Caption)<>0 then begin
          MainForm.Button7.Caption:=Copy(MainForm.Button7.Caption,1,Pos('(',MainForm.Button7.Caption)-2);
        end;

        if (SG2.Cells[1,1]<>'') then begin
          for i:=1 to SG2.RowCount-1 do begin
            ini.WriteString('IN_TCP','ip_'+inttostr(i),SG2.Cells[1,i]);
            ini.WriteString('IN_TCP','dir_'+inttostr(i),SG2.Cells[3,i]);
            ini.WriteString('IN_TCP','mask_'+inttostr(i),SG2.Cells[2,i]);
            ini.WriteString('IN_TCP','stan_'+inttostr(i),SG2.Cells[4,i]);
            ini.WriteInteger('IN_TCP','see_'+inttostr(i),0);
          end;
          ini.Writeinteger('IN_TCP','count',SG2.rowcount-1);
        end else
          ini.Writeinteger('IN_TCP','count',0);



        ini.UpdateFile;
      except on e:exception do
        MainForm.addlog(e.classname+' Викликало помилку: '+e.message,0);
      end;

    finally
      ini.Free;
    end;


  end;

//------------------------------end-1----------------------------------------------------

  form2.Close;
except on e:exception do
  MainForm.addlog(e.ClassName +' викликало помилку: '+e.Message,0);
  end
end;

procedure TForm2.CheckBox8Click(Sender: TObject);
begin
  if CheckBox8.Checked then begin
    chFTP.Checked:=False;
    eUser.Enabled:=False;
    ePass.Enabled:=False;
    eHost.Enabled:=False;
    groupbox2.Enabled:=true;
    groupbox3.Enabled:=true;
    ip1.Enabled:=true;
    if form2.Active then
      ip1.SetFocus;
    if ip1.Text='' then
      ip1.Color:=clred
  end
  else begin
    ip1.Enabled:=false;
    ip1.Color:=clWindow;
  end;
//application.MessageBox('задати місце призначення','Mover',mb_iconinformation+mb_ok);
end;

procedure TForm2.SG1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin

   if (SG1.Cells[0,arow]='n')and(ARow<>0) then begin
     SG1.Canvas.Brush.Color:=RGB(255,135,160);
     SG1.Canvas.FillRect(Rect);
     //SG1.Canvas.Font.Color:=clGreen;
     SG1.Canvas.TextOut(Rect.Left,Rect.Top,SG1.Cells[Acol,Arow]);
    end;

  if acol=4 then begin     
    if SG1.Cells[5,arow]='2' then begin
      SG1.Canvas.Brush.Color:=clGreen;
      SG1.Canvas.FillRect(Rect);
      SG1.Canvas.TextOut(Rect.Left,Rect.Top,SG1.Cells[Acol,Arow]);
    end;
    if SG1.Cells[5,arow]='3' then begin
      SG1.Canvas.Brush.Color:=clRed;
      SG1.Canvas.FillRect(Rect);
      SG1.Canvas.TextOut(Rect.Left,Rect.Top,SG1.Cells[Acol,Arow]);
    end;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  SG1.Cells[0,0]:='№';
  SG1.Cells[1,0]:='IP';
  SG1.Cells[2,0]:='Маска';
  SG1.Cells[3,0]:='Шлях';
  SG1.Cells[4,0]:='Статус';
  SG1.Cells[5,0]:='ID';

  SG1.ColWidths[0]:=25;
  SG1.ColWidths[1]:=70;
  SG1.ColWidths[2]:=118;
  SG1.ColWidths[3]:=138;
  SG1.ColWidths[4]:=85;
  SG1.ColWidths[5]:=0;

  SG2.Cells[0,0]:='№';
  SG2.Cells[1,0]:='IP';
  SG2.Cells[2,0]:='Маска';
  SG2.Cells[3,0]:='Шлях';
  SG2.Cells[4,0]:='Статус';
  SG2.Cells[5,0]:='See';

  SG2.ColWidths[0]:=25;
  SG2.ColWidths[1]:=70;
  SG2.ColWidths[2]:=118;
  SG2.ColWidths[3]:=138;
  SG2.ColWidths[4]:=85;
  SG2.ColWidths[5]:=0;

  MainForm.for2;

      if MainForm.v<>MainForm.vers then
        UPv(MainForm.v);
end;

procedure TForm2.FormResize(Sender: TObject);
begin
 if (combobox2.ItemIndex=7) then begin
    labelededit2.Width:=((bevel5.Width-34) div 2)-14;
    labelededit3.Left:=labelededit2.Left+labelededit2.Width+27;
    labelededit3.Width:=labelededit2.Width;
    label5.Left:=labelededit2.Left+labelededit2.Width+7;
 end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  Form2.WindowState:=wsNormal;
end;

procedure TForm2.N1Click(Sender: TObject);
var
  I: Integer;
  e: boolean;
begin
e:=false;
  for I := 1 to MainForm.SG1.RowCount - 1 do begin
    if (MainForm.SG1.Cells[2,i]='\\'+SG1.Cells[1,SG1.Row]+
    '\'+SG1.Cells[3,SG1.Row])and
    (MainForm.SG1.Cells[3,i]=SG1.Cells[2,SG1.Row]) then begin
      form2.close;
      if i>7 then      
        MainForm.SG1.TopRow:=i-3
      else
        MainForm.SG1.TopRow:=1;

      MainForm.SG1.Selection := TGridRect(rect(1, i, 3, i));
      MainForm.SG1.Options:=MainForm.SG1.Options+[goRowselect];

      e:=true;
      break;
    end;
  end;

  if e=false then
      application.MessageBox('Запису для такої заявки не знайдено!','Mover',mb_iconInformation+mb_ok);

end;

procedure TForm2.SG2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
 if (SG2.Cells[5,arow]='1')and(ARow<>0) then begin
   SG2.Canvas.Brush.Color:=RGB(180,226,180);
   SG2.Canvas.FillRect(Rect);
   SG2.Canvas.Font.Color:=clGreen;
   SG2.Canvas.TextOut(Rect.Left,Rect.Top,SG2.Cells[Acol,Arow]);
 end;

  if (acol=4)and(ARow<>0) then begin
      SG2.Canvas.Brush.Color:=clSilver;
      SG2.Canvas.FillRect(Rect);
      SG2.Canvas.Font.Color:=clGreen;
      SG2.Canvas.TextOut(Rect.Left,Rect.Top,SG2.Cells[Acol,Arow]);
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
row,i:integer;
begin
row:=SG1.Row;
for i:=row to SG1.RowCount-1 do begin
  SG1.Rows[i]:=SG1.Rows[i+1];
  SG1.Cells[0,i]:=inttostr(i);
end;
  SG1.rows[SG1.RowCount].Clear;
  if SG1.RowCount<>2 then
 SG1.RowCount:=SG1.RowCount-1;

end;

procedure TForm2.Button4Click(Sender: TObject);
var
  row,i:integer;
begin
row:=SG2.Row;
for i:=row to SG2.RowCount-1 do begin
  SG2.Rows[i]:=SG2.Rows[i+1];
  SG2.Cells[0,i]:=inttostr(i);
end;
  SG2.rows[SG2.RowCount].Clear;
  if SG2.RowCount<>2 then
 SG2.RowCount:=SG2.RowCount-1;

end;

procedure TForm2.Button1Click(Sender: TObject);
var
  ip:string;
begin
  try
   case  (Sender as TButton).Tag of
    1: ip:=SG1.Cells[1,SG1.row];
    2: ip:=SG2.Cells[1,SG2.row];

   end;
    if ZPT(ip) then
       application.MessageBox(pChar('З''єднання з "'+ip+'" пройшло успішно!'),'Mover',mb_iconInformation+mb_ok)
    else
       application.MessageBox(pChar('Не вдалось з''єднатись з "'+ip+'" !'
       +#13#10+ 'Можливо на тому комп''ютері не запущена програма.'),'Mover',MB_ICONERROR+mb_ok);

  except
  end;

end;



procedure TForm2.Button3Click(Sender: TObject);
var
  i,j : integer;
  flg : Boolean;
begin

    try
      for I := 1 to SG1.RowCount - 1 do begin
        flg:=False;
        for j := 1 to MainForm.SG1.RowCount - 1 do
          if ('\\'+SG1.Cells[1,i]+'\'+SG1.Cells[3,i]+SG1.Cells[2,i])=MainForm.SG1.Cells[2,j]+MainForm.SG1.Cells[3,j] then begin
            flg:=True;
            Break;
          end;

        if flg then
          SG1.Cells[0,i]:='y'
        else
          SG1.Cells[0,i]:='n'
      end;   

    except
    end;


end;

end.



