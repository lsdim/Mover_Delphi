unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sockets, StdCtrls,
  ShellApi, ExtCtrls, Menus, Grids,masks, ActnList,inifiles,idGlobal,
  Buttons, FileCtrl, winsock;

type
  TForm1 = class(TForm)
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Timer1: TTimer;
    N3: TMenuItem;
    N2: TMenuItem;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Button3: TButton;
    Button4: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    TcpServer1: TTcpServer;
    SpeedButton1: TSpeedButton;
    Edit2: TEdit;
    Label3: TLabel;
    procedure WriteParams;
    procedure ReadParams;
    procedure addlog(text:string);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
//    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1SelectCell(Sender: TObject; Col, Row: Integer;
  var CanSelect: Boolean);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure TcpServer1Accept(Sender: TObject;
      ClientSocket: TCustomIpClient);
    procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid2Click(Sender: TObject);
  private
    { Private declarations }
    nid : TNotifyIconData;
    procedure WMQueryEndSession(var Message: TWMQueryEndSession); message WM_QUERYENDSESSION;

  public
    { Public declarations }
    procedure IconCallBackMessage ( var Mess : TMessage ); message WM_USER + 100;
  end;

var
  Form1: TForm1;

implementation

type
  maskType = record
    nameMask:string;
    Day:integer;
    time:string;
    end;

var
namef:string;

{$R *.dfm}

procedure TrimWorkingSet;
var
MainHandle: THandle;
begin
if Win32Platform = VER_PLATFORM_WIN32_NT then
begin
MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
SetProcessWorkingSetSize(MainHandle, DWORD(-1), DWORD(-1));
CloseHandle(MainHandle);
end;
end;

function GetLocalIP: String;
const WSVer = $101;
var
  wsaData: TWSAData;
  P: PHostEnt;
  Buf: array [0..127] of Char;
begin
  Result := '';
  if WSAStartup(WSVer, wsaData) = 0 then begin
    if GetHostName(@Buf, 128) = 0 then begin
      P := GetHostByName(@Buf);
      if P <> nil then Result := iNet_ntoa(PInAddr(p^.h_addr_list^)^);
    end;
    WSACleanup;
  end;
end;



function mass(mask: string):maskType;
var
i:smallint;
newmask,d:string;
begin
i:=1;
result.Day:=0;

  while i<=length(mask) do begin
    if (mask[i]<>'+') then
     newmask:=newmask+mask[i]
    else begin
      d:='';
      inc(i);
      while mask[i]<>'+' do begin
        d:=d+mask[i];
        inc(i);
      end;
      if uppercase(d)='D' then begin
        d:=datetostr(date)[1]+datetostr(date)[2];
        newmask:=newmask+d;
      end;
      if uppercase(d)='D-1' then begin
        d:=inttostr(strtoint(datetostr(date)[1]+datetostr(date)[2])-1);
        newmask:=newmask+d;
      end;
      if uppercase(d)='D-2' then begin
        d:=inttostr(strtoint(datetostr(date)[1]+datetostr(date)[2])-2);
        newmask:=newmask+d;
      end;
      if uppercase(d)='M' then begin
        d:=datetostr(date)[4]+datetostr(date)[5];
        newmask:=newmask+d;
      end;
      if uppercase(d)='M-1' then begin
        d:=inttostr(strtoint(datetostr(date)[4]+datetostr(date)[5])-1);
        newmask:=newmask+d;
      end;
      if uppercase(d)='M-2' then begin
        d:=inttostr(strtoint(datetostr(date)[4]+datetostr(date)[5])-2);
        newmask:=newmask+d;
      end;
      if uppercase(d)='YY' then begin
        d:=datetostr(date)[9]+datetostr(date)[10];
        newmask:=newmask+d;
      end;
      if uppercase(d)='YYYY' then begin
        d:=datetostr(date)[7]+datetostr(date)[8]+datetostr(date)[9]+datetostr(date)[10];
        newmask:=newmask+d;
      end;
      if uppercase(d)='NAME' then begin
        d:=Namef;
        newmask:=newmask+d;
      end;

      if uppercase(d)='ПН' then result.Day:=1;
      if uppercase(d)='ВТ' then result.Day:=2;
      if uppercase(d)='СР' then result.Day:=3;
      if uppercase(d)='ЧТ' then result.Day:=4;
      if uppercase(d)='ПТ' then result.Day:=5;
      if uppercase(d)='СБ' then result.Day:=6;
      if uppercase(d)='НД' then result.Day:=7;

      if MatchesMask(d,'*:*') then result.time:=d;

    end;

  i:=i+1;
  end;

  result.nameMask:=newmask;

