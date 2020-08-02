unit uAlxdOptionEditor;

interface

uses
  Windows, ComObj, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  TntForms, Dialogs, ComCtrls, StdCtrls, ExtCtrls, Registry, Menus, ActnList, IniFiles,
  uAlxdOptions, uAlxdLocalizer, uAlxdRegistry, uAlxdSystem,{AlxdTypes, AlxdSystem, AlxdOption,}
  TntClasses, TntRegistry, TntComCtrls, uoarxImport, TntSysUtils{, HtmlHelpAPI{, AlxdEditorForm, };

type
  //TOptionForm = class(TTntForm)
  TfrmAlxdOptionEditor = class(TTntForm)
    bOk: TButton;
    bCancel: TButton;
    PageControl: TPageControl;
    tsProperties: TTabSheet;
    lProperties: TLabel;
    lValue: TLabel;
    bvBrowse: TBevel;
    tvProperties: TTntTreeView;
    cbValue: TComboBox;
    bBrowse: TButton;
    tsActions: TTabSheet;
    lActions: TLabel;
    lHotkey: TLabel;
    bvClear: TBevel;
    lbActions: TListBox;
    hkAction: THotKey;
    bClear: TButton;
    cbColor: TColorBox;

    // Form
    procedure LoadCaptions;
    procedure LoadRegistry;
    procedure SaveRegistry;
    procedure LoadActions;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);

    // Tree View Events
    procedure tvPropertiesAdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
    procedure tvPropertiesChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure tvPropertiesDeletion(Sender: TObject; Node: TTreeNode);
    procedure tvPropertiesKeyPress(Sender: TObject; var Key: Char);

    // Value events
    procedure cbValueSelect(Sender: TObject);

    // Service Functions
    procedure cbPositiveFloatKeyPress(Sender: TObject; var Key: Char);
    procedure cbPositiveIntegerKeyPress(Sender: TObject; var Key: Char);
    procedure bBrowseClick(Sender: TObject);

    {$IFDEF DLL}
    procedure cbColorDropDown(Sender: TObject);
    procedure cbColorCloseUp(Sender: TObject);
    procedure cbColorDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    {$ENDIF}

    procedure CopyNames(Source: TTntStrings; Dest: TStrings);
    function  IndexOfValue(List: TTntStrings; Value: WideString): integer;

    // Listbox events
    procedure lbActionsClick(Sender: TObject);
    procedure lbActionsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure hkActionChange(Sender: TObject);
    procedure bClearClick(Sender: TObject);

    procedure WndProc(var Message: TMessage); override;
  private
    { Private declarations }
    //FEditorForm: TEditorForm;
    //FAlxdOption: TAlxdOption;
    FValue: TAlxdSpreadSheetOptionsInt;

    FLanguageList: TTntStringList;
    FLanguageTitle: WideString;

  protected
    { Protected declarations }
    procedure WMHelp(var aMessage: TWMHelp); message WM_HELP;

  public
    { Public declarations }
    // Form
    //property    AlxdOption: TAlxdOption read FAlxdOption;
    function    Edit(Value: TAlxdSpreadSheetOptionsInt): integer;
    //constructor CreateEx(AOwner: TComponent{; AEditorForm: TEditorForm; AAlxdOption: TAlxdOption});
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

//var
//  OptionForm: TOptionForm;

implementation

uses uAlxdEditor;

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
//
// Private
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdOptionEditor.LoadCaptions;
begin
  try
    Caption:=MessageMemIniFile(50);
    ReadCaptionSectionData(Self, 'OptionForm');
    ReadTreeSectionData(tvProperties);
  except
    on E:Exception do
      Raise EOleError.CreateFmt('Loading captions failed! Some values is invalid.', []);
  end;
end;

procedure TfrmAlxdOptionEditor.LoadRegistry;
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    LoadSize(r, Self, 'OptionForm');
//    if not q then
//      Raise EOleError.CreateFmt('Loading OptionForm position keys failed! Some keys has invalid values.', []);

  finally
    r.Free;
  end;
end;

procedure TfrmAlxdOptionEditor.SaveRegistry;
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    SaveSize(r, Self, 'OptionForm');

  finally
    r.Free;
  end;
end;

