unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sockets, StdCtrls,
  ShellApi, ExtCtrls, Menus, Grids,masks{, ActnList}{,idGlobal},inifiles,
  Buttons, FileCtrl, winsock, JvTrayIcon, {JvComponentBase,} {IdBaseComponent,}
  {IdComponent,} IdTCPConnection, IdTCPClient, IdHTTP,ComObj, ShlObj, ActiveX,
  XPMan, stohtmlhelp, crc32, dateUtils, JvComponentBase, JvZlibMultiple,
  JvLogFile, JvLogClasses, moverserv, InvokeRegistry, Rio, SOAPHTTPClient,
  Gauges, IdBaseComponent, IdComponent, IdExplicitTLSClientServerBase, IdFTP,
  JclFileUtils{,syncobjs};

type
maskType = record
    nameMask:string;
    Day:array[0..6] of integer;
    time1,time2:string;
    tcp,recur,ftp:boolean;
    end;
  TMainForm = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    SpeedButton2: TSpeedButton;
    edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    SG1: TStringGrid;
    CheckBox2: TCheckBox;
    PopupMenu1: TPopupMenu;
    N3: TMenuItem;
    N7: TMenuItem;
    N6: TMenuItem;
    N2: TMenuItem;
    N1: TMenuItem;
    Timer1: TTimer;
    TcpServer1: TTcpServer;
    JvTrayIcon1: TJvTrayIcon;
    PopupMenu2: TPopupMenu;
    N5: TMenuItem;
    N4: TMenuItem;
    TcpClient1: TTcpClient;
    ZM1: TJvZlibMultiple;
    Log1: TJvLogFile;
    Splitter1: TSplitter;
    Panel2: TPanel;
    XPManifest1: TXPManifest;
    Bevel3: TBevel;
    Bevel4: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    Button7: TButton;
    BLog: TButton;
    SG2: TStringGrid;
    ComboBox3: TComboBox;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    UPTimer: TTimer;
    TmrWeb: TTimer;
    BBStart: TBitBtn;
    G1: TGauge;
    Bevel5: TBevel;
    BAutoRun: TBitBtn;
    procedure WebCfg(s:string);
    procedure WEBreg;
    function mass(mask: string; pars: boolean = false):maskType;
    procedure WriteParams;
    procedure ReadParams;
    procedure for2;
    function  renam(mask,nameF: string):string;
    procedure addlog(text:string;Event:integer);
   // function  outTcp(stan:integer):string;
