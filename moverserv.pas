// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.202.14.15/mover/services/moverserv.asmx?WSDL
//  >Import : http://10.202.14.15/mover/services/moverserv.asmx?WSDL:0
// Encoding : utf-8
// Version  : 1.0
// (04.10.2016 13:04:26 - - $Rev: 10138 $)
// ************************************************************************ //

unit moverserv;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : MoverServSoap
  // service   : MoverServ
  // port      : MoverServSoap
  // URL       : http://10.202.14.15/mover/services/moverserv.asmx
  // ************************************************************************ //
  MoverServSoap = interface(IInvokable)
  ['{AE976353-68A9-78B0-0230-A3EC9E37A7D6}']
    function  IP(const query: WideString): WideString; stdcall;
    function  REG(const ip: WideString; const name_: WideString; const path: WideString; const vers: WideString; const aStart: Integer; const interval: Integer; 
                  const baloon: Integer): WideString; stdcall;
    function  SetCnf(const dir_id: WideString; const MC: WideString; const mask: WideString; const stat: WideString; const dir: WideString; const ip: WideString; 
                     const interval: Integer; const baloon: Integer): WideString; stdcall;
    function  GetCnf(const m_hash: WideString; const ip: WideString): WideString; stdcall;
  end;

function GetMoverServSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MoverServSoap;


implementation
  uses SysUtils;

function GetMoverServSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MoverServSoap;
const
  defWSDL = 'http://10.202.14.15/mover/services/moverserv.asmx?WSDL';
  defURL  = 'http://10.202.14.15/mover/services/moverserv.asmx';
  defSvc  = 'MoverServ';
  defPrt  = 'MoverServSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as MoverServSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(MoverServSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MoverServSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(MoverServSoap), ioDocument);
  InvRegistry.RegisterExternalParamName(TypeInfo(MoverServSoap), 'REG', 'name_', 'name');

end.