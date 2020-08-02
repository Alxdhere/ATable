unit uAlxdSearchForm;

interface

uses
  Windows, ComObj, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  TnTForms, TntStdCtrls, StdCtrls, TntRegistry, uAlxdSystem, uAlxdLocalizer, uAlxdRegistry;
  {AlxdTypes, AlxdRegistry, AlxdLocalizer, HtmlHelpAPI}

const
  mrFind       = 20;
  mrReplace    = 21;
  mrReplaceAll = 22;

type
  TfrmAlxdSearchForm = class(TTntForm)
    cbReplaceText: TTntComboBox;
    lFindText: TLabel;
    cbFindText: TTntComboBox;
    lReplaceText: TLabel;
    cbCase: TCheckBox;
    bFind: TButton;
    bReplace: TButton;
    bReplaceAll: TButton;
    bCancel: TButton;

    procedure LoadCaptions;
    procedure LoadRegistry;
    procedure SaveRegistry;
    procedure TntFormResize(Sender: TObject);

    procedure bFindClick(Sender: TObject);
    procedure bReplaceClick(Sender: TObject);
    procedure bReplaceAllClick(Sender: TObject);
{
    function  Get_IsReplace: Boolean;
    procedure Set_IsReplace(Value: Boolean);
}
    procedure SetHelpContext(Value: integer);

  private
    { Private declarations }
    Value: PFind;
//    FIsReplace: boolean;

  protected
    { Protected declarations }
    procedure WMHelp(var aMessage: TWMHelp); message WM_HELP;

  public
    { Public declarations }
    //property  IsReplace: boolean read Get_IsReplace write Set_IsReplace;
    function  Find(AValue: PFind): integer;
    function  Replace(AValue: PFind): integer;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

//var
//  SearchForm: TAlxdSearchForm;

implementation

//uses AlxdEditorForm;

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
//
// Private
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdSearchForm.LoadCaptions;
begin
  try
    ReadCaptionSectionData(Self, 'SearchForm');
  except
    on E:Exception do
      Raise EOleError.CreateFmt('Loading captions failed! Some values is invalid.', []);
  end;
end;

procedure TfrmAlxdSearchForm.LoadRegistry;
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    LoadSize(r, Self, 'SearchForm');
//    if not q then
//      Raise EOleError.CreateFmt('Loading SearchForm position keys failed! Some keys has invalid values.', []);

  finally
    r.Free;
  end;
end;

procedure TfrmAlxdSearchForm.SaveRegistry;
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    SaveSize(r, Self, 'SearchForm');

  finally
    r.Free;
  end;
end;

procedure TfrmAlxdSearchForm.TntFormResize(Sender: TObject);
begin
  cbFindText.Width:=ClientWidth - cbFindText.Left - 8;
  cbReplaceText.Width:=cbFindText.Width;
  cbReplaceText.Top:=cbFindText.Top + cbFindText.Height + 8;

  lFindText.Top:=cbFindText.Top + Round((cbFindText.Height - lFindText.Height) / 2);
  lReplaceText.Top:=cbReplaceText.Top + Round((cbReplaceText.Height - lReplaceText.Height) / 2);

  if not cbReplaceText.Visible then
    cbCase.Top:=cbReplaceText.Top
  else
    cbCase.Top:=cbReplaceText.Top + cbReplaceText.Height + 8;

  bCancel.Top:=cbCase.Top + cbCase.Height + 8;//  - bCancel.Height - 8;
  bCancel.Left:=ClientWidth - bCancel.Width - 8;

  bReplaceAll.Top:=bCancel.Top;
  bReplaceAll.Left:=bCancel.Left - bReplaceAll.Width - 8;

  bReplace.Top:=bCancel.Top;
  bReplace.Left:=bReplaceAll.Left - bReplace.Width - 8;

  bFind.Top:=bCancel.Top;
  if not cbReplaceText.Visible then
    bFind.Left:=bCancel.Left - bFind.Width - 8
  else
    bFind.Left:=bReplace.Left - bFind.Width - 8;

  ClientHeight:=bCancel.Top + bCancel.Height + 8;

end;

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdSearchForm.bFindClick(Sender: TObject);
begin
  if Length(cbFindText.Text) = 0 then
    MessageBox(Handle, PChar(MessageMemIniFile(700)), nil, MB_OK + MB_ICONWARNING)
  else
  begin
    if cbFindText.Items.IndexOf(cbFindText.Text) < 0 then
      cbFindText.Items.Add(cbFindText.Text);

    ModalResult:=mrFind;
  end;//if Length(cbFindText.Text) = 0 then
  cbFindText.SetFocus;
end;

procedure TfrmAlxdSearchForm.bReplaceClick(Sender: TObject);
begin
  if Length(cbFindText.Text) = 0 then
    MessageBox(Handle, PChar(MessageMemIniFile(700)), nil, MB_OK + MB_ICONWARNING)
  else
  begin
    if cbFindText.Items.IndexOf(cbFindText.Text) < 0 then
      cbFindText.Items.Add(cbFindText.Text);
    if cbReplaceText.Items.IndexOf(cbReplaceText.Text) < 0 then
      cbReplaceText.Items.Add(cbReplaceText.Text);

    ModalResult:=mrReplace;
  end;//if Length(cbFindText.Text) = 0 then
  cbFindText.SetFocus;
