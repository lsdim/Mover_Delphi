unit ULogPer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, dateUtils, XPMan;

type
  TFormLP = class(TForm)
    DT1: TDateTimePicker;
    DT2: TDateTimePicker;
    BBOK: TBitBtn;
    XPManifest1: TXPManifest;
    procedure FormShow(Sender: TObject);
    procedure DT1Change(Sender: TObject);
    procedure DT2Change(Sender: TObject);
    procedure BBOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLP: TFormLP;

implementation

uses UMain;

{$R *.dfm}

procedure TFormLP.BBOKClick(Sender: TObject);
var
  FS,FL:TextFile;
  i:tdate;
  s:string;
  LogPath:string;
begin

  logPath:=extractfilepath(application.exename)+'Log\';
  forceDirectories(logPath);




  if dt1.Date=dt2.Date then begin
    if fileexists(LogPath+'Mover_'+formatdatetime('yyyy"_"mm"_"dd"',dt1.dateTime)+'.log') then begin
      MainForm.Log1.FileName:=LogPath+'Mover_'+formatdatetime('yyyy"_"mm"_"dd"',dt1.DateTime)+'.log';
      MainForm.log1.ShowLog('Журнал подій ('+LogPath+'Mover_'+formatdatetime('yyyy"_"mm"_"dd"',dt1.DateTime)+'.log)');
    end
    else
      application.MessageBox(PAnsiChar('Немає журналу подій за '+formatdatetime('dd"."mm"."yyyy',dt1.DateTime)),'Mover',mb_iconInformation+mb_ok);
  end
  else begin
    try
      assignFile(FS,LogPath+'TMP.log');
      Rewrite(FS);



      I := dt1.Date;
     while I <= dt2.Date do begin

          if fileexists(LogPath+'Mover_'+formatdatetime('yyyy"_"mm"_"dd"',i)+'.log') then begin
           try

            assignFile(FL,LogPath+'Mover_'+formatdatetime('yyyy"_"mm"_"dd"',i)+'.log');
            reset(fl);
            while not Eof(fl) do begin
              readLn(fl,s);
              writeLn(fs,s);
            end;
          finally
            closeFile(fl);
          end;

        end;



        i:=IncDay(i,1);
      end;



    finally
      closeFile(fs);
    end;

    MainForm.Log1.FileName:=LogPath+'TMP.log';
    MainForm.log1.ShowLog('Журнал подій (з '+formatdatetime('dd"."mm"."yyyy',dt1.DateTime)+' по '+formatdatetime('dd"."mm"."yyyy',dt2.DateTime)+')');

    deletefile(LogPath+'TMP.log');




  end;

end;

procedure TFormLP.DT1Change(Sender: TObject);
begin
  if dt1.Date>dt2.Date then
    dt2.Date:=dt1.Date;
end;

procedure TFormLP.DT2Change(Sender: TObject);
begin
  if dt1.Date>dt2.Date then
    dt1.Date:=dt2.Date;
end;

procedure TFormLP.FormShow(Sender: TObject);
begin
  Dt1.DateTime:=now;
  Dt2.DateTime:=now;

  dt1.SetFocus;

end;

end.
