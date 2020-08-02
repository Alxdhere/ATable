unit uAlxdFormatEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  TntForms, Dialogs, ComCtrls, ToolWin, ExtCtrls, StdCtrls, AlxdGrid_TLB,
  uAlxdSystem, uAlxdLocalizer, uAlxdSpreadSheet, ComObj, uoarxImport,
  TntRegistry, uAlxdRegistry, uAlxdCell, uAlxdSpreadSheetStyle, TntStdCtrls,
  TntComCtrls, uAlxdTreeView, uAlxdBorder;

type
  TfrmAlxdFormatForm = class(TTntForm)
    bCancel: TButton;
    bApply: TButton;
    cbValue: TComboBox;
    lValue: TTntLabel;
    lCellProperty: TTntLabel;
    tvCellProperties: TAlxdTreeView;

    // Form
    procedure LoadCaptions;
    procedure LoadRegistry;
    procedure SaveRegistry;
    procedure FormResize(Sender: TObject);

    // Tree View Events
    procedure tvCellPropertiesAdvancedCustomDrawItem(
      Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
      Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
    procedure tvCellPropertiesChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure tvCellPropertiesDeletion(Sender: TObject; Node: TTreeNode);
    procedure tvCellPropertiesKeyPress(Sender: TObject; var Key: Char);

    // Value events
    procedure cbValueSelect(Sender: TObject);
    //procedure cbValueApplyStyle(objId: Longint);

    // Service Functions
    procedure cbFloatKeyPress(Sender: TObject; var Key: Char);
    procedure cbPositiveFloatKeyPress(Sender: TObject; var Key: Char);
    {$IFDEF DLL}
    procedure cbColorDropDown(Sender: TObject);
    procedure cbColorCloseUp(Sender: TObject);
    procedure cbColorDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);

    procedure cbLineWeightDropDown(Sender: TObject);
    procedure cbLineWeightDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    {$ENDIF}

    procedure WndProc(var Message: TMessage); override;
  private
//    FAlxdSpreadSheetItem: IAlxdSpreadSheetItem;
//    FAlxdSpreadSheet: TAlxdSpreadSheet;

    //FGridProperty: TGridProperty;
    FSpreadSheetStyle: TAlxdSpreadSheetStyleInt;
    FCellsProperty: TAlxdCellInt;
    FVerBordersProperty: TAlxdBorderInt;
    FHorBordersProperty: TAlxdBorderInt;
    //FBorderProperties: TBorderProperties;
//    TBorderProperty
  public

//    property AlxdSpreadSheetItem: IAlxdSpreadSheetItem read FAlxdSpreadSheetItem write FAlxdSpreadSheetItem;
    //property CellProperty: TCellProperty read FCellProperty;
    //property BordersProperties: TBorderProperties read FBorderProperties;

    // Form
    function    Edit(ASpreadSheetStyle: TAlxdSpreadSheetStyleInt; ACellsProperty: TAlxdCellInt; AVerBordersProperty: TAlxdBorderInt; AHorBordersProperty: TAlxdBorderInt): integer;
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;

  end;

const
  DELTA = 3;

var
  FfrmAlxdFormatForm: TfrmAlxdFormatForm;
//var
//  FormatForm: TFormatForm;

implementation

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
//
// Private
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Form
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdFormatForm.LoadCaptions;
begin
  try
    Caption:=MessageMemIniFile(55);
    ReadCaptionSectionData(self, 'FormatForm');
    ReadTreeSectionData(tvCellProperties);

  except
    on E:Exception do
      Raise EOleError.CreateFmt('Loading captions failed! Some values is invalid.', []);
  end;
end;

procedure TfrmAlxdFormatForm.LoadRegistry;
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    LoadSize(r, Self, 'FormatForm');
//    if not q then
//      Raise EOleError.CreateFmt('Loading OptionForm position keys failed! Some keys has invalid values.', []);

  finally
    r.Free;
  end;
end;

procedure TfrmAlxdFormatForm.SaveRegistry;
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    SaveSize(r, Self, 'FormatForm');

  finally
    r.Free;
  end;
end;