procedure TfrmAlxdOptionEditor.LoadActions;
var
  i: integer;
begin
  lbActions.Clear;
  with FfrmEditor do
    for i:=0 to alMain.ActionCount-1 do
    begin
      if TAction(alMain[i]).Tag < 3000 then //??? renumerate
        lbActions.AddItem('', alMain[i]);
    end;

  lbActions.ItemIndex:=0;
  lbActionsClick(lbActions);
end;

procedure TfrmAlxdOptionEditor.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  hk: THotKey;
begin
  if (ActiveControl is THotKey) and not (ssShift in Shift) then
  begin
    hk:=(ActiveControl as THotKey);

    if Key = VK_DELETE then
    begin
      hk.HotKey:=ShortCut(VK_DELETE, Shift);
      hkActionChange(Sender);
      Key:=0;
    end;

    if key = VK_BACK then
    begin
      hk.HotKey:=ShortCut(VK_BACK, Shift);
      hkActionChange(Sender);
      Key:=0;
    end;
  end;
end;

procedure TfrmAlxdOptionEditor.FormResize(Sender: TObject);
begin
  bCancel.Top:=Height - bCancel.Height - (Height-ClientHeight) - 6;
  bOk.Top:=bCancel.Top;

  bCancel.Left:=Width - bCancel.Width - (Width - ClientWidth) - 6;
  bOk.Left:=bCancel.Left - bOk.Width - 8;

  PageControl.Width:=ClientWidth - 12;
  PageControl.Height:=bOk.Top - PageControl.Top - 8;

  tvProperties.Width:=tsProperties.Width - tvProperties.Left - 8;
  lbActions.Width:=tvProperties.Width;

  cbValue.Top:=tsProperties.Height - cbValue.Height - 16;

  bvBrowse.Top:=cbValue.Top;
  bvBrowse.Height:=cbValue.Height;
  bvBrowse.Width:=cbValue.Height;
  bvBrowse.Left:=tvProperties.Left + tvProperties.Width - bvBrowse.Width;

  bBrowse.Top:=bvBrowse.Top + 1;
  bBrowse.Left:=bvBrowse.Left + 1;
  bBrowse.Height:=bvBrowse.Height - 2;
  bBrowse.Width:=bvBrowse.Width - 2;

  bvClear.Top:=hkAction.Top;
  bvClear.Height:=hkAction.Height;
  bvClear.Width:=hkAction.Height;
  bvClear.Left:=lbActions.Left + lbActions.Width - bvClear.Width;

  bClear.Top:=bvClear.Top + 1;
  bClear.Left:=bvClear.Left + 1;
  bClear.Height:=bvClear.Height - 2;
  bClear.Width:=bvClear.Width - 2;

  if bBrowse.Visible then
    cbValue.Width:=tvProperties.Left + tvProperties.Width - cbValue.Left - bvBrowse.Width - 1
  else
    cbValue.Width:=tvProperties.Left + tvProperties.Width - cbValue.Left;

  cbColor.Top:=cbValue.Top;
  cbColor.Left:=cbValue.Left;
  cbColor.Width:=cbValue.Width;

  hkAction.Top:=cbValue.Top;
  hkAction.Width:=lbActions.Left + lbActions.Width - hkAction.Left - bvClear.Width - 1;

  tvProperties.Height:=cbValue.Top - tvProperties.Top - 16;
  lbActions.Height:=tvProperties.Height;

  lValue.Top:=cbValue.Top + ((cbValue.Height - lValue.Height) div 2);
  lHotKey.Top:=lValue.Top;

  lbActions.Invalidate;
end;

////////////////////////////////////////////////////////////////////////////////
// Tree View Events
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdOptionEditor.tvPropertiesAdvancedCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);

  procedure SwitchColor;
  begin
    if cdsSelected in State then
      Node.TreeView.Canvas.Font.Color:=clSkyBlue
    else
      Node.TreeView.Canvas.Font.Color:=clNavy;
  end;

var
  tmp: string;