end;

function renam(mask: string):string;
var
i:smallint;
a,b:string;
begin
i:=1;

 while mask[i]<>'%' do begin
      a:=a+mask[i];
      inc(i);
 end;
 inc(i);
 while i<=length(mask) do begin
      b:=b+mask[i];
       inc(i);
      end;


 result:=StringReplace(Namef, a, b, [rfReplaceAll, rfIgnoreCase]);

end;


procedure tform1.addlog(text:string);
var
F: TextFile;
begin
  if Form1.CheckBox1.Checked=true then begin

  AssignFile(F, extractfilepath(application.exename)+'Moover.log');
 if not fileexists(extractfilepath(application.exename)+'Moover.log') then begin
    Rewrite(F);
    CloseFile(F);
    addlog(text);
    end else
if filesizebyname(extractfilepath(application.exename)+'Moover.log')<(strtoint(edit2.Text)*1024) then begin

    AssignFile(F, extractfilepath(application.exename)+'Moover.log');
 if fileexists(extractfilepath(application.exename)+'Moover.log') then
   append(f) else Rewrite(F);
   WriteLn(F,datetostr(now)+' '+timetostr(now)+' '+text);
   CloseFile(F);
end
  else begin
  deletefile(extractfilepath(application.exename)+'Moover_old.log');
    renamefile(extractfilepath(application.exename)+'Moover.log',extractfilepath(application.exename)+'Moover_old.log');
    AssignFile(F, extractfilepath(application.exename)+'Moover.log');
 if fileexists(extractfilepath(application.exename)+'Moover.log') then
   append(f) else Rewrite(F);
   CloseFile(F);
    addlog(text);
  end;

end;

end;


procedure TForm1.FormCreate(Sender: TObject);
begin
 with nid do
  begin
    cbSize := SizeOf( TNotifyIconData );
    Wnd := Form1.Handle;
    uID := 1;
    uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
    uCallbackMessage := WM_USER + 100;
    hIcon := Application.Icon.Handle;
    StrPCopy(szTip, 'Mover Server');
  end;
  Shell_NotifyIcon( NIM_ADD, @nid );

 TcpServer1.LocalHost:=GetLocalIP;
 TcpServer1.LocalPort:='30000';

  SpeedButton1.Visible := false;

stringgrid1.Cells[0,0]:='###';
stringgrid1.Cells[3,0]:='Стан';
stringgrid1.Cells[1,0]:='Місце призначення';
stringgrid1.Cells[2,0]:='Маска';
stringgrid1.ColWidths[0]:=30;
stringgrid1.ColWidths[1]:=300;
stringgrid1.ColWidths[2]:=109;
stringgrid1.ColWidths[3]:=30;

stringgrid2.Cells[0,0]:='№';
stringgrid2.Cells[1,0]:='Перевіряти папки';
stringgrid2.ColWidths[0]:=30;
stringgrid2.ColWidths[1]:=440;

   ReadParams;

   tcpserver1.Active:=true;

//   addlog(inttostr(getlasterror));

   if tcpserver1.Active=true then
  addlog('TCP is ACTIVE *** '+tcpserver1.LocalHost+' * '+tcpserver1.LocalPort)
   else  addlog('TCP is NOT ACTIVE');


   form1.timer1.Interval:=strtoint(Form1.Edit1.Text)*1000;
   form1.timer1.Enabled:=true;
   form1.addlog('*** Mover запущено... ***');
  

end;


procedure TForm1.N1Click(Sender: TObject);
begin
close();
end;


procedure TForm1.IconCallBackMessage( var Mess : TMessage );
Var p:tpoint;
begin
GetCursorPos(p); 
  case Mess.lParam of
    WM_RBUTTONDOWN    : Begin
    SetForegroundWindow(Handle);  
    PopupMenu1.Popup(p.X,p.Y);
    PostMessage(Handle,WM_NULL,0,0);
   end;
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
var
Find:TSearchRec;
s,i:integer;
rez,obj:maskType;
label m1;
begin