procedure TfrmAlxdFormatForm.FormResize(Sender: TObject);
begin
  bCancel.Top:=Height - bCancel.Height - (Height-ClientHeight) - 8;
  bApply.Top:=bCancel.Top;

  bCancel.Left:=Width - bCancel.Width - (Width - ClientWidth) - 8;
  bApply.Left:=bCancel.Left - bApply.Width - 8;

  cbValue.Top:=bCancel.Top - cbValue.Height - 8;
  cbValue.Width:=ClientWidth - cbValue.Left - 8;
  lValue.Top:=cbValue.Top + (cbValue.Height - lValue.Height) div 2;

  tvCellProperties.Height:=cbValue.Top - tvCellProperties.Top - 8;
  tvCellProperties.Width:=Width - tvCellProperties.Left - 16;

end;

////////////////////////////////////////////////////////////////////////////////
//  Tree View Events
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdFormatForm.tvCellPropertiesAdvancedCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
var
  s: string;
  w: widestring;
  i: integer;
  tmp1, tmp2: WideString;
begin
  //if (ComponentState <> []) then exit;
  if (ComponentState <> [csFreeNotification]) then exit;

  if Stage = cdPrePaint then
  begin
    if Node.Level = 0 then
    begin
      Node.TreeView.Canvas.Font.Style:=[fsBold];
    end;

    with FCellsProperty do
    begin
      case Node.SelectedIndex of
      1000..1005:
        begin
          Node.Text:=String(PChar(Node.data));
        end;
      6:
        begin
          s:=FCellsProperty.Layer;

          if s = '' then //default
            s:=DefaultString + ' [' + FSpreadSheetStyle.TextLayer + ']';

          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      7:
        begin
          if TextStyleObjectId = -1 then
            s:=MessageMemIniFile(2720)
          else
          if TextStyleObjectId = 0 then
            s:=DefaultString + ' [' + FSpreadSheetStyle.TextStyleName + ']'
          else
            {$IFDEF DLL}
            begin
              oarxGetTextStyleName(TextStyleObjectId, w);
              s:=String(w);
            end;
            {$ELSE}
            s:='SomeStyle';
            {$ENDIF}
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      8:
        begin
          s:=FVerBordersProperty.Layer;

          if s = '' then //default
            s:=DefaultString + ' [' + FSpreadSheetStyle.VerBorderLayer + ']';

          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      9:
        begin
          s:=FHorBordersProperty.Layer;

          if s = '' then //default
            s:=DefaultString + ' [' + FSpreadSheetStyle.HorBorderLayer + ']';

          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;

      40:
        begin
          if Height = -1 then
            s:=MessageMemIniFile(2720)
          else
            s:=AlxdDoubleOrString(0, Height, FSpreadSheetStyle.TextHeight);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      41:
        begin
          if WidthFactor = -1 then
            s:=MessageMemIniFile(2720)
          else
            s:=AlxdDoubleOrString(0, WidthFactor, FSpreadSheetStyle.TextWidthFactor);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      42:
        begin
          if ObliqueAngle = -87 then
            s:=MessageMemIniFile(2720)
          else
            s:=AlxdDoubleOrString(-86, ObliqueAngle, FSpreadSheetStyle.TextObliqueAngle, true);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      43:
        begin
          if Between = -1 then
            s:=MessageMemIniFile(2720)
          else
            s:=AlxdDoubleOrString(0, Between, FSpreadSheetStyle.DefaultSize);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      50:
        begin
          if Rotation = -1 then
            s:=MessageMemIniFile(2720)
          else
            s:=AlxdAngToS(Rotation);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;

      60:
        with FCellsProperty do
        begin
          case Color of
          -2:
            Node.Text:=Format(String(PChar(Node.data)),[MessageMemIniFile(2720)]);
          -1:
            Node.Text:=Format(String(PChar(Node.data)),[DefaultString]);
          else
            AlxdColorText(Node, Color);
          end;
        end;
      61:
        with FVerBordersProperty do
        begin
          case Color of
          -2:
            Node.Text:=Format(String(PChar(Node.data)),[MessageMemIniFile(2720)]);
          -1:
            Node.Text:=Format(String(PChar(Node.data)),[DefaultString]);
          else
            AlxdColorText(Node, Color);
          end;
        end;
      62:
        with FHorBordersProperty do
        begin
          case Color of
          -2:
            Node.Text:=Format(String(PChar(Node.data)),[MessageMemIniFile(2720)]);
          -1:
            Node.Text:=Format(String(PChar(Node.data)),[DefaultString]);
          else
            AlxdColorText(Node, Color);
          end;
        end;
      64:
        with FCellsProperty do
        begin
          case Weight of
          -5:
            Node.Text:=Format(String(PChar(Node.data)),[MessageMemIniFile(2720)]);
          -4:
            Node.Text:=Format(String(PChar(Node.data)),[DefaultString]);
          else
            AlxdLineweightText(Node, Weight);
          end;
        end;
      65:
        with FVerBordersProperty do
        begin
          case Weight of
          -5:
            Node.Text:=Format(String(PChar(Node.data)),[MessageMemIniFile(2720)]);
          -4:
            Node.Text:=Format(String(PChar(Node.data)),[DefaultString]);
          else
            AlxdLineweightText(Node, Weight);
          end;
        end;
      66:
        with FHorBordersProperty do
        begin
          case Weight of
          -5:
            Node.Text:=Format(String(PChar(Node.data)),[MessageMemIniFile(2720)]);
          -4:
            Node.Text:=Format(String(PChar(Node.data)),[DefaultString]);
          else
            AlxdLineweightText(Node, Weight);
          end;
        end;
      72:
        begin
          if HorizontalAlignment = cthaMixed then
            s:=MessageMemIniFile(2720)
          else
          if HorizontalAlignment = cthaDefault then
            s:=DefaultString
          else
            s:=SubMessageMemIniFile(1526, Ord(HorizontalAlignment) - 1);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      73:
        begin
          if VerticalAlignment = ctvaMixed then
            s:=MessageMemIniFile(2720)
          else
          if VerticalAlignment = ctvaDefault then
            s:=DefaultString
          else
            s:=SubMessageMemIniFile(1527, Ord(VerticalAlignment) - 1);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;

      140:
        begin
          if MarginLeft = -2 then
            s:=MessageMemIniFile(2720)
          else
            s:=AlxdDoubleOrString(-1, MarginLeft, FSpreadSheetStyle.TextMarginLeft);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      141:
        begin
          if MarginBottom = -2 then
            s:=MessageMemIniFile(2720)
          else
            s:=AlxdDoubleOrString(-1, MarginBottom, FSpreadSheetStyle.TextMarginBottom);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      142:
        begin
          if MarginRight = -2 then
            s:=MessageMemIniFile(2720)
          else
            s:=AlxdDoubleOrString(-1, MarginRight, FSpreadSheetStyle.TextMarginRight);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      143:
        begin
          if MarginTop = -2 then
            s:=MessageMemIniFile(2720)
          else
            s:=AlxdDoubleOrString(-1, MarginTop, FSpreadSheetStyle.TextMarginTop);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;

      282:
        begin
          if TextFit = ctfsMixed then
            s:=MessageMemIniFile(2720)
          else
          if TextFit = ctfsDefault then
            s:=Format('%s [%s]', [DefaultString, SubMessageMemIniFile(2721, Ord(FSpreadSheetStyle.TextFit))])
          else
            s:=SubMessageMemIniFile(2721, Ord(TextFit) - 1);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      283:
        begin
          if TextType = cttsMixed then
            s:=MessageMemIniFile(2720)
          else
          if TextType = cttsDefault then
            s:=Format('%s [%s]', [DefaultString, SubMessageMemIniFile(1525, Ord(FSpreadSheetStyle.TextType))])
          else
            s:=SubMessageMemIniFile(1525, Ord(TextType) - 1);
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      701:
        begin
          if TextStyleObjectId = -1 then
            s:=MessageMemIniFile(2720)
          else
          begin
            {$IFDEF DLL}
            if TextStyleObjectId = 0 then
              i:=FSpreadSheetStyle.TextStyleObjectId
            else
              i:=TextStyleObjectId;

            oarxGetTextStyleName(i, w);

            if oarxValidTextStyleName(w, tmp1, tmp2, i) then
            begin
              s:=tmp1;
            end;
            {$ENDIF}
          end;
          Node.TreeView.Canvas.Font.Color:=clGray;
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;
      702:
        begin
          if TextStyleObjectId = -1 then
            s:=MessageMemIniFile(2720)
          else
          begin
            {$IFDEF DLL}
            if TextStyleObjectId = 0 then
              i:=FSpreadSheetStyle.TextStyleObjectId
            else
              i:=TextStyleObjectId;

            oarxGetTextStyleName(i, w);

            if oarxValidTextStyleName(w, tmp1, tmp2, i) then
            begin
              s:=tmp2;
            end;
            {$ENDIF}
          end;
          Node.TreeView.Canvas.Font.Color:=clGray;
          Node.Text:=Format(String(PChar(Node.data)),[s]);
        end;

      end;//case
    end;//with
  end;