begin
  //if (ComponentState <> []) then exit;
  if FValue = nil then exit;
  
  if Stage = cdPrePaint then
  begin
    if Node.Level = 0 then
    begin
      Node.TreeView.Canvas.Font.Style:=[fsBold];
    end;

    with FValue do
    begin
      case Node.SelectedIndex of
      1..10:Node.Text:=String(PChar(Node.data));
      100:  Node.Text:=Format(String(PChar(Node.data)),[FontName]);
      101:  Node.Text:=Format(String(PChar(Node.data)),[FontSize]);
      {
      200:  Node.Text:=Format(String(PChar(Node.data)),[SubMessageMemIniFile(15002, Ord(UseCase))]);
      201:  Node.Text:=Format(String(PChar(Node.data)),[UpperCase]);
      202:  Node.Text:=Format(String(PChar(Node.data)),[LowerCase]);
      }
      300:  Node.Text:=Format(String(PChar(Node.data)),[SubMessageMemIniFile(15011, Ord(Transparency))]);
      301:  Node.Text:=Format(String(PChar(Node.data)),[TransparencyValue]);
      {
      400:  Node.Text:=Format(String(PChar(Node.data)),[SubMessageMemIniFile(15005, TAPosition)]);
      401:  Node.Text:=Format(String(PChar(Node.data)),[TAPrevStr]);
      402:  Node.Text:=Format(String(PChar(Node.data)),[TANextStr]);
      403:  Node.Text:=Format(String(PChar(Node.data)),[TAFileName]);
      404:  Node.Text:=Format(String(PChar(Node.data)),[SubMessageMemIniFile(15000, Integer(TAAskSave))]);
      }
      900:  Node.Text:=Format(String(PChar(Node.data)),[PixelToMmX]);
      901:  Node.Text:=Format(String(PChar(Node.data)),[PixelToMmY]);
      902:  Node.Text:=Format(String(PChar(Node.data)),[SubMessageMemIniFile(15006, Ord(DrawHidedBorders))]);
      903:  Node.Text:=Format(PChar(Node.data),[SubMessageMemIniFile(15007, Ord(ExitOnEnter))]);
      904:  Node.Text:=Format(String(PChar(Node.data)),[StylePath]);
      905:
        begin
          SwitchColor;
          Node.Text:=Format(String(PChar(Node.data)),[FLanguageTitle]);
        end;
      906:  Node.Text:=Format(PChar(Node.data),[SubMessageMemIniFile(15008, Ord(DirectionEnter))]);
      907:  Node.Text:=Format(PChar(Node.data),[SubMessageMemIniFile(15009, Ord(DirectionTab))]);
      908:  Node.Text:=Format(String(PChar(Node.data)),[FixedColWidth]);
      909:  Node.Text:=Format(String(PChar(Node.data)),[FixedRowHeight]);
      910:  Node.Text:=Format(PChar(Node.data),[SubMessageMemIniFile(15000, Ord(WordWrap))]);
      911:  Node.Text:=Format(String(PChar(Node.data)),[SyncDelay]);
      912:  AlxdColorText(Node, DrawingSelectionColor);// Node.Text:=Format(String(PChar(Node.data)),['test']);
      913:
        begin
          SwitchColor;
          Node.Text:=Format(PChar(Node.data),[SubMessageMemIniFile(15010, Ord(UseDynamicProperties))]);
        end;
      914:
        begin
          if not AlxdColorToPrettyName(SelectionColor, tmp) then
            tmp:=Format('%x',[SelectionColor]);
          Node.Text:=Format(String(PChar(Node.data)),[tmp]);
        end;
      915:
        begin
          if not AlxdColorToPrettyName(FixedColor, tmp) then
            tmp:=Format('%x',[FixedColor]);
          Node.Text:=Format(String(PChar(Node.data)),[tmp]);
        end;

      end;//case
    end;//with FAlxdGridOption do
  end;//if Stage = cdPrePaint then
end;

procedure TfrmAlxdOptionEditor.tvPropertiesChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  if Node.SelectedIndex < 10 then
  begin
    cbValue.Clear;
    cbValue.Enabled:=False;
    lVAlue.Enabled:=False;
  end
  else
  with FValue do
  begin
    cbValueSelect(Sender);

    {$IFDEF DLL}
    oarxDetachColorCombo;
    {$ENDIF}