end;

procedure TfrmAlxdSearchForm.bReplaceAllClick(Sender: TObject);
begin
  if Length(cbFindText.Text) = 0 then
    MessageBox(Handle, PChar(MessageMemIniFile(700)), nil, MB_OK + MB_ICONWARNING)
  else
  begin
    if cbFindText.Items.IndexOf(cbFindText.Text) < 0 then
      cbFindText.Items.Add(cbFindText.Text);
    if cbReplaceText.Items.IndexOf(cbReplaceText.Text) < 0 then
      cbReplaceText.Items.Add(cbReplaceText.Text);

    ModalResult:=mrReplaceAll;
  end;//if Length(cbFindText.Text) = 0 then
  cbFindText.SetFocus;
end;
{
function  TfrmAlxdSearchForm.Get_IsReplace: Boolean;
begin
  Result:=FIsReplace;
end;

procedure TfrmAlxdSearchForm.Set_IsReplace(Value: Boolean);
begin
  FIsReplace:=Value;
  if FIsReplace then
  begin
    Caption:=MessageMemIniFile(54);
    SetHelpContext(72);
  end
  else
  begin
    Caption:=MessageMemIniFile(53);
    SetHelpContext(70);
  end;
end;
}
procedure TfrmAlxdSearchForm.SetHelpContext(Value: integer);
begin
  HelpContext:=Value;
  cbFindText.HelpContext:=Value;
  cbReplaceText.HelpContext:=Value;
  cbCase.HelpContext:=Value;
  bFind.HelpContext:=Value;
  bReplace.HelpContext:=Value;
  bReplaceAll.HelpContext:=Value;
  bCancel.HelpContext:=Value;
end;

////////////////////////////////////////////////////////////////////////////////
//
// Protected
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdSearchForm.WMHelp(var aMessage: TWMHelp);
//var
//  ContextId: integer;
begin
{  ContextId:=HHWMHelp(aMessage);
  if ContextId <> 0 then
    HtmlHelp(Handle, Application.HelpFile, HH_HELP_CONTEXT, ContextId);}
end;

////////////////////////////////////////////////////////////////////////////////
//
// Public
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Form
////////////////////////////////////////////////////////////////////////////////

function TfrmAlxdSearchForm.Find(AValue: PFind): integer;
begin
  try
    Caption:=MessageMemIniFile(53);

    //visible/invisible buttons
    lReplaceText.Visible:=false;
    cbReplaceText.Visible:=false;
    bFind.Visible:=true;
    bReplace.Visible:=false;
    bReplaceAll.Visible:=false;

    Value:=AValue;

    LoadRegistry;

    //copy values to comboboxes
    with Value^ do
    begin
      cbFindText.Items.CommaText:=FindTexts;
      cbReplaceText.Items.CommaText:=ReplaceTexts;

      cbFindText.Text:=FindText;
      cbReplaceText.Text:=ReplaceText;

      cbCase.Checked:=FindUseCase;
    end;

    ShowModal;

    SaveRegistry;
  finally
    with Value^ do
    begin
      FindText:=cbFindText.Text;
      ReplaceText:=cbReplaceText.Text;
      FindTexts:=cbFindText.Items.CommaText;
      ReplaceTexts:=cbReplaceText.Items.CommaText;
      FindUseCase:=cbCase.Checked;
    end;

    Result:=ModalResult;
  end;
end;

function  TfrmAlxdSearchForm.Replace(AValue: PFind): integer;
begin
  try
    Caption:=MessageMemIniFile(54);

    //visible/invisible buttons
    lReplaceText.Visible:=true;
    cbReplaceText.Visible:=true;
    bFind.Visible:=false;
    bReplace.Visible:=true;
    bReplaceAll.Visible:=true;

    Value:=AValue;

    LoadRegistry;

    //copy values to comboboxes
    with Value^ do
    begin
      cbFindText.Items.CommaText:=FindTexts;
      cbReplaceText.Items.CommaText:=ReplaceTexts;

      cbFindText.Text:=FindText;
      cbReplaceText.Text:=ReplaceText;

      cbCase.Checked:=FindUseCase;
    end;

    ShowModal;

    SaveRegistry;
  finally
    with Value^ do
    begin
      FindText:=cbFindText.Text;
      ReplaceText:=cbReplaceText.Text;
      FindTexts:=cbFindText.Items.CommaText;
      ReplaceTexts:=cbReplaceText.Items.CommaText;
      FindUseCase:=cbCase.Checked;
    end;

    Result:=ModalResult;
  end;
end;

constructor TfrmAlxdSearchForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Icon.ReleaseHandle;
  Icon.Handle:=LoadIcon(GetWindowLong(Application.Handle, GWL_HINSTANCE), MakeIntResource(1));

  //LoadRegistry;
  LoadCaptions;
end;

destructor  TfrmAlxdSearchForm.Destroy;
begin
  //SaveRegistry;
  inherited;
end;

end.