end;

procedure TfrmAlxdFormatForm.tvCellPropertiesChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
var
  s: string;
  w: widestring;
begin
  cbValueSelect(Sender);

  if Node.SelectedIndex > 700 then
  begin
    cbValue.Clear;
    cbValue.Enabled:=False;
    lVAlue.Enabled:=False;
  end
  else
  with FCellsProperty do
  begin
    {$IFDEF DLL}
    oarxDetachColorCombo;
    oarxDetachLineWeightCombo;
    {$ENDIF}

    cbValue.Clear;
//    cbValue.MaxLength:=0;
    cbValue.OnKeyPress:=nil;
    cbValue.OnExit:=nil;

    cbValue.OnDrawItem:=nil;
    cbValue.OnDropDown:=nil;
    cbValue.OnCloseUp:=nil;

    lVAlue.Enabled:=True;
    cbValue.Enabled:=True;

    case Node.SelectedIndex of
    6:
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=DefaultString;
        {$IFDEF DLL}
        oarxGetLayers(cbValue.Handle);
        {$ENDIF}
        s:=FCellsProperty.Layer;

        if s = '' then //default
          s:=DefaultString;

        cbValue.ItemIndex:=cbValue.Items.IndexOf(s);
      end;
    7:
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=DefaultString;
        {$IFDEF DLL}
        oarxGetTextStyles(cbValue.Handle);
        {$ENDIF}
        if (TextStyleObjectId = -1) then
          cbValue.ItemIndex:=-1
        else
        if (TextStyleObjectId = 0) then
          cbValue.ItemIndex:=0
        else
          {$IFDEF DLL}
          begin
            oarxGetTextStyleName(TextStyleObjectId, w);
            cbValue.ItemIndex:=cbValue.Items.IndexOf(w);
          end;
          {$ELSE}
          cbValue.ItemIndex:=cbValue.Items.IndexOf('SomeStyle');
          {$ENDIF}
      end;
    8:
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=DefaultString;
        {$IFDEF DLL}
        oarxGetLayers(cbValue.Handle);
        {$ENDIF}
        s:=FVerBordersProperty.Layer;

        if s = '' then //default
          s:=DefaultString;

        cbValue.ItemIndex:=cbValue.Items.IndexOf(s);
      end;
    9:
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=DefaultString;
        {$IFDEF DLL}
        oarxGetLayers(cbValue.Handle);
        {$ENDIF}
        s:=FHorBordersProperty.Layer;

        if s = '' then //default
          s:=DefaultString;

        cbValue.ItemIndex:=cbValue.Items.IndexOf(s);
      end;
    40://Text height
      begin
        cbValue.Style:=csDropDown;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Items.CommaText:=DefaultString;
        if (Height = -1) then
          cbValue.Text:=''//MessageMemIniFile(2720)
        else
        if (Height = 0) then
          cbValue.ItemIndex:=0
        else
          cbValue.Text:=AlxdRToS(Height);
      end;
    41://Text width factor
      begin
        cbValue.Style:=csDropDown;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Items.CommaText:=DefaultString;
        if (WidthFactor = -1) then
          cbValue.Text:=''
        else
        if (WidthFactor = 0) then
          cbValue.ItemIndex:=0
        else
          cbValue.Text:=AlxdRToS(WidthFactor);
      end;
    42://Text oblique angle
      begin
        cbValue.Style:=csDropDown;
        cbValue.OnKeyPress:=cbFloatKeyPress;
        cbValue.Items.CommaText:=DefaultString;
        if (ObliqueAngle = -87) then
          cbValue.Text:=''
        else
        if (ObliqueAngle = -86) then
          cbValue.ItemIndex:=0
        else
          cbValue.Text:=AlxdAngToS(ObliqueAngle);
      end;
    43:
      begin
        cbValue.Style:=csDropDown;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Items.CommaText:=DefaultString;
        if (Between = -1) then
          cbValue.Text:=''
        else
        if (Between = 0) then
          cbValue.ItemIndex:=0
        else
          cbValue.Text:=AlxdRToS(Between);
      end;
    50:
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:='0,90';
        if (Rotation = -1) then
          cbValue.ItemIndex:=-1
        else
          cbValue.ItemIndex:=ord(Rotation = 90);
      end;

    60:
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxAttachColorCombo(cbValue.Handle);
        oarxInsertColorItemInList(0, DefaultString, 257);
        cbValue.OnDrawItem:=cbColorDrawItem;
        cbValue.OnDropDown:=cbColorDropDown;
        cbValue.OnCloseUp:=cbColorCloseUp;

        if (Color = -2) then
          cbValue.ItemIndex:=-1
        else
        if (Color = -1) then
          cbValue.ItemIndex:=0
        else
          cbValue.ItemIndex:=oarxAddColorToColorCombo(Color);
        {$ENDIF}
      end;
    61:
      with FVerBordersProperty do
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxAttachColorCombo(cbValue.Handle);
        oarxInsertColorItemInList(0, DefaultString, 257);
        cbValue.OnDrawItem:=cbColorDrawItem;
        cbValue.OnDropDown:=cbColorDropDown;
        cbValue.OnCloseUp:=cbColorCloseUp;

        if (Color = -2) then
          cbValue.ItemIndex:=-1
        else
        if (Color = -1) then
          cbValue.ItemIndex:=0
        else
          cbValue.ItemIndex:=oarxAddColorToColorCombo(Color);
        {$ENDIF}
      end;
    62:
      with FHorBordersProperty do
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxAttachColorCombo(cbValue.Handle);
        oarxInsertColorItemInList(0, DefaultString, 257);
        cbValue.OnDrawItem:=cbColorDrawItem;
        cbValue.OnDropDown:=cbColorDropDown;
        cbValue.OnCloseUp:=cbColorCloseUp;

        if (Color = -2) then
          cbValue.ItemIndex:=-1
        else
        if (Color = -1) then
          cbValue.ItemIndex:=0
        else
          cbValue.ItemIndex:=oarxAddColorToColorCombo(Color);
        {$ENDIF}
      end;
    64:
      with FCellsProperty do
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxAttachLineWeightCombo(cbValue.Handle);
        oarxInsertLineWeightItemInList(0, DefaultString, -4);
        cbValue.OnDrawItem:=cbLineWeightDrawItem;
        cbValue.OnDropDown:=cbLineWeightDropDown;

        if (Weight = -5) then
          cbValue.ItemIndex:=-1
        else
        if (Weight = -4) then
          cbValue.ItemIndex:=0
        else
          cbValue.ItemIndex:=oarxFindItemByLineWeight(Weight);
        {$ENDIF}
      end;
    65:
      with FVerBordersProperty do
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxAttachLineWeightCombo(cbValue.Handle);
        oarxInsertLineWeightItemInList(0, DefaultString, -4);
        cbValue.OnDrawItem:=cbLineWeightDrawItem;
        cbValue.OnDropDown:=cbLineWeightDropDown;

        if (Weight = -5) then
          cbValue.ItemIndex:=-1
        else
        if (Weight = -4) then
          cbValue.ItemIndex:=0
        else
          cbValue.ItemIndex:=oarxFindItemByLineWeight(Weight);
        {$ENDIF}
      end;
    66:
      with FHorBordersProperty do
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Style:=csOwnerDrawFixed;
        {$IFDEF DLL}
        oarxAttachLineWeightCombo(cbValue.Handle);
        oarxInsertLineWeightItemInList(0, DefaultString, -4);
        cbValue.OnDrawItem:=cbLineWeightDrawItem;
        cbValue.OnDropDown:=cbLineWeightDropDown;

        if (Weight = -5) then
          cbValue.ItemIndex:=-1
        else
        if (Weight = -4) then
          cbValue.ItemIndex:=0
        else
          cbValue.ItemIndex:=oarxFindItemByLineWeight(Weight);
        {$ENDIF}
      end;
    72://Item horizontal alignment
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=DefaultString + ','+MessageMemIniFile(1526);
        if HorizontalAlignment = cthaMixed then
          cbValue.ItemIndex:=-1
        else
          cbValue.ItemIndex:=Ord(HorizontalAlignment);
      end;
    73://Item vertical alignment
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=DefaultString + ','+MessageMemIniFile(1527);
        if VerticalAlignment = ctvaMixed then
          cbValue.ItemIndex:=-1
        else
          cbValue.ItemIndex:=Ord(VerticalAlignment);
      end;

    140://Text left margin
      begin
        cbValue.Style:=csDropDown;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Items.CommaText:=DefaultString;
        if (MarginLeft = -2) then
          cbValue.Text:=''
        else
        if (MarginLeft = -1) then
          cbValue.ItemIndex:=0
        else
          cbValue.Text:=AlxdRToS(MarginLeft);
      end;
    141://Text bottom margin
      begin
        cbValue.Style:=csDropDown;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Items.CommaText:=DefaultString;
        if (MarginBottom = -2) then
          cbValue.Text:=''
        else
        if (MarginBottom = -1) then
          cbValue.ItemIndex:=0
        else
          cbValue.Text:=AlxdRToS(MarginBottom);
      end;
    142://Text right margin
      begin
        cbValue.Style:=csDropDown;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Items.CommaText:=DefaultString;
        if (MarginRight = -2) then
          cbValue.Text:=''
        else
        if (MarginRight = -1) then
          cbValue.ItemIndex:=0
        else
          cbValue.Text:=AlxdRToS(MarginRight);
      end;
    143://Text top margin
      begin
        cbValue.Style:=csDropDown;
        cbValue.OnKeyPress:=cbPositiveFloatKeyPress;
        cbValue.Items.CommaText:=DefaultString;
        if (MarginTop = -2) then
          cbValue.Text:=''
        else
        if (MarginTop = -1) then
          cbValue.ItemIndex:=0
        else
          cbValue.Text:=AlxdRToS(MarginTop);
      end;
    282://Fit text
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=DefaultString + ','+MessageMemIniFile(2721);
        if TextFit = ctfsMixed then
          cbValue.ItemIndex:=-1
        else
          cbValue.ItemIndex:=ord(TextFit);
      end;
    283://Text type
      begin
        cbValue.Style:=csDropDownList;
        cbValue.Items.CommaText:=DefaultString + ','+MessageMemIniFile(1525);
        if TextType = cttsMixed then
          cbValue.ItemIndex:=-1
        else
          cbValue.ItemIndex:=Ord(TextType);
      end;
    {701:
      begin
        cbValue.Clear;
        cbValue.Enabled:=False;
        lVAlue.Enabled:=False;
      end;
    702:
      begin
        cbValue.Clear;
        cbValue.Enabled:=False;
        lVAlue.Enabled:=False;
      end;}
    end;

    cbValue.Enabled:=True;
    lVAlue.Enabled:=True;
    cbValue.OnExit:=cbValueSelect;
    FormResize(nil);