//    if (tvProperties.Selected <> nil) and (tvProperties.Selected.SelectedIndex = 905) then
//      FreeObjects;

    cbValue.Clear;
    cbValue.MaxLength:=0;
    cbValue.Visible:=True;
    bBrowse.Visible:=False;
    bvBrowse.Visible:=False;
    cbColor.Visible:=False;
    cbValue.OnKeyPress:=nil;
    cbValue.OnExit:=nil;

    cbValue.OnDrawItem:=nil;
    cbValue.OnDropDown:=nil;
    cbValue.OnCloseUp:=nil;


    case Node.SelectedIndex of
    100://Font name
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items:=Screen.Fonts;
        cbValue.ItemIndex:=cbValue.Items.IndexOf(FontName);
      end;
    101://Font size
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(15001);
        cbValue.ItemIndex:=cbValue.Items.IndexOf(IntToStr(FontSize));
      end;
    {
    200://Find sensitive
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(15002);
        cbValue.ItemIndex:=Ord(UseCase);
      end;
    201://Find Upper case string
      begin
        cbValue.Style:=csSimple;
        cbValue.Text:=UpperCase;
      end;
    202://Find Lower case string
      begin
        cbValue.Style:=csSimple;
        cbValue.Text:=LowerCase;
      end;
    }
    300://Transparency
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(15011);
        cbValue.ItemIndex:=Ord(Transparency);
      end;
    301://Transparency value
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveIntegerKeyPress;
        cbValue.Text:=Format('%d', [TransparencyValue]);
      end;
    {
    400://Text assist position
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(15005);
        cbValue.ItemIndex:=TAPosition;
      end;
    401://Text assist prevStr symbols
      begin
        cbValue.Style:=csSimple;
        cbValue.MaxLength:=2;
        cbValue.Text:=TAPrevStr;
      end;
    402://Text assist nextStr symbols
      begin
        cbValue.Style:=csSimple;
        cbValue.MaxLength:=2;
        cbValue.Text:=TANextStr;
      end;
    403://Text assist default database file name
      begin
        bBrowse.Visible:=True;
        bvBrowse.Visible:=True;
        cbValue.Style:=csSimple;
        cbValue.Text:=TAFileName;
      end;
    404://Text assist ask save
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(15000);
        cbValue.ItemIndex:=Ord(TAAskSave);
      end;
    }
    900://Editor X scale factor
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Text:=AlxdRToS(PixelToMmX)
      end;
    901://Editor Y scale factor
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Text:=AlxdRToS(PixelToMmY);
      end;
    902://Editor show/hide hided borders
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(15006);
        cbValue.ItemIndex:=Ord(DrawHidedBorders);
      end;
    903://Editor exit on enter
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(15007);
        cbValue.ItemIndex:=Ord(ExitOnEnter);
      end;
    904://Editor style path
      begin
        bBrowse.Visible:=True;
        bvBrowse.Visible:=True;
        cbValue.Style:=csSimple;
        cbValue.Text:=StylePath;
      end;
    905: //language
      begin
        cbValue.Style:=csDropDownList;
        CopyNames(FLanguageList, cbValue.Items);
        cbValue.ItemIndex:=cbValue.Items.IndexOf(FLanguageTitle);
      end;
    906://Editor enter direction
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(15008);
        cbValue.ItemIndex:=Ord(DirectionEnter);
      end;
    907://Editor tab direction
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(15009);
        cbValue.ItemIndex:=Ord(DirectionTab);
      end;
    908://Editor Fixed Col Width
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveIntegerKeyPress;
        cbValue.Text:=Format('%d', [FixedColWidth]);
      end;
    909://Editor Fixed Row Height
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveIntegerKeyPress;
        cbValue.Text:=Format('%d', [FixedRowHeight]);
      end;
    910://Editor word wrap
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(15000);
        cbValue.ItemIndex:=Ord(WordWrap);
      end;
    911://Editing delay
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveIntegerKeyPress;
        cbValue.Text:=Format('%d', [SyncDelay]);
      end;

    912://Selection color in drawing
      begin
        cbValue.Style:=csDropDownList; //do not remove!!! very important line!!!
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxSetUseByBlock(0);
        oarxSetUseByLayer(0);
        oarxAttachColorCombo(cbValue.Handle);
        oarxInsertColorItemInList(0, 'Inverse', 257);
        cbValue.OnDrawItem:=cbColorDrawItem;
        cbValue.OnDropDown:=cbColorDropDown;
        cbValue.OnCloseUp:=cbColorCloseUp;

        if (DrawingSelectionColor = -1) then
          cbValue.ItemIndex:=0
        else
          cbValue.ItemIndex:=oarxAddColorToColorCombo(DrawingSelectionColor);
        {$ENDIF}
      end;
    913:
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(15010);
        cbValue.ItemIndex:=Ord(UseDynamicProperties);
      end;
    914:
      begin
        cbValue.Visible:=False;
        cbColor.Selected:=SelectionColor;
        cbColor.Visible:=True;
      end;
    915:
      begin
        cbValue.Visible:=False;
        cbColor.Selected:=FixedColor;
        cbColor.Visible:=True;
      end;
    end;

    cbValue.Enabled:=True;
    lVAlue.Enabled:=True;
    cbValue.OnExit:=cbValueSelect;
    cbColor.OnExit:=cbValueSelect;
    FormResize(nil);
  end;
