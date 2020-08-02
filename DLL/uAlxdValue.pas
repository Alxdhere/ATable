unit uAlxdValue;

interface

uses
  Windows, Messages, Controls, StdCtrls, Classes, SysUtils, Forms,
  uAlxdSystem, TntForms, TntStdCtrls, uoarxImport, uAlxdLocalizer
  {, HtmlHelpAPI};

type
  TValueForm = class(TTnTForm)
    bOk: TButton;
    bCancel: TButton;
    lValue: TLabel;
    eValue: TTntEdit;
    procedure bOkIntegerClick(Sender: TObject);
    procedure bOkStringClick(Sender: TObject);
    procedure bOkFloatClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure WMHelp(var aMessage: TWMHelp); message WM_HELP;

  public
    { Public declarations }
  end;

var
  ValueForm: TValueForm;

  function GetInteger(AParent: TTntForm; Help: integer; ACaption, ATitle: string; Default: integer; var AValue: integer): integer;
  function GetString(AParent: TTntForm; Help: integer; ACaption, ATitle, Default: WideString; var AValue: WideString): integer;
  function GetFloat(AParent: TTntForm; Help: integer; ACaption, ATitle: string; Default: Double; var AValue: Double): integer;

implementation

//uses AlxdEditorForm;

{$R *.dfm}
function GetInteger(AParent: TTnTForm; Help: integer; ACaption, ATitle: string; Default: integer; var AValue: integer): integer;
begin
  ValueForm:=TValueForm.Create(AParent);
//   CreateParented(AParent);
  try
    with ValueForm do
    begin
      Font.Name:=AParent.Font.Name;
      Caption:=ACaption;
      lValue.Caption:=ATitle;
      eValue.Text:=IntToStr(Default);
      ReadCaptionSectionData(ValueForm, 'ValueForm');

      eValue.HelpContext:=Help;
      bOk.HelpContext:=Help;
      bCancel.HelpContext:=Help;

      bOk.OnClick:=bOkIntegerClick;

      result:=ShowModal;

      if result=mrOk then
        AValue:=StrToInt(eValue.Text);
    end;
  finally
    ValueForm.Free;
  end;
end;

function GetString(AParent: TTnTForm; Help: integer; ACaption, ATitle, Default: WideString; var AValue: WideString): integer;
begin
  ValueForm:=TValueForm.Create(AParent);
  try
    with ValueForm do
    begin
      Font.Name:=AParent.Font.Name;
      Caption:=ACaption;
      lValue.Caption:=ATitle;
      eValue.Text:=Default;
      bOk.OnClick:=bOkStringClick;
      ReadCaptionSectionData(ValueForm, 'ValueForm');

      eValue.HelpContext:=Help;
      bOk.HelpContext:=Help;
      bCancel.HelpContext:=Help;

      result:=ShowModal;

      if result=mrOk then
        AValue:=eValue.Text;
    end;
  finally
    ValueForm.Free;
  end;
end;

function GetFloat(AParent: TTnTForm; Help: integer; ACaption, ATitle: string; Default: Double; var AValue: Double): integer;
begin
  ValueForm:=TValueForm.Create(AParent);
  try
    with ValueForm do
    begin
      Font.Name:=AParent.Font.Name;
      Caption:=ACaption;
      lValue.Caption:=ATitle;
      eValue.Text:=AlxdRToS(Default);
      bOk.OnClick:=bOkFloatClick;
      ReadCaptionSectionData(ValueForm, 'ValueForm');

      eValue.HelpContext:=Help;
      bOk.HelpContext:=Help;
      bCancel.HelpContext:=Help;

      result:=ShowModal;

      if result=mrOk then
        AlxdDisToF(eValue.Text, AValue);
    end;
  finally
    ValueForm.Free;
  end;
end;

procedure TValueForm.bOkIntegerClick(Sender: TObject);
var
  code: integer;
  v: integer;
begin
  Val(eValue.Text, v, code);
  if Code <> 0 then
  begin
//    MessageBox(Handle, PChar(atMessages.Values['intError']), PChar(Caption), MB_OK+MB_ICONEXCLAMATION);
    eValue.SetFocus;
  end
  else
    ModalResult:=mrOk;
end;

procedure TValueForm.bOkStringClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TValueForm.bOkFloatClick(Sender: TObject);
var
  Value: double;
begin
  if not AlxdDisToF(eValue.Text, Value) then
  begin
    eValue.SetFocus
  end
  else
    ModalResult:=mrOk;
end;

////////////////////////////////////////////////////////////////////////////////
//
// Protected
//
////////////////////////////////////////////////////////////////////////////////

procedure TValueForm.WMHelp(var aMessage: TWMHelp);
//var
//  ContextId: integer;
begin
{  ContextId:=HHWMHelp(aMessage);
  if ContextId <> 0 then
    HtmlHelp(Handle, Application.HelpFile, HH_HELP_CONTEXT, ContextId);}
end;

end.