//    cbValue.OnExit:=cbValueSelect;
  end;
end;

procedure TfrmAlxdFormatForm.tvCellPropertiesDeletion(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Data <> nil then
    FreeMem(Node.Data);
end;

procedure TfrmAlxdFormatForm.tvCellPropertiesKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmAlxdFormatForm.cbValueSelect(Sender: TObject);
var
  ret: double;
  value: Longint;
  default: boolean;
  different: boolean;
begin
  try
    ret:=0;
    default:=isDefault(cbValue.Text);
    different:=(MessageMemIniFile(2720) = cbValue.Text) or (cbValue.Text = '');

    with FCellsProperty, tvCellProperties  do
      if (Selected <> nil) and (Sender as TWinControl).Enabled then
        case Selected.SelectedIndex of
        6:  //TextLayer
          begin
            if cbValue.ItemIndex = 0 then
              FCellsProperty.Layer:=''
            else
              FCellsProperty.Layer:=cbValue.Text;
          end;
        7:  //TextStyleId
          begin
            if cbValue.ItemIndex = 0 then
              TextStyleObjectId:=0
            else
            begin
              {$IFDEF DLL}
              value:=oarxGetTextStyleId(cbValue.Text);
              //if TextStyleObjectId <> value then
              //begin
              TextStyleObjectId:=value;
                //cbValueApplyStyle(TextStyleObjectId);
              //end;
              {$ELSE}
              TextStyleObjectId:=0;
              {$ENDIF}
            end;
          end;
        8:  //VerLayer
          begin
            if cbValue.ItemIndex = 0 then
              FVerBordersProperty.Layer:=''
            else
              FVerBordersProperty.Layer:=cbValue.Text;
          end;
        9:  //HorLayer
          begin
            if cbValue.ItemIndex = 0 then
              FHorBordersProperty.Layer:=''
            else
              FHorBordersProperty.Layer:=cbValue.Text;
          end;
        40: //TextProperty.Height:=StrToFloat(cbValue.Text);
          if not different then
          begin
            if not default then
              AlxdDisToF(cbValue.Text, ret);
            FCellsProperty.Height:=ret;
          end;
        41: //TextProperty.WidthFactor:=StrToFloat(cbValue.Text);
          if not different then
          begin
            if not default then
              AlxdDisToF(cbValue.Text, ret);
            FCellsProperty.WidthFactor:=ret;
          end;
        42: //TextProperty.ObliqueAngle:=StrToFloat(cbValue.Text);
          if not different then
          begin
            if default then
              FCellsProperty.ObliqueAngle:=-86
            else
            begin
              AlxdDisToF(cbValue.Text, ret);

              //if (ret >= -85) and (ret <= 85) then
              FCellsProperty.ObliqueAngle:=Ret;
            end;
          end;
        43: //TextProperty.Between:=StrToFloat(cbValue.Text);
          if not different then
          begin
            if not default then
              AlxdDisToF(cbValue.Text, ret);
            FCellsProperty.Between:=ret;
          end;
        50:
          if not different then
          begin
            if cbValue.ItemIndex = 0 then
              FCellsProperty.Rotation:=0
            else
              FCellsProperty.Rotation:=90;
          end;
        {$IFDEF DLL}
        60:
          begin
            if cbValue.ItemIndex >= 0 then
            begin
              FCellsProperty.Color:=Integer(cbValue.Items.Objects[cbValue.ItemIndex]);
              if FCellsProperty.Color = 257 then
                FCellsProperty.Color:=-1;
            end;
          end;
        61:
          with FVerBordersProperty do
          begin
            if cbValue.ItemIndex >= 0 then
            begin
              Color:=Integer(cbValue.Items.Objects[cbValue.ItemIndex]);
              if Color = 257 then
                Color:=-1;
            end;
          end;
        62:
          with FHorBordersProperty do
          begin
            if cbValue.ItemIndex >= 0 then
            begin
              Color:=Integer(cbValue.Items.Objects[cbValue.ItemIndex]);
              if Color = 257 then
                Color:=-1;
            end;
          end;
        64:
          begin
            if cbValue.ItemIndex >= 0 then
            begin
              FCellsProperty.Weight:=oarxGetItemLineWeight(cbValue.ItemIndex);
            end;
          end;
        65:
          begin
            if cbValue.ItemIndex >= 0 then
            begin
              FVerBordersProperty.Weight:=oarxGetItemLineWeight(cbValue.ItemIndex);
            end;
          end;
        66:
          begin
            if cbValue.ItemIndex >= 0 then
            begin
              FHorBordersProperty.Weight:=oarxGetItemLineWeight(cbValue.ItemIndex);
            end;
          end;
        {$ENDIF}
        72:
          if not different then
            FCellsProperty.HorizontalAlignment:=TAlxdCellTextHorAlignment(cbValue.ItemIndex);
        73:
          if not different then
            FCellsProperty.VerticalAlignment:=TAlxdCellTextVerAlignment(cbValue.ItemIndex);

        140: //TextProperty.Margins.MarginLeft:=StrToFloat(cbValue.Text);
          if not different then
          begin
            if default then
              FCellsProperty.MarginLeft:=-1
            else
            begin
              AlxdDisToF(cbValue.Text, ret);
              FCellsProperty.MarginLeft:=ret;
            end;
          end;
        141: //TextProperty.Margins.MarginBottom:=StrToFloat(cbValue.Text);
          if not different then
          begin
            if default then
              FCellsProperty.MarginBottom:=-1
            else
            begin
              AlxdDisToF(cbValue.Text, ret);
              FCellsProperty.MarginBottom:=ret;
            end;
          end;
        142: //TextProperty.Margins.MarginRight:=StrToFloat(cbValue.Text);
          if not different then
          begin
            if default then
              FCellsProperty.MarginRight:=-1
            else
            begin
              AlxdDisToF(cbValue.Text, ret);
              FCellsProperty.MarginRight:=ret;
            end;
          end;
        143: //TextProperty.Margins.MarginTop:=StrToFloat(cbValue.Text);
          if not different then
          begin
            if default then
              FCellsProperty.MarginTop:=-1
            else
            begin
              AlxdDisToF(cbValue.Text, ret);
              FCellsProperty.MarginTop:=ret;
            end;
          end;
                  
        282:
          if not different then
            FCellsProperty.TextFit:=TAlxdCellTextFit(cbValue.ItemIndex);
        283:
          if not different then
            FCellsProperty.TextType:=TAlxdCellTextType(cbValue.ItemIndex);

        end;//case
        
    if (Sender is TComboBox) then
      tvCellProperties.Refresh;
  except
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  Service Functions
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdFormatForm.cbFloatKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmAlxdFormatForm.cbPositiveFloatKeyPress(Sender: TObject; var Key: Char);
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

{$IFDEF DLL}
procedure TfrmAlxdFormatForm.cbColorDropDown(Sender: TObject);
begin
  oarxOnColorComboDropDown;
end;

procedure TfrmAlxdFormatForm.cbColorCloseUp(Sender: TObject);
var
  colorindex: integer;
  newsel: integer;
  oldsel: integer;
begin
  if (Sender as TComboBox).ItemIndex < 0 then exit;
  
  colorindex:=Integer((Sender as TComboBox).Items.Objects[(Sender as TComboBox).ItemIndex]);
  if colorindex < 0 then
//    if PageControl.ActivePage.Tag = 0 then
    begin
      //with FCellsProperty do
        //case tvCellProperties.Selected.SelectedIndex of
        //60:
        //  begin
            oldsel:=oarxAddColorToColorCombo(Integer((Sender as TComboBox).Items.Objects[(Sender as TComboBox).ItemIndex]));
            if oarxOnColorComboSelectOther(0, oldsel, newsel) then
            begin
              (Sender as TComboBox).ItemIndex:=newsel;
              //correct combobox list, Default is absent after oarxOnColorComboSelectOther
              oarxInsertColorItemInList(0, DefaultString, 257);
            end;
          //end;
        //end;
//    end
//    else
//    if PageControl.ActivePage.Tag = 1 then
//    begin
//      oldsel:=expAddColorToColorCombo(Integer((Sender as TComboBox).Items.Objects[(Sender as TComboBox).ItemIndex]));
//      if expOnColorComboSelectOther(false, oldsel, newsel) then
//        (Sender as TComboBox).ItemIndex:=newsel;
  end;
  oarxOnColorComboCloseUp;
end;

procedure TfrmAlxdFormatForm.cbColorDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  DrawItemStruct: TDrawItemStruct;
begin
  with DrawItemStruct do
  begin
    CtlType:=ODT_COMBOBOX;
    //CtlID:=0;//?
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

procedure TfrmAlxdFormatForm.cbLineWeightDropDown(Sender: TObject);
begin
  oarxOnLineWeightComboDropDown;
end;

procedure TfrmAlxdFormatForm.cbLineWeightDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
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

procedure TfrmAlxdFormatForm.WndProc(var Message: TMessage);
begin
  case Message.Msg of
  CM_DIALOGKEY:
    with TWMKeyDown(Message) do
    if not ((CharCode = 13) and cbValue.Focused) then
      inherited;
  else
    inherited;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
// Public
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Form
////////////////////////////////////////////////////////////////////////////////

function TfrmAlxdFormatForm.Edit(ASpreadSheetStyle: TAlxdSpreadSheetStyleInt; ACellsProperty: TAlxdCellInt; AVerBordersProperty: TAlxdBorderInt; AHorBordersProperty: TAlxdBorderInt): integer;
begin
  try
    //PageControl.ActivePage:=TabSheet1;
    FSpreadSheetStyle:=ASpreadSheetStyle;
    FCellsProperty:=ACellsProperty;
    FVerBordersProperty:=AVerBordersProperty;
    FHorBordersProperty:=AHorBordersProperty;

    tvCellProperties.FullExpand;
    tvCellProperties.Items[0].Selected:=True;

    LoadRegistry;

    SetCapture(Self.Handle);
    ShowModal;
    
    //clear attaches
    {$IFDEF DLL}
    oarxDetachColorCombo;
    oarxDetachLineWeightCombo;
    {$ENDIF}

    cbValue.OnKeyPress:=nil;
    cbValue.OnExit:=nil;

    cbValue.OnDrawItem:=nil;
    cbValue.OnDropDown:=nil;
    cbValue.OnCloseUp:=nil;

    //release
    ReleaseCapture;
    SaveRegistry;
  finally
    Result:=ModalResult;
  end;
end;

constructor TfrmAlxdFormatForm.Create(AOwner: TComponent);
begin
  inherited;

  {FGridProperty:=AAlxdSpreadSheet.GridProperty^;
  FCellsProperty:=AAlxdSpreadSheet.CellsProperty;
  FBorderProperties:=AAlxdSpreadSheet.BordersProperties;}

  Icon.ReleaseHandle;
  Icon.Handle:=LoadIcon(GetWindowLong(Application.Handle, GWL_HINSTANCE), MakeIntResource(1));

  //Font.Name:=(AOwner as TForm).Font.Name;

  //LoadRegistry;
  LoadCaptions;
end;

destructor  TfrmAlxdFormatForm.Destroy;
begin
  //SaveRegistry;
  inherited;
end;

end.
