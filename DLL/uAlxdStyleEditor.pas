unit uAlxdStyleEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, TntForms, Forms,
  Dialogs, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, uAlxdSpreadSheetStyle,
  ActnList, TntActnList, xAlxdStyleEditor, AlxdGrid_TLB, ExtCtrls, uAlxdTreeView,
  TntRegistry, uAlxdRegistry, uAlxdLocalizer, uoarxImport, uAlxdSystem;

type
  TfrmAlxdStyleEditor = class(TTntForm, IAlxdStyleEditor)
    lStyleProperty: TTntLabel;
    lValue: TTntLabel;
    cbValue: TTntComboBox;
    bCancel: TButton;
    bApply: TButton;
    bBrowse: TButton;
    bvBrowse: TBevel;
    tvStyleProperties: TAlxdTreeView;

    // Form
    procedure LoadCaptions;
    procedure LoadRegistry;
    procedure SaveRegistry;
    procedure FormResize(Sender: TObject);

    // Service item functions
    function  SearchTreeNode(SelectedIndex: integer): TTntTreeNode;
    function  ItemRealSize(Index: integer): double;
    function  ItemFullSize: double;
    procedure ItemFillTree;
    function  ItemTreeNode: TTntTreeNode;

    // Service combobox function
    procedure cbFloatKeyPress(Sender: TObject; var Key: Char);
    procedure cbPositiveFloatKeyPress(Sender: TObject; var Key: Char);
    procedure cbPositiveIntegerKeyPress(Sender: TObject; var Key: Char);

    {$IFDEF DLL}
    procedure cbColorDropDown(Sender: TObject);
    procedure cbColorCloseUp(Sender: TObject);
    procedure cbColorDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);

    procedure cbLineWeightDropDown(Sender: TObject);
    procedure cbLineWeightDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    {$ENDIF}

    // Tree events
    //procedure tvStylePropertiesAdvancedCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
    procedure tvStylePropertiesChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure tvStylePropertiesDeletion(Sender: TObject; Node: TTreeNode);
    procedure tvStylePropertiesKeyPress(Sender: TObject; var Key: Char);
    procedure tvStylePropertiesAdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);

    // Value events
    procedure cbValueSelect(Sender: TObject);

    // Button event
    procedure bBrowseClick(Sender: TObject);


  private
    { Private declarations }
    FAlxdStyleEditor: IAlxdStyleEditor;
    FValue: TAlxdSpreadSheetStyleInt;

  public
    property Intf: IAlxdStyleEditor read FAlxdStyleEditor implements IAlxdStyleEditor;

    function Edit(Value: TAlxdSpreadSheetStyleInt): Integer;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

var
  FfrmAlxdStyleEditor: TfrmAlxdStyleEditor;

implementation

uses ComServ;
//uses uAlxdSpreadSheetStyle;

{$R *.dfm}