end;

procedure TfrmAlxdOptionEditor.tvPropertiesDeletion(Sender: TObject; Node: TTreeNode);
begin
  if Node.Data <> nil then
    FreeMem(Node.Data);
end;

procedure TfrmAlxdOptionEditor.tvPropertiesKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [^H, #32..#255] then
    if cbValue.Enabled then
    begin
      cbValue.SetFocus;
      SendMessage(cbValue.Handle, WM_CHAR, Ord(Key), 0);
      Key:=#0;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
// Value events
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdOptionEditor.cbValueSelect(Sender: TObject);
begin
  try
    with FValue do
      case tvProperties.Selected.SelectedIndex of
      100: FontName:=cbValue.Text;
      101: FontSize:=StrToInt(cbValue.Text);
      {
      200: UseCase:=Boolean(cbValue.ItemIndex);
      201: UpperCase:=cbValue.Text;
      202: LowerCase:=cbValue.Text;
      }
      300: Transparency:=Boolean(cbValue.ItemIndex);
      301: TransparencyValue:=StrToInt(cbValue.Text);
      {
      400: TAPosition:=cbValue.ItemIndex;
      401: TAPrevStr:=cbValue.Text;
      402: TANextStr:=cbValue.Text;
      403: TAFileName:=cbValue.Text;
      404: TAAskSave:=Boolean(cbValue.ItemIndex);
      }
      900: PixelToMmX:=StrToFloat(cbValue.Text);
      901: PixelToMmY:=StrToFloat(cbValue.Text);
      902: DrawHidedBorders:=boolean(cbValue.ItemIndex);
      903: ExitOnEnter:=boolean(cbValue.ItemIndex);
      904: StylePath:=cbValue.Text;
      905:
         begin
           Language:=FLanguageList.Values[cbValue.Text];
           FLanguageTitle:=FLanguageList.Names[IndexOfValue(FLanguageList, Language)];
         end;
      906: DirectionEnter:=TAlxdDirectionEnter(cbValue.ItemIndex);
      907: DirectionTab:=TAlxdDirectionTab(cbValue.ItemIndex);
      908: FixedColWidth:=StrToInt(cbValue.Text);
      909: FixedRowHeight:=StrToInt(cbValue.Text);
      910: WordWrap:=boolean(cbValue.ItemIndex);
      911: SyncDelay:=StrToInt(cbValue.Text);
      912:
        begin
          DrawingSelectionColor:=Integer(cbValue.Items.Objects[cbValue.ItemIndex]);
          if DrawingSelectionColor > 256 then
            DrawingSelectionColor:=-1;
        end;
      913: UseDynamicProperties:=boolean(cbValue.ItemIndex);
      914: SelectionColor:=cbColor.Selected;
      915: FixedColor:=cbColor.Selected;
      end;

      if (Sender is TComboBox) then
        tvProperties.Refresh;

  except
    on E:Exception do
    begin
//        MessageBox(Handle, PChar(Format(atMessages.Values['optIncorrect'],[caption])), FormCaption, MB_OK+MB_ICONEXCLAMATION);
//        ShowErr(Handle, 700);
      Pagecontrol.ActivePage:=tsProperties;
      cbValue.SetFocus;
    end;
  end;//try
end;

////////////////////////////////////////////////////////////////////////////////
// Service Functions
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdOptionEditor.cbPositiveFloatKeyPress(Sender: TObject; var Key: Char);
begin
  AlxdFloatKeyPress(Sender, Key, False);
end;

procedure TfrmAlxdOptionEditor.cbPositiveIntegerKeyPress(Sender: TObject; var Key: Char);
begin
  AlxdIntegerKeyPress(Sender, Key, False);
end;

procedure TfrmAlxdOptionEditor.bBrowseClick(Sender: TObject);
{$IFDEF DLL}
var
  value: WideString;
{$ENDIF}
begin
  cbValue.SetFocus;
  case tvProperties.Selected.SelectedIndex of
  {
  403:
    begin
      if AlxdGetFileNavDialog('', cbValue.Text, 'txt', '', 0+256, value) = RTNORM then
      begin
        cbValue.Text:=value;
        cbValue.SelectAll;
      end;
    end;
  }
  904:
    begin
      {$IFDEF DLL}
      if oarxAcEdGetFileNavDialog('', cbValue.Text, '', '', 16+2048, value) = RTNORM then
      begin
        cbValue.Text:=value;
        cbValue.SelectAll;
      end;
      {$ENDIF}
    end;
  end;
end;

{$IFDEF DLL}
procedure TfrmAlxdOptionEditor.cbColorDropDown(Sender: TObject);
begin
  oarxOnColorComboDropDown;
end;

procedure TfrmAlxdOptionEditor.cbColorCloseUp(Sender: TObject);
var
  colorindex: integer;
  newsel: integer;
  oldsel:integer;
begin
  if (Sender as TComboBox).ItemIndex < 0 then exit;
  colorindex:=Integer((Sender as TComboBox).Items.Objects[(Sender as TComboBox).ItemIndex]);
  if colorindex < 0 then
    with FValue do
      case tvProperties.Selected.SelectedIndex of
      912:
        begin
          oldsel:=oarxAddColorToColorCombo(DrawingSelectionColor);
          if oarxOnColorComboSelectOther(0, oldsel, newsel) then
            cbValue.ItemIndex:=newsel;
        end;
      end;//case
  oarxOnColorComboCloseUp;
end;

procedure TfrmAlxdOptionEditor.cbColorDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  DrawItemStruct: TDrawItemStruct;
begin
  with DrawItemStruct do
  begin
    CtlType:=ODT_COMBOBOX;
//    CtlID:=
    itemID:=Index;
    itemAction:=ODA_FOCUS;//ODA_DRAWENTIRE;//ODA_FOCUS;ODA_SELECT;
    itemState:=ODS_DEFAULT;//ODS_DEFAULT;//ODS_FOCUS
    hwndItem:=control.Handle;
    hDC:=TComboBox(Control).Canvas.Handle;
    rcItem:=Rect;
    itemData:=0;
  end;
  oarxOnColorComboDrawItem(@DrawItemStruct);
end;
{$ENDIF}

procedure TfrmAlxdOptionEditor.CopyNames(Source: TTntStrings; Dest: TStrings);
var
  i: integer;
begin
  for i:=0 to Source.Count - 1 do
    Dest.Add(Source.Names[i]);
end;

function TfrmAlxdOptionEditor.IndexOfValue(List: TTntStrings; Value: WideString): integer;
var
  i: integer;
begin
  Result:=-1;
  for i:=0 to List.Count -1 do
    if List.Values[List.Names[i]] = Value then
    begin
      Result:=i;
      break;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
// Listbox events
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdOptionEditor.lbActionsClick(Sender: TObject);
begin
  hkAction.HotKey:=TAction(lbActions.Items.Objects[lbActions.ItemIndex]).ShortCut;
end;

procedure TfrmAlxdOptionEditor.lbActionsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  b: TBitmap;
  newRect: TRect;
  s: string;
 // size: TSize;
begin
//  with (Control as TListBox).Canvas do
  with lbActions.Canvas do
  begin
    b:=TBitmap.Create;
    try
      FillRect(Rect);
//      Offset := 2;
      with TAction(lbActions.Items.Objects[Index]) do
      begin//.ImageIndex;
        if not ImageIndex<0 then
        begin
          newRect:=Rect;
          newRect.Left:=Rect.Left+2;
          newRect.Top:=Rect.Top+1;
          FfrmEditor.ilMain.GetBitmap(ImageIndex, b);
//          b.TransparentMode:=tmFixed;
//          b.TransparentColor:=clBtnFace;
          b.Transparent:=True;

          Draw(newRect.Left, newRect.Top, b);
        end;
        //Caption
        newRect:=rect;
        newRect.Left:=Rect.Left+18;
        TextRect(newRect, newRect.Left+1, newRect.Top, Caption);// + #9 + ShortCutToText(ShortCut));
        if ShortCut<>0 then
        begin
          s:=ShortCutToText(ShortCut);
//          size:=TextExtent(s);
          newRect.Left:=Rect.Left+lbActions.Width - TextWidth(s)-25;
          TextRect(newRect, newRect.Left+1, newRect.Top, s);
        end;
      end;
    finally
      b.Free;
    end;
  end;
end;

procedure TfrmAlxdOptionEditor.hkActionChange(Sender: TObject);
var
  i: integer;
begin
  if hkAction.HotKey <> 0 then
    for i:=0 to lbActions.Items.Count - 1 do
      if (i <> lbActions.ItemIndex) and (TAction(lbActions.Items.Objects[i]).ShortCut = hkAction.HotKey) then
      begin
        MessageBox(Handle, PChar(Format(MessageMemIniFile(15020), [TAction(lbActions.Items.Objects[i]).Caption])), nil, MB_OK + MB_ICONWARNING);
        Break;
      end;
  TAction(lbActions.Items.Objects[lbActions.ItemIndex]).ShortCut:=hkAction.HotKey;
  lbActions.Repaint;// .Invalidate;
end;

procedure TfrmAlxdOptionEditor.bClearClick(Sender: TObject);
begin
  hkAction.SetFocus;
  hkAction.HotKey:=0;
  hkActionChange(Sender);
end;



procedure TfrmAlxdOptionEditor.WndProc(var Message: TMessage);
begin
  case Message.Msg of
  CM_DIALOGKEY:
    with TWMKeyDown(Message) do
    if not ((CharCode = 13) and (ActiveControl = cbValue)) then
      inherited;
  else
    inherited;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
// Protected
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdOptionEditor.WMHelp(var aMessage: TWMHelp);
{var
  ContextId: integer;}
begin
{  ContextId:=HHWMHelp(aMessage);
  if ContextId <> 0 then
    HtmlHelp(Handle, Application.HelpFile, HH_HELP_CONTEXT, ContextId);}
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Form
////////////////////////////////////////////////////////////////////////////////

function TfrmAlxdOptionEditor.Edit(Value: TAlxdSpreadSheetOptionsInt): integer;
begin
  try
    FValue:=Value;

    with FValue do
    begin
      LoadLanguages(FLanguageList);
      FLanguageTitle:=FLanguageList.Names[IndexOfValue(FLanguageList, Language)];
    end;

    LoadRegistry;

    tvProperties.FullExpand;
    tvProperties.Items[0].Selected:=True;

    ShowModal;

    SaveRegistry;
  finally
    Result:=ModalResult;
  end;
end;

//constructor TfrmAlxdOptionEditor.CreateEx(AOwner: TComponent{; AEditorForm: TEditorForm; AAlxdOption: TAlxdOption});
constructor TfrmAlxdOptionEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //FValue:=TAlxdSpreadSheetOptionsInt.Create(Self);
  {FEditorForm:=AEditorForm;
  FAlxdOption:=TAlxdOption.Create;
  FAlxdOption.Assign(AAlxdOption);}

  Icon.ReleaseHandle;
  Icon.Handle:=LoadIcon(GetWindowLong(Application.Handle, GWL_HINSTANCE), MakeIntResource(1));

  //Font.Name:=(AOwner as TForm).Font.Name;

  //LoadRegistry;
  LoadActions;
  LoadCaptions;

  FLanguageList:=TTntStringList.Create;
end;

destructor  TfrmAlxdOptionEditor.Destroy;
begin
  FLanguageList.Free;
  //FAlxdOption.Free;
  inherited;
end;

end.