//    function  inTcp(stan:integer):string;
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
    procedure SG1SelectCell(Sender: TObject; Col, Row: Integer;
  var CanSelect: Boolean);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure TcpServer1Accept(Sender: TObject;
      ClientSocket: TCustomIpClient);
    procedure SG2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SG1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure SG1Click(Sender: TObject);
    procedure SG2Click(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SG1KeyPress(Sender: TObject; var Key: Char);
    procedure Button7Click(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox3DropDown(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ZM1DecompressedFile(Sender: TObject; const FileName: string;
      const FileSize: Cardinal);
    procedure ZM1CompressedFile(Sender: TObject; const FileName: string);
    procedure BLogClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure UPTimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SG1DblClick(Sender: TObject);
    procedure TmrWebTimer(Sender: TObject);
    procedure BBStartClick(Sender: TObject);
    procedure SG2SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure BAutoRunClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    URL : string;
    Save : Boolean;
    hs : string;
    shutDown : Boolean;

  public
    { Public declarations }
    v :string;
    const
      vers = '5.5.1';
    procedure WMQueryEndSession(var Message: TWMQueryEndSession); message WM_QueryEndSession;
  end;

var
  MainForm: TMainForm;
implementation

uses Unit2, ULogPer, UFtp;

{const
  vers='5.0.02.HF1.2';
 }
type
  {maskType = record
    nameMask:string;
    Day:array[0..6] of integer;
    time1,time2:string;
    tcp:boolean;
    end; }
  maktype=record
    nam:string;
    ind:integer;
    end;
  tcp_type=record
    ip:string;
    dir:string;
  end;
  ftp_type=record
    ftp: Boolean;
    ip:string;
    user: string;
    pass: string;
    dir:string;
  end;


{$R *.dfm}

function split(s,sep:string;no:integer):string;
var
  i,k:integer;
begin
  result:='';
  for I := 1 to no do begin
    k:=Pos(sep,s);
    if k=0 then begin
      result:=s;
      Exit;
    end;
    result:=Copy(s,1,k-1);
    s:=Copy(s,k+1,Length(s));
  end;



end;

procedure TMainForm.for2;
var
ini:tmeminifile;
k,i,s:integer;
begin

  ini:=tmeminifile.Create(extractfilepath(application.ExeName)+'Properties.ini');
try
  k:=ini.ReadInteger('OUT_TCP','count',0);
  if k>0 then begin
    for i:=1 to k do begin
      form2.SG1.Cells[0,i]:=inttostr(i);
      form2.SG1.Cells[1,i]:=ini.ReadString('OUT_TCP','ip_'+inttostr(i),'');
      form2.SG1.Cells[2,i]:=ini.ReadString('OUT_TCP','mask_'+inttostr(i),'');
      form2.SG1.Cells[3,i]:=ini.ReadString('OUT_TCP','dir_'+inttostr(i),'');
      form2.SG1.Cells[5,i]:=ini.ReadString('OUT_TCP','stan_'+inttostr(i),'0');
      form2.SG1.Cells[4,i]:=ini.ReadString('OUT_TCP','time_'+inttostr(i),'');
    end;
    form2.Button1.Enabled:=true;
    form2.Button2.Enabled:=true;
    form2.Button3.Enabled:=true;
    form2.SG1.RowCount:=k+1;
  end else begin
    form2.SG1.RowCount:=2;
    form2.SG1.Rows[1].Clear;
    form2.Button1.Enabled:=False;
    form2.Button2.Enabled:=False;
    form2.Button3.Enabled:=False;
  end;

  s:=0;
  k:=ini.ReadInteger('IN_TCP','count',0);
  if k>0 then begin
    for i:=1 to k do begin
      form2.SG2.Cells[0,i]:=inttostr(i);
      form2.SG2.Cells[1,i]:=ini.ReadString('IN_TCP','ip_'+inttostr(i),'');
      form2.SG2.Cells[2,i]:=ini.ReadString('IN_TCP','mask_'+inttostr(i),'');
      form2.SG2.Cells[3,i]:=ini.ReadString('IN_TCP','dir_'+inttostr(i),'');
      form2.SG2.Cells[4,i]:=ini.ReadString('IN_TCP','stan_'+inttostr(i),'');
      form2.SG2.Cells[5,i]:=ini.ReadString('IN_TCP','see_'+inttostr(i),'0');
      s:=s+ini.ReadInteger('IN_TCP','see_'+inttostr(i),0);
    end;
    form2.SG2.RowCount:=k+1;
    if s>0 then begin
      if Pos('(',MainForm.Button7.Caption)>0 then
        MainForm.Button7.Caption:=Copy(MainForm.Button7.Caption,1,Pos('(',MainForm.Button7.Caption)-2);      
      MainForm.Button7.Caption:=MainForm.Button7.Caption+' ('+inttostr(s)+')'
    end;
    form2.Button4.Enabled:=True;
    form2.Button5.Enabled:=True;
  end else begin
    form2.SG2.RowCount:=2;
    form2.SG2.Rows[1].Clear;
    form2.Button4.Enabled:=False;
    form2.Button5.Enabled:=False;
  end;



finally
  ini.Free;
end;
end;

function gridup(a:string;it,oper:integer):string;
var
k:integer;
s,n:string;
begin
k:=1;
n:='';
while k<=length(a) do begin
      s:='';
      if (a[k] in ['0'..'9']) then begin

      while (a[k] in ['0'..'9'])and (k<=(length(a))) do begin
        s:=s+a[k];
        k:=k+1;
      end;
      if (oper=1)and (strtoint(s)=it) then s:='0';
      if (oper=1)and (strtoint(s)>it) then s:=inttostr(strtoint(s)-1);
      if (oper=2)and (strtoint(s)>it)and(s<>'0') then s:=inttostr(strtoint(s)+1);
      n:=n+s;
    end
    else begin
      n:=n+a[k];
      k:=k+1;
    end;

end;

result:=n;


end;

procedure whatday(a:array of integer);
var
i:integer;
begin

form2.CheckBox1.Checked:=false;
form2.CheckBox2.Checked:=false;
form2.CheckBox3.Checked:=false;
form2.CheckBox4.Checked:=false;
form2.CheckBox5.Checked:=false;
form2.CheckBox6.Checked:=false;
form2.CheckBox7.Checked:=false;

for i:=0 to 6 do begin
  if a[i]=1 then form2.CheckBox7.Checked:=true;
  if a[i]=2 then form2.CheckBox1.Checked:=true;
  if a[i]=3 then form2.CheckBox2.Checked:=true;
  if a[i]=4 then form2.CheckBox3.Checked:=true;
  if a[i]=5 then form2.CheckBox4.Checked:=true;
  if a[i]=6 then form2.CheckBox5.Checked:=true;
  if a[i]=7 then form2.CheckBox6.Checked:=true;
end;


end;

{function TMainForm.outTcp(stan:integer):string;
begin
  case stan of
    1:
      result:='Очікування';
    2:
      result:='Прийнято';
    3:
      result:='Відхилено';
    4:
      result:='Не відправлено';
    else
      result:='Невідомий стан';
  end;

end;
}

{function TMainForm.inTcp(stan:integer):string;
begin
  case stan of
    1:
      result:='Очікування';
    2:
      result:='Прийнято';
    3:
      result:='Відхилено';
    4:
      result:='Не підтверджено';
    else
      result:='Невідомий стан';
  end;

end;  }

function che(a,b:string):boolean;
var
k,i:integer;
s,a1:string;
op:boolean;
begin
op:=false;
  k:=pos(b,a);

if (k<>0) then begin
    if not (a[k-1] in ['0'..'9']) then begin
      i:=0;
      s:='';
      while (a[k+i] in ['0'..'9'])and (i<=(length(a)-k)) do begin
        s:=s+a[k+i];
        i:=i+1;
      end;
    end;
    if s=b then op:=true;

{    if op=true then
    showmessage (a+' - '+b+' - true')
    else
    showmessage (a+' - '+b+' - false');
}
    if op=false then begin
    k:=k+1;
    i:=k;
     while (a[i] in ['0'..'9'])do begin
     i:=i+1;
     k:=i;
     end;
      a1:=copy(a,k,(length(a)-k+1));
      op:=che(a1,b);
    end;

{    if op=true then
    showmessage (a+' - '+b+' - true')
    else
    showmessage (a+' - '+b+' - false');
}
end;
    result:=op;

end;

procedure isAutoRun;
var
  Folder: array[0..255] of Char;
  List: PitemidList;
  lnk: string;
begin
  lnk := ChangeFileExt(ExtractFileName(Application.ExeName), '.lnk');
  SHGetSpecialFolderLocation(0, CSIDL_STARTUP, List);
  FillChar(Folder, SizeOf(Folder), 0);
  SHGetPathFromIDList(List, @Folder);
  ChDir(folder);
  if FileExists(lnk) then
    MainForm.BAutoRun.Glyph := MainForm.BitBtn1.Glyph
  else
    MainForm.BAutoRun.Glyph.Assign(nil);

  ChDir(ExtractFilePath(Application.ExeName));

end;

procedure addAutoRun(const filename: string);

  procedure CreateLink(const PathObj, PathLink, Desc, Param: string);
  var
    IObject: IUnknown;
    SLink: IShellLink;
    PFile: IPersistFile;
  begin
    IObject := CreateComObject(CLSID_ShellLink);
    SLink := IObject as IShellLink;
    PFile := IObject as IPersistFile;
    with SLink do
    begin
      SetArguments(PChar(Param));
      SetDescription(PChar(Desc));
      SetPath(PChar(PathObj));
    end;
    PFile.Save(PWChar(WideString(PathLink)), FALSE);
  end;

var
  Folder: array[0..255] of Char;
  List: PitemidList;
  lnk: string;
begin
  try 
    lnk := ChangeFileExt(filename, '.lnk');
    SHGetSpecialFolderLocation(0, CSIDL_STARTUP, List);
    FillChar(Folder, SizeOf(Folder), 0);
    SHGetPathFromIDList(List, @Folder);
    ChDir(folder);
    CreateLink(filename, lnk, '', '');
    CopyFile(PChar(lnk), PChar(ExtractFileName(lnk)), false);
    DeleteFile(lnk);
    application.MessageBox('Ярлик програми добавлено в атоматичне завантаження!', 'Mover', MB_ICONINFORMATION + MB_OK);

    ChDir(ExtractFilePath(Application.ExeName));

  except
    on e: exception do
      MainForm.addlog(e.ClassName + ' викликало помилку: ' + e.Message, 0);

  end;
end;

procedure up;
var
ini:tmeminifile;
newversion,pat,sourc,s:string;
 http:TIdHTTP;
 str,fs:TFileStream;
begin
  pat:=extractfilepath(application.exename);
  ini:=tmeminifile.Create(pat+'Properties.ini');
  sourc:=MainForm.URL;
  ini.Free;
if sourc<>'' then begin

//---------
    try
     try
      http:=TIdHTTP.Create(nil);
      //каталог, куда файл положить
      deletefile(pat+'version.ini');
      ForceDirectories(pat);  
      //Поток для сохранения
      str:=TFileStream.Create(pat+'version.ini', fmCreate);
      try
        //Качаем
        http.Get(sourc+'version.zip',str);
      except
      on e:exception do begin
        MainForm.addlog('Помилка при отримані актуальної версії '+#13#10+e.ClassName+' викликало помилку '+e.Message,0);
      end;
      end;
     finally
        http.Free;
        str.Free;
     end;


    //---------
    try
    try
      ini:=tmeminifile.Create(pat+'version.ini');
      newversion:=ini.ReadString('GENERAL','Verinfo',newversion);
    except
    end;
    finally
      ini.Free;
    end;



      if (MainForm.vers<>newversion)and (newversion<>'') then begin

        MainForm.addlog('Знайдено нову версію - v.'+newversion,1);
        deletefile(pat+'nov.bat');
          http:=TIdHTTP.Create(nil);
       // ForceDirectories(pat);
        str:=TFileStream.Create(pat+'nov.zip', fmCreate);
        try
          http.Get(sourc+'nov.zip',str);

        finally
          http.Free;
          str.Free;
        end;
         renamefile(pansichar(pat+'nov.zip'),pansichar(pat+'nov.bat'));
          MainForm.addlog('Перехід на нову версію - '+inttostr(getlasterror),1);
          //*-*-*-*-*-*-*-*-
          fs := TFileStream.Create(pat+'nov.bat', fmOpenread or fmShareDenyNone);
        try 
          SetLength(S, fs.Size);
          fs.ReadBuffer(S[1], fs.Size);
        finally
          fs.Free; 
        end;
        S  := StringReplace(S, 'myname', extractfilename(application.ExeName), [rfReplaceAll, rfIgnoreCase]);
        S  := StringReplace(S, 'aplic', '"'+extractfilepath(application.ExeName)+'"', [rfReplaceAll, rfIgnoreCase]);

        fs := TFileStream.Create(pat+'nov.bat', fmCreate);
        try
          fs.WriteBuffer(S[1], Length(S)); 
        finally 
          fs.Free; 
        end;
          //*-*-*-*-*-*-*-*-

          //********
          deletefile(pat+'umover.exe');
          http:=TIdHTTP.Create(nil);
      //  ForceDirectories(pat);
        str:=TFileStream.Create(pat+'umover.exe', fmCreate);
        try
          http.Get(sourc+'umover.zip',str);
        finally
          http.Free;
          str.Free;
        end;
          //********
          //--------
          deletefile(pat+'help.chm');
          http:=TIdHTTP.Create(nil);
      //  ForceDirectories(pat);
        str:=TFileStream.Create(pat+'help.chm', fmCreate);
        try
          http.Get(sourc+'help.zip',str);
        finally
          http.Free;
          str.Free;
        end;
          //--------

         ShellExecute(0, nil, pchar(pat+'nov.bat'), nil, nil, SW_HIDE);

         application.Terminate;
    

      end;

  except
   on e:exception do begin
   MainForm.addlog('Помилка при копіюванні нової версії '+#13#10+e.ClassName+' викликало помилку '+e.Message,0);
   end;
  end;

end;
end;

function SecondToTime(const Seconds: Cardinal): Double;
var 
  ms, ss, mm, hh, dd: Cardinal; 
begin 
  dd := Seconds div 86400;
  hh := (Seconds mod 86400) div 3600;
  mm := ((Seconds mod 86400) mod 3600) div 60;
  ss := ((Seconds mod 86400) mod 3600) mod 60;
  ms := 0; 
  Result := dd + EncodeTime(hh, mm, ss, ms); 
end;

function ober(tex:string;id:integer):maktype;
begin
result.nam:='';
  while (tex[id]<>';') and (id <=length(tex)) do begin
  if tex[id]<>' ' then
    result.nam:=result.nam+tex[id];
    id:=id+1;
  end; 
  result.ind:=id;
end;

function delall(tex,all:string):bool;
var
  id: integer;
  nam: string;
begin
  id := 1;
  result := false;
  while id <= length(tex) do
  begin
    nam := '';

    while (tex[id] <> ';') and (id <= length(tex)) do
    begin
      if tex[id] <> ' ' then
        nam := nam + tex[id];
      id := id + 1;
    end;

    if MatchesMask(all, trim(nam)) then
    begin
      result := true;
      exit;
    end;
    id := id + 1;
  end;

end;

//--------------------------NEW FIND----------------------------------------------------------------

procedure FindAndDo (Stan:string;s,i:integer;obj,where,realwhere:string;tcp,ftp,recur:boolean;mc,dc:string);
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

function ftp_str(s:string):ftp_type;
var
i:integer;
begin

  Result.ftp:= False;

  if s<>'' then
        if (s[4]='@') then begin
          Result.ftp:= True;
          s:=copy(s,5,maxint);
          i:=pos('\',s);
          Result.dir := copy(s,i+1,maxint);
          i:=pos(';',s);
          if i<>0 then begin
            Result.ip := split(s,';',1);
            Result.user := split(s,';',2);
            Result.pass := split(split(s,';',3),'\',1);
          end
          else begin
            Result.ip := split(s,'\',1)
          end;

        end else
          Result.dir := s;

               
end;

  function SendTcp(ip, dir, mc: string; stream: Tstream; ow: boolean{;i:integer}): boolean;
  var
    k, z: integer;
    b: array[1..1280] of Byte;
    zap, ChSum: string;
  begin
    try
      result := false;

      if ow = false then
        zap := 'two'
      else
        zap := 'one';

      MainForm.TcpClient1.RemoteHost := ip;
      MainForm.TcpClient1.RemotePort := '30000';

      chsum := (MainForm.TcpServer1.LocalHost + '@' + dir + '@' + mc);

      if MainForm.TcpClient1.Connect then
      begin
        MainForm.TcpClient1.Sendln('SendFile');
        if MainForm.TcpClient1.Receiveln = 'ok' then
        begin
          MainForm.TcpClient1.Sendln(chsum);
          ip := MainForm.TcpClient1.Receiveln;
          if (ip = 'ok') or (ip = 'no') then
          begin

            MainForm.TcpClient1.Sendln(MainForm.mass(dir).nameMask);

            if MainForm.TcpClient1.Receiveln = 'ok' then
            begin
              MainForm.TcpClient1.Sendln(FormatDateTime('YYYMMDDhhnnsszz', now));
              if MainForm.TcpClient1.Receiveln = 'ok' then
              begin
                MainForm.TcpClient1.Sendln(zap);
                ip := MainForm.TcpClient1.Receiveln;
                if ip{MainForm.TcpClient1.Receiveln} = 'ok' then
                begin

                  try
              { stream:=tMemorystream.Create;
               stream.LoadFromFile(realwhere+Name);
               MainForm.TcpClient1.Sendln(inttostr(stream.Size));
               }
                    MainForm.TcpClient1.Sendln(inttostr(stream.Size));
               //-------------------------------------------------------------

                    if MainForm.TcpClient1.Receiveln = 'ok' then
                    begin
//               MainForm.addlog(inttostr(StreamCRC32(stream)));  //-----------
//               showmessage(inttostr(stream.Size));
                      MainForm.TcpClient1.Sendln(inttostr(StreamCRC32(stream)));
//                showmessage(inttostr(stream.Size));

//                MainForm.addlog(inttostr(stream.Size));  //-----------
//                MainForm.addlog(inttostr(stream.Size div 1280));  //-----------
                      z := 0;
                      repeat

                        stream.Position := 0;
                        for k := 0 to stream.Size div 1280 do
                        begin
                          if (MainForm.TcpClient1.Receiveln = 'ok') or (MainForm.TcpClient1.Receiveln = 'err') then
                          begin
                            if k = stream.Size div 1280 then
                            begin
                              stream.ReadBuffer(b, stream.Size mod 1280);
                              MainForm.TcpClient1.SendBuf(b, stream.Size mod 1280);
                            end
                            else
                            begin
                              stream.ReadBuffer(b, 1280);
                              MainForm.TcpClient1.SendBuf(b, 1280);
                            end;
                          end;
                        end;

                        ip := MainForm.TcpClient1.Receiveln;
                        if ip = 'ok' then
                        begin
                          //MainForm.addlog('Скопійовано файл '+realwhere+Name+' до ' +where);
                          result := true;
                          break;
                        end;

                        z := z + 1;

                      until z > 5;
              {
                ip:=MainForm.TcpClient1.Receiveln ;
                     if ip='err' then
                        goto m1
                     else if ip='ok' then
                        MainForm.addlog('Скопійовано файл '+realwhere+Name+' до ' +where);
               {
                  MainForm.TcpClient1.Sendln(inttostr(FileCRC32(realwhere+Name)));

                  if MainForm.TcpClient1.Receiveln='ok' then begin

                     m1:
                     MainForm.TcpClient1.SendBuf(stream.memory^,stream.Size);
                     ip:=MainForm.TcpClient1.Receiveln ;
                     if ip='err' then
                        goto m1
                     else if ip='ok' then
                        MainForm.addlog('Скопійовано файл '+realwhere+Name+' до ' +where);


                   end;
               }    end;

                  finally
              //stream.Free;
                  end;

                end
                else
                begin
                  MainForm.TcpClient1.Disconnect;
                  MainForm.addlog(ip, 1);
                end;
              end
              else
                MainForm.TcpClient1.Disconnect;
            end
            else
              MainForm.TcpClient1.Disconnect;
          end
          else
          begin
            MainForm.TcpClient1.Disconnect;
          {ini:=tMemInifile.Create(extractfilepath(application.ExeName)+'properties.ini');
          try
            ini.WriteString('OUT_TCP','stan_'+inttostr(i),'3');
            form2.SG1.Cells[5,i]:='4';
            ini.UpdateFile;
            MainForm.addlog('Статус відправки - '+form2.SG1.Cells[1,i]+' - '+form2.SG1.Cells[2,i]+' - '+form2.SG1.Cells[3,i]+' змінено на - '+form2.SG1.Cells[5,i],1);
          finally
            freeAndNil(ini);
          end;
          }
          end;

        end
        else
          MainForm.TcpClient1.Disconnect;
//    result:=true;
      end
      else
      begin
        MainForm.TcpClient1.Disconnect;
        MainForm.addlog('Невдалось з''єднатись з ' + ip, 0);
      end;

    finally
      stream.Free;
    end;

  end;

procedure sendStat(ip,dir,mc,stat:string);
var
  ini:TMemIniFile;
  nom,i:Integer;
begin
  nom:=0;
        for i:=1 to form2.SG1.RowCount do
              if (form2.SG1.Cells[1,i]=ip)and(form2.SG1.Cells[3,i]=dir)and(form2.SG1.Cells[2,i]=mc) then begin
                nom:=i;
                break;
              end;
            if nom=0 then begin
              if not((form2.SG1.RowCount=2)and(form2.SG1.cells[1,1]='')) then
                form2.SG1.RowCount:=form2.SG1.RowCount+1;
              nom:=form2.SG1.RowCount-1;
            end;

              ini:=tMemInifile.Create(extractfilepath(application.ExeName)+'properties.ini');
              try
                ini.WriteInteger('OUT_TCP','count',nom);
                ini.WriteString('OUT_TCP','ip_'+inttostr(nom),ip);
                ini.WriteString('OUT_TCP','dir_'+inttostr(nom),dir);
                ini.WriteString('OUT_TCP','mask_'+inttostr(nom),mc);
                ini.WriteString('OUT_TCP','stan_'+inttostr(nom),stat);
                ini.WriteString('OUT_TCP','time_'+inttostr(nom),FormatDateTime('yyy.mm.dd',now));
                form2.SG1.Cells[1,nom]:=ip;
                form2.SG1.Cells[2,nom]:=mc;
                form2.SG1.Cells[3,nom]:=dir;
                form2.SG1.Cells[4,nom]:=FormatDateTime('yyy.mm.dd',now);
                form2.SG1.Cells[5,nom]:=stat;

                ini.UpdateFile;
              finally
                FreeAndNil(ini);
              end;
end;



//---------new seach------------------------

procedure FileFinder(Path,maska:string;recur:boolean;sl:TStringList);
var
  r:TSearchRec;
  mak:string;
begin
  if (Path[Length(Path)]='\') then SetLength(Path,Length(Path)-1);
  if recur then
    mak:='*'
  else
    mak:=maska;

if FindFirst(PAth+'\'+mak, faAnyFile,r)=0 then   begin
  if (r.Attr or faDirectory)=r.Attr then begin
    if recur then begin
      if (r.Name<>'.')and(r.Name<>'..') then
        FileFinder(path+'\'+r.name,maska,recur,sl)
    end;
  end
  else
      if MatchesMask(r.Name,maska) then
        sl.Add(path+'\'+r.Name);
  while (FindNext(r)=0) do
    if (r.Attr or faDirectory)=r.Attr then begin
      if recur then begin
        if (r.Name<>'.')and(r.Name<>'..') then
          FileFinder(path+'\'+r.name,maska,recur,sl)
      end;
    end
    else
      if MatchesMask(r.Name,maska) then
        sl.Add(path+'\'+r.Name);
end;

  FindClose(r);

end;

//------------end new seach-------------

// -------search FTP-------------------------------------
procedure FtpFileFinder(Path:ftp_type;maska:string;recur:boolean;sl:TStringList; stan:string);
var
  idFTP: TIdFTP;  
  i: Integer;
  ddt: string;
  download: Boolean;
begin
  download := True;
  if (stan = '3') or (stan = '8') or (stan = '4') or (stan = '5') or (stan = '6') or (stan = '7') then
    download := false;

  idFTP := TIdFTP.Create(nil);
  try
    try
      idFTP.Host := Path.ip;
      idFTP.Port := 21;
      if Path.user<>'' then
        idFTP.Username := Path.user
      else
         idFTP.Username := 'anonymous';
      idFTP.Password := Path.pass;
      idFTP.Passive:= True;

      MainForm.addlog('Спроба підключитись на FTP: ' + idFTP.Host, 1);

      idFTP.Connect();

      MainForm.addlog('Підключено на FTP: ' + idFTP.Host, 1);

      if Trim(Path.dir) <> '' then
        idFTP.ChangeDir(Path.dir);
      idFTP.List(sl, maska, False);
      if sl.Count = 0 then begin
        MainForm.addlog('Не знайдено файлів в " '+Path.dir+'" по масці: ' + maska, 1);
        Exit;
      end;

      ddt:= ExtractFilePath(Application.ExeName) + formatdatetime('yyyymmddhhnnsszzz',Now)+'\';

      if download then
        ForceDirectories(ddt);

      i:=0;
      while i <= sl.Count - 1 do begin
        if Pos('/',sl[i])>0 then
          sl.Delete(i)
        else begin
          if download then begin
            try
              idFTP.Get(sl[i],ddt+sl[i],True);
              MainForm.addlog('В папці "'+Path.dir+'" знайдено файл "'+ sl[i] + '" і завантажено в тимчасову папку: ' + ddt, 1);
            except on e: exception do
              MainForm.addlog(e.ClassName + ' викликало помилку: ' + e.Message, 0);
            end;
          end;
          sl[i]:= ddt + sl[i];
          Inc(i);
        end;
      end;


    except
    on e: exception do
        MainForm.addlog(e.ClassName + ' викликало помилку: ' + e.Message, 0);

    end;


  finally
    idFTP.Disconnect;
    MainForm.addlog('Відключено від FTP: ' + idFTP.Host, 1);
    FreeAndNil(idFTP);
  end;


end;
// ------- end search FTP-------------------------------------

// -------del from FTP-------------------------------------
procedure DelFromFTP(Path:ftp_type;sl:TStringList; fileName:string = '');
var
  idFTP: TIdFTP;
  i: Integer;
begin
if not Path.ftp then
  Exit;
  
  idFTP := TIdFTP.Create(nil);
  try
    try
      idFTP.Host := Path.ip;
      idFTP.Port := 21;
      if Path.user<>'' then
        idFTP.Username := Path.user
      else
         idFTP.Username := 'anonymous';
      idFTP.Password := Path.pass;
      idFTP.Passive:= True;

      MainForm.addlog('Спроба підключитись для видалення на FTP: ' + idFTP.Host, 1);

      idFTP.Connect();

      MainForm.addlog('Підключено для видалення на FTP: ' + idFTP.Host, 1);

      if Trim(Path.dir) <> '' then
        idFTP.ChangeDir(Path.dir);

      if fileName='' then
        for I := 0 to sl.Count - 1 do  begin
          try
            idFTP.Delete(ExtractFileName(sl[i]));
            MainForm.addlog('Видалено "'+ExtractFileName(sl[i])+'" з папки "'+Path.dir+'" на ФТП: '+ idFTP.Host, 1);
          except on e: exception do
            MainForm.addlog(e.ClassName + ' викликало помилку: ' + e.Message, 0);
          end;
        end
      else begin
        try
          idFTP.Delete(ExtractFileName(fileName));
          MainForm.addlog('Видалено "'+ExtractFileName(fileName)+'" з папки "'+Path.dir+'" на ФТП: '+ idFTP.Host, 1);
        except on e: exception do
          MainForm.addlog(e.ClassName + ' викликало помилку: ' + e.Message, 0);
        end;
      end;

    except
    on e: exception do
        MainForm.addlog(e.ClassName + ' викликало помилку: ' + e.Message, 0);

    end;


  finally
    idFTP.Disconnect;
    MainForm.addlog('Відключено від FTP: ' + idFTP.Host, 1);
    FreeAndNil(idFTP);
  end;

end;

// ------- end del from FTP-------------------------------------

// -------upload to FTP-------------------------------------
function UploadToFTP(Path:ftp_type;sl:TStringList; notOverWrite: boolean): Boolean;
var
  idFTP: TIdFTP;
  i: Integer;
begin
  Result:= False;
  idFTP := TIdFTP.Create(nil);
  try
    try
      idFTP.Host := Path.ip;
      idFTP.Port := 21;
      if Path.user<>'' then
        idFTP.Username := Path.user
      else
         idFTP.Username := 'anonymous';
      idFTP.Password := Path.pass;
      idFTP.Passive:= True;

      MainForm.addlog('Спроба підключитись для завантаження на FTP: ' + idFTP.Host, 1);

      idFTP.Connect();

      MainForm.addlog('Підключено для завантаження на FTP: ' + idFTP.Host, 1);

      if Trim(Path.dir) <> '' then
        idFTP.ChangeDir(Path.dir);

      for I := 0 to sl.Count - 1 do  begin
        try
          if notOverWrite then
            if IdFTP.Size(ExtractFileName(sl[i]))>0 then begin
              MainForm.addlog('Файл "'+ExtractFileName(sl[i])+'" вже є в папці "'+Path.dir+'" на ФТП: '+ idFTP.Host, 1);
              sl[i]:= sl[i] + ';0';
              Continue;
            end;


          idFTP.Put(sl[i],ExtractFileName(sl[i]),false);
          MainForm.addlog('Завантажено "'+sl[i]+'" в папку "'+Path.dir+'" на ФТП: '+ idFTP.Host, 1);
          sl[i]:= sl[i] + ';1';
        except on e: exception do begin
          MainForm.addlog(e.ClassName + ' викликало помилку: ' + e.Message, 0);
          sl[i]:= sl[i] + ';0';
        end;

        end;
      end


    except
    on e: exception do
        MainForm.addlog(e.ClassName + ' викликало помилку: ' + e.Message, 0);

    end;

    Result:=True;
  finally
    idFTP.Disconnect;
    MainForm.addlog('Відключено від FTP: ' + idFTP.Host, 1);
    FreeAndNil(idFTP);
  end;

end;

// ------- end upload to FTP-------------------------------------

procedure delTmpDir(rlwr: ftp_type; dir: string);
var
  dirPath: string;
begin
  if not rlwr.ftp then
    Exit;

  dirPath:= ExtractFileDir(dir);
  if DeleteDirectory(dirPath, False) then
    MainForm.addlog('Видалено тимчасову папку "'+dirPath + '"', 1)
  else
    MainForm.addlog('НЕ видалено тимчасову папку "'+dirPath + '"' + '. Код помилки ' + IntToStr(GetLastError), 0);


end;

var
  makin:maktype;
  k:integer;
  mak,ip,dir:string;
  Sl:TstringList;
  NotOverWrite:boolean;
  j:integer;
  rlwr: ftp_type;
begin

  sl := tStringList.Create;
  try
    try
      k := 1;
//-----------8-----------------------
      if stan = '8' then
      begin
        rlwr := ftp_str(realwhere);
        if rlwr.ftp then
          FtpFileFinder(rlwr, '*', recur, sl, Stan)
        else
          FileFinder(realwhere, '*', recur, sl);

        for I := 0 to sl.Count - 1 do
        begin
          if delall(obj, extractFileName(sl[i])) = false then
            if rlwr.ftp then
               DelFromFTP(rlwr,sl,sl[i])
            else
              if deletefile(pansichar(sl[i])) then
                MainForm.addlog(extractFileName(sl[i]) + ' видалено з ' + extractFilePath(sl[i]), 1)
              else
                MainForm.addlog(extractFileName(sl[i]) + ' не видалено з ' + extractFilePath(sl[i]) + '. Код помилки ' + IntToStr(GetLastError), 0);
        end;
      end
//----------end 8------------------------
//-----------1234567---------------------
      else
      begin
        sl.Clear;
        while k <= length(obj) do
        begin
          makin := ober(obj, k);
          mak := makin.nam;
          k := makin.ind + 1;

          rlwr := ftp_str(realwhere);
          realwhere := rlwr.dir;
          if rlwr.ftp then
            FtpFileFinder(rlwr, mak, recur, sl, Stan)
          else
            FileFinder(realwhere, mak, recur, sl);
        end;

        if sl.Count > 0 then
        begin

          if (Stan = '1') or (Stan = '1.1') then
          begin
              notOverWrite:= Stan = '1.1';
//            if (Stan = '1') then
//              notOverWrite := false
//            else
//              notOverWrite := true;

            if tcp then
            begin
              ip := tcp_str(where).ip;
              dir := tcp_str(where).dir;

              MainForm.addlog('Підготовлено файл(и) для копіювання до' + where, 1);
              if sendtcp(ip, dir, mc, MainForm.ZM1.CompressFiles(sl), NotOverWrite{,i}) then
              begin
                MainForm.addlog('Файл(и) скопійовано до ' + where, 1);
                sendStat(ip, dir, mc, '2');
              end
              else
              begin
                MainForm.addlog('Файл(и) НЕ скопійовано до ' + where, 0);
                sendStat(ip, dir, mc, '3');
              end;
              delTmpDir(rlwr,Sl[0]);

            end
            else if ftp then begin
               UploadToFTP(ftp_str(where),sl,NotOverWrite);
            end
            else
            begin
              if where[length(where)] <> '\' then
                where := where + '\';
              forcedirectories(where);
              for I := 0 to sl.Count - 1 do
              begin
                if copyfile(pansichar(sl[i]), pansichar(where + extractFileName(sl[i])), NotOverWrite) then
                  MainForm.addlog(extractFileName(sl[i]) + ' скопійовано з ' + extractFilePath(sl[i]) + ' до ' + where, 1)
                else
                  MainForm.addlog(extractFileName(sl[i]) + '  не скопійовано з ' + extractFilePath(sl[i]) + ' до ' + where + '. Код помилки ' + IntToStr(GetLastError), 0);
              end;
              delTmpDir(rlwr,Sl[0]);
            end
          end;

          if (Stan = '2') or (Stan = '2.1') then
          begin
            notOverWrite := Stan = '2.1' ;
//            if (Stan = '2') then
//              notOverWrite := false
//            else
//              notOverWrite := true;

            if tcp then 
            begin
              ip := tcp_str(where).ip;
              dir := tcp_str(where).dir;

              MainForm.addlog('Підготовлено файл(и) для переміщеня до' + where, 1);
              if sendtcp(ip, dir, mc, MainForm.ZM1.CompressFiles(sl), notOverWrite{,i}) then
              begin
                MainForm.addlog('Файл(и) переміщено  до ' + where, 1);
                for j := 0 to sl.Count - 1 do
                  deletefile(pansichar(sl[j]));
                DelFromFTP(rlwr, sl);
                sendStat(ip, dir, mc, '2');
              end
              else
              begin
                MainForm.addlog('Файл(и) НЕ переміщено  до ' + where, 0);
                sendStat(ip, dir, mc, '3');
              end;
              delTmpDir(rlwr,Sl[0]);
              //end;
            end
            else if ftp then begin
               if UploadToFTP(ftp_str(where),sl,NotOverWrite) then begin
//                i:=0;
//                while i <= sl.Count - 1 do begin
//                  if split(sl[i],';',2)='0' then
//                    sl.Delete(i)
//                  else begin
//                    sl[i]:= split(sl[i],';',1);
//                    Inc(i);
//                  end;
//                end;

                for I := 0 to sl.Count - 1 do
                begin
                  if split(sl[i],';',2)='1' then
                    if deletefile(pansichar(split(sl[i],';',1))) then
                      MainForm.addlog('Переміщено на ФТП файл ' + split(sl[i],';',1), 1)
                    else
                      MainForm.addlog('Преміщено на ФТП але не видалено початковий  файл ' + split(sl[i],';',1) + '. Код помилки ' + IntToStr(GetLastError), 0);
                  end;

                //DelFromFTP(ftp_str(where),Sl);
               end;
            end
            else
            begin

              if where[length(where)] <> '\' then
                where := where + '\';
              forcedirectories(where);
              for I := 0 to sl.Count - 1 do
              begin
                if notOverWrite = false then
                begin
                  if movefile(pansichar(sl[i]), pansichar(where + extractFileName(sl[i]))) then begin
                    MainForm.addlog(extractFileName(sl[i]) + ' переміщено з ' + extractfilepath(sl[i]) + ' до ' + where, 1);
                    DelFromFTP(rlwr, sl, sl[i]);
                  end
                  else if (GetLastError = 80) or (GetLastError = 183) then
                  begin
                    deletefile(pansichar(where + extractFileName(sl[i])));

                    if movefile(pansichar(sl[i]), pansichar(where + extractFileName(sl[i]))) then begin
                      MainForm.addlog(extractFileName(sl[i]) + ' переміщено із заміною з ' + extractfilepath(sl[i]) + ' до ' + where, 1);
                      DelFromFTP(rlwr, sl, sl[i]);
                    end
                    else
                      MainForm.addlog(extractFileName(sl[i]) + '  не переміщено з ' + extractfilepath(sl[i]) + ' до ' + where + '. Код помилки ' + IntToStr(GetLastError), 0);
                  end
                end
                else if movefile(pansichar(sl[i]), pansichar(where + extractFileName(sl[i]))) then begin
                  MainForm.addlog(extractFileName(sl[i]) + ' переміщено з ' + extractfilepath(sl[i]) + ' до ' + where, 1);
                  DelFromFTP(rlwr, sl, sl[i]);
                end
                else
                  MainForm.addlog(extractFileName(sl[i]) + '  не переміщено з ' + extractfilepath(sl[i]) + ' до ' + where + '. Код помилки ' + IntToStr(GetLastError), 0);
              end;
              delTmpDir(rlwr,Sl[0]);

            end

          end;

          if Stan = '3' then
          begin
            if rlwr.ftp then
              DelFromFTP(rlwr, sl)
            else
              for I := 0 to sl.Count - 1 do
              begin
                if deletefile(pansichar(sl[i])) then
                  MainForm.addlog(extractFileName(sl[i]) + ' видалено з ' + extractfilepath(sl[i]), 1)
                else
                  MainForm.addlog(extractFileName(sl[i]) + '  не видалено з ' + extractfilepath(sl[i]) + '. Код помилки ' + IntToStr(GetLastError), 0);
              end;
          end;

          if Stan = '4' then
          begin
            ShellExecute(0, nil, pchar(where), nil, nil, SW_SHOWNORMAL);
                  //winexec(pansichar(where),sw_show);
            if getlasterror = 0 then
              MainForm.addlog(extractFileName(sl[0]) + ' знайдено у ' + extractfilepath(sl[0]) + ' і запущено файл ' + where, 1)
            else
              MainForm.addlog(extractFileName(sl[0]) + ' знайдено у ' + extractfilepath(sl[0]) + ', але не запущено файл ' + where + '. Код помилки ' + IntToStr(GetLastError), 0);
          end;

          if Stan = '5' then
          begin
        //ShellExecute(0, nil, pchar(where), nil, nil, SW_SHOWMINNOACTIVE);
            winexec(pansichar(where), sw_show);
            if getlasterror = 0 then
              MainForm.addlog(extractFileName(sl[0]) + ' знайдено у ' + extractfilepath(sl[0]) + ' і виконано команду ' + where, 1)
            else
              MainForm.addlog(extractFileName(sl[0]) + ' знайдено у ' + extractfilepath(sl[0]) + ', але не виконано команду ' + where + '. Код помилки ' + IntToStr(GetLastError), 0);
          end;

          if Stan = '6' then
          begin
            for I := 0 to sl.Count - 1 do
            begin
              if where = '' then
            //application.MessageBox(PAnsiChar('В дерикторії - '+extractfilepath(sl[i])+' - знайдено файл - '+#13#10+#13#10+extractFileName(sl[i])),'Mover Повідомлення', mb_iconInformation+mb_OK)
                MessageBox(0, PChar('В дерикторії - ' + realwhere + ' - знайдено файл - ' + #13#10 + #13#10 + extractFileName(sl[i])), 'Mover', MB_OK or MB_ICONINFORMATION or MB_TASKMODAL)
              else
            //application.MessageBox(PAnsiChar(Where),'Mover Повідомлення', mb_iconInformation+mb_OK);
                MessageBox(0, PChar(where), 'Mover', MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
              if getlasterror = 0 then
                MainForm.addlog(extractFileName(sl[i]) + ' знайдено у ' + extractfilepath(sl[i]) + ' і показано повідомлення - ' + where, 1)
              else
                MainForm.addlog(extractFileName(sl[i]) + ' знайдено у ' + extractfilepath(sl[i]) + ', але повідомлення не показано. Код помилки ' + IntToStr(GetLastError), 0);
            end;
          end;

          if Stan = '7' then
          begin
            if where = '' then
              MainForm.addlog('Незадані параметри для перейменування файлу', 2)
            else
            begin
              for I := 0 to sl.Count - 1 do
              begin
                if renamefile(pansichar(sl[i]), pansichar(extractfilepath(sl[i]) + MainForm.renam(where, extractFileName(sl[i])))) then
                  MainForm.addlog('У ' + extractfilepath(sl[i]) + ' перейменовано файл з ' + extractFileName(sl[i]) + ' на ' + MainForm.renam(where, extractFileName(sl[i])), 1)
                else
                  MainForm.addlog('У ' + extractfilepath(sl[i]) + ' не перейменовано файл з ' + extractFileName(sl[i]) + ' на ' + MainForm.renam(where, extractFileName(sl[i])) + ' . Код помилки ' + IntToStr(GetLastError), 0);
              end;
            end;
          end;

        end;

      end;

//-----------END 1234567---------------------


    except
      on e: exception do
        MainForm.addlog(e.ClassName + ' викликало помилку: ' + e.Message, 0);
    end

  finally
    FreeAndNil(sl);
  end;

end;


//----------------------------end NEW FIND----------------------------------------------------------

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

function maxday(d,y:integer):integer;
begin

  if (d=01)or(d=03)or(d=05)or(d=07)or(d=08)or(d=10)or(d=12) then
  maxday:=31;

  if (d=04)or(d=06)or(d=09)or(d=11) then
  maxday:=30;

  if (d=02) and (y mod 4 = 0) then
  maxday:=29;

  if (d=02) and (y mod 4 <> 0) then
  maxday:=28;

  if (d=00) then
  maxday:=31;

end;

function TMainForm.mass(mask: string; pars: boolean = false):maskType;
type
  newD=record
    d:tDateTime;
    s:String;
  end;

function newDate(d,znak:string;l,t:integer;dt:tDateTime):newD;
var
  j,a:integer;
  s:string;
  dat:tdatetime;
begin
  j:=l+2;
  s:='';
          while d[j] in ['0'..'9'] do  begin
            s:=s+d[j];
            j:=j+1;
          end;
          delete(d,(l+1),(j-l-1));
          a:=strtoint(s);
          if znak='-' then begin
            case t of
            1: dat:=IncDay(dt,-a);
            2: dat:=IncMonth(dt,-a);
            3: dat:=IncYear(dt,-a);
            end;
          end
          else begin
            case t of
            1: dat:=IncDay(dt,+a);
            2: dat:=IncMonth(dt,+a);
            3: dat:=IncYear(dt,+a);
            end;
          end;


        result.d:=dat;//formatdatetime(d,dat);
        result.s:=d;
end;

var
  i,k,l:smallint;
  newmask,d:string;
  dat:tdatetime;
  a:newD;
begin
  i:=1;
  for k:=0 to 6 do
  result.Day[k]:=0;
  result.time1:='';
  result.time2:='';
  result.tcp:=false;
  Result.ftp:=False;
  result.recur:=false;
  k:=0;
    while i<=length(mask) do begin
      if (mask[i]<>'<') then
       newmask:=newmask+mask[i]
      else begin
        d:='';
        inc(i);

        while (mask[i]<>'>') and (i<=length(mask)) do begin
          d:=d+mask[i];
          inc(i);
        end;

        if pars=false then begin

            if (pos('D',AnsiUpperCase(d))>0)or(pos('M',AnsiUpperCase(d))>0)or(pos('Y',AnsiUpperCase(d))>0)
            or(pos('H',AnsiUpperCase(d))>0)or(pos('N',AnsiUpperCase(d))>0)or(pos('S',AnsiUpperCase(d))>0) then begin

              dat:=now;
              l:=pos('D-',AnsiUpperCase(d));
              if l>0 then begin
                a:=newDate(d,'-',l,1,dat);
                d:=a.s;
                dat:=a.d;
              end;
              l:=pos('D+',AnsiUpperCase(d));
              if l>0 then begin
                a:=newDate(d,'+',l,1,dat);
                d:=a.s;
                dat:=a.d;
              end;
              l:=pos('M-',AnsiUpperCase(d));
              if l>0 then begin
                a:=newDate(d,'-',l,2,dat);
                d:=a.s;
                dat:=a.d;
              end;
              l:=pos('M+',AnsiUpperCase(d));
              if l>0 then begin
                a:=newDate(d,'+',l,2,dat);
                d:=a.s;
                dat:=a.d;
              end;
              l:=pos('Y-',AnsiUpperCase(d));
              if l>0 then begin
                a:=newDate(d,'-',l,3,dat);
                d:=a.s;
                dat:=a.d;
              end;
              l:=pos('Y+',AnsiUpperCase(d));
              if l>0 then begin
                a:=newDate(d,'+',l,3,dat);
                d:=a.s;
                dat:=a.d;
              end;

              d:=formatdateTime(d,dat);

              newmask:=newmask+d;
            end;


        end;

        if (ansiUpperCase(d)='*')or(ansiUpperCase(d)='.*')or(ansiUpperCase(d)='*.') then begin
          newmask:=newmask+'<'+d+'>';
        end

        else begin
          if (pos('D',AnsiUpperCase(d))>0)or(pos('M',AnsiUpperCase(d))>0)or(pos('Y',AnsiUpperCase(d))>0)
            or(pos('H',AnsiUpperCase(d))>0)or(pos('N',AnsiUpperCase(d))>0)or(pos('S',AnsiUpperCase(d))>0) then
            newmask:=newmask+'<'+d+'>';
        end;

          if (AnsiUpperCase(d)='ПН')and(k<7) then begin result.Day[k]:=2; k:=k+1 end;
          if (AnsiUpperCase(d)='ВТ')and(k<7) then begin result.Day[k]:=3; k:=k+1 end;
          if (AnsiUpperCase(d)='СР')and(k<7) then begin result.Day[k]:=4; k:=k+1 end;
          if (AnsiUpperCase(d)='ЧТ')and(k<7) then begin result.Day[k]:=5; k:=k+1 end;
          if (AnsiUpperCase(d)='ПТ')and(k<7) then begin result.Day[k]:=6; k:=k+1 end;
          if (AnsiUpperCase(d)='СБ')and(k<7) then begin result.Day[k]:=7; k:=k+1 end;
          if (AnsiUpperCase(d)='НД')and(k<7) then begin result.Day[k]:=1; k:=k+1 end;

          if (AnsiUpperCase(d)='TCP') then begin result.tcp:=true; end;
          if (AnsiUpperCase(d)='FTP') then begin result.ftp:=true; end;
          if (AnsiUpperCase(d)='RECUR') then begin result.recur:=true; end;

          if MatchesMask(d,'??:??')then
            if (result.time1='')or((result.time1=result.time2)and(strtotime(result.time1)>strtotime(d))) then
              result.time1:=d+':00';
          if (MatchesMask(d,'??:??'))then
            if (result.time2='')or(result.time1=result.time2) then
           result.time2:=d+':00'
      end;

      i:=i+1;
    end;

    result.nameMask:=newmask;

end;

function TMainForm.renam(mask,nameF: string):string;
var
i:smallint;
a,b:string;
begin
i:=1;

 while( mask[i]<>'%') and (i<=length(mask)) do begin
      a:=a+mask[i];
      inc(i);
 end;
 inc(i);
 while i<=length(mask) do begin
      b:=b+mask[i];
       inc(i);
      end;

 if AnsiupperCase(a)='<*>' then begin
  a:=nameF;
  result:=StringReplace(Namef, a, b, [rfReplaceAll, rfIgnoreCase]);
 end
 else
 if AnsiupperCase(a)='<*.>' then begin
  a:=ChangeFileExt(nameF,'');
  nameF:=copy(nameF,length(a)+1,maxint);
  result:=b+namef;
 end
 else
 if AnsiupperCase(a)='<.*>' then begin
  if b[1]='.' then
    result:=ChangeFileExt(NameF,b)
  else
    result:=ChangeFileExt(NameF,'.'+b);
 end
 else
  result:=StringReplace(Namef, a, b, [rfReplaceAll, rfIgnoreCase]);


end;


{procedure tMainForm.addlog(text:string;EventSeverity:integer);
var
  LogPath:string;
begin

logPath:=extractfilepath(application.exename)+'Log\';
  forceDirectories(logPath);

log1.FileName:=logPath+'Mover_'+formatdatetime('yyyy"_"mm"_"dd"',now)+'.log';
log1.AutoSave:=true;

    try
        MainForm.JvTrayIcon1.BalloonHint('Mover v.'+vers,text,btInfo);
        case EventSeverity of
          0 :
            log1.Add('Mover',lesError,text);
          1 :
            log1.Add(formatdatetime('dd"."mm"."yyy" "hh":"mm":"ss',now),'Mover',text);
          2 :
            log1.Add('Mover',lesWarning,text);
         end;
    except on e:exception do
      MainForm.addlog(e.Message,0);
    end;

end; }

procedure TMainForm.addlog(text:string;event:integer);
var
  FS:TFileStream;
//  F: TextFile;
  fn,LogPath,ev: string;
begin
{ event:
 0 :Error;
 1 :OK
 2 :Warning
}
  case event of
    0: ev:='Error';
    1: ev:='Information';
    2: ev:='Warning';

  end;
    try
      logPath:=extractfilepath(application.exename)+'Log\';
      forceDirectories(logPath);

      FN:=logPath+'Mover_'+formatdatetime('yyyy"_"mm"_"dd"',now)+'.log';

      if Fileexists(FN) then
        fs:=TFileStream.Create(FN, fmOpenReadWrite+fmShareDenyNone)
      else
        fs:=TFileStream.Create(FN, fmCreate);

      fs.Position:=fs.Size;
      if MainForm.CheckBox2.Checked then
        MainForm.JvTrayIcon1.BalloonHint('Mover v.'+vers,text,btInfo);
      text:='['+formatdatetime('dd"."mm"."yyy" "hh":"mm":"ss',now)+']'+ev+'>Mover v'+MainForm.vers+'>'+text+#13#10;
      fs.Write(text[1],length(text));

    finally
      fs.Free;
    end;



end;


procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if shutDown=true then
    CanClose:=true
  else
    CanClose:=application.MessageBox('Ви дійсно бажаєте завершити роботу?','Mover',mb_iconQuestion+mb_YesNo)=idYes;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  ini:tmeminifile;

//CheckEvent:TEvent;
begin
   log1.Active:=true;


{CheckEvent:= TEvent.Create( nil, false, true, 'MYPROGRAM_CHECKEXIST' );
try
If CheckEvent.WaitFor( 10 ) <> wrSignaled then
begin
application.MessageBox('Один екземпляр програми вже запущено...','Mover',mb_iconInformation+mb_ok);
freeandnil(CheckEvent);
halt;
end;
finally
  freeandnil(CheckEvent);
end;
}
//--------------------------
  shutDown:=False;
  Application.HelpFile:=ExtractFilePath(Application.ExeName)+'help.chm';

  Ini:=TmemIniFile.Create(ExtractFilePath(Application.ExeName)+'Properties.ini');
  try
    v:=ini.ReadString('GENERAL','vers','');

    //Ini.Writestring('UPD','source','http://10.202.14.15/mover/');
    Ini.Writestring('GENERAL','vers',vers);


    checkbox2.Checked:=ini.ReadBool('LOG','ballon',checkbox2.Checked);
    SpeedButton2.Parent := SG1;
  finally
    ini.UpdateFile;
    ini.free;
  end;


 jvtrayicon1.Hint:='Mover server v.'+vers;

 addlog('*** Mover запущено... v.'+vers+' ***',1);

    ReadParams;

 TcpServer1.LocalHost:=GetLocalIP;
  if TcpServer1.LocalHost<>'127.0.0.1' then begin
    WEBreg;
   TcpServer1.LocalPort:='30000';
   tcpserver1.Active:=true;

   addlog('TCP is ACTIVE *** '+tcpserver1.LocalHost+' * '+tcpserver1.LocalPort,1);
    up;
  end;


 
  SpeedButton1.Visible := false;

  SG1.Cells[0,0]:='№';
  SG1.Cells[1,0]:='###';
  SG1.Cells[4,0]:='Стан';
  SG1.Cells[2,0]:='Місце призначення';
  SG1.Cells[3,0]:='Маска';
  SG1.ColWidths[0]:=25;
  SG1.ColWidths[1]:=30;
  SG1.ColWidths[2]:=285;
  SG1.ColWidths[3]:=99;
  SG1.ColWidths[4]:=30;

  SG2.Cells[0,0]:='№';
  SG2.Cells[1,0]:='Перевіряти папки';
  SG2.ColWidths[0]:=30;
  SG2.ColWidths[1]:=440;

  MainForm.Caption:='Налаштування v.'+vers;






//   addlog(inttostr(getlasterror));





   MainForm.timer1.Interval:=strtoint(MainForm.Edit1.Text)*1000;
   MainForm.timer1.Enabled:=true;


end;


procedure TMainForm.N1Click(Sender: TObject);
begin
close();
end;

procedure Motor(g:boolean=false);
var
  k:smallint;
  s,i:integer;
  obj:maskType;
  where,realwhere,stan:string;
//ini:tMemInifile;
begin

  if MainForm.TcpServer1.LocalHost='127.0.0.1' then begin
     MainForm.TcpServer1.LocalHost:=GetLocalIP;
     if MainForm.TcpServer1.LocalHost<>'127.0.0.1'then begin
       MainForm.WEBreg;
       MainForm.TcpServer1.LocalPort:='30000';
       MainForm.TcpServer1.Active:=true;
       MainForm.addlog('TCP is ACTIVE *** '+MainForm.TcpServer1.LocalHost+' * '+MainForm.TcpServer1.LocalPort,1);
       up;
     end;
   end;

   
  for s:=1 to MainForm.SG2.RowCount-1 do
  begin
   if g then begin
    MainForm.G1.Progress:=s;
    Mainform.Update;
   end;


    for i:=1 to MainForm.SG1.RowCount-1 do begin

      if (che(MainForm.SG1.Cells[1,i],inttostr(s))=true) and(MainForm.SG1.Cells[4,i]<>'0') then begin

        stan:=MainForm.SG1.Cells[4,i];
        obj:=MainForm.mass(MainForm.SG1.Cells[3,i]);
        where:=MainForm.mass(MainForm.SG1.Cells[2,i]).nameMask;
        realwhere:=MainForm.mass(MainForm.SG2.Cells[1,s]).nameMask;
  //      obj.nameMask:=rez.nameMask;
  //      obj.Day:=rez.Day;
  //      obj.time1:=rez.time1;
  //      obj.time2:=rez.time2;



  //      MessageDlg(inttostr(StringGrid1.RowCount-1)+' * '+inttostr(StringGrid2.RowCount-1) , mtInformation, [mbOK], 0);
  //      try

        if (obj.Day[0]<>0) and (obj.time1='') then
          for k:=0 to 6 do
            if obj.Day[k]=DayOfWeek(now{date}) then
              findanddo(stan,s,i,obj.nameMask,where,realwhere,obj.tcp,obj.ftp,obj.recur,MainForm.SG1.Cells[3,i],MainForm.SG1.Cells[2,i]);

        if (obj.Day[0]=0) and (obj.time1<>'') then
          if (obj.time1=timetostr(time)) or ((time-strtotime(obj.time1)>0)and (time-strtotime(obj.time2)<SecondToTime(MainForm.timer1.Interval div 1000))) then
           findanddo(stan, s,i,obj.nameMask,where,realwhere,obj.tcp,obj.ftp,obj.recur,MainForm.SG1.Cells[3,i],MainForm.SG1.Cells[2,i]);

        if (obj.Day[0]<>0) and (obj.time1<>'') then
          for k:=0 to 6 do
            if obj.Day[k]=DayOfWeek(date) then
              if ((obj.time1=timetostr(time)) or ((time-strtotime(obj.time1)>0)and (time-strtotime(obj.time2)<SecondToTime(MainForm.timer1.Interval div 1000)))) then
                findanddo(stan, s,i,obj.nameMask,where,realwhere,obj.tcp,obj.ftp,obj.recur,MainForm.SG1.Cells[3,i],MainForm.SG1.Cells[2,i]);

        if (obj.Day[0]=0) and (obj.time1='') then
          findanddo(stan, s,i,obj.nameMask,where,realwhere,obj.tcp,obj.ftp,obj.recur,MainForm.SG1.Cells[3,i],MainForm.SG1.Cells[2,i]);

  //     except;

  //     end;

      end;
    end;

  end;
      //namef:='';
  TrimWorkingSet;
end;



procedure TMainForm.Timer1Timer(Sender: TObject);

{  var
  k:smallint;
  s,i:integer;
  obj:maskType;
  where,realwhere,stan:string;  }
//ini:tMemInifile;
begin
  Motor;


{  if TcpServer1.LocalHost='127.0.0.1' then begin
     TcpServer1.LocalHost:=GetLocalIP;
     if TcpServer1.LocalHost<>'127.0.0.1'then begin
       WEBreg;
       TcpServer1.LocalPort:='30000';
       tcpserver1.Active:=true;
       addlog('TCP is ACTIVE *** '+tcpserver1.LocalHost+' * '+tcpserver1.LocalPort,1);
       up;
     end;
   end;

for s:=1 to MainForm.SG2.RowCount-1 do
begin

  for i:=1 to SG1.RowCount-1 do begin

    if (che(SG1.Cells[1,i],inttostr(s))=true) and(SG1.Cells[4,i]<>'0') then begin

      stan:=SG1.Cells[4,i];
      obj:=mass(SG1.Cells[3,i]);
      where:=mass(SG1.Cells[2,i]).nameMask;
      realwhere:=mass(SG2.Cells[1,s]).nameMask;






      if (obj.Day[0]<>0) and (obj.time1='') then
        for k:=0 to 6 do
          if obj.Day[k]=DayOfWeek(now) then
            findanddo(stan,s,i,obj.nameMask,where,realwhere,obj.tcp,obj.recur,SG1.Cells[3,i],SG1.Cells[2,i]);

      if (obj.Day[0]=0) and (obj.time1<>'') then
        if (obj.time1=timetostr(time)) or ((time-strtotime(obj.time1)>0)and (time-strtotime(obj.time2)<SecondToTime(timer1.Interval div 1000))) then
         findanddo(stan, s,i,obj.nameMask,where,realwhere,obj.tcp,obj.recur,SG1.Cells[3,i],SG1.Cells[2,i]);

      if (obj.Day[0]<>0) and (obj.time1<>'') then
        for k:=0 to 6 do
          if obj.Day[k]=DayOfWeek(date) then
            if ((obj.time1=timetostr(time)) or ((time-strtotime(obj.time1)>0)and (time-strtotime(obj.time2)<SecondToTime(timer1.Interval div 1000)))) then
              findanddo(stan, s,i,obj.nameMask,where,realwhere,obj.tcp,obj.recur,SG1.Cells[3,i],SG1.Cells[2,i]);

      if (obj.Day[0]=0) and (obj.time1='') then
        findanddo(stan, s,i,obj.nameMask,where,realwhere,obj.tcp,obj.recur,SG1.Cells[3,i],SG1.Cells[2,i]);



    end;
  end;

end;
    //namef:='';
TrimWorkingSet;
   }
end;

function Hash(s:string):string;
var
  p,i:Integer;
  ha,p_pow: Int64;
//  x:integer;
begin
  p:= 31;
  ha:= 0;
  p_pow:= 1;
  for i:=1 to  Length(s) do
   begin
    //x:= Ord(s[i]);
    ha :=ha +( (Ord(s[i])-ord('a')+1)*p_pow);
    p_pow:=p_pow*p;

   end;

   result:=inttostr(ha);

end;

procedure TMainForm.WebCfg(s:string);
  function GetXML(s,tag:string):string;
  var
    k,l:Integer;
  begin
    Result:='';
    if Pos(UpperCase('<'+tag+' />'),s)>0 then begin
      Exit;
    end;

    k:=Pos('<'+tag+'>',s);
    l:=Length('<'+tag+'>');
    Result:=StringReplace(Copy(s,k+l,Pos('</'+tag+'>',s)-(k+l)),'&lt;','<',[rfReplaceAll, rfIgnoreCase]);
    Result:=StringReplace(Result,'&gt;','>',[rfReplaceAll, rfIgnoreCase]);
  end;
var
  mov, dir, tmov, tdir:string;
  i:Integer;

begin
 try
  mov:=copy(s,1,Pos('</NewDataSet>',s));
  dir:=copy(s,Pos('</NewDataSet><NewDataSet>',s),Pos('</NewDataSet><INTERVAL>',s));
   i:=1;
  while Pos('<Table>',mov)>0 do begin
    tmov:=Copy(mov,1,Pos('</Table>',mov));
    mov:=Copy(mov,Pos('</Table>',mov)+length('</Table>'),Length(mov));

    MainForm.SG1.Cells[1,i]:=GetXML(tmov,'DIR_N');
    MainForm.SG1.Cells[2,i]:=GetXML(tmov,'MC_PRIZ');
    MainForm.SG1.Cells[3,i]:=GetXML(tmov,'MASK');
    MainForm.SG1.Cells[4,i]:=GetXML(tmov,'STAN');
    MainForm.SG1.RowCount:=i+1;

    i:=i+1;
  end;

  i:=1;
  while Pos('<Table>',dir)>0 do begin
    tdir:=Copy(dir,1,Pos('</Table>',dir));
    dir:=Copy(dir,Pos('</Table>',dir)+length('</Table>'),Length(dir));

    MainForm.SG2.Cells[1,i]:=GetXML(tdir,'DIR');
    MainForm.SG2.RowCount:=i+1;

    i:=i+1;
  end;

  MainForm.edit1.Text:=GetXML(s,'INTERVAL');
  if GetXML(s,'BALOON')='1' then
    MainForm.CheckBox2.Checked:=True
  else
    MainForm.CheckBox2.Checked:=False;


  WriteParams;
   MainForm.addlog('Збереженно нову конфігурацію Mover із сервера',1);

 except  on e:exception do
    MainForm.addlog('При збереженні нової конфігурації Mover '+#13#10+e.ClassName+' викликало помилку '+e.Message,0);
  end;

end;

procedure TMainForm.WEBreg;
    function GetComputerName:string;
    var
      buf: array[0..MAX_COMPUTERNAME_LENGTH] of Char;
      sz:DWORD;
    begin
      sz:=Length(buf);
      if not Windows.GetComputerName(buf,sz) then sz:=0;
      SetString(Result,buf,sz);
    end;

var
  x : moverservSoAP;
  httpRIO : ThttpRIO;
  s, path : string;
  baloon: Integer;
  ini : TMemIniFile;
begin

   httpRIO:= THtTPRIO.create(nil);
  httpRIO.URL:=MainForm.URL+'services/moverserv.asmx?WSDL';
   x:= httprio as MoverServSoap;
   try
   try
    Path:=ExtractFilePath(Application.ExeName);
    baloon:=ord(MainForm.CheckBox2.Checked);
    

    s:=x.REG(MainForm.TcpServer1.LocalHost,GetComputerName,path,MainForm.vers,1,StrToInt(MainForm.edit1.Text),baloon);

    if s='OK' then begin
      MainForm.addlog('Mover зареєстровано на сервері!',1);
      MainForm.TmrWeb.Interval:=30000;

      ini:=TMemIniFile.Create(Path+'Properties.ini');
      try
        ini.WriteBool('UPD','Save',true);
        ini.UpdateFile;
        MainForm.Save:=true;

      finally
        FreeAndNil(ini);
      end;
      Exit;
    end;

    if s='YET' then begin
      MainForm.addlog('Такий Mover вже зареєстрований на сервері!',1);
      MainForm.TmrWeb.Interval:=1800000;
      Exit;
    end;

    MainForm.addlog('При реєстрації Mover на сервері  виникла помилка - '+s,0);
    MainForm.TmrWeb.Interval:=300000;
   except  on e:exception do begin
    MainForm.addlog('При реєстрації Mover '+#13#10+e.ClassName+' викликало помилку '+e.Message,0);
    MainForm.TmrWeb.Interval:=300000;
   end;
   end;

   finally
    x:=nil;
   // freeandnil(httprio);
   end;


end;

procedure CheckCnf();
var
  x : moverservSoAP;
  httpRIO : ThttpRIO;
  s, mov,dir : string;
  I: Integer;
  j: Integer;
begin
  httpRIO:= THtTPRIO.create(nil);
  httpRIO.URL:=MainForm.URL+'services/moverserv.asmx?WSDL';
   x:= httprio as MoverServSoap;
   try
   try
    mov:='';
    for I := 1 to MainForm.SG1.RowCount-1 do begin
      for j := 1 to MainForm.SG1.ColCount - 1 do
        mov := mov + mainform.SG1.Cells[j,i];
    end;

    for I := 1 to MainForm.SG2.RowCount-1 do begin
        dir := dir + mainform.SG2.Cells[1,i];
    end;

    s:=Utf8ToAnsi(x.GetCnf(Hash(AnsiToUtf8(AnsiToUtf8(mov+dir))+MainForm.edit1.Text+inttostr(ord(MainForm.CheckBox2.Checked))),MainForm.TcpServer1.LocalHost));

    if s='OK' then begin
      MainForm.addlog('Конфігурація на сервері ідентична!',1);
      MainForm.TmrWeb.Interval:=1800000;
      Exit;
    end;

    if s='Must Reg' then begin
      MainForm.WEBreg;
      //MainForm.addlog('Оновленно конфігурацію на сервері!',1);
      MainForm.TmrWeb.Interval:=1800000;
      Exit;
    end;

    if Pos('<NewDataSet>',s)>0 then begin
      MainForm.WebCFG(s);
      MainForm.TmrWeb.Interval:=1800000;
      Exit;
    end;


      MainForm.TmrWeb.Interval:=300000;
    MainForm.addlog('При оновлені конфігурації на сервері  виникла помилка - '+s,0);
   except  on e:exception do begin
    MainForm.addlog('При оновлені конфігурації '+#13#10+e.ClassName+' викликало помилку '+e.Message,0);
    MainForm.TmrWeb.Interval:=300000;
   end;
   end;

   finally
    x:=nil;
    //freeandnil(httprio);
   end;

end;

procedure SaveCnf();
var
  x : moverservSoAP;
  httpRIO : ThttpRIO;
  s, dir_id,MC,mas,stan,dir, path : string;
  I: Integer;
  ini: TMemIniFile;
begin
  httpRIO:= THtTPRIO.create(nil);
  httpRIO.URL:=MainForm.URL+'services/moverserv.asmx?WSDL';
   x:= httprio as MoverServSoap;
   try
   try
    for I := 1 to MainForm.SG1.RowCount-1 do begin
      if i=1 then
        dir_id :=mainform.SG1.Cells[1,i]
      else
        dir_id := dir_id + '^'+mainform.SG1.Cells[1,i];

      if i=1 then
        MC:=mainform.SG1.Cells[2,i]
      else
        MC := MC + '^'+mainform.SG1.Cells[2,i];

      if i=1 then
        mas:=mainform.SG1.Cells[3,i]
      else
        mas := mas + '^'+mainform.SG1.Cells[3,i];

      if i=1 then
        stan:=mainform.SG1.Cells[4,i]
      else
        stan := stan + '^'+mainform.SG1.Cells[4,i];


    end;
    for I := 1 to MainForm.SG2.RowCount-1 do begin
      if i=1 then
        dir:=mainform.SG2.Cells[1,i]
      else
        dir := dir + '^'+mainform.SG2.Cells[1,i];


    end;

    s:=x.SetCnf(dir_id,MC,mas,stan,dir,MainForm.TcpServer1.LocalHost,strtoint(MainForm.edit1.Text),ord(MainForm.CheckBox2.Checked));

    if s='OK' then begin
      MainForm.addlog('Оновленно конфігурацію на сервері!',1);
      Path:=ExtractFilePath(Application.ExeName);
      ini:=TMemIniFile.Create(Path+'Properties.ini');
      try 
        ini.WriteBool('UPD','Save',false);
        ini.UpdateFile;
        MainForm.Save:=False;

      finally
        FreeAndNil(ini);
      end;
      MainForm.TmrWeb.Interval:=1800000;
      Exit;
    end;

    if s='Must Reg' then begin
      MainForm.WEBreg;
      //MainForm.addlog('Оновленно конфігурацію на сервері!',1);
      MainForm.TmrWeb.Interval:=1800000;
      Exit;
    end;

    MainForm.TmrWeb.Interval:=300000;

    MainForm.addlog('При оновлені конфігурації на сервері  виникла помилка - '+s,0);
   except  on e:exception do begin
    MainForm.addlog('При оновлені конфігурації '+#13#10+e.ClassName+' викликало помилку '+e.Message,0);
    MainForm.TmrWeb.Interval:=300000;
   end;
   end;

   finally
    x:=nil;
    //freeandnil(httprio);
   end;

end;

procedure TMainForm.TmrWebTimer(Sender: TObject);
begin

   try

    if save then begin
      SaveCnf;
    end
    else
      CheckCnf;

   finally

   end;


end;

procedure TMainForm.UPTimerTimer(Sender: TObject);
begin
  up;
end;

procedure TMainForm.N3Click(Sender: TObject);
var
  mov,dir : string;
  i,j:Integer;
begin
  mov:='';
    for I := 1 to MainForm.SG1.RowCount-1 do begin
      for j := 1 to MainForm.SG1.ColCount - 1 do
        mov := mov + mainform.SG1.Cells[j,i];
    end;

    for I := 1 to MainForm.SG2.RowCount-1 do begin
        dir := dir + mainform.SG2.Cells[1,i];
    end;

     hs:=Hash(mov+dir+MainForm.edit1.Text+inttostr(ord(MainForm.CheckBox2.Checked)));

  timer1.Enabled:=false;
  TmrWeb.Enabled:=False;
  MainForm.ReadParams;
  Application.MainForm.Visible:=True;
  SetForegroundWindow(Application.Handle);
  jvtrayicon1.ApplicationVisible;
//MainForm.Show;
//MainForm.Activate;
end;


//------------------------------------------------------------------------------


procedure TMainForm.WriteParams;
Var
  IniFile:TmemIniFile;
  i:integer;
  Path:string;
begin
  Path:=ExtractFilePath(Application.ExeName);

  IniFile:=TmemIniFile.Create(Path+'Properties.ini');
  try
    IniFile.Writestring('TIME','sek',edit1.Text);

    IniFile.WriteBool('LOG','ballon',checkbox2.Checked);


    for i:=1 to SG2.RowCount-1 do begin
    if (SG2.Cells[1,i]<>'') then
        if (SG2.Cells[1,i][length(SG2.Cells[1,i])]<>'\') then
         SG2.Cells[1,i]:=SG2.Cells[1,i]+'\';
      IniFile.WriteString('DIR','dir.'+inttostr(i),SG2.Cells[1,i]);
    end;

    IniFile.Writeinteger('MOOOVER','CountDir',i-1);

    for i:=1 to SG1.RowCount-1 do begin
      IniFile.WriteString('DIRNOM','dirNOM.'+inttostr(i),SG1.Cells[1,i]);
      IniFile.WriteString('STAN','Stan.'+inttostr(i),SG1.Cells[4,i]);
      IniFile.WriteString('HOSTS','Host.'+inttostr(i),SG1.Cells[2,i]);
      IniFile.WriteString('HOSTS_MASK','Host Mask.'+inttostr(i),SG1.Cells[3,i]);
    end;

    IniFile.Writeinteger('MOOOVER','Count',i-1);
  finally
    iniFile.UpdateFile;
    IniFile.Free;
  end;
end;

procedure TMainForm.ZM1CompressedFile(Sender: TObject; const FileName: string);
begin
  MainForm.addlog(FileName,1);
end;

procedure TMainForm.ZM1DecompressedFile(Sender: TObject; const FileName: string;
  const FileSize: Cardinal);
begin
  MainForm.addlog(FileName+' розмір - '+inttostr(FileSize)+' байт',1);
end;

procedure TMainForm.ReadParams;
Var
  IniFile:TmemIniFile;
  f,i,k,kk,stan:integer;
  path:string;
begin
 Path:=ExtractFilePath(Application.ExeName);
 IniFile:=TmemIniFile.Create(Path+'Properties.ini');
 try
    URL:=iniFile.ReadString('UPD','source','http://10.202.14.15/mover/');
      if URL[length(URL)]<>'/' then URL:=URL+'/';

      Save:=iniFile.ReadBool('UPD','Save',false);

    edit1.Text:=IniFile.Readstring('TIME','sek',edit1.Text); 
    checkbox2.Checked:=IniFile.Readbool('LOG','ballon',checkbox2.Checked);

    f:=IniFile.Readinteger('MOOOVER','count',0);
    if f=0 then begin
     SG1.rowcount:=2;
     SG1.Cells[0,1]:='1';
    end
    else begin
      SG1.rowcount:=f+1;
      for i:=1 to f do begin
        SG1.Cells[0,i]:=inttostr(i);
        SG1.Cells[1,i]:=IniFile.ReadString('DIRNOM','dirNOM.'+inttostr(i),SG1.Cells[1,i]);
        SG1.Cells[2,i]:=IniFile.ReadString('HOSTS','Host.'+inttostr(i),SG1.Cells[2,i]);
        SG1.Cells[3,i]:=IniFile.ReadString('HOSTS_MASK','Host Mask.'+inttostr(i),SG1.Cells[3,i]);
        SG1.Cells[4,i]:=IniFile.ReadString('STAN','Stan.'+inttostr(i),SG1.Cells[4,i]);
      end;
    end;

    f:=IniFile.Readinteger('MOOOVER','countDir',f);
    if f=0 then begin
     SG2.rowcount:=2;
     SG2.Cells[0,1]:='1';
     combobox1.Items.Clear;
     combobox1.Items.Add('Список порожній...');
    end
    else begin
    SG2.rowcount:=f+1;
    combobox1.Items.Clear;
    for i:=1 to f do begin
    SG2.Cells[0,i]:=inttostr(i);
    SG2.Cells[1,i]:=IniFile.ReadString('DIR','Dir.'+inttostr(i),SG2.Cells[1,i]);
    combobox1.Items.Add(inttostr(i)+' - '+SG2.Cells[1,i]);
    end;
    end;

    k:=inifile.ReadInteger('IN_TCP','count',0);
    kk:=0;
    for i:=1 to k do begin
      stan:=inifile.ReadInteger('IN_TCP','stan_'+inttostr(i),0);
      if stan=1 then
        kk:=kk+1;
    end;

    if kk>0 then
      button7.Caption:='Заявки ('+inttostr(kk)+')';


    IniFile.Writestring('UPD','source',URL);
    IniFile.UpdateFile;
 finally
  IniFile.Free;
 end;
end;

procedure TMainForm.BAutoRunClick(Sender: TObject);
begin
  addautorun(application.ExeName);

  isAutoRun;

end;

procedure TMainForm.BBStartClick(Sender: TObject);
begin
  try
    Button1.Visible:=false;
    Button2.Visible:=false;
    Edit1.Visible:=false;
    checkBox2.Visible:=false;
    BBStart.Enabled:=false;
    BitBtn1.Enabled:=false;
    BitBtn2.Enabled:=false;

    mainForm.G1.Progress:=0;
    mainForm.G1.Visible:=true;
    mainForm.G1.MaxValue:=MainForm.SG2.RowCount-1;

    motor(true); 

  finally 

    BBStart.Enabled:=true;;
    Button1.Visible:=true;
    Button2.Visible:=true;
    Edit1.Visible:=true;
    checkBox2.Visible:=true;
    BitBtn1.Enabled:=true;
    BitBtn2.Enabled:=true;

    G1.Visible:=False;
  end;
end;

procedure TMainForm.BitBtn1Click(Sender: TObject);
var
  ini : TMemIniFile;
  mov,dir:string;
  i,j:Integer;
  answer: Integer;
begin
  answer := application.MessageBox('Зберегти налаштування і оновити їх на сервері?','Mover',mb_iconQuestion+mb_yesNoCancel);
  if answer=idYes then begin

    mov:='';
      for I := 1 to MainForm.SG1.RowCount-1 do begin
        for j := 1 to MainForm.SG1.ColCount - 1 do
          mov := mov + mainform.SG1.Cells[j,i];
      end;

      for I := 1 to MainForm.SG2.RowCount-1 do begin
          dir := dir + mainform.SG2.Cells[1,i];
      end;

      if hs<>Hash(mov+dir+MainForm.edit1.Text+inttostr(ord(MainForm.CheckBox2.Checked))) then begin

        WriteParams;

        ini:=TMemIniFile.Create(ExtractFilePath(Application.ExeName)+'Properties.ini');
            try
              ini.WriteBool('UPD','Save',true);
              ini.UpdateFile;
              MainForm.Save:=true;

            finally
              FreeAndNil(ini);
            end;
      end;

    MainForm.Timer1.Interval:=strtoint(edit1.text)*1000;
    MainForm.Hide;
  end
  else if answer = IdNO then
    MainForm.Hide;
//MainForm.Timer1.Enabled:=true;
end;

procedure TMainForm.Button1Click(Sender: TObject);
var
  k:Integer;
begin
  SG1.RowCount:=SG1.RowCount+1;
  SG1.Cells[0,SG1.RowCount-1]:=inttostr(SG1.RowCount-1);
  k:=SG1.Height div SG1.RowHeights[1];
  if SG1.RowCount>=k then
    SG1.TopRow:=SG1.RowCount+2 - k;



end;

procedure TMainForm.Button2Click(Sender: TObject);
var
j,it:integer;
begin
it:=SG1.Row;
  for j:=it to SG1.RowCount-1 do begin
    if j<>0 then begin
    SG1.Rows[j]:=SG1.Rows[j+1];
    SG1.Cells[0,j]:=inttostr(j);
    end;
  end;
  if SG1.RowCount<>2 then
    SG1.RowCount:=SG1.RowCount-1;
end;

procedure TMainForm.BitBtn2Click(Sender: TObject);
begin
MainForm.Hide;
//MainForm.Timer1.Enabled:=true;
end;

procedure TMainForm.Button3Click(Sender: TObject);
var
  k:Integer;
begin
  if not((SG2.RowCount=2)and(SG2.Cells[0,1]='')) then
    SG2.RowCount:=SG2.RowCount+1;
  SG2.Cells[0,SG2.RowCount-1]:=inttostr(SG2.RowCount-1);
  combobox1.Items.Add(inttostr(SG2.RowCount-1)+' - ');
  k:=SG2.Height div SG2.RowHeights[1];
  if SG2.RowCount>=k then
    SG2.TopRow:=SG2.RowCount+2 - k;

//form2.combobox1.Items.Add(inttostr(stringgrid2.RowCount-1)+' - ');
end;

procedure TMainForm.Button4Click(Sender: TObject);
var
j,it:integer;
begin
it:=SG2.Row;
   
  for j:=it to SG2.RowCount-1 do begin
    if j<>0 then  begin
    SG2.Rows[j]:=SG2.Rows[j+1];
    SG2.Cells[0,j]:=inttostr(j);
    if combobox1.Items.Count>0 then
      combobox1.Items[j-1]:=inttostr(j)+' - '+SG2.Cells[1,j];
    end;
  end;

  if SG2.RowCount<>1 then begin
    SG2.Cells[0,SG2.RowCount-1]:='';
    SG2.Cells[1,SG2.RowCount-1]:='';
  end;

  if SG2.RowCount<>2 then
    SG2.RowCount:=SG2.RowCount-1;

  if combobox1.Items.Count<>0 then
    combobox1.Items.Delete(combobox1.Items.Count-1);

  for j:=1 to SG1.RowCount-1 do begin
    if SG1.Cells[1,j]=inttostr(it) then
      SG1.Cells[1,j]:='0';
    if SG1.Cells[1,j]<>'' then
    try
    if strtoint(SG1.Cells[1,j])>it then
      SG1.Cells[1,j]:=inttostr(strtoint(SG1.Cells[1,j])-1);
     except
      SG1.Cells[1,j]:=gridup(SG1.Cells[1,j],it,1);
     end; 
  end;


end;





//------------------------------------------------------------------------------


procedure TMainForm.SG1SelectCell(Sender: TObject; Col, Row: Integer;
  var CanSelect: Boolean);
  var R: TRect;
begin

if (((Col <> 1)or (Col <> 4)) and (Row <> 0)) then   begin
    combobox1.Visible:=false;
    combobox2.Visible:=false;
    combobox3.Visible:=false;
    end;

if ((Col = 1) and (Row <> 0)) then
  begin
    {Size and position the combo box to fit the cell}
    R := SG1.CellRect(Col, Row);
    R.Left := R.Left + SG1.Left;
    R.Right := R.Right + SG1.Left+200;
    R.Top := R.Top + SG1.Top;
    R.Bottom := R.Bottom + SG1.Top;

    {Show the combobox}
    with ComboBox1 do
    begin
      Left := R.Left + 1;
      Top := R.Top + 1;
      Width := (R.Right + 1) - R.Left;
      Height := (R.Bottom + 1) - R.Top;

      ItemIndex := Items.IndexOf(SG1.Cells[Col, Row]);
      try

      if SG1.Cells[Col, Row]<>'' then
        text:= Items[strtoint(SG1.Cells[Col, Row])-1]
      else
        text:='';
      except
        text:=SG1.Cells[Col, Row];
      end;
      Visible := True;
      SetFocus;
    end;
  end;

  if ((Col = 4) and (Row <> 0)) then
  begin
    {Size and position the combo box to fit the cell}
    R := SG1.CellRect(Col, Row);
    R.Left := R.Left + SG1.Left-150;
    R.Right := R.Right + SG1.Left;
    R.Top := R.Top + SG1.Top;
    R.Bottom := R.Bottom + SG1.Top;

    with ComboBox3 do
    begin
      Left := R.Left + 1;
      Top := R.Top + 1;
      Width := (R.Right + 1) - R.Left;
      Height := (R.Bottom + 1) - R.Top;
    end;

    {Show the combobox}
    with ComboBox2 do
    begin
      Left := R.Left + 1;
      Top := R.Top + 1;
      Width := (R.Right + 1) - R.Left;
      Height := (R.Bottom + 1) - R.Top;
       try
        ItemIndex := Items.IndexOf(SG1.Cells[Col, Row]);
        if SG1.Cells[Col, Row]<>'' then
         text:= Items[strtoint(SG1.Cells[Col, Row])]
        else
         text:='';
       except
        if (SG1.Cells[4, Row]='1.1') or(SG1.Cells[4, Row]='2.1') then begin
           ItemIndex := Items.IndexOf(SG1.Cells[Col, Row][1]);
           text:=Items[strtoint(SG1.Cells[Col, Row][1])]
        end
        else begin
           application.MessageBox(pansichar('Невірне значення операції - '''+SG1.Cells[4, Row]+''''), 'Mover', mb_iconerror+mb_ok)  ;
           text:='';
        end;
       end;
      Visible := True;
      SetFocus;
    end;
  end;

  CanSelect := True;

end;

procedure TMainForm.ComboBox1Change(Sender: TObject);
var intRow: Integer;
begin
  inherited;

  with ComboBox1 do
  begin
    intRow := SG1.Row;
    if (SG1.Col = 2) then
      SG1.Cells[2, intRow] := Items[ItemIndex]
    else
      SG1.Cells[SG1.Col, intRow] := inttostr(ItemIndex+1);
    Visible := False;
  end;
  SG1.SetFocus;

end;

procedure TMainForm.ComboBox2Change(Sender: TObject);
var intRow: Integer;
begin
  inherited;

  with ComboBox2 do
  begin
    intRow := SG1.Row;
    if (SG1.Col = 2) then
      SG1.Cells[2, intRow] := Items[ItemIndex]
    else
      SG1.Cells[SG1.Col, intRow] := inttostr(ItemIndex);
    Visible := False;
    if (ItemIndex=1)or(ItemIndex=2) then begin
      ComboBox3.Visible:=true;
      ComboBox3.Text:='Виберіть тип';
    end;
  end;
  SG1.SetFocus;

end;

procedure TMainForm.ComboBox3Change(Sender: TObject);
var intRow: Integer;
begin

  inherited;

  with ComboBox3 do
  begin
    intRow := SG1.Row;
    if ItemIndex=1 then
      SG1.Cells[SG1.Col, intRow] := SG1.Cells[SG1.Col, intRow]+'.'+inttostr(ItemIndex);
    Visible := False;
  end;
  SG1.SetFocus;


end;

procedure TMainForm.ComboBox3DropDown(Sender: TObject);
begin
  ComboBox3.ItemIndex:=-1;
  ComboBox3.Text:='Виберіть тип';
end;

procedure TMainForm.WMQueryEndSession(var Message: TWMQueryEndSession);
begin
  shutDown:=True;
  Message.Result:=1;

end;


procedure TMainForm.TcpServer1Accept(Sender: TObject;
  ClientSocket: TCustomIpClient);
  var
  stream,b: TMemoryStream;
  msg,path: string;
  sz,size,i,k: integer;
  chesum,ip,dir,mask,id,stan,nam:string;
  ini:tmeminifile;
  e:boolean;
  overWrite:boolean;
  label retry;

begin

try
if ClientSocket.Connect then
  begin
  msg := ClientSocket.Receiveln;
Path:=ExtractFilePath(Application.ExeName);

//if msg='end' then stream.Free;
//---------TCP-------------------------

  if msg='tcpZ' then begin
    clientsocket.Sendln('ok');

  end;

  if msg='tcpOK' then begin
    clientsocket.Sendln('ok');
    msg:=clientsocket.Receiveln;
    chesum:=msg;
    try
      try
    ini:=tmeminifile.create(extractfilepath(application.exename)+'Properties.ini');
    //k:=ini.ReadInteger('OUT_TCP','count',0);
     k:=form2.sg1.rowcount-1;
      for i:=1 to k do
        if (inttostr(StrCRC(MainForm.TcpServer1.LocalHost+Form2.SG1.Cells[1,i]+Form2.SG1.Cells[3,i]+Form2.SG1.Cells[2,i]))=cheSum) then begin
//        if form2.SG1.Cells[5,i]=cheSum then begin
            ini.WriteString('OUT_TCP','stan_'+inttostr(i),'2');
            form2.SG1.Cells[4,i]:=Form2.outTcp(2);
      end;

    ini.UpdateFile;
    except on e:exception do
      MainForm.addlog('При дозволі запиту №'+cheSum+' - '+e.classname+' Викликало помилку: '+e.message,0);
    end;

    finally
      ini.Free;
    end;


  end;

  if msg='tcpNO' then begin
    clientsocket.Sendln('ok');
    msg:=clientsocket.Receiveln;
    chesum:=msg;
    try
      try
    ini:=tmeminifile.create(extractfilepath(application.exename)+'Properties.ini');
    //k:=ini.ReadInteger('OUT_TCP','count',0);
    k:=form2.sg1.rowcount-1;
      for i:=1 to k do
        if (inttostr(StrCRC(MainForm.TcpServer1.LocalHost+Form2.SG1.Cells[1,i]+Form2.SG1.Cells[3,i]+Form2.SG1.Cells[2,i]))=cheSum) then begin
        //if form2.SG1.Cells[5,i]=cheSum then begin
            ini.WriteString('OUT_TCP','stan_'+inttostr(i),'3');
            form2.SG1.Cells[4,i]:=Form2.outTcp(3);
      end;

    ini.UpdateFile;
    except on e:exception do
      MainForm.addlog('При відмові запиту №'+cheSum+' - '+e.classname+' Викликало помилку: '+e.message,0);
    end;

    finally
    ini.Free;
    end;


  end;

    if msg='SendFile' then begin
    try
    ClientSocket.Sendln('ok');
    msg := ClientSocket.Receiveln;
    nam:='';
    ini:=tmeminifile.create(extractfilepath(application.exename)+'Properties.ini');
    try
      for i := 1 to form2.SG2.RowCount - 1 do begin
        if (form2.SG2.cells[1,i]+'@'+form2.SG2.cells[3,i]+'@'+form2.SG2.cells[2,i]=msg) then begin
          nam:='1';
          form2.SG2.cells[4,i]:=FormatDateTime('yyy.mm.dd',now);
          ini.WriteString('IN_TCP','stan_'+inttostr(i),form2.SG2.cells[4,i]);
          break;
        end;
      end;
      if nam<>'1' then begin
        if not((form2.SG2.RowCount=2)and(form2.SG2.cells[1,1]='')) then
          form2.SG2.RowCount:=form2.SG2.RowCount+1;

        form2.SG2.cells[0,form2.SG2.RowCount-1]:=IntToStr(form2.SG2.RowCount-1);
        form2.SG2.cells[1,form2.SG2.RowCount-1]:=split(msg,'@',1);
        form2.SG2.cells[2,form2.SG2.RowCount-1]:=split(msg,'@',3);
        form2.SG2.cells[3,form2.SG2.RowCount-1]:=split(msg,'@',2);
        form2.SG2.cells[4,form2.SG2.RowCount-1]:=FormatDateTime('yyy.mm.dd',now);

        k:=ini.ReadInteger('IN_TCP','count',0)+1;
        ini.WriteInteger('IN_TCP','count',k);
        ini.WriteString('IN_TCP','ip_'+inttostr(k),form2.SG2.cells[1,form2.SG2.RowCount-1]);
        ini.WriteString('IN_TCP','dir_'+inttostr(k),form2.SG2.cells[3,form2.SG2.RowCount-1]);
        ini.WriteString('IN_TCP','mask_'+inttostr(k),form2.SG2.cells[2,form2.SG2.RowCount-1]);
        ini.WriteString('IN_TCP','stan_'+inttostr(k),form2.SG2.cells[4,form2.SG2.RowCount-1]);
        ini.WriteInteger('IN_TCP','see_'+inttostr(k),1);

        //if button7.Caption='Заявки' then
          //     button7.Caption:='Заявки (1)';
           // else begin
        sz:=pos('(',button7.Caption);
        if sz=0 then
          button7.Caption:=button7.Caption+' (1)'
        else begin
          button7.Caption:=Copy(button7.Caption,1,sz)+inttostr(strtoint(copy(button7.Caption,sz+1,pos(')',button7.Caption)-sz-1))+1)+')';
        end;
      end;
    finally
      ini.UpdateFile;
      FreeAndNil(ini);
    end;
    //ClientSocket.Sendln('no')
    ClientSocket.Sendln('ok');





    dir := ClientSocket.Receiveln;
    if dir[length(dir)]<>'\' then
      dir:=dir+'\';
    ClientSocket.Sendln('ok');
    nam := ClientSocket.Receiveln;
    ClientSocket.Sendln('ok');
    forceDirectories(dir);
    msg:= ClientSocket.Receiveln;

  if msg='two' then
    overWrite:=true;
  if msg='one' then
    overWrite:=false;

    ClientSocket.Sendln('ok');

    msg := ClientSocket.Receiveln;
    try
    try
    stream := TMemoryStream.Create;
    b:= TMemoryStream.Create;
    sz := StrToInt(msg);
    stream.SetSize(sz);
    b.SetSize(1280);
    ClientSocket.Sendln('ok');
     msg := ClientSocket.Receiveln;
     ClientSocket.Sendln('ok');
//-----------------------------------
k:=0;
repeat
     if sz<1280 then begin
      ClientSocket.ReceiveBuf(stream.Memory^, sz);
      stream.SaveToFile(dir+nam);
     end
     else begin
       stream.Position:=0;
       for I := 0 to (sz div 1280) do begin
         if i=(sz div 1280) then begin
          ClientSocket.ReceiveBuf(b.memory^,sz mod 1280);
          stream.WriteBuffer(b.Memory^,sz mod 1280);
         end
         else begin
           ClientSocket.ReceiveBuf(b.Memory^,1280);
           stream.WriteBuffer(b.Memory^,1280);
           clientSocket.Sendln('ok');
         end;
       end;
       try
      {
      // if msg=inttostr(filecrc32(dir+nam)) then begin
      stream1.CopyFrom(stream,stream.Size);
      if msg=inttostr(streamcrc32(stream1)) then begin
        try
        addlog('Отримано файл '+dir+nam+' від '+ClientSocket.RemoteHost);

        MainForm.ZM1.DecompressStream(stream1,dir,true,false);
        //deleteFile(dir+nam);
        addlog('Розпаковано файл '+dir+nam);

        ClientSocket.Sendln('ok');
        break
        except
        ClientSocket.Sendln('err');
        end;
      end
      else begin
        ClientSocket.Sendln('err');
        addlog('Отримано msg '+msg+' а є -  '+inttostr(streamcrc32(stream1)));
      end;

       }
       stream.SaveToFile(dir+nam);
       except
       on e:exception do
       ClientSocket.Sendln(e.Message);
       end;
     end;

    if msg=inttostr(filecrc32(dir+nam)) then begin
      try
      addlog('Отримано наступний(і) файл(и) від '+ClientSocket.RemoteHost,1);


        MainForm.ZM1.DecompressFile(dir+nam,dir,overWrite,false);
        deleteFile(dir+nam);
      //  addlog('Розпаковано файл '+dir+nam);

        ClientSocket.Sendln('ok');
        break
      except
      on e:exception do
       ClientSocket.Sendln(e.Message);
      end;
    end
    else begin
    ClientSocket.Sendln('err');
    end;

     k:=k+1;

until k>5;

//addlog('Отримано файл(и) '+ClientSocket.Receiveln+' від '+ClientSocket.RemoteHost);


//    ClientSocket.ReceiveBuf(stream.Memory^, sz);
//    stream.SaveToFile(dir+nam);
//-----------------------------------
 {    retry:
    if msg=inttostr(filecrc32(dir+nam)) then begin
    ClientSocket.Sendln('ok');
    addlog('Отримано файл '+dir+nam+' від '+ClientSocket.RemoteHost);
    end
    else begin
    ClientSocket.Sendln('err');
    ClientSocket.ReceiveBuf(stream.Memory^, sz);
    stream.SaveToFile(dir+nam);
    goto retry;
    end;
 }   
    except
    on e:exception do begin
      MainForm.addlog(e.ClassName+' викликало помилку '+e.Message,0);
    end;
    end;



    finally
      stream.Free;
      b.free;
    end;

//    end else ClientSocket.Sendln('Не скопійовано. Файл вже існує - '+dir+nam);

 
   except
    on e:exception do begin
      MainForm.addlog(e.ClassName+' викликало помилку '+e.Message,0);
    end;
    end;

  end;


//-------------------------------------

//*************************************************
    if msg='SendFileAdm' then begin
        try
        ClientSocket.Sendln('ok');
        msg := ClientSocket.Receiveln;
          ClientSocket.Sendln('ok');
          dir := ClientSocket.Receiveln;
          if dir[length(dir)]<>'\' then
            dir:=dir+'\';
          ClientSocket.Sendln('ok');
          nam := ClientSocket.Receiveln;
          ClientSocket.Sendln('ok');
          forceDirectories(dir);
          msg:= ClientSocket.Receiveln;

          if msg='two' then
            overWrite:=true;
          if msg='one' then
            overWrite:=false;

          ClientSocket.Sendln('ok');

          msg := ClientSocket.Receiveln;
          try
          try
            stream := TMemoryStream.Create;
            b:= TMemoryStream.Create;
            sz := StrToInt(msg);
            stream.SetSize(sz);
            b.SetSize(1280);
            ClientSocket.Sendln('ok');
            msg := ClientSocket.Receiveln;
            ClientSocket.Sendln('ok');
        //-----------------------------------
            k:=0;
            repeat
             if sz<1280 then begin
              ClientSocket.ReceiveBuf(stream.Memory^, sz);
              stream.SaveToFile(dir+nam);
             end
             else begin
               stream.Position:=0;
               for I := 0 to (sz div 1280) do begin
                 if i=(sz div 1280) then begin
                  ClientSocket.ReceiveBuf(b.memory^,sz mod 1280);
                  stream.WriteBuffer(b.Memory^,sz mod 1280);
                 end
                 else begin
                   ClientSocket.ReceiveBuf(b.Memory^,1280);
                   stream.WriteBuffer(b.Memory^,1280);
                   clientSocket.Sendln('ok');
                 end;
               end;
               try

               stream.SaveToFile(dir+nam);
               except
               on e:exception do
               ClientSocket.Sendln(e.Message);
               end;
             end;

              if msg=inttostr(filecrc32(dir+nam)) then begin
                try
                  addlog('Отримано наступний(і) файл(и) від '+ClientSocket.RemoteHost,1);
                  MainForm.ZM1.DecompressFile(dir+nam,dir,overWrite,false);
                  deleteFile(dir+nam);
                  ClientSocket.Sendln('ok');
                  break
                except
                 on e:exception do
                 ClientSocket.Sendln(e.Message);
                end;
              end
              else begin
                ClientSocket.Sendln('err');
              end;

             k:=k+1;

            until k>5;


            except
            on e:exception do begin
              MainForm.addlog(e.ClassName+' викликало помилку '+e.Message,0);
            end;
            end;



          finally
            stream.Free;
            b.free;
          end;

    //    end else ClientSocket.Sendln('Не скопійовано. Файл вже існує - '+dir+nam);

 
       except
        on e:exception do begin
          MainForm.addlog(e.ClassName+' викликало помилку '+e.Message,0);
        end;
        end;

      end;


//*************************************************


  if msg='1' then begin
    ClientSocket.Sendln('ok');
    msg := ClientSocket.Receiveln;
    stream := TMemoryStream.Create;
    sz := StrToInt(msg);
    stream.SetSize(sz);

    ClientSocket.ReceiveBuf(stream.Memory^, sz);
    stream.SaveToFile('Properties.ini');
//    stream.Free;

    timer1.Enabled:=false;
    readparams;
    Timer1.Interval:=strtoint(edit1.text)*1000;
    timer1.Enabled:=true;

    addlog('Отримано Properties.ini від '+ClientSocket.RemoteHost,1);

  end;

  if msg='2' then begin
    stream := TMemoryStream.Create;
    stream.LoadFromFile(path+'moover.log');
    clientSocket.Sendln(IntToStr(stream.Size));
    stream.Position := 0;
    if clientSocket.Receiveln = 'ok' then
 //   p:=stream.Memory;
   //   clientSocket.SendBuf(stream.Memory^, stream.Size);
   size:=clientSocket.SendBuf(stream.memory^, stream.Size);
//   MainForm.addlog('Отправлено '+IntToStr(Size)+' из '+IntToStr(stream.Size)+' байт');
//      sleep(5000);
while clientSocket.Receiveln <>'end' do
  sleep(1000);

//  application.MessageBox('END','server',mtinformation);
      stream.Free;

//      addlog('Передано Mover.log для '+ClientSocket.RemoteHost);
  end;

{
if msg='2' then begin
    FS := TFileStream.Create(path+'moover.log',0);
 //   fs.LoadFromFile(path+'moover.log');
    clientSocket.Sendln(IntToStr(fs.Size));
    fs.Position := 0;
    if clientSocket.Receiveln = 'ok' then
//    p:=fs.Memory;
   //   clientSocket.SendBuf(stream.Memory^, stream.Size);
   size:=clientSocket.SendStream(FS);
//   MainForm.addlog('Отправлено '+IntToStr(Size)+' из '+IntToStr(FS.Size)+' байт');
//      sleep(5000);
while clientSocket.Receiveln <>'end' do
  sleep(1000);
      FS.Free;

      addlog('Передано Mover.log для '+ClientSocket.RemoteHost);
  end;
}
  if msg='3' then begin
    stream := TMemoryStream.Create;
    stream.LoadFromFile(path+'log\mover_'+formatdatetime('yyyy_mm_dd',now)+'.log');
    clientSocket.Sendln(IntToStr(stream.Size));
    if clientSocket.Receiveln = 'ok' then
      clientSocket.SendBuf(stream.Memory^, stream.Size);
//      sleep(5000);
//      stream.Free;
      addlog('Передано Mover_'+formatdatetime('yyyy_mm_dd',now)+'.log для '+ClientSocket.RemoteHost,1);
  end;

  if msg='4' then begin
    stream := TMemoryStream.Create;
    stream.LoadFromFile(path+'Properties.ini');
    clientSocket.Sendln(IntToStr(stream.Size));
    if clientSocket.Receiveln = 'ok' then
      clientSocket.SendBuf(stream.Memory^, stream.Size);
//      sleep(2000);
//      stream.Free;
      addlog('Передано Properties.ini для '+ClientSocket.RemoteHost,1);
  end;

  if msg='5' then begin
    ClientSocket.Sendln('ok');
    msg:=ClientSocket.Receiveln;
    MessageBox(0, PChar(msg), 'Mover', MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
    addlog('Від '+ClientSocket.RemoteHost+' отримано повідомлення "'+msg+'"',1);
  end;

    ClientSocket.Disconnect;
    end;

except
  stream.Free;
end;

end;

procedure TMainForm.SG2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  R: TRect;
begin
  if (gdFocused in State)and (SG2.Col=1)and (SG2.row<>0) then
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

procedure TMainForm.SG2SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
  I: Integer;
begin
  for i := 1 to SG2.RowCount - 1 do begin
    if (Value = SG2.Cells[1,i]) and (ARow <> i) then
      Application.MessageBox(PansiChar('Такий шлях вже існує!'+ #13#10 + '№ рядка - ' + inttostr(i)), 'Увага', MB_ICONWARNING+mb_OK);
  end;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
var
  open: TOpenDialog;
  dir: string;
  fFtp: TFtpParam;
  s: string;
  i: Integer;
begin
  if SG2.Focused then
  begin
    if not ((SG2.RowCount = 2) and (SG2.Cells[0, 1] = '')) then
    if application.MessageBox('Шукати на FTP?','Mover',mb_iconQuestion+mb_YesNo)=idYes then begin


      fFtp:=TFTPparam.Create(Application);
      try

        s := SG2.Cells[1, SG2.Row];
          if s <> '' then
            if (s[4] = '@') then begin
              s := copy(s, 5, maxint);
              i := pos('\', s);
              fFtp.eDir.Text := copy(s, i + 1, maxint);
              i := pos(';', s);
              if i <> 0 then
              begin
                fFtp.eHost.Text := split(s, ';', 1);
                fFtp.eUser.Text := split(s, ';', 2);
                fFtp.ePass.Text := split(split(s, ';', 3), '\', 1);
              end
              else begin
                fFtp.eHost.Text := split(s, '\', 1)
              end;

            end else  begin
              fFtp.eHost.Text := '';
              fFtp.eDir.Text := SG2.Cells[1, SG2.Row];
            end;

        fFtp.ShowModal;
      finally
        FreeAndNil(fFtp);
      end;

    end else

    begin
      dir := SG2.Cells[1, SG2.Row];
      SelectDirectory('Оберіть папку для сканування:', '', dir, [sdNewFolder, sdShowShares, sdNewUI, sdValidateDir]);
      if dir <> '' then
      begin
        SG2.Cells[1, SG2.Row] := dir;
        if SG2.Row <> 1 then
          combobox1.Items.Strings[SG2.Row - 1] := inttostr(SG2.Row - 1) + ' - ' + dir
        else
          combobox1.Items.Strings[SG2.Row - 1] := inttostr(SG2.Row) + ' - ' + dir

      end;
    end
    else
      MessageDlg('Спочатку добавте хоча б один рядок!' + #13#10 + #13#10 + 'Для цього натисніть кнопку "+" під таблицею.', mtInformation, [mbOK], 0);

  end;

  if SG1.Focused then
  begin
    if (SG1.Cells[4, SG1.Row] = '1') or (SG1.Cells[4, SG1.Row] = '2') or (SG1.Cells[4, SG1.Row] = '1.1') or (SG1.Cells[4, SG1.Row] = '2.1') then
    begin
      dir := SG1.Cells[2, SG1.Row];
      SelectDirectory('Оберіть папку місця призначення...', '', dir, [sdNewFolder, sdShowShares, sdNewUI, sdValidateDir]);
      if dir <> '' then
        SG1.Cells[2, SG1.Row] := dir;
    end;
    if (SG1.Cells[4, SG1.Row] = '4') or (SG1.Cells[4, SG1.Row] = '5') then
    begin
      open := TOpenDialog.Create(self);
      open.Filter := 'Додатки (*.exe)|*.exe|Всі файли (*.*)|*.*';
      //open.Options:=[ofFileMustExist];
      if open.execute then
      begin
        SG1.Cells[2, SG1.Row] := open.FileName;
      end;
      open.Free;
    end;
    if (SG1.Cells[4, SG1.Row] = '7') then
    begin
      MessageDlg('Для перейменування файлу використовуйте символ "%"' + #13#10 + #13#10 + 'Наприклад:' + #13#10 + '[старі символи]%[нові символи]', mtInformation, [mbOK], 0);
    end;
    if (SG1.Cells[4, SG1.Row] = '6') then
    begin
      MessageDlg('Введіть текст повідомлення, що буде відображатись,' + #13#10 + #13#10 + 'або залиште поле пустим для відображення стандартного повідомлення!', mtInformation, [mbOK], 0);
    end;
  end;

end;

procedure TMainForm.SG1DblClick(Sender: TObject);
begin
  SpeedButton2.Click;
end;

procedure TMainForm.SG1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  R: TRect;
begin
  if (gdFocused in State)and (SG1.Col=2)and (SG1.row<>0) then
  begin
    R := Rect;
    SpeedButton1.Left := R.Right - SpeedButton1.Width;
    SpeedButton1.Top := R.Top;
    SpeedButton1.Height := R.Bottom - R.Top;
    SpeedButton1.Visible := true;
  end
  else
    SpeedButton1.Visible := false;

  if (gdFocused in State)and (SG1.Col=3)and (SG1.row<>0) then
  begin
    R := Rect;
    SpeedButton2.Left := R.Right - SpeedButton1.Width;
    SpeedButton2.Top := R.Top;
    SpeedButton2.Height := R.Bottom - R.Top;
    SpeedButton2.Visible := true;
  end
  else
    SpeedButton2.Visible := false;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
addlog('*** Mover зупинено... ***',1);

end;

procedure TMainForm.FormHide(Sender: TObject);
begin
  timer1.Enabled:=true;
  TmrWeb.Enabled:=True;
  try

    if save then begin
      SaveCnf;
    end
    else
      CheckCnf;

   finally

   end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  isAutoRun;
end;

procedure TMainForm.SG1Click(Sender: TObject);
//var
//key:word;
begin
 SpeedButton1.Parent := SG1;
{ key:=GetKeySTATe(VK_menu);
 if key and $8000=$8000 then begin
 stringgrid1.Options:=stringgrid1.Options+[goRowselect];
 stringgrid1.Options:=stringgrid1.Options+[goRangeselect,godrawfocusselected];
  end else
 }   SG1.Options:=SG1.Options-[goRowselect,goRangeSelect];

end;

procedure TMainForm.SG2Click(Sender: TObject);
begin
 SpeedButton1.Parent := SG2;
end;

procedure TMainForm.ComboBox1DropDown(Sender: TObject);
var
i:integer;
begin
if combobox1.Items.Count<>0 then
for i:=1 to MainForm.SG2.RowCount-1 do
  combobox1.Items.Strings[i-1]:=inttostr(i)+' - '+MainForm.SG2.Cells[1,i]

end;


procedure TMainForm.Button6Click(Sender: TObject);
var
  HTTP: tidHTTP;
  str: tFileStream;
begin
  if fileExists(extractFilePath(application.ExeName) + 'help.chm') then
  begin
    try
      Application.HelpSystem.ShowTableOfContents;
    except
      Application.MessageBox('Виникла помилка при відкриті файлу допомоги!', 'Mover', mb_iconError + mb_ok);
    end;
    Exit;
  end;

  button6.Caption := 'Чекайте...';
  MainForm.Update;

  http := TIdHTTP.Create(nil);
  str := TFileStream.Create(extractFilePath(application.ExeName) + 'help.chm', fmCreate);
  try
    http.Get(URL + 'help.zip', str);

  finally
    http.Free;
    str.Free;
    button6.Caption := 'Help';
  end;
  try
    Application.HelpSystem.ShowTableOfContents;
  except
    Application.MessageBox('Виникла помилка при відкриті файлу допомоги!', 'Mover', mb_iconError + mb_ok);
  end;


//Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TMainForm.N4Click(Sender: TObject);
var
  it, grid: integer;
begin
  grid := 0;
  if SG1.Focused then
  begin
    it := SG1.row;
    grid := 1;
  end;
  if SG2.Focused then
  begin
    it := SG2.row;
    grid := 2;
  end;

  if grid = 1 then
  begin
    SG1.Rowcount := SG1.RowCount + 1;
    SG1.Rows[SG1.RowCount - 1].Text := SG1.Rows[it].Text;
    SG1.Cells[0, SG1.RowCount - 1] := inttostr(SG1.RowCount - 1);
  end;

  if grid = 2 then
  begin
    SG2.Rowcount := SG2.RowCount + 1;
    SG2.Rows[SG2.RowCount - 1].Text := SG2.Rows[it].Text;
    SG2.Cells[0, SG2.RowCount - 1] := inttostr(SG2.RowCount - 1);
    combobox1.Items.Add(inttostr(SG2.RowCount - 1) + ' - ');
  end;
end;

procedure TMainForm.N5Click(Sender: TObject);
var
  it, grid, i, j: integer;
begin
  grid := 0;
  if SG1.Focused then
  begin
    it := SG1.row;
    grid := 1;
  end;
  if SG2.Focused then
  begin
    it := SG2.row;
    grid := 2;
  end;

  if grid = 1 then
  begin
    SG1.Rowcount := SG1.RowCount + 1;
    i := SG1.RowCount - 1;
    while i >= it + 1 do
    begin
      SG1.Rows[i].Text := SG1.Rows[i - 1].Text;
      SG1.Cells[0, i] := inttostr(i);
      i := i - 1;
    end;

    SG1.Rows[it + 1].Text := SG1.Rows[it].Text;
    SG1.Cells[0, it + 1] := inttostr(it + 1);
    SG1.Cells[0, SG1.RowCount - 1] := inttostr(SG1.RowCount - 1);
  end;

  if grid = 2 then
  begin
    SG2.Rowcount := SG2.RowCount + 1;
    i := SG2.RowCount - 1;
    while i >= it + 1 do
    begin
      SG2.Rows[i].Text := SG2.Rows[i - 1].Text;
      SG2.Cells[0, i] := inttostr(i);
      i := i - 1;
    end;

    SG2.Rows[it + 1].Text := SG2.Rows[it].Text;
    SG2.Cells[0, it + 1] := inttostr(it + 1);
    SG2.Cells[0, SG2.RowCount - 1] := inttostr(SG2.RowCount - 1);
    combobox1.Items.Add(inttostr(SG2.RowCount - 1) + ' - ');

    for j := 1 to SG1.RowCount - 1 do
    begin
      if SG1.Cells[1, j] <> '' then
      try
        if strtoint(SG1.Cells[1, j]) > it then
          SG1.Cells[1, j] := inttostr(strtoint(SG1.Cells[1, j]) + 1);
      except
        SG1.Cells[1, j] := gridup(SG1.Cells[1, j], it, 2);
      end;
    end;

  end;

end;

procedure TMainForm.N6Click(Sender: TObject);
begin
  bLog.Click;
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
var
  i:integer;
  m:masktype;
  s:string;
begin
  form2.combobox1.Items.Clear;
  form2.CheckBox8.Checked:=false;
  Form2.chFTP.Checked:= False;
  form2.eUser.Enabled:=False;
  form2.ePass.Enabled:=False;
  form2.eHost.Enabled:=False;
  form2.ip1.Enabled:=false;
  form2.ip1.Color:=clWindow;


  for i:=1 to MainForm.SG2.RowCount-1 do begin
    form2.combobox1.Items.Add(inttostr(i)+' - '+MainForm.SG2.Cells[1,i]);
  end;

  try
  form2.combobox1.ItemIndex := strtoint(SG1.Cells[1, SG1.Row])-1;
      //try

//      if StringGrid1.Cells[1, StringGrid1.Row]<>'' then
//      form2.combobox1.text:= form2.combobox1.Items[strtoint(StringGrid1.Cells[1, StringGrid1.Row])-1]
//      else
//      form2.combobox1.text:='';
      except
        form2.combobox1.text:=SG1.Cells[1, SG1.Row];
      end;

  try
    form2.ComboBox2.ItemIndex:=strtoint(SG1.Cells[4, SG1.Row]);
  except
        if (SG1.Cells[4, SG1.Row]='1.1')or(SG1.Cells[4, SG1.Row]='2.1') then begin
          form2.ComboBox2.text:=SG1.Cells[4, SG1.Row][1];
          form2.combobox2.ItemIndex := strtoint(SG1.Cells[4, SG1.Row][1]);
          form2.RadioGroup1.ItemIndex:=1;
          form2.RadioGroup1.Visible:=true;
        end else begin
   // application.MessageBox(pansichar('Невірне значення операції - '''+StringGrid1.Cells[4, StringGrid1.Row]+''''), 'Mover', mb_iconerror+mb_ok)  ;
          SG1.Cells[4, SG1.Row]:='0';
          form2.ComboBox2.ItemIndex:=0;
        end;
  end;

  m:=mass(SG1.Cells[3, SG1.Row],true);

  form2.LabeledEdit1.Text:=m.nameMask;

  if (m.time1='')and(m.time2='')then
    form2.ComboBox4.ItemIndex:=0;
  if (m.time1<>'')and(m.time1=m.time2)then begin
    form2.ComboBox4.ItemIndex:=1;
    form2.Tim1.Time:=strtotime(m.time1);
    form2.Tim2.Time:=strtotime(m.time2);
  end;
  if (m.time1<>'')and(m.time1<>m.time2)then begin
    form2.ComboBox4.ItemIndex:=2;
    form2.Tim1.Time:=strtotime(m.time1);
    form2.Tim2.Time:=strtotime(m.time2);
  end;

  if (m.Day[0]=0) then
    form2.ComboBox3.ItemIndex:=0
  else begin
    form2.ComboBox3.ItemIndex:=1;
    whatday(m.Day);
  end;

  if SG1.Cells[4,SG1.Row]='7' then begin
   i:=pos('%',SG1.Cells[2,SG1.Row]);
   form2.LabeledEdit2.Text:=copy(SG1.Cells[2,SG1.Row],1,i-1);
   form2.LabeledEdit3.Text:=copy(SG1.Cells[2,SG1.Row],i+1,MaxInt{length(stringgrid1.Cells[2,stringgrid1.Row])-i});
  end
  else

    form2.LabeledEdit2.Text:=SG1.Cells[2,SG1.Row];
    form2.groupbox2.Enabled:=false;
    form2.groupbox3.Enabled:=false;
    form2.ip1.Enabled:=false;
    form2.ip1.Text:='';
    form2.eUser.Text:='';
    form2.ePass.Text:='';
    form2.eHost.Text:='';

    if m.tcp then begin
      form2.CheckBox8.Checked:=true;
      form2.groupbox2.Enabled:=true;
      form2.ip1.Enabled:=true;
      s:=SG1.Cells[2,SG1.Row];
      if s<>'' then
      if (s[1]='\')and((s[2]='\')) then begin
        s:=copy(s,3,maxint);
        i:=pos('\',s);
        form2.ip1.Text:=copy(s,1,i-1);
        form2.LabeledEdit2.Text:=copy(s,i+1,maxint);
      end else begin
        form2.ip1.Text:='';
        form2.LabeledEdit2.Text:=SG1.Cells[2,SG1.Row];
      end;
    end;

    if m.ftp then begin
      form2.chFTP.Checked:=true;
      form2.groupbox3.Enabled:=true;
      form2.eHost.Enabled:=true;
      form2.eUser.Enabled:=True;
      form2.ePass.Enabled:=True;
      s:=SG1.Cells[2,SG1.Row];
      if s<>'' then
        if (s[4]='@') then begin
          s:=copy(s,5,maxint);
          i:=pos('\',s);
          form2.LabeledEdit2.Text:=copy(s,i+1,maxint);
          i:=pos(';',s);
          if i<>0 then begin
            form2.eHost.Text := split(s,';',1);
            form2.eUser.Text := split(s,';',2);
            form2.ePass.Text := split(split(s,';',3),'\',1);
          end
          else begin
            form2.eHost.Text:= split(s,'\',1)
          end;

        end else begin
          form2.eHost.Text:='';
          form2.LabeledEdit2.Text:=SG1.Cells[2,SG1.Row];
        end;
    end;




  if m.recur then
    form2.rg2.itemindex:=1
  else
    form2.rg2.itemindex:=0;

  form2.ComboBox2Change(sender);
  form2.ComboBox3Change(sender);
  form2.ComboBox4Change(sender);

  form2.PageControl1.Pages[1].TabVisible:=false;
  form2.PageControl1.ActivePageIndex:=0;
  form2.showmodal;
end;

procedure TMainForm.SG1KeyPress(Sender: TObject; var Key: Char);
begin
if SG1.Col=4 then
  if  (key in ['0'..'8']) then begin
    if length(SG1.Cells[4,SG1.Row])<=1 then
      SG1.Cells[4,SG1.Row]:=key;
    end
  else if not (key=#13) then
    key:=#0;
end;



procedure TMainForm.Button7Click(Sender: TObject);
begin   
 for2;
  form2.PageControl1.Pages[0].TabVisible:=false;
  form2.PageControl1.ActivePageIndex:=1;
  form2.ShowModal;
end;

procedure TMainForm.BLogClick(Sender: TObject);
var
  flog:TFormLP;
begin
  flog:=TFormLP.Create(Application);
  try
    N6.Enabled:=False;
    BLog.Enabled:=False;

    flog.ShowModal;
    N6.Enabled:=True;
    BLog.Enabled:=True;       

  finally
    FreeAndNil(flog);
  end;

end;

end.