for s:=1 to Form1.StringGrid2.RowCount-1 do
begin

  for i:=1 to StringGrid1.RowCount-1 do begin
    if (StringGrid1.Cells[0,i]=inttostr(s))and(StringGrid1.Cells[3,i]<>'0') then

      rez:=mass(StringGrid1.Cells[2,i]);
      obj.nameMask:=rez.nameMask;
      obj.Day:=rez.Day;
      obj.time:=rez.time;

      if (obj.Day<>0) or (obj.time<>'') then
        if  then
          if DayOfWeek(date)=obj.Day then

 //-------------------------------------------------------------------------------------------------------------------------------------------
        if FindFirst(StringGrid2.Cells[1,s]+mass(StringGrid1.Cells[2,i]), faAnyFile, Find)=0 then begin

          if (Find.Attr and faDirectory)<>Find.Attr then begin

            if MatchesMask(find.Name,mass(StringGrid1.Cells[2,i])) then begin

              namef:=find.Name;
                if StringGrid1.Cells[3,i]='1' then begin
                     if StringGrid1.Cells[1,i][length(StringGrid1.Cells[1,i])]<>'\'then
                     StringGrid1.Cells[1,i]:=StringGrid1.Cells[1,i]+'\';
                if copyfile(pansichar(StringGrid2.Cells[1,s]+find.Name),pansichar(StringGrid1.Cells[1,i]+find.Name),false) then
                  addlog(find.Name+' скопійовано з '+StringGrid2.Cells[1,s]+' до '+StringGrid1.Cells[1,i])
                else
                  addlog(find.Name+'  не скопійовано з '+StringGrid2.Cells[1,s]+' до '+StringGrid1.Cells[1,i]+'. Код помилки '+IntToStr(GetLastError));
              end;
              if StringGrid1.Cells[3,i]='2' then begin
                     if StringGrid1.Cells[1,i][length(StringGrid1.Cells[1,i])]<>'\'then
                     StringGrid1.Cells[1,i]:=StringGrid1.Cells[1,i]+'\';
                if movefile(pansichar(StringGrid2.Cells[1,s]+find.Name),pansichar(StringGrid1.Cells[1,i]+find.Name)) then
                  addlog(find.Name+' переміщено з '+StringGrid2.Cells[1,s]+' до '+StringGrid1.Cells[1,i])
                else
                  if (GetLastError = 80) or (GetLastError = 183) then begin
                    deletefile(pansichar(StringGrid1.Cells[1,i]+find.Name));
                  if movefile(pansichar(StringGrid2.Cells[1,s]+find.Name),pansichar(StringGrid1.Cells[1,i]+find.Name)) then
                    addlog(find.Name+' переміщено із заміною з '+StringGrid2.Cells[1,s]+' до '+StringGrid1.Cells[1,i])
                  else
                    addlog(find.Name+'  не переміщено з '+StringGrid2.Cells[1,s]+' до '+StringGrid1.Cells[1,i]+'. Код помилки '+IntToStr(GetLastError));
                  end;
                                end;
              if StringGrid1.Cells[3,i]='3' then begin
                      if StringGrid1.Cells[1,i][length(StringGrid1.Cells[1,i])]<>'\'then
                      StringGrid1.Cells[1,i]:=StringGrid1.Cells[1,i]+'\';
                if deletefile(pansichar(StringGrid2.Cells[1,s]+find.Name)) then
                  addlog(find.Name+' видалено з '+StringGrid2.Cells[1,s])
                else
                  addlog(find.Name+'  не видалено з '+StringGrid2.Cells[1,s]+'. Код помилки '+IntToStr(GetLastError));
              end;
              if StringGrid1.Cells[3,i]='4' then begin
                  winexec(pansichar(mass(StringGrid1.Cells[1,i])),sw_show);
                if getlasterror = 0  then
                  addlog(find.Name+' знайдено у '+StringGrid2.Cells[1,s]+' і запущено файл '+StringGrid1.Cells[1,i])
                else
                  addlog(find.Name+' знайдено у '+StringGrid2.Cells[1,s]+', але не запущено файл '+StringGrid1.Cells[1,i]+'. Код помилки '+IntToStr(GetLastError));
              end;
              if StringGrid1.Cells[3,i]='5' then begin
                  winexec(pansichar(mass(StringGrid1.Cells[1,i])),sw_hide);
                if getlasterror = 0  then
                  addlog(find.Name+' знайдено у '+StringGrid2.Cells[1,s]+' і запущено файл '+StringGrid1.Cells[1,i])
                else
                  addlog(find.Name+' знайдено у '+StringGrid2.Cells[1,s]+', але не запущено файл '+StringGrid1.Cells[1,i]+'. Код помилки '+IntToStr(GetLastError));
              end;
              if StringGrid1.Cells[3,i]='6' then begin
                  MessageBox(0, PChar('В дерикторії - '+StringGrid2.Cells[1,s]+' - знайдено файл - '+#13#10+#13#10+find.Name), 'Mover', MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
                if getlasterror = 0 then
                  addlog(find.Name+' знайдено у '+StringGrid2.Cells[1,s]+' і показано повідомлення')
                else
                  addlog(find.Name+' знайдено у '+StringGrid2.Cells[1,s]+', але повідомлення не показано. Код помилки '+IntToStr(GetLastError));
              end;
              if StringGrid1.Cells[3,i]='7' then begin
                  if renamefile(pansichar(StringGrid2.Cells[1,s]+find.Name),pansichar(StringGrid2.Cells[1,s]+renam(StringGrid1.Cells[1,i]))) then
                  addlog('У '+StringGrid2.Cells[1,s]+' перейменовано файл з '+find.Name+' на '+renam(StringGrid1.Cells[1,i]))
                else
                  addlog('У '+StringGrid2.Cells[1,s]+' не перейменовано файл з '+find.Name+' на '+renam(StringGrid1.Cells[1,i])+' . Код помилки '+IntToStr(GetLastError));
              end;


          end;
          end;

          while FindNext(Find)=0 do  begin

              if (Find.Attr and faDirectory)<>Find.Attr then begin
              if MatchesMask(find.Name,mass(StringGrid1.Cells[2,i])) then begin
              namef:=find.Name;

                if StringGrid1.Cells[3,i]='1' then begin
                    if StringGrid1.Cells[1,i][length(StringGrid1.Cells[1,i])]<>'\'then
                    StringGrid1.Cells[1,i]:=StringGrid1.Cells[1,i]+'\';
                if copyfile(pansichar(StringGrid2.Cells[1,s]+find.Name),pansichar(StringGrid1.Cells[1,i]+find.Name),false) then
                  addlog(find.Name+' скопійовано з '+StringGrid2.Cells[1,s]+' до '+StringGrid1.Cells[1,i])
                else
                  addlog(find.Name+'  не скопійовано з '+StringGrid2.Cells[1,s]+' до '+StringGrid1.Cells[1,i]+'. Код помилки '+IntToStr(GetLastError));
              end;
              if StringGrid1.Cells[3,i]='2' then begin
                    if StringGrid1.Cells[1,i][length(StringGrid1.Cells[1,i])]<>'\'then
                    StringGrid1.Cells[1,i]:=StringGrid1.Cells[1,i]+'\';
                if movefile(pansichar(StringGrid2.Cells[1,s]+find.Name),pansichar(StringGrid1.Cells[1,i]+find.Name)) then
                  addlog(find.Name+' переміщено з '+StringGrid2.Cells[1,s]+' до '+StringGrid1.Cells[1,i])
                else
                  if (GetLastError = 80) or (GetLastError = 183) then begin
                    deletefile(pansichar(StringGrid1.Cells[1,i]+find.Name));
                  if movefile(pansichar(StringGrid2.Cells[1,s]+find.Name),pansichar(StringGrid1.Cells[1,i]+find.Name)) then
                    addlog(find.Name+' переміщено із заміною з '+StringGrid2.Cells[1,s]+' до '+StringGrid1.Cells[1,i])
                  else
                    addlog(find.Name+'  не переміщено з '+StringGrid2.Cells[1,s]+' до '+StringGrid1.Cells[1,i]+'. Код помилки '+IntToStr(GetLastError));
                  end;
                                end;
              if StringGrid1.Cells[3,i]='3' then begin
                   if StringGrid1.Cells[1,i][length(StringGrid1.Cells[1,i])]<>'\'then
                   StringGrid1.Cells[1,i]:=StringGrid1.Cells[1,i]+'\';
                if deletefile(pansichar(StringGrid2.Cells[1,s]+find.Name)) then
                  addlog(find.Name+' видалено з '+StringGrid2.Cells[1,s])
                else
                  addlog(find.Name+'  не видалено з '+StringGrid2.Cells[1,s]+'. Код помилки '+IntToStr(GetLastError));
              end;
              if StringGrid1.Cells[3,i]='4' then begin
                  winexec(pansichar(mass(StringGrid1.Cells[1,i])),sw_show);
                if getlasterror = 0  then
                  addlog(find.Name+' знайдено у '+StringGrid2.Cells[1,s]+' і запущено файл '+StringGrid1.Cells[1,i])
                else
                  addlog(find.Name+' знайдено у '+StringGrid2.Cells[1,s]+', але не запущено файл '+StringGrid1.Cells[1,i]+'. Код помилки '+IntToStr(GetLastError));
              end;
              if StringGrid1.Cells[3,i]='5' then begin
                  winexec(pansichar(mass(StringGrid1.Cells[1,i])),sw_hide);
                if getlasterror = 0  then
                  addlog(find.Name+' знайдено у '+StringGrid2.Cells[1,s]+' і запущено файл '+StringGrid1.Cells[1,i])
                else
                  addlog(find.Name+' знайдено у '+StringGrid2.Cells[1,s]+', але не запущено файл '+StringGrid1.Cells[1,i]+'. Код помилки '+IntToStr(GetLastError));
              end;
              if StringGrid1.Cells[3,i]='6' then begin
                  MessageBox(0, PChar('В дерикторії - '+StringGrid2.Cells[1,s]+' - знайдено файл - '+#13#10+#13#10+find.Name), 'Mover', MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
                if getlasterror = 0 then
                  addlog(find.Name+' знайдено у '+StringGrid2.Cells[1,s]+' і показано повідомлення')
                else
                  addlog(find.Name+' знайдено у '+StringGrid2.Cells[1,s]+', але повідомлення не показано. Код помилки '+IntToStr(GetLastError));
              end;
              if StringGrid1.Cells[3,i]='7' then begin
                  if renamefile(pansichar(StringGrid2.Cells[1,s]+find.Name),pansichar(StringGrid2.Cells[1,s]+renam(StringGrid1.Cells[1,i]))) then
                  addlog('У '+StringGrid2.Cells[1,s]+' перейменовано файл з '+find.Name+' на '+renam(StringGrid1.Cells[1,i]))
                else
                  addlog('У '+StringGrid2.Cells[1,s]+' не перейменовано файл з '+find.Name+' на '+renam(StringGrid1.Cells[1,i])+' . Код помилки '+IntToStr(GetLastError));
              end;


              end;
              end;

          end;

        FindClose(Find);

    end;
//===============================================================================================================================
  end;

end;
    namef:='';
TrimWorkingSet;

end;

procedure TForm1.N3Click(Sender: TObject);
begin
timer1.Enabled:=false;
Form1.ReadParams;
Form1.Show;
Form1.Activate;
end;


//------------------------------------------------------------------------------


procedure TForm1.WriteParams;
Var IniFile:TIniFile;
i:integer;
Path:string;
begin
Path:=ExtractFilePath(Application.ExeName);

IniFile:=TIniFile.Create(Path+'Properties.ini');
IniFile.WriteString('TIME','sek ',edit1.Text);
IniFile.WriteBool('LOG','log ',checkbox1.Checked);
IniFile.WriteString('LOG','size ',edit2.Text);

for i:=1 to stringgrid2.RowCount-1 do begin
if (stringgrid2.Cells[1,i]<>'') then
    if (stringgrid2.Cells[1,i][length(stringgrid2.Cells[1,i])]<>'\') then stringgrid2.Cells[1,i]:=stringgrid2.Cells[1,i]+'\';
IniFile.WriteString('DIR','dir.'+inttostr(i),stringgrid2.Cells[1,i]);
end;

IniFile.Writeinteger('MOOOVER','CountDir',i-1);

for i:=1 to stringgrid1.RowCount-1 do begin
IniFile.WriteString('DIRNOM','dirNOM.'+inttostr(i),stringgrid1.Cells[0,i]);
IniFile.WriteString('STAN','Stan.'+inttostr(i),stringgrid1.Cells[3,i]);
IniFile.WriteString('HOSTS','Host.'+inttostr(i),stringgrid1.Cells[1,i]);
IniFile.WriteString('HOSTS_MASK','Host Mask.'+inttostr(i),stringgrid1.Cells[2,i]);
end;

IniFile.Writeinteger('MOOOVER','Count',i-1);


IniFile.Free;
end;

procedure TForm1.ReadParams;
Var IniFile:TIniFile;
f,i:integer;
path:string;
begin
Path:=ExtractFilePath(Application.ExeName);

IniFile:=TIniFile.Create(Path+'Properties.ini');
edit1.Text:=IniFile.Readstring('TIME','sek',edit1.Text);
checkbox1.Checked:=IniFile.Readbool('LOG','log',checkbox1.Checked);
edit2.Text:=IniFile.ReadString('LOG','size',edit2.Text);
f:=IniFile.Readinteger('MOOOVER','count',0);
stringgrid1.rowcount:=f+1;
for i:=1 to f do begin
stringgrid1.Cells[0,i]:=IniFile.ReadString('DIRNOM','dirNOM.'+inttostr(i),stringgrid1.Cells[0,i]);
stringgrid1.Cells[1,i]:=IniFile.ReadString('HOSTS','Host.'+inttostr(i),stringgrid1.Cells[1,i]);
stringgrid1.Cells[2,i]:=IniFile.ReadString('HOSTS_MASK','Host Mask.'+inttostr(i),stringgrid1.Cells[2,i]);
stringgrid1.Cells[3,i]:=IniFile.ReadString('STAN','Stan.'+inttostr(i),stringgrid1.Cells[3,i]);
end;

f:=IniFile.Readinteger('MOOOVER','countDir',f);
stringgrid2.rowcount:=f+1;
combobox1.Items.Clear;
for i:=1 to f do begin
stringgrid2.Cells[0,i]:=inttostr(i);
stringgrid2.Cells[1,i]:=IniFile.ReadString('DIR','Dir.'+inttostr(i),stringgrid2.Cells[1,i]);
combobox1.Items.Add(inttostr(i)+' - '+stringgrid2.Cells[1,i]);
end;


IniFile.Free;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
WriteParams;
form1.Timer1.Interval:=strtoint(edit1.text)*1000;
form1.Hide;
form1.Timer1.Enabled:=true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
stringgrid1.RowCount:=stringgrid1.RowCount+1;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
j,it:integer;
begin
it:=stringgrid1.Row;
  for j:=it to stringgrid1.RowCount-1 do begin
    if j<>0 then
    stringgrid1.Rows[j]:=stringgrid1.Rows[j+1];
  end;

  stringgrid1.RowCount:=stringgrid1.RowCount-1;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
Form1.Hide;
form1.Timer1.Enabled:=true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
stringgrid2.RowCount:=stringgrid2.RowCount+1;
stringgrid2.Cells[0,stringgrid2.RowCount-1]:=inttostr(stringgrid2.RowCount-1);
combobox1.Items.Add(inttostr(stringgrid2.RowCount-1)+' - ');
end;

procedure TForm1.Button4Click(Sender: TObject);
var
j,it:integer;
begin
it:=StringGrid2.Row;

  for j:=it to stringgrid2.RowCount-1 do begin
    if j<>0 then  begin
    stringgrid2.Rows[j]:=stringgrid2.Rows[j+1];
    stringgrid2.Cells[0,j]:=inttostr(j);
    combobox1.Items[j-1]:=inttostr(j)+' - '+stringgrid2.Cells[1,j];
    end;
  end;
  if stringgrid2.RowCount<>1 then begin
  stringgrid2.Cells[0,stringgrid2.RowCount-1]:='';
    stringgrid2.Cells[1,stringgrid2.RowCount-1]:='';
  end;
  stringgrid2.RowCount:=stringgrid2.RowCount-1;
  if combobox1.Items.Count<>0 then
  combobox1.Items.Delete(combobox1.Items.Count-1);

  for j:=1 to stringgrid1.RowCount-1 do begin
    if stringgrid1.Cells[0,j]=inttostr(it) then
      stringgrid1.Cells[0,j]:='0';
    if stringgrid1.Cells[0,j]<>'' then
    if strtoint(stringgrid1.Cells[0,j])>it then
      stringgrid1.Cells[0,j]:=inttostr(strtoint(stringgrid1.Cells[0,j])-1);
  end;


end;





//------------------------------------------------------------------------------


procedure TForm1.StringGrid1SelectCell(Sender: TObject; Col, Row: Integer;
  var CanSelect: Boolean);
  var R: TRect;
begin

if (((Col <> 0)or (Col <> 3)) and (Row <> 0)) then   begin
    combobox1.Visible:=false;
    combobox2.Visible:=false;
    end;

if ((Col = 0) and (Row <> 0)) then
  begin
    {Size and position the combo box to fit the cell}
    R := StringGrid1.CellRect(Col, Row);
    R.Left := R.Left + StringGrid1.Left;
    R.Right := R.Right + StringGrid1.Left+200;
    R.Top := R.Top + StringGrid1.Top;
    R.Bottom := R.Bottom + StringGrid1.Top;

    {Show the combobox}
    with ComboBox1 do
    begin
      Left := R.Left + 1;
      Top := R.Top + 1;
      Width := (R.Right + 1) - R.Left;
      Height := (R.Bottom + 1) - R.Top;

      ItemIndex := Items.IndexOf(StringGrid1.Cells[Col, Row]);
      if StringGrid1.Cells[Col, Row]<>'' then
      text:= Items[strtoint(StringGrid1.Cells[Col, Row])-1]
      else
      text:='';
      Visible := True;
      SetFocus;
    end;
  end;

  if ((Col = 3) and (Row <> 0)) then
  begin
    {Size and position the combo box to fit the cell}
    R := StringGrid1.CellRect(Col, Row);
    R.Left := R.Left + StringGrid1.Left-150;
    R.Right := R.Right + StringGrid1.Left;
    R.Top := R.Top + StringGrid1.Top;
    R.Bottom := R.Bottom + StringGrid1.Top;

    {Show the combobox}
    with ComboBox2 do
    begin
      Left := R.Left + 1;
      Top := R.Top + 1;
      Width := (R.Right + 1) - R.Left;
      Height := (R.Bottom + 1) - R.Top;

      ItemIndex := Items.IndexOf(StringGrid1.Cells[Col, Row]);
       if StringGrid1.Cells[Col, Row]<>'' then
       text:= Items[strtoint(StringGrid1.Cells[Col, Row])]
      else
      text:='';Visible := True;
      SetFocus;
    end;
  end;

  CanSelect := True;

end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var intRow: Integer;
begin
  inherited;

  with ComboBox1 do
  begin
    intRow := StringGrid1.Row;
    if (StringGrid1.Col = 2) then
      StringGrid1.Cells[2, intRow] := Items[ItemIndex]
    else
      StringGrid1.Cells[StringGrid1.Col, intRow] := inttostr(ItemIndex+1);
    Visible := False;
  end;
  StringGrid1.SetFocus;

end;

procedure TForm1.ComboBox2Change(Sender: TObject);
var intRow: Integer;
begin
  inherited;

  with ComboBox2 do
  begin
    intRow := StringGrid1.Row;
    if (StringGrid1.Col = 2) then
      StringGrid1.Cells[2, intRow] := Items[ItemIndex]
    else
      StringGrid1.Cells[StringGrid1.Col, intRow] := inttostr(ItemIndex);
    Visible := False;
  end;
  StringGrid1.SetFocus;

end;

procedure TForm1.WMQueryEndSession(var Message: TWMQueryEndSession);
begin
inherited;
 Form1.Close;
end;

procedure TForm1.TcpServer1Accept(Sender: TObject;
  ClientSocket: TCustomIpClient);
  var
  stream: TMemoryStream; 
  msg,path: string; 
  sz: integer;
begin
if ClientSocket.Connect then
  begin
  msg := ClientSocket.Receiveln;
Path:=ExtractFilePath(Application.ExeName);

  if msg='1' then begin
    ClientSocket.Sendln('ok');
    msg := ClientSocket.Receiveln;
    stream := TMemoryStream.Create;
    sz := StrToInt(msg);
    stream.SetSize(sz);

    ClientSocket.ReceiveBuf(stream.Memory^, sz);
    stream.SaveToFile('Properties.ini');
    stream.Free;

    timer1.Enabled:=false;
    readparams;
    Timer1.Interval:=strtoint(edit1.text)*1000;
    timer1.Enabled:=true;

    addlog('Отримано Properties.ini від '+ClientSocket.RemoteHost);

  end;

  if msg='2' then begin
    stream := TMemoryStream.Create;
    stream.LoadFromFile(path+'moover.log');
    clientSocket.Sendln(IntToStr(stream.Size));
    if clientSocket.Receiveln = 'ok' then
      clientSocket.SendBuf(stream.Memory^, stream.Size);
      sleep(5000);
      stream.Free;

      addlog('Передано Mover.log для '+ClientSocket.RemoteHost);
  end;

  if msg='3' then begin
    stream := TMemoryStream.Create;
    stream.LoadFromFile(path+'moover_old.log');
    clientSocket.Sendln(IntToStr(stream.Size));
    if clientSocket.Receiveln = 'ok' then
      clientSocket.SendBuf(stream.Memory^, stream.Size);
      sleep(5000);
      stream.Free;
      addlog('Передано Mover_old.log для '+ClientSocket.RemoteHost);
  end;

  if msg='4' then begin
    stream := TMemoryStream.Create;
    stream.LoadFromFile(path+'Properties.ini');
    clientSocket.Sendln(IntToStr(stream.Size));
    if clientSocket.Receiveln = 'ok' then
      clientSocket.SendBuf(stream.Memory^, stream.Size);
      sleep(2000);
      stream.Free;
      addlog('Передано Properties.ini для '+ClientSocket.RemoteHost);
  end;

  if msg='5' then begin
    ClientSocket.Sendln('ok');
    msg:=ClientSocket.Receiveln;
    MessageBox(0, PChar(msg), 'Mover', MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
    addlog('Від '+ClientSocket.RemoteHost+' отримано повідомлення "'+msg+'"');
  end;

    ClientSocket.Disconnect;
    end;

end;

procedure TForm1.StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  R: TRect;
begin
  if (gdFocused in State)and (StringGrid2.Col=1)and (StringGrid2.row<>0) then
  begin
    R := Rect;
    SpeedButton1.Left := R.Right - SpeedButton1.Width;
    SpeedButton1.Top := R.Top;
    SpeedButton1.Height := R.Bottom - R.Top;
    SpeedButton1.Visible := true;
  end
  else
    SpeedButton1.Visible := false;

end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
open:TOpenDialog;
dir:string;
begin
 if stringgrid2.Focused then begin
  dir:=stringgrid2.Cells[1,stringgrid2.Row];
  SelectDirectory ('Оберіть папку для сканування', '', dir);
  if dir<>'' then begin
    stringgrid2.Cells[1,stringgrid2.Row]:=dir;
    if stringgrid2.Row<>1 then
    combobox1.Items.Strings[stringgrid2.Row-1]:=inttostr(stringgrid2.Row-1)+' - '+dir
    else combobox1.Items.Strings[stringgrid2.Row-1]:=inttostr(stringgrid2.Row)+' - '+dir

  end;
end;
 if stringgrid1.Focused then begin
    if (stringgrid1.Cells[3,stringgrid1.Row]='1')or(stringgrid1.Cells[3,stringgrid1.Row]='2') then begin
      dir:=stringgrid1.Cells[1,stringgrid1.Row];
      SelectDirectory ('Оберіть папку місця призначення', '', dir);
      if dir<>'' then
      stringgrid1.Cells[1,stringgrid1.Row]:=dir;
    end;
    if (stringgrid1.Cells[3,stringgrid1.Row]='4') or (stringgrid1.Cells[3,stringgrid1.Row]='5') then begin
      open:=TOpenDialog.Create(self);
      open.Filter:='Додатки (*.exe)|*.exe';
      if open.execute then begin
        stringgrid1.Cells[1,stringgrid1.Row]:=open.FileName;
      end;
      open.Free;
    end;
    if (stringgrid1.Cells[3,stringgrid1.Row]='7') then begin
      MessageDlg('Для перейменування файлу використовуйте символ "%"'+#13#10+#13#10+'Наприклад:'+#13#10+'[старі символи]%[нові символи]', mtInformation, [mbOK], 0);
    end;
 end;


end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  R: TRect;
begin
  if (gdFocused in State)and (StringGrid1.Col=1)and (StringGrid1.row<>0) then
  begin
    R := Rect;
    SpeedButton1.Left := R.Right - SpeedButton1.Width;
    SpeedButton1.Top := R.Top;
    SpeedButton1.Height := R.Bottom - R.Top;
    SpeedButton1.Visible := true;
  end
  else
    SpeedButton1.Visible := false;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if checkbox1.Checked=true then
  edit2.Enabled:=true
else
  edit2.Enabled:=false;
end;


  procedure TForm1.FormDestroy(Sender: TObject);
begin
Shell_NotifyIcon(NIM_DELETE, @nid);
addlog('*** Mover зупинено... ***');
end;

procedure TForm1.StringGrid1Click(Sender: TObject);
begin
 SpeedButton1.Parent := StringGrid1;
end;

procedure TForm1.StringGrid2Click(Sender: TObject);
begin
 SpeedButton1.Parent := StringGrid2;
end;

end.