procedure TfrmAlxdStyleEditor.LoadCaptions;
begin
  try
    Caption:=MessageMemIniFile(51);
    ReadCaptionSectionData(Self, 'StyleEditForm');
    ReadTreeSectionData(tvStyleProperties);
  except
    on E:Exception do
      {$IFDEF DLL}
      oarxAcUtPrintf(#10'Loading Style Editor captions failed! Some values is invalid.');
      {$ENDIF}
  end;
end;

procedure TfrmAlxdStyleEditor.LoadRegistry;
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    LoadSize(r, Self, 'StyleEditForm');
    //LoadPos(r, Self, 'StyleEditForm');
  finally
    r.Free;
  end;
end;

procedure TfrmAlxdStyleEditor.SaveRegistry;
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    SaveSize(r, Self, 'StyleEditForm');
    //SavePos(r, Self, 'StyleEditForm');
  finally
    r.Free;
  end;
end;

procedure TfrmAlxdStyleEditor.FormResize(Sender: TObject);
begin
  bCancel.Top:=Height - bCancel.Height - (Height-ClientHeight) - 8;
  bApply.Top:=bCancel.Top;

  bCancel.Left:=Width - bCancel.Width - (Width - ClientWidth) - 8;
  bApply.Left:=bCancel.Left - bApply.Width - 8;

  cbValue.Top:=bCancel.Top - cbValue.Height - 8;

  bvBrowse.Top:=cbValue.Top;
  bvBrowse.Height:=cbValue.Height;
  bvBrowse.Width:=cbValue.Height;

  if bBrowse.Visible then
    cbValue.Width:=ClientWidth - cbValue.Left - bvBrowse.Width - 8
  else
    cbValue.Width:=ClientWidth - cbValue.Left - 8;

  tvStyleProperties.Top:=lStyleProperty.Top + lStyleProperty.Height + 8;
  tvStyleProperties.Left:=8;
  tvStyleProperties.Width:=ClientWidth - tvStyleProperties.Left - 8;
  tvStyleProperties.Height:=cbValue.Top - tvStyleProperties.Top - 8;

  bvBrowse.Left:=tvStyleProperties.Left + tvStyleProperties.Width - bvBrowse.Width;

  bBrowse.Top:=bvBrowse.Top + 1;
  bBrowse.Left:=bvBrowse.Left + 1;
  bBrowse.Height:=bvBrowse.Height - 2;
  bBrowse.Width:=bvBrowse.Width - 2;

  lValue.Top:=cbValue.Top + Round((cbValue.Height - lValue.Height) / 2);
end;

////////////////////////////////////////////////////////////////////////////////
//
// Service item functions
//
////////////////////////////////////////////////////////////////////////////////

function TfrmAlxdStyleEditor.SearchTreeNode(SelectedIndex: integer): TTntTreeNode;
var
  i: integer;
  Node: TTntTreeNode;
begin
  result:=nil;
  for i:=0 to tvStyleProperties.Items.Count-1 do
  begin
    Node:=tvStyleProperties.Items[i];
    if Node.SelectedIndex = SelectedIndex then
    begin
      result:=Node;
      break;
    end;
  end;
end;

function TfrmAlxdStyleEditor.ItemRealSize(Index: integer): double;
begin
  with FValue.Items do
  if Items[Index].Size = 0 then
    result:=FValue.DefaultSize
  else
    result:=Items[Index].Size;
end;

function TfrmAlxdStyleEditor.ItemFullSize: double;
var
  count: integer;
  i: integer;
begin
  result:=0;
  count:=FValue.Items.Count;

  for i:=0 to count-1 do
    result:=result + ItemRealSize(i);
end;

procedure TfrmAlxdStyleEditor.ItemFillTree;
var
  count: integer;
  i: integer;
  Node: TTntTreeNode;
  ItemNode: TTntTreeNode;
  ChildNode: TTntTreeNode;
  Expanded: boolean;
begin
  Node:=ItemTreeNode;

  tvStyleProperties.Items.BeginUpdate;
  Expanded:=Node.Expanded;
  Node.DeleteChildren;
  count:=FValue.Items.Count;

  for i:=0 to count-1 do
  begin
    ItemNode:=tvStyleProperties.Items.AddChild(Node, '');
    ChildNode:=tvStyleProperties.Items.AddChild(ItemNode, '');
    ChildNode.SelectedIndex:=1;
    ChildNode:=tvStyleProperties.Items.AddChild(ItemNode, '');
    ChildNode.SelectedIndex:=72;
    ChildNode:=tvStyleProperties.Items.AddChild(ItemNode, '');
    ChildNode.SelectedIndex:=73;
  end;

  if Expanded then
    Node.Expanded:=True;
  tvStyleProperties.Items.EndUpdate;
end;

function TfrmAlxdStyleEditor.ItemTreeNode: TTntTreeNode;
begin
  result:=SearchTreeNode(1001);
end;

////////////////////////////////////////////////////////////////////////////////
//
// Service combobox functions
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdStyleEditor.cbFloatKeyPress(Sender: TObject; var Key: Char);
begin
  if GetKeyState(VK_CONTROL) < 0 then
    inherited
  else
  begin
    case Ord(Key) of
      VK_RETURN:
        cbValueSelect(Sender);
      VK_ESCAPE:
        bCancel.Click;
    end;
    AlxdFloatKeyPress(Sender, Key, True);
  end;
end;

procedure TfrmAlxdStyleEditor.cbPositiveFloatKeyPress(Sender: TObject; var Key: Char);
begin
  if GetKeyState(VK_CONTROL) < 0 then
    inherited
  else
  begin
    case Ord(Key) of
      VK_RETURN:
        cbValueSelect(Sender);
      VK_ESCAPE:
        bCancel.Click;
    end;
    AlxdFloatKeyPress(Sender, Key, False);
  end;
end;

procedure TfrmAlxdStyleEditor.cbPositiveIntegerKeyPress(Sender: TObject; var Key: Char);
begin
  if GetKeyState(VK_CONTROL) < 0 then
    inherited
  else
  begin
    case Ord(Key) of
      VK_RETURN:
        cbValueSelect(Sender);
      VK_ESCAPE:
        bCancel.Click;
    end;
    AlxdIntegerKeyPress(Sender, Key, False);
  end;
end;

{$IFDEF DLL}
procedure TfrmAlxdStyleEditor.cbColorDropDown(Sender: TObject);
begin
  oarxOnColorComboDropDown;
end;

procedure TfrmAlxdStyleEditor.cbColorCloseUp(Sender: TObject);
var
  colorindex: integer;
  newsel: integer;
  oldsel:integer;
begin
  colorindex:=Integer(cbValue.Items.Objects[cbValue.ItemIndex]);
  if colorindex < 0 then
    with FValue do
      case tvStyleProperties.Selected.SelectedIndex of
      60:
        begin
          oldsel:=oarxAddColorToColorCombo(TextColor);
          if oarxOnColorComboSelectOther(0, oldsel, newsel) then
            cbValue.ItemIndex:=newsel;
        end;
      61:
        begin
          oldsel:=oarxAddColorToColorCombo(VerBorderColor);
          if oarxOnColorComboSelectOther(0, oldsel, newsel) then
            cbValue.ItemIndex:=newsel;
        end;
      62:
        begin
          oldsel:=oarxAddColorToColorCombo(HorBorderColor);
          if oarxOnColorComboSelectOther(0, oldsel, newsel) then
            cbValue.ItemIndex:=newsel;
        end;
      end;
  oarxOnColorComboCloseUp;
end;

procedure TfrmAlxdStyleEditor.cbColorDrawItem(Control: TWinControl;
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

////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdStyleEditor.cbLineWeightDropDown(Sender: TObject);
begin
  oarxOnLineWeightComboDropDown;
end;

procedure TfrmAlxdStyleEditor.cbLineWeightDrawItem(Control: TWinControl;
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
  oarxOnLineWeightComboDrawItem(@DrawItemStruct);
end;
{$ENDIF}

////////////////////////////////////////////////////////////////////////////////
//
// Tree events
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdStyleEditor.tvStylePropertiesAdvancedCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);

  procedure isLocked;
  begin
//    if not FIsManager and FValue.Lock then
//      Node.TreeView.Canvas.Font.Color:=clInactiveCaption;
  end;
  
var
  index: integer;
  ItemNode: TTreeNode;
  s: WideString;
begin
  if (ComponentState <> [csFreeNotification]) then exit;

  if Stage = cdPrePaint then
  begin
    if Node.Level = 0 then
    begin
      Node.TreeView.Canvas.Font.Style:=[fsBold];
    end;

    with FValue do
    begin
      case Node.SelectedIndex of
      0:
        begin
          index:=Node.Parent.IndexOf(Node);
          if Items.Items[Index].Size = 0 then
            s:='%d: %s*'
          else
            s:='%d: %s';
          Node.Text:=Format(s,[Index+1, AlxdRToS(ItemRealSize(Index))]); ;
        end;
      1:
        begin
          ItemNode:=Node.Parent;
          Index:=ItemNode.Parent.IndexOf(ItemNode);
          s:=Items.Items[Index].Title;
          if s = '' then s:='-';
          (Node as TTntTreeNode).Text:=WideFormat('%s',[S]);
        end;
      3:
        begin
          isLocked;
          Node.Text:=WideFormat(String(PChar(Node.data)), [HeaderFileName]);
        end;
      4:
        begin
          isLocked;
          Node.Text:=WideFormat(String(PChar(Node.data)), [HeaderBlockName]);
        end;

      6:
        begin
          isLocked;
          (Node as TTntTreeNode).Text:=WideFormat(String(PChar(Node.data)),[TextLayer]);
        end;
      7:
        begin
          isLocked;
          (Node as TTntTreeNode).Text:=WideFormat(String(PChar(Node.data)),[TextStyleName]);
        end;
      8:
        begin
          isLocked;
          (Node as TTntTreeNode).Text:=WideFormat(String(PChar(Node.data)),[VerBorderLayer]);
        end;
      9:
        begin
          isLocked;
          (Node as TTntTreeNode).Text:=WideFormat(String(PChar(Node.data)),[HorBorderLayer]);
        end;
      701:
        begin
           isLocked;
           (Node as TTntTreeNode).Text:=WideFormat(String(PChar(Node.data)),[TextStyleFontName]);
           Node.TreeView.Canvas.Font.Color:=clGray;
        end;
      702:
        begin
          isLocked;
          (Node as TTntTreeNode).Text:=WideFormat(String(PChar(Node.data)),[TextStyleBigFontName]);
           Node.TreeView.Canvas.Font.Color:=clGray;
        end;
      38:
        begin
          isLocked;
          Node.Text:=Format(String(PChar(Node.data)),[AlxdRToS(DefaultSize)]);
        end;
      40:
        begin
          isLocked;
          Node.Text:=Format(String(PChar(Node.data)),[AlxdRToS(TextHeight)]);
        end;
      41:
        begin
          isLocked;
          Node.Text:=Format(String(PChar(Node.data)),[AlxdRToS(TextWidthFactor)]);
        end;
      42:
        begin
          isLocked;
          Node.Text:=Format(String(PChar(Node.data)),[AlxdAngToS(TextObliqueAngle)]);
        end;
      56:
        begin
          isLocked;
          Node.Text:=Format(String(PChar(Node.data)),[AlxdRToS(TextMarginLeft)]);
        end;
      57:
        begin
          isLocked;
          Node.Text:=Format(String(PChar(Node.data)),[AlxdRToS(TextMarginBottom)]);
        end;
      58:
        begin
          isLocked;
          Node.Text:=Format(String(PChar(Node.data)),[AlxdRToS(TextMarginRight)]);
        end;
      59:
        begin
          isLocked;
          Node.Text:=Format(String(PChar(Node.data)),[AlxdRToS(TextMarginTop)]);
        end;
      60:
        begin
          isLocked;
          AlxdColorText(Node, TextColor);
        end;
      61:
        begin
          isLocked;
          AlxdColorText(Node, VerBorderColor);
        end;
      62:
        begin
          isLocked;
          AlxdColorText(Node, HorBorderColor);
        end;
      64:
        begin
          isLocked;
          AlxdLineweightText(Node, TextWeight);
        end;
      65:
        begin
          isLocked;
          AlxdLineweightText(Node, VerBorderWeight);
        end;
      66:
        begin
          isLocked;
          AlxdLineweightText(Node, HorBorderWeight);
        end;

      70:  Node.Text:=Format(String(PChar(Node.data)),[ColCount]);
      71:  Node.Text:=Format(String(PChar(Node.data)),[RowCount]);

      //Items alignment
      72:
        begin
          ItemNode:=Node.Parent;
          Index:=ItemNode.Parent.IndexOf(ItemNode);
          Node.Text:=Format('%s',[SubMessageMemIniFile(1526, Ord(Items.Items[Index].HorizontalAlignment))]);
        end;
      73:
        begin
          ItemNode:=Node.Parent;
          Index:=ItemNode.Parent.IndexOf(ItemNode);
          Node.Text:=Format('%s',[SubMessageMemIniFile(1527, Ord(Items.Items[Index].VerticalAlignment))]);
        end;

      //bool param
      280:
        begin
          Node.Text:=Format(String(PChar(Node.data)),[SubMessageMemIniFile(1522, Ord(DrawBorder))]);
        end;
      281:
        begin
          Node.Text:=Format(String(PChar(Node.data)),[SubMessageMemIniFile(1523, Ord(FillCell))]);
        end;
      282:
        begin
          Node.Text:=Format(String(PChar(Node.data)),[SubMessageMemIniFile(1524, Ord(TextFit))]);
        end;
      283:
        begin
          Node.Text:=Format(String(PChar(Node.data)),[SubMessageMemIniFile(1525, Ord(TextFit))]);
        end;
      287:
        begin
          isLocked;
          Node.Text:=Format(String(PChar(Node.data)),[SubMessageMemIniFile(1520, Ord(Primary))]);
        end;
      288:
        begin
          Node.Text:=Format(String(PChar(Node.data)),[SubMessageMemIniFile(1521, Ord(Justify))]);
        end;
      289:
        begin
          isLocked;
          //Node.Text:=Format(String(PChar(Node.data)),[SubMessageMemIniFile(1528, Ord(Lock))]);
        end;

      1000, 1002..1006: Node.Text:=String(PChar(Node.data));
      1001: Node.Text:=Format(String(PChar(Node.data)),[AlxdRToS(ItemFullSize)]);

      end;//case Node.SelectedIndex of
    end;//with FGridProperty^ do
  end;//if Stage = cdPrePaint
end;


procedure TfrmAlxdStyleEditor.tvStylePropertiesChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);

  procedure isLocked;
  begin
{
    if not FIsManager and FGridProperty^.FLock then
    begin
      lVAlue.Enabled:=False;
      cbValue.Enabled:=False;
      bBrowse.Enabled:=False;
    end;
}
  end;

var
  index: integer;
  ItemNode: TTreeNode;
begin
  cbValueSelect(Sender);
  
  if Node.SelectedIndex > 999 then
  begin
    cbValue.Clear;
    cbValue.Enabled:=False;
    lVAlue.Enabled:=False;
    bBrowse.Enabled:=False;
  end
  else
  with FValue do
  begin
    {$IFDEF DLL}
    oarxDetachColorCombo;
    oarxDetachLineWeightCombo;
    {$ENDIF}

    cbValue.Style:=csDropDownList; //do not remove!!! very important line!!!
    cbValue.Clear;
//    cbValue.MaxLength:=0;
    cbValue.OnKeyPress:=nil;
    cbValue.OnExit:=nil;

    cbValue.OnDrawItem:=nil;
    cbValue.OnDropDown:=nil;
    cbValue.OnCloseUp:=nil;

    lVAlue.Enabled:=True;
    cbValue.Enabled:=True;
    bBrowse.Enabled:=True;

    bBrowse.Visible:=False;
    bvBrowse.Visible:=False;

    case Node.SelectedIndex of
    0: //Items size
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Text:=AlxdRToS(Items.Items[Node.Parent.IndexOf(Node)].Size);
      end;
    1:
      begin
        cbValue.Style:=csSimple;
        ItemNode:=Node.Parent;
        Index:=ItemNode.Parent.IndexOf(ItemNode);
        cbValue.Text:=Items.Items[Index].Title;
      end;
    3: //Header file name
      begin
        bBrowse.Visible:=True;
        bvBrowse.Visible:=True;
        cbValue.Style:=csSimple;
        cbValue.Text:=HeaderFileName;
        isLocked;
      end;
    4: //Header block name
      begin
        //cbValue.Style:=csDropDownList;
        {$IFDEF EXE}
//        cbValue.Items.CommaText:=HeaderBlockName;
//        cbValue.ItemIndex:=0;
        {$ENDIF}
        {$IFDEF DLL}
        oarxGetBlocks(cbValue.Handle);
        cbValue.ItemIndex:=cbValue.Items.IndexOf(HeaderBlockName);
        {$ENDIF}
        isLocked;
      end;
    6: //Text layer
      begin
        //cbValue.Style:=csDropDownList;
        {$IFDEF DLL}
        oarxGetLayers(cbValue.Handle);
        cbValue.ItemIndex:=cbValue.Items.IndexOf(TextLayer);
        {$ELSE}
        cbValue.Items.CommaText:=TextLayer;
        cbValue.ItemIndex:=0;
        {$ENDIF}
        isLocked;
      end;
    7: //Text style
      begin
        //cbValue.Style:=csDropDownList;
        {$IFDEF DLL}
        oarxGetTextStyles(cbValue.Handle);
        cbValue.ItemIndex:=cbValue.Items.IndexOf(TextStyleName);
        {$ELSE}
        cbValue.Items.CommaText:=TextStyleName;
        cbValue.ItemIndex:=0;
        {$ENDIF}
        isLocked;
      end;
    701:
      begin
        isLocked;
        cbValue.Clear;
        cbValue.Enabled:=False;
        lVAlue.Enabled:=False;
      end;
    702:
      begin
        isLocked;
        cbValue.Clear;
        cbValue.Enabled:=False;
        lVAlue.Enabled:=False;
      end;
    8://VerBorderLayer
      begin
        //cbValue.Style:=csDropDownList;
        {$IFDEF DLL}
        oarxGetLayers(cbValue.Handle);
        cbValue.ItemIndex:=cbValue.Items.IndexOf(VerBorderLayer);
        {$ELSE}
        cbValue.Items.CommaText:=VerBorderLayer;
        cbValue.ItemIndex:=0;
        {$ENDIF}
        isLocked;
      end;
    9://HorBorderLayer
      begin
        //cbValue.Style:=csDropDownList;
        {$IFDEF DLL}
        oarxGetLayers(cbValue.Handle);
        cbValue.ItemIndex:=cbValue.Items.IndexOf(HorBorderLayer);
        {$ELSE}
        cbValue.Items.CommaText:=HorBorderLayer;
        cbValue.ItemIndex:=0;
        {$ENDIF}
        isLocked;
      end;
    38://Default size
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Text:=AlxdRToS(DefaultSize);
        isLocked;
      end;
    40://Text height
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Text:=AlxdRToS(TextHeight);
        //cbValue.OnExit:=cbValueSelect;
        isLocked;
      end;
    41://Text width factor
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Text:=AlxdRToS(TextWidthFactor);
        isLocked;
      end;
    42://Text oblique angle
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbFloatKeyPress;
        cbValue.Text:=AlxdAngToS(TextObliqueAngle);
        isLocked;
      end;
    56://Text left margin
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Text:=AlxdRToS(TextMarginLeft);
        isLocked;
      end;
    57://Text bottom margin
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Text:=AlxdRToS(TextMarginBottom);
        isLocked;
      end;
    58://Text right margin
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Text:=AlxdRToS(TextMarginRight);
        isLocked;
      end;
    59://Text top margin
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Text:=AlxdRToS(TextMarginTop);
        isLocked;
      end;
    60:
      begin
        //cbValue.Style:=csDropDownList; //do not remove!!! very important line!!!
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxAttachColorCombo(cbValue.Handle);
        cbValue.OnDrawItem:=cbColorDrawItem;
        cbValue.OnDropDown:=cbColorDropDown;
        cbValue.OnCloseUp:=cbColorCloseUp;
        cbValue.ItemIndex:=oarxAddColorToColorCombo(TextColor);
        {$ENDIF}
        isLocked;
      end;
    61:
      begin
        //cbValue.Style:=csDropDownList; //do not remove!!! very important line!!!
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxAttachColorCombo(cbValue.Handle);
        cbValue.OnDrawItem:=cbColorDrawItem;
        cbValue.OnDropDown:=cbColorDropDown;
        cbValue.OnCloseUp:=cbColorCloseUp;
        cbValue.ItemIndex:=oarxAddColorToColorCombo(VerBorderColor);
        {$ENDIF}
        isLocked;
      end;
    62:
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxAttachColorCombo(cbValue.Handle);
        cbValue.OnDrawItem:=cbColorDrawItem;
        cbValue.OnDropDown:=cbColorDropDown;
        cbValue.OnCloseUp:=cbColorCloseUp;
        cbValue.ItemIndex:=oarxAddColorToColorCombo(HorBorderColor);
        {$ENDIF}
        isLocked;
      end;
    64:
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxAttachLineWeightCombo(cbValue.Handle);
        cbValue.OnDrawItem:=cbLineWeightDrawItem;
        cbValue.OnDropDown:=cbLineWeightDropDown;
        oarxInsertLineWeightItemInList(2, DefaultString, -3);
        cbValue.ItemIndex:=oarxFindItemByLineWeight(TextWeight);
        {$ENDIF}
        isLocked;
      end;
    65:
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxAttachLineWeightCombo(cbValue.Handle);
        cbValue.OnDrawItem:=cbLineWeightDrawItem;
        cbValue.OnDropDown:=cbLineWeightDropDown;
        oarxInsertLineWeightItemInList(2, DefaultString, -3);
        cbValue.ItemIndex:=oarxFindItemByLineWeight(VerBorderWeight);
        {$ENDIF}
        isLocked;
      end;
    66:
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxAttachLineWeightCombo(cbValue.Handle);
        cbValue.OnDrawItem:=cbLineWeightDrawItem;
        cbValue.OnDropDown:=cbLineWeightDropDown;
        oarxInsertLineWeightItemInList(2, DefaultString, -3);
        cbValue.ItemIndex:=oarxFindItemByLineWeight(HorBorderWeight);
        {$ENDIF}
        isLocked;
      end;
    70://Colcount
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveIntegerKeyPress;
        cbValue.Text:=IntToStr(ColCount);
        if Primary = prColumn then
          ItemTreeNode.Expanded:=False;
      end;
    71://Rowcount
      begin
        cbValue.Style:=csSimple;
        cbValue.OnKeyPress:=cbPositiveIntegerKeyPress;
        cbValue.Text:=IntToStr(RowCount);
        if Primary = prRow then
          ItemTreeNode.Expanded:=False;
      end;
    72://Item horizontal alignment
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(1526);

        ItemNode:=Node.Parent;
        Index:=ItemNode.Parent.IndexOf(ItemNode);
        cbValue.ItemIndex:=Ord(Items.Items[Index].HorizontalAlignment);
      end;
    73://Item vertical alignment
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(1527);

        ItemNode:=Node.Parent;
        Index:=ItemNode.Parent.IndexOf(ItemNode);
        cbValue.ItemIndex:=Ord(Items.Items[Index].VerticalAlignment);
      end;
    280://Draw borders
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(1522);
        cbValue.ItemIndex:=Ord(DrawBorder);
      end;
    281://Fill cells
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(1523);
        cbValue.ItemIndex:=Ord(FillCell);
      end;
    282://Fit text
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(1524);
        cbValue.ItemIndex:=ord(TextFit);
      end;
    283://Text type
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(1525);
        cbValue.ItemIndex:=Ord(TextType);
      end;
    287://Primary col/row
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(1520);
        cbValue.ItemIndex:=Ord(Primary);
        ItemTreeNode.Expanded:=False;
        isLocked;
      end;
    288://Justify
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(1521);
        cbValue.ItemIndex:=Ord(Justify);
      end;
    289://Lock
      begin
        //cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=MessageMemIniFile(1528);
        //cbValue.ItemIndex:=Integer(Lock);
        isLocked;
      end;
    end;//case Node.SelectedIndex of

    cbValue.OnExit:=cbValueSelect;
    FormResize(nil);
  end;//with FValue do
end;

procedure TfrmAlxdStyleEditor.tvStylePropertiesDeletion(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Data <> nil then
    FreeMem(Node.Data);
end;

procedure TfrmAlxdStyleEditor.tvStylePropertiesKeyPress(Sender: TObject; var Key: Char);
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
// Value Events
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdStyleEditor.cbValueSelect(Sender: TObject);
var
  tempInt: integer;
  Node: TTreeNode;
  ItemNode: TTreeNode;
  dValue: double;
  tmpStyleName, tmpFontName, tmpBigFontName: WideString;
//  TextStyleFontName: string;
//  TextStyleBigFontName: string;
begin
{$IFDEF SEFDEBUG}
  if tvStyleProperties.Selected <> nil then
    OutputDebugString(PChar(Format(#10'TStyleEditForm.cbValueSelect Tree.Selected.SelectedIndex=%d', [tvStyleProperties.Selected.SelectedIndex])));
{$ENDIF}
  try
    with FValue, tvStyleProperties  do
      if (Selected<>nil) and (Sender as TWinControl).Enabled then
        case Selected.SelectedIndex of
        0:
          begin
            Node:=Selected;
            if AlxdDisToF(cbValue.Text, dValue) then
              FValue.Items.Items[Node.Parent.IndexOf(Node)].Size:=dValue;
          end;
        1:
          begin
            ItemNode:=Selected.Parent;
            tempInt:=ItemNode.Parent.IndexOf(ItemNode);
            FValue.Items.Items[tempInt].Title:=cbValue.Text;
          end;

        3:  HeaderFileName:=cbValue.Text;
        4:  HeaderBlockName:=cbValue.Text;
        6:  TextLayer:=cbValue.Text;
        7://Text Style
          begin
//            TextStyleFontName:='';
//            TextStyleBigFontName:='';
            tmpStyleName:=cbValue.Text;
            tmpFontName:='';
            tmpBigFontName:='';
            {$IFDEF DLL}
            //oarxValidTextStyleName(TextStyleName, TextStyleFontName, TextStyleBigFontName, FTextStyleObjectId);
            if oarxValidTextStyleName(tmpStyleName, tmpFontName, tmpBigFontName, tempInt) then
            {$ENDIF}
            begin
              TextStyleFontName:=tmpFontName;
              TextStyleBigFontName:=tmpBigFontName;
              TextStyleName:=tmpStyleName;
            end;

            tvStyleProperties.Repaint;
          end;
        8:  VerBorderLayer:=cbValue.Text;
        9:  HorBorderLayer:=cbValue.Text;
        38:
          begin
            if AlxdDisToF(cbValue.Text, dValue) then
            begin
              DefaultSize:=dValue;
              tvStyleProperties.Repaint;
            end;
          end;
        40:
          begin
            if AlxdDisToF(cbValue.Text, dValue) then
              TextHeight:=dValue;
          end;
        41:
          begin
            if AlxdDisToF(cbValue.Text, dValue) then
              TextWidthFactor:=dValue;
          end;
        42:
          begin
            if AlxdDisToF(cbValue.Text, dValue) then
              TextObliqueAngle:=dValue;
          end;
        56:
          begin
            if AlxdDisToF(cbValue.Text, dValue) then
              TextMarginLeft:=dValue;
          end;
        57:
          begin
            if AlxdDisToF(cbValue.Text, dValue) then
              TextMarginBottom:=dValue;
          end;
        58:
          begin
            if AlxdDisToF(cbValue.Text, dValue) then
              TextMarginRight:=dValue;
          end;
        59:
          begin
            if AlxdDisToF(cbValue.Text, dValue) then
              TextMarginTop:=dValue;
          end;

        {$IFDEF DLL}
        60: TextColor:=Integer(cbValue.Items.Objects[cbValue.ItemIndex]);
        61: VerBorderColor:=Integer(cbValue.Items.Objects[cbValue.ItemIndex]);
        62: HorBorderColor:=Integer(cbValue.Items.Objects[cbValue.ItemIndex]);
        64: TextWeight:=oarxGetCurrentItemLineWeight;
        //64: TextWeight:=oarxGetItemLineWeight(cbValue.ItemIndex);
        65: VerBorderWeight:=oarxGetCurrentItemLineWeight;
        66: HorBorderWeight:=oarxGetCurrentItemLineWeight;
        {$ENDIF}

        70:
          begin
            tempInt:=StrToInt(cbValue.Text);
            if ColCount<>tempInt then
            begin
              ColCount:=tempInt;
              if Primary = prColumn then
                ItemFillTree;
            end;
          end;
        71:
          begin
            tempInt:=StrToInt(cbValue.Text);
            if RowCount<>tempInt then
            begin
              RowCount:=tempInt;
              if Primary = prRow then
                ItemFillTree;
            end;//if FRowCount
          end;//71: begin
        72:
          begin
            ItemNode:=Selected.Parent;
            tempInt:=ItemNode.Parent.IndexOf(ItemNode);
            FValue.Items.Items[tempInt].HorizontalAlignment:=TAlxdItemTextHorAlignment(cbValue.ItemIndex);
          end;
        73:
          begin
            ItemNode:=Selected.Parent;
            tempInt:=ItemNode.Parent.IndexOf(ItemNode);
            FValue.Items.Items[tempInt].VerticalAlignment:=TAlxdItemTextVerAlignment(cbValue.ItemIndex);
          end;
        280: DrawBorder:=TAlxdDrawBorder(cbValue.ItemIndex);
        281: FillCell:=TAlxdFillCell(cbValue.ItemIndex);
        282: TextFit:=TAlxdTextFit(cbValue.ItemIndex);
        283: TextType:=TAlxdTextType(cbValue.ItemIndex);
        287:
          begin
            if Primary <> TAlxdPrimary(cbValue.ItemIndex) then
            begin
              Primary:=TAlxdPrimary(cbValue.ItemIndex);
              ItemFillTree;
            end;
          end;
        288: Justify:=TAlxdJustify(cbValue.ItemIndex);
//        289: Lock:=Boolean(cbValue.ItemIndex);
        end;//case

    if (Sender is TComboBox) then
      tvStyleProperties.Refresh;
  except
    on E:Exception do
      raise;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Button events
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdStyleEditor.bBrowseClick(Sender: TObject);
var
  value: WideString;
  temp: WideString;
begin
  cbValue.SetFocus;

  case tvstyleProperties.Selected.SelectedIndex of
  3:
    begin
      temp:=cbValue.Text;
      if not FileExists(temp) then
      begin
        temp:=ExtractFilePath(FValue.StyleFileName);
        temp:=temp + ExtractFileName(cbValue.Text);
      end;
      {$IFDEF DLL}
      if oarxAcEdGetFileNavDialog('', temp, 'dwg', '', 256, value) = RTNORM then
      //if AlxdGetFileNavDialog('', cbValue.Text, 'dwg', '', 256, value) = RTNORM then
      begin
        cbValue.Text:=value;
        cbValue.SelectAll;
      end;
      {$ENDIF}
    end;
  end;//case tvstyleProperties.Selected.SelectedIndex of
end;


function TfrmAlxdStyleEditor.Edit(Value: TAlxdSpreadSheetStyleInt): Integer;
begin
  try
    FValue:=Value; //копирует указатель, а не содержимое! Это не Assign!
    
    LoadRegistry;

    ItemFillTree;
    tvStyleProperties.FullExpand;
    tvStyleProperties.Items[0].Selected:=True;
    tvStyleProperties.TopItem:=tvStyleProperties.Items[0];
    //if tvStyleProperties.HandleAllocated then
      //tvStyleProperties.SetFocus;
    //PostMessage(Handle, WM_SETFOCUS, tvStyleProperties.Handle, 0);
    //SendMessage(Handle, WM_SETFOCUS, tvStyleProperties.Handle, 0);
    //FocusControl(tvStyleProperties);
    ActiveControl:=tvStyleProperties;
    
    ShowModal;
    tvStyleProperties.Items[0].Selected:=True;
    
    SaveRegistry;
  finally
    Result:=ModalResult;
    FValue:=nil;
  end;
end;

constructor TfrmAlxdStyleEditor.Create(AOwner: TComponent);
begin
  inherited;
  FAlxdStyleEditor:=TAlxdStyleEditor.Create;

  Icon.ReleaseHandle;
  Icon.Handle:=LoadIcon(GetWindowLong(Application.Handle, GWL_HINSTANCE), MakeIntResource(1));

  LoadCaptions;
end;

destructor  TfrmAlxdStyleEditor.Destroy;
begin
  FValue:=nil;
  //FAlxdStyleEditor.Free;
  inherited;
end;

end.
