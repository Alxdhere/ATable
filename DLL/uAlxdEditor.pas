unit uAlxdEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, xAlxdEditor, AlxdGrid_TLB, ComCtrls, TntComCtrls, ToolWin,
  ExtCtrls, TntExtCtrls, Menus, TntMenus, Tabs, uAlxdSpreadSheets, ActnList,
  TntActnList, ImgList, StdCtrls, TntStdCtrls, uAlxdSystem, uAlxdValue,
  uAlxdSpreadSheet, TntRegistry, uAlxdRegistry, uAlxdLocalizer, uoarxImport,
  uAlxdSpreadSheetStyle, ShellApi, uAlxdAbout, TntDialogs, TntSysUtils,
  uAlxdSpreadSheetSelection, RegExpr, StrUtils, uAlxdOptions, uAlxdOptionEditor,
  uAlxdSearchForm, uAlxdFormatEditor, uAlxdCell, uAlxdBorder;

type
  TfrmEditor = class(TTntForm, IAlxdEditor)
    sbMain: TTntStatusBar;
    cbMain: TTntControlBar;
    mmMain: TTntMainMenu;
    mnGrid: TTntMenuItem;
    pBackground: TTntPanel;
    pBackgroundSheets: TTntPanel;
    tsAlxdSpreadSheets: TTabSet;
    tbRows: TTntToolBar;
    tbAddRow: TTntToolButton;
    tbInsertRow: TTntToolButton;
    tbDeleteRow: TTntToolButton;
    tbCols: TTntToolBar;
    alMain: TTntActionList;
    rcAddRow: TTntAction;
    rcInsertRow: TTntAction;
    rcDeleteRow: TTntAction;
    tbAddColumn: TTntToolButton;
    tbInsertColumn: TTntToolButton;
    tbDeleteColumn: TTntToolButton;
    ccAddColumn: TTntAction;
    ccInsertColumn: TTntAction;
    ccDeleteColumn: TTntAction;
    ilMain: TImageList;
    tbJoins: TTntToolBar;
    jcJoin: TTntAction;
    jcJoinByRow: TTntAction;
    jcJoinByCol: TTntAction;
    jcDisjoin: TTntAction;
    tbJoin: TTntToolButton;
    tbJoinByRow: TTntToolButton;
    tbJoinByCol: TTntToolButton;
    tbDisjoin: TTntToolButton;
    ssSaveToXML: TTntAction;
    ssOpenFromXML: TTntAction;
    gsOpenFromXML1: TTntMenuItem;
    gsSaveToXML1: TTntMenuItem;
    ssNew: TTntAction;
    ssClose: TTntAction;
    ssNew1: TTntMenuItem;
    ssClose1: TTntMenuItem;
    ccAddColumns: TTntAction;
    mnInsert: TTntMenuItem;
    rcAddRow1: TTntMenuItem;
    rcInsertRow1: TTntMenuItem;
    rcDeleteRow1: TTntMenuItem;
    N2: TTntMenuItem;
    ccAddColumns1: TTntMenuItem;
    rcAddRows: TTntAction;
    rcAddRows1: TTntMenuItem;
    N3: TTntMenuItem;
    ccAddColumn1: TTntMenuItem;
    ccInsertColumn1: TTntMenuItem;
    ccDeleteColumn1: TTntMenuItem;
    haDefault: TTntAction;
    haLeft: TTntAction;
    haCenter: TTntAction;
    haRight: TTntAction;
    mnAlign: TTntMenuItem;
    haDefault1: TTntMenuItem;
    haLeft1: TTntMenuItem;
    haCenter1: TTntMenuItem;
    haRight1: TTntMenuItem;
    tbhAlign: TTntToolBar;
    tbvAlign: TTntToolBar;
    tbhDefault: TTntToolButton;
    tbLeft: TTntToolButton;
    tbCenter: TTntToolButton;
    tbRight: TTntToolButton;
    tbvDefault: TTntToolButton;
    tbBaseline: TTntToolButton;
    tbBottom: TTntToolButton;
    tbMiddle: TTntToolButton;
    tbTop: TTntToolButton;
    vaDefault: TTntAction;
    vaBaseline: TTntAction;
    vaBottom: TTntAction;
    vaMiddle: TTntAction;
    vaTop: TTntAction;
    tbTextType: TTntToolBar;
    tbtDefault: TTntToolButton;
    tbMText: TTntToolButton;
    tbDText: TTntToolButton;
    ttDefault: TTntAction;
    ttMText: TTntAction;
    ttDText: TTntAction;
    ttBlock: TTntAction;
    tbBlock: TTntToolButton;
    tbFits: TTntToolBar;
    tbfDefault: TTntToolButton;
    tbFit: TTntToolButton;
    tbBreak: TTntToolButton;
    tfDefault: TTntAction;
    tfFit: TTntAction;
    tfBreak: TTntAction;
    tfUnbreaked: TTntAction;
    tfFitted: TTntAction;
    tbUnbreaked: TTntToolButton;
    tbFitted: TTntToolButton;
    N4: TTntMenuItem;
    mnRows: TTntMenuItem;
    mnCols: TTntMenuItem;
    icResetColSize: TTntAction;
    icChangeColName: TTntAction;
    icChangeColSize: TTntAction;
    icAutoColSize: TTntAction;
    icColInvisible: TTntAction;
    icResetColSize1: TTntMenuItem;
    icChangeColSize1: TTntMenuItem;
    icChangeColName1: TTntMenuItem;
    icAutoColSize1: TTntMenuItem;
    icColInvisible1: TTntMenuItem;
    pmMain: TTntPopupMenu;
    irResetRowSize: TTntAction;
    irChangeRowName: TTntAction;
    irChangeRowSize: TTntAction;
    irAutoRowSize: TTntAction;
    irRowInvisible: TTntAction;
    irResetRowSize1: TTntMenuItem;
    irChangeRowSize1: TTntMenuItem;
    irAutoRowSize1: TTntMenuItem;
    irChangeRowName1: TTntMenuItem;
    irRowInvisible1: TTntMenuItem;
    tbBorders: TTntToolBar;
    tbbLeft: TTntToolButton;
    tbbTop: TTntToolButton;
    tbbRight: TTntToolButton;
    tbbBottom: TTntToolButton;
    tbbVer: TTntToolButton;
    bdLeft: TTntAction;
    bdTop: TTntAction;
    bdRight: TTntAction;
    bdBottom: TTntAction;
    bdVertical: TTntAction;
    bdHorizontal: TTntAction;
    bdCross: TTntAction;
    bdContour: TTntAction;
    tbbHor: TTntToolButton;
    tbbCross: TTntToolButton;
    tbbContour: TTntToolButton;
    tbbAll: TTntToolButton;
    bdAll: TTntAction;
    mnStyle: TTntMenuItem;
    mnEdit: TTntMenuItem;
    slSelect: TTntAction;
    slApply: TTntAction;
    slChange: TTntAction;
    slMake: TTntAction;
    stDrawBorder: TTntAction;
    stFillCell: TTntAction;
    stTextFit: TTntAction;
    stTextType: TTntAction;
    slSelect1: TTntMenuItem;
    slApply1: TTntMenuItem;
    slChange1: TTntMenuItem;
    slMake1: TTntMenuItem;
    N5: TTntMenuItem;
    stDrawBorder1: TTntMenuItem;
    stFillCell1: TTntMenuItem;
    stTextFit1: TTntMenuItem;
    stTextType1: TTntMenuItem;
    jfTopLeft: TTntAction;
    jfTopRight: TTntAction;
    jfBottomLeft: TTntAction;
    jfBottomRight: TTntAction;
    N6: TTntMenuItem;
    jfTopLeft1: TTntMenuItem;
    jfTopRight1: TTntMenuItem;
    jfBottomLeft1: TTntMenuItem;
    jfBottomRight1: TTntMenuItem;
    N7: TTntMenuItem;
    vaDefault1: TTntMenuItem;
    vaBaseline1: TTntMenuItem;
    vaBottom1: TTntMenuItem;
    vaMiddle1: TTntMenuItem;
    vaTop1: TTntMenuItem;
    mnFormat: TTntMenuItem;
    mnTextFit: TTntMenuItem;
    mnTextFill: TTntMenuItem;
    mnTextType: TTntMenuItem;
    mnTextCase: TTntMenuItem;
    N8: TTntMenuItem;
    N9: TTntMenuItem;
    jcJoin1: TTntMenuItem;
    jcJoinByRow1: TTntMenuItem;
    jcJoinByCol1: TTntMenuItem;
    jcDisjoin1: TTntMenuItem;
    mnBorder: TTntMenuItem;
    bdLeft1: TTntMenuItem;
    bdTop1: TTntMenuItem;
    bdRight1: TTntMenuItem;
    bdBottom1: TTntMenuItem;
    bdVertical1: TTntMenuItem;
    bdHorizontal1: TTntMenuItem;
    bdCross1: TTntMenuItem;
    bdContour1: TTntMenuItem;
    bdAll1: TTntMenuItem;
    tbFills: TTntToolBar;
    tbNumProperties: TTntToolBar;
    tbMargins: TTntToolBar;
    tbEdits: TTntToolBar;
    tbfcDefault: TTntToolButton;
    tbfcEmpty: TTntToolButton;
    tbfcFill: TTntToolButton;
    fcDefault: TTntAction;
    fcEmpty: TTntAction;
    fcFill: TTntAction;
    tfDefault1: TTntMenuItem;
    tfFit1: TTntMenuItem;
    tfBreak1: TTntMenuItem;
    tfUnbreaked1: TTntMenuItem;
    tfFitted1: TTntMenuItem;
    ttDefault1: TTntMenuItem;
    ttMText1: TTntMenuItem;
    ttDText1: TTntMenuItem;
    ttBlock1: TTntMenuItem;
    fcDefault1: TTntMenuItem;
    fcEmpty1: TTntMenuItem;
    fcFill1: TTntMenuItem;
    mnTools: TTntMenuItem;
    mnHelp: TTntMenuItem;
    msAbout: TTntAction;
    msHomepage: TTntAction;
    msHelp: TTntAction;
    tbNumProperty: TTntToolButton;
    cbNumProperty: TTntComboBox;
    tbsNumProperty: TTntToolButton;
    tbMargin: TTntToolButton;
    tbsMargin: TTntToolButton;
    cbMargin: TTntComboBox;
    npHeight: TTntAction;
    npWidthFactor: TTntAction;
    npObliqueAngle: TTntAction;
    npBetween: TTntAction;
    mnLeft: TTntAction;
    mnBottom: TTntAction;
    mnRight: TTntAction;
    mnTop: TTntAction;
    msHelp1: TTntMenuItem;
    msHomepage1: TTntMenuItem;
    N10: TTntMenuItem;
    msAbout1: TTntMenuItem;
    ssOpen: TTntAction;
    ssInsert: TTntAction;
    ssRead1: TTntMenuItem;
    ssInsert1: TTntMenuItem;
    ssSaveAsToXML: TTntAction;
    sdMain: TTntSaveDialog;
    ssSaveAsToXML1: TTntMenuItem;
    odMain: TTntOpenDialog;
    edUndo: TTntAction;
    edRedo: TTntAction;
    edUndo1: TTntMenuItem;
    edRedo1: TTntMenuItem;
    edCut: TTntAction;
    edCopy: TTntAction;
    edPaste: TTntAction;
    edPasteSpecial: TTntAction;
    edDelFormat: TTntAction;
    edDelContent: TTntAction;
    edDelAll: TTntAction;
    edSelectAll: TTntAction;
    N1: TTntMenuItem;
    edCut1: TTntMenuItem;
    edCopy1: TTntMenuItem;
    edPaste1: TTntMenuItem;
    edPasteSpecial1: TTntMenuItem;
    mnDel: TTntMenuItem;
    edDelContent1: TTntMenuItem;
    edDelFormat1: TTntMenuItem;
    edDelAll1: TTntMenuItem;
    N11: TTntMenuItem;
    edSelectAll1: TTntMenuItem;
    N12: TTntMenuItem;
    edFind: TTntAction;
    edFindAgain: TTntAction;
    edReplace: TTntAction;
    edFind1: TTntMenuItem;
    edFind2: TTntMenuItem;
    edReplace1: TTntMenuItem;
    icCopyCellsAll: TTntAction;
    icMoveCellsAll: TTntAction;
    icExchangeCellsAll: TTntAction;
    icCopyCellsValue: TTntAction;
    icCopyCellsFormat: TTntAction;
    icAppendCellsValue: TTntAction;
    ftFormat: TTntAction;
    trRotation: TTntAction;
    ftFormat1: TTntMenuItem;
    ftRotate1: TTntMenuItem;
    tbsRotation: TTntToolButton;
    tbRotation: TTntToolButton;
    tbCut: TTntToolButton;
    tbCopy: TTntToolButton;
    tbPaste: TTntToolButton;
    tbsEdit: TTntToolButton;
    tbUndo: TTntToolButton;
    tbRedo: TTntToolButton;
    icExpandCopyCellsAll: TTntAction;
    icExpandCopyCellsContent: TTntAction;
    icExpandCopyCellsFormat: TTntAction;
    icExpandIncCopyCellsContent: TTntAction;
    icExpandIncCopyCellsAll: TTntAction;
    stTextColor: TTntAction;
    stVerBorderColor: TTntAction;
    stHorBorderColor: TTntAction;
    nImport: TTntMenuItem;
    ssExit: TTntAction;
    ssExit1: TTntMenuItem;
    N13: TTntMenuItem;
    tsOptions: TTntAction;
    msOptions1: TTntMenuItem;
    mnToolbars: TTntMenuItem;
    scSortAO: TTntAction;
    scSortNAO: TTntAction;
    scSortNO: TTntAction;
    scSortAO1: TTntMenuItem;
    scSortNAO1: TTntMenuItem;
    scSortNO1: TTntMenuItem;
    N14: TTntMenuItem;

    procedure LoadCaptions;
    procedure LoadRegistry;
    procedure SaveRegistry;

    function  FindAction(Tagnum: integer): TContainedAction;
    procedure ResetActions(Groupnum: array of Integer);
    procedure ActionUpdate(Motive: TAlxdActionUpdateMotive);

    procedure edExecute(Sender: TObject);

    procedure ccExecute(Sender: TObject);
    procedure icExecute(Sender: TObject);
    procedure rcExecute(Sender: TObject);
    procedure irExecute(Sender: TObject);
    procedure slExecute(Sender: TObject);
    procedure stExecute(Sender: TObject);
    procedure jfExecute(Sender: TObject);

    procedure haExecute(Sender: TObject);
    procedure vaExecute(Sender: TObject);
    procedure tfExecute(Sender: TObject);
    procedure fcExecute(Sender: TObject);
    procedure ttExecute(Sender: TObject);
    procedure ftExecute(Sender: TObject);

    procedure jcExecute(Sender: TObject);
    procedure bdExecute(Sender: TObject);
    procedure iccExecute(Sender: TObject);
    procedure iceExecute(Sender: TObject);

    procedure npExecute(Sender: TObject);
    procedure mnExecute(Sender: TObject);

    procedure msExecute(Sender: TObject);
    procedure ssExecute(Sender: TObject);
    procedure tsExecute(Sender: TObject);
    procedure scExecute(Sender: TObject);

    //comboboxes
    procedure cbSelectOrExit(Sender: TObject);
    procedure cbNumPropertyKeyPress(Sender: TObject; var Key: Char);
    procedure cbMarginKeyPress(Sender: TObject; var Key: Char);

    //StatusBar
    procedure sbMainResize(Sender: TObject);
    procedure sbMainMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sbMainMouseLeave(Sender: TObject);
    procedure sbMainMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure sbMainMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sbMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);

    //Toolbar
    procedure ToolbarCycle(Menu: TMenuItem);
    procedure ToolbarMenuClick(Sender: TObject);
    procedure mnToolsClick(Sender: TObject);
    
    //Popup
    procedure pmMainClear;
    procedure pmMainAddActions(StartP, EndP, TagP: integer);
    procedure pmMainAddDelimiter;
    procedure pmMainPopup(Sender: TObject);

    //Menu
    procedure miExecute(Sender: TObject);
    procedure miImport(Value: WideString);

    //TabSet
    procedure tsAlxdSpreadSheetsChange(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure TntFormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    FAlxdEditor: IAlxdEditor;
    FOpened: boolean;
  protected
    procedure WndProc(var Message: TMessage); override;

  public
    FDragRects: TRects;
    FAlxdSpreadSheets: TAlxdSpreadSheetsInt;

    property Intf: IAlxdEditor read FAlxdEditor implements IAlxdEditor;

    procedure Open; safecall;
    procedure Close; safecall;
    procedure DoHint(Sender: TObject);
    procedure DoIdle;

    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

var
  FfrmEditor: TfrmEditor;
  FImport: array of WideString;
implementation

{$R *.DFM}

uses
  uAlxdStyleEditor, uAlxdStyleManager, ComServ;

////////////////////////////////////////////////////////////////////////////////
//
// Internal functions
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmEditor.LoadCaptions;
begin
  try
    //Caption:='ATable 8.0';
    ReadActionSectionData(alMain);
    ReadCaptionSectionData(Self, 'EditorForm');
  except
    on E:Exception do
      {$IFDEF DLL}
      oarxAcUtPrintf(#10'Loading Editor captions failed! Some values is invalid.');
      {$ENDIF}
  end;
end;

procedure TfrmEditor.LoadRegistry;
var
  r: TTntRegistry;
  NumTag, MarTag: integer;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    LoadSize(r, Self, 'EditorForm');
    LoadPos(r, Self, 'EditorForm');
    LoadShortcuts(r, alMain);

    MarTag:=tbMargin.Action.Tag;
    NumTag:=tbNumProperty.Action.Tag;
    LoadToolbars(r, cbMain, NumTag, MarTag);
    tbNumProperty.Action:=FindAction(NumTag);
    tbMargin.Action:=FindAction(MarTag);
  finally
    r.Free;
  end;
end;

procedure TfrmEditor.SaveRegistry;
var
  r: TTntRegistry;
  NumTag, MarTag: integer;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    MarTag:=tbMargin.Action.Tag;
    NumTag:=tbNumProperty.Action.Tag;
    SaveToolbars(r, cbMain, NumTag, MarTag);
    SaveShortcuts(r, alMain);
    SavePos(r, Self, 'EditorForm');
    SaveSize(r, Self, 'EditorForm');

  finally
    r.Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Actions utility
//
////////////////////////////////////////////////////////////////////////////////

function  TfrmEditor.FindAction(Tagnum: integer): TContainedAction;
var
  j: integer;
begin
  result:=nil;
  for j:=0 to alMain.ActionCount-1 do
    if alMain.Actions[j].Tag=Tagnum then
    begin
      result:=alMain.Actions[j];
      exit;
    end;
end;

procedure TfrmEditor.ResetActions(Groupnum: array of Integer);
var
  j: integer;
begin
  for j:=0 to alMain.ActionCount-1 do
    if InIntegerArray(TAction(alMain.Actions[j]).GroupIndex, Groupnum) then
    begin
      TAction(alMain.Actions[j]).Checked := false;
    end;
end;

procedure TfrmEditor.ActionUpdate(Motive: TAlxdActionUpdateMotive);
var
  act: TContainedAction;
  b: boolean;
  bv: TAlxdDrawBorders;
  bh: TAlxdDrawBorders;
begin
  if FAlxdSpreadSheets.Active >= 0 then
    with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    begin
      edUndo.Enabled:=AlxdUndo.CanUndo;
      edRedo.Enabled:=AlxdUndo.CanRedo;

      if aumStyle in Motive then
      begin
        Caption:=Format(AlxdGridTitle, [AlxdSpreadSheetStyle.StyleName]);
        //tsAlxdSpreadSheets

        with stDrawBorder do
        begin
          Checked:=boolean(AlxdSpreadSheetStyle.DrawBorder);
          ImageIndex:=Ord(Checked) + 21;
        end;

        with stFillCell do
        begin
          Checked:=boolean(AlxdSpreadSheetStyle.FillCell);
          ImageIndex:=Ord(Checked) + 23;
        end;

        with stTextFit do
        begin
          Checked:=boolean(AlxdSpreadSheetStyle.TextFit);
          ImageIndex:=Ord(Checked) + 25;
        end;

        with stTextType do
        begin
          Checked:=boolean(AlxdSpreadSheetStyle.TextType);
          ImageIndex:=Ord(Checked) + 27;
        end;

        act:=FindAction(180 + Ord(AlxdSpreadSheetStyle.Justify));
        if act<>nil then
          TAction(act).Checked:=true;

        act:=FindAction(151);
        if act<>nil then
          TAction(act).Enabled:=(AlxdSpreadSheetStyle.StyleFileName <> '');

      end;

      if aumCells in Motive then
      begin
        ResetActions([200, 210, 240, 250, 260, 271]);

        act:=FindAction(200 + Integer(AlxdSpreadSheetArray.Cells.HorizontalAlignment));
        if act<>nil then
          TAction(act).Checked:=true;

        act:=FindAction(210 + Integer(AlxdSpreadSheetArray.Cells.VerticalAlignment));
        if act<>nil then
          TAction(act).Checked:=true;

        act:=FindAction(240 + Integer(AlxdSpreadSheetArray.Cells.TextFit));
        if act<>nil then
          TAction(act).Checked:=true;

        act:=FindAction(250 + Integer(AlxdSpreadSheetArray.Fills.FillType));
        if act<>nil then
          TAction(act).Checked:=true;

        act:=FindAction(260 + Integer(AlxdSpreadSheetArray.Cells.TextType));
        if act<>nil then
          TAction(act).Checked:=true;

        with AlxdSpreadSheetArray.Cells do
        case tbNumProperty.Action.Tag of
          220: cbNumProperty.Text:=AlxdDoubleOrString(0, Height, AlxdSpreadSheetStyle.TextHeight);
          221: cbNumProperty.Text:=AlxdDoubleOrString(0, WidthFactor, AlxdSpreadSheetStyle.TextWidthFactor);
          222: cbNumProperty.Text:=AlxdDoubleOrString(-86, ObliqueAngle, AlxdSpreadSheetStyle.TextObliqueAngle, true);
          223: cbNumProperty.Text:=AlxdDoubleOrString(0, Between, AlxdSpreadSheetStyle.DefaultSize);
        end;
        //cbNumProperty.Hint:=TAction(tbNumProperty.Action).Hint;}

        with AlxdSpreadSheetArray.Cells do
        case tbMargin.Action.Tag of
          230: cbMargin.Text:=AlxdDoubleOrString(-1, MarginLeft, AlxdSpreadSheetStyle.TextMarginLeft);
          231: cbMargin.Text:=AlxdDoubleOrString(-1, MarginTop, AlxdSpreadSheetStyle.TextMarginTop);
          232: cbMargin.Text:=AlxdDoubleOrString(-1, MarginRight, AlxdSpreadSheetStyle.TextMarginRight);
          233: cbMargin.Text:=AlxdDoubleOrString(-1, MarginBottom, AlxdSpreadSheetStyle.TextMarginBottom);
        end;
        //cbMargin.Hint:=TAction(tbMargin.Action).Hint;}
        with AlxdSpreadSheetArray.Cells do
          trRotation.Checked:=(Rotation > 0);
        trRotation.ImageIndex:=Ord(trRotation.Checked) + 64;
      end;

      if aumBorders in Motive then
      begin
        bv:=AlxdSpreadSheetArray.VerBorders.State;
        bdLeft.Checked:=(dbLeft in bv);
        bdRight.Checked:=(dbRight in bv);
        bdVertical.Checked:=(dbVer in bv);

        bh:=AlxdSpreadSheetArray.HorBorders.State;
        bdTop.Checked:=(dbTop in bh);
        bdBottom.Checked:=(dbBottom in bh);
        bdHorizontal.Checked:=(dbHor in bh);

        bdCross.Checked:=(dbVer in bv) and (dbHor in bh);
        bdContour.Checked:=(dbLeft in bv) and (dbRight in bv) and (dbTop in bh) and (dbBottom in bh);
        bdAll.Checked:=bdCross.Checked and bdContour.Checked;
      end;

      if aumSelections in Motive then
      begin
        b:=AlxdSpreadSheetSelections.HasColumnsOnly;
        icResetColSize.Enabled:=b;
        icChangeColName.Enabled:=b;
        icChangeColSize.Enabled:=b;
        icAutoColSize.Enabled:=b;
        icColInvisible.Enabled:=b;
        icColInvisible.Checked:=not AlxdSpreadSheetArray.Columns.Visible;

        b:=AlxdSpreadSheetSelections.HasRowsOnly;
        irResetRowSize.Enabled:=b;
        irChangeRowName.Enabled:=b;
        irChangeRowSize.Enabled:=b;
        irAutoRowSize.Enabled:=b;
        irRowInvisible.Enabled:=b;
        irRowInvisible.Checked:=not AlxdSpreadSheetArray.Rows.Visible;
      end;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Actions (in tag order)
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmEditor.edExecute(Sender: TObject);
var
  tmpSearchForm: TfrmAlxdSearchForm;
  tmpFind: TFind;
  ret: integer;
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
  begin
    case (Sender as TAction).Tag of
    50://undo
      begin
        //standard message, don't need RedrawBlockDefinition (is in uAlxdSpreadSheet.pas)
        SendMessage(GetFocus, WM_UNDO, 0, 0);
        //Recalculate;
        //RedrawBlockDefinition;
        ActionUpdate([aumStyle, aumBorders, aumCells, aumSelections]);
      end;
    51://redo
      begin
        Redo;
        Recalculate;
        RedrawBlockDefinition;
        Invalidate;
        ActionUpdate([aumStyle, aumBorders, aumCells, aumSelections]);
      end;
    52://cut
      begin
        //standard message, don't need RedrawBlockDefinition (is in uAlxdSpreadSheet.pas)
        SendMessage(GetFocus, WM_CUT, 0, 0);
        ActionUpdate([aumCells]);
      end;
    53://copy
      begin
        //standard message, don't need RedrawBlockDefinition (is in uAlxdSpreadSheet.pas)
        SendMessage(GetFocus, WM_COPY, 0, 0);
      end;
    54://paste
      begin
        //standard message, don't need RedrawBlockDefinition (is in uAlxdSpreadSheet.pas)
        SendMessage(GetFocus, WM_PASTE, 0, 0);
        ActionUpdate([aumCells]);
      end;
    55://paste special
      begin
        EditorMode:=false;
        AlxdSpreadSheetSelections.PasteSpecialFromClipboard;
        RedrawBlockDefinition;
        Invalidate;
        ActionUpdate([aumCells]);
      end;
    56://del format
      begin
        AlxdSpreadSheetArray.Cells.ClearFormat;
        RedrawBlockDefinition;
        Invalidate;
        ActionUpdate([aumCells]);
      end;
    57://del content
      begin
        //standard message, don't need RedrawBlockDefinition (is in uAlxdSpreadSheet.pas)
        if EditorMode then
          SendMessage(GetFocus, WM_KEYDOWN, VK_DELETE, 0)
        else
        begin
          SendMessage(GetFocus, WM_CLEAR, 0, 0);
          ActionUpdate([aumCells]);
        end;
      end;
    58://del all
      begin
        AlxdSpreadSheetArray.Cells.ClearAll;
        RedrawBlockDefinition;
        Invalidate;
        ActionUpdate([aumCells]);
      end;
    59://select all
      begin
        AlxdSpreadSheetSelections.SelectAll;
        Invalidate;
        ActionUpdate([]);
      end;
    70://find
      begin
        tmpSearchForm:=TfrmAlxdSearchForm.Create(Self);
        try
          tmpFind:=FvarOptions.Find;
          if tmpSearchForm.Find(@tmpFind) = mrFind then
          begin
            //FvarOptions.FindText:='\w';
            FvarOptions.Find:=tmpFind;
            FvarOptions.FindUseReplace:=false;
            FvarOptions.FindOffset:=1;
            edFindAgain.Execute;
            {EditorMode:=False;

            if not AlxdSpreadSheetSelections.Find(true) then
            begin
               Invalidate;
               ret:=AlxdMessageBox(Handle, MessageMemIniFile(701), '', MB_YESNO + MB_ICONQUESTION);

               if ret=IDYES then
                edFindAgain.Execute;
            end;

            Invalidate;}
          end;
        finally
          tmpSearchForm.Free;
        end;
      end;
    71://find again
      begin
        if Length(FvarOptions.FindText) = 0 then
          AlxdMessageBox(Self.Handle, MessageMemIniFile(700), '', MB_OK + MB_ICONINFORMATION)
        else
        begin
          EditorMode:=False;

          if AlxdSpreadSheetSelections.Find(true) then
          begin
            if FvarOptions.FindUseReplace then
            begin
              Invalidate;
              ret:=AlxdMessageBox(Self.Handle, MessageMemIniFile(702), '', MB_YESNO + MB_ICONQUESTION);

              if ret=IDYES then
                with FvarOptions, AlxdSpreadSheetArray.Cells.Items[FindCell.X, FindCell.Y] do
                begin
                  EditorMode:=False;
                  Contain:=StuffString(Contain, FindPos, FindLen, ReplaceText);
                  FindOffset:=FindPos + Length(ReplaceText);
                  edFindAgain.Execute;
                end;
            end;

          end
          else
          begin
            Invalidate;
            ret:=AlxdMessageBox(Self.Handle, MessageMemIniFile(701), '', MB_YESNO + MB_ICONQUESTION);

            if ret=IDYES then
              edFindAgain.Execute;
          end;
          Invalidate;
        end;
      end;
    72://replace
      begin
        tmpSearchForm:=TfrmAlxdSearchForm.Create(Self);
        try
          tmpFind:=FvarOptions.Find;
          ret:=tmpSearchForm.Replace(@tmpFind);
          if ret <> mrCancel then
          begin
            FvarOptions.Find:=tmpFind;
            FvarOptions.FindUseReplace:=true;
            FvarOptions.FindOffset:=1;

            if ret = mrReplace then
            begin
              edFindAgain.Execute;
            end;//if ret = mrReplace then

            if ret = mrReplaceAll then
            begin
              ret:=0;
              while AlxdSpreadSheetSelections.Find(false) do
                with FvarOptions, AlxdSpreadSheetArray.Cells.Items[FindCell.X, FindCell.Y] do
                begin
                  Contain:=StuffString(Contain, FindPos, FindLen, ReplaceText);
                  inc(ret);
                end;//with, while
              
              Invalidate;
              AlxdMessageBox(Self.Handle, Format(MessageMemIniFile(703), [ret]), '' , MB_ICONINFORMATION + MB_OK);
            end;//if ret = mrReplaceAll then
          end;
        finally
          tmpSearchForm.Free;
        end;
      end;
    end;
  end;

end;

procedure TfrmEditor.scExecute(Sender: TObject);
begin
  AlxdMessageBox(Self.Handle, 'Not available in beta version.', '', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmEditor.ccExecute(Sender: TObject);
var
  n, k: integer;
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    case (Sender as TAction).Tag of
    100:
      begin
        k:=AlxdSpreadSheetArray.ColCountInt;
        AddColumns(1);
        RedrawBlockDefinition(k, 0, [rmVerBorders, rmHorBorders, rmFills]);
        Invalidate;
      end;
    101:
      begin
        InsertColumns;
        Recalculate;
        RedrawBlockDefinition;
        Invalidate;
      end;
    102:
      begin
        DeleteColumns;
        Recalculate;
        RedrawBlockDefinition;
        Invalidate;
      end;
    103:
      if GetInteger(Self, (Sender as TAction).HelpContext, MessageMemIniFile(1030), MessageMemIniFile(1031), 1, n) = mrOk then
      begin
        k:=AlxdSpreadSheetArray.ColCountInt;
        AddColumns(n);
        RedrawBlockDefinition(k, 0, [rmVerBorders, rmHorBorders, rmFills]);
        Invalidate;
      end;
    end;
end;

procedure TfrmEditor.icExecute(Sender: TObject);
var
  newString: WideString;
  newDouble: double;
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    case (Sender as TAction).Tag of
    120:
      begin
        AlxdSpreadSheetArray.Columns.ResetSize;
        RedrawBlockDefinition;
        Invalidate;
      end;
    121:
      if GetString(Self, (Sender as TAction).HelpContext, MessageMemIniFile(1210), MessageMemIniFile(1211), AlxdSpreadSheetArray.Columns.Title, newString) = mrOk then
      begin
        AlxdSpreadSheetArray.Columns.Title:=newString;
        Invalidate;
      end;
    122:
      if GetFloat(Self, (Sender as TAction).HelpContext, MessageMemIniFile(1220), MessageMemIniFile(1221), AlxdSpreadSheetArray.Columns.Size, newDouble) = mrOk then
      begin
        AlxdSpreadSheetArray.Columns.Size:=newDouble;
        RedrawBlockDefinition;
        Invalidate;
      end;
    123:
      begin
        AlxdSpreadSheetArray.Columns.MaxSize;
        RedrawBlockDefinition;
        Invalidate;
      end;
    124:
      begin
        AlxdSpreadSheetArray.Columns.Visible:=not (Sender as TAction).Checked;
        RedrawBlockDefinition;
        Invalidate;
      end;
    end;
end;

procedure TfrmEditor.rcExecute(Sender: TObject);
var
  n, k: integer;
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    case (Sender as TAction).Tag of
    110:
      begin
        k:=AlxdSpreadSheetArray.RowCountInt;
        AddRows(1);
        RedrawBlockDefinition(0, k, [rmVerBorders, rmHorBorders, rmFills]);
        Invalidate;
      end;
    111:
      begin
        InsertRows;
        Recalculate;
        RedrawBlockDefinition;
        Invalidate;
      end;
    112:
      begin
        DeleteRows;
        Recalculate;
        RedrawBlockDefinition;
        Invalidate;
      end;
    113:
      if GetInteger(Self, (Sender as TAction).HelpContext, MessageMemIniFile(1130), MessageMemIniFile(1131), 1, n) = mrOk then
      begin
        k:=AlxdSpreadSheetArray.RowCountInt;
        AddRows(n);
        RedrawBlockDefinition(0, k, [rmVerBorders, rmHorBorders, rmFills]);
        Invalidate;
      end;
    end;
end;

procedure TfrmEditor.irExecute(Sender: TObject);
var
  newString: WideString;
  newDouble: double;
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    case (Sender as TAction).Tag of
    130:
      begin
        AlxdSpreadSheetArray.Rows.ResetSize;
        RedrawBlockDefinition(0, 0);
        Invalidate;
      end;
    131:
      if GetString(Self, (Sender as TAction).HelpContext, MessageMemIniFile(1310), MessageMemIniFile(1311), AlxdSpreadSheetArray.Rows.Title, newString) = mrOk then
      begin
        AlxdSpreadSheetArray.Rows.Title:=newString;
        Invalidate;
      end;
    132:
      if GetFloat(Self, (Sender as TAction).HelpContext, MessageMemIniFile(1320), MessageMemIniFile(1321), AlxdSpreadSheetArray.Rows.Size, newDouble) = mrOk then
      begin
        AlxdSpreadSheetArray.Rows.Size:=newDouble;
        RedrawBlockDefinition(0, 0);
        Invalidate;
      end;
    133:
      begin
        AlxdSpreadSheetArray.Rows.MaxSize;
        RedrawBlockDefinition(0, 0);
        Invalidate;
      end;
    134:
      begin
        AlxdSpreadSheetArray.Rows.Visible:=not (Sender as TAction).Checked;
        RedrawBlockDefinition(0, 0);
        Invalidate;
      end;
    end;
end;

procedure TfrmEditor.slExecute(Sender: TObject);
var
  tempStyle: TAlxdSpreadSheetStyleInt;
  tempName: WideString;
  //tempOwner: Pointer;
//  motive: TAlxdRedrawMotive;
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    case (Sender as TAction).Tag of
    150://select
      begin
        if FfrmAlxdStyleManager.Select(tempName) = mrOk then
        begin
          tempStyle:=TAlxdSpreadSheetStyleInt.Create(nil);
          try
            if tempStyle.LoadFrom(tempName) then
            begin

              if AlxdIndexedMessageBox(0, 1502, '', MB_YESNO + MB_ICONQUESTION) = ID_YES then
                if tempStyle.Primary = prColumn then
                begin
                  tempStyle.RowCount:=AlxdSpreadSheetStyle.RowCount;
                  if tempStyle.ColCount < AlxdSpreadSheetStyle.ColCount then
                    tempStyle.ColCount:=AlxdSpreadSheetStyle.ColCount;
                end
                else
                begin
                  tempStyle.ColCount:=AlxdSpreadSheetStyle.ColCount;
                  if tempStyle.RowCount < AlxdSpreadSheetStyle.RowCount then
                    tempStyle.RowCount:=AlxdSpreadSheetStyle.RowCount;
                end;

              AlxdSpreadSheetStyle.Assign(tempStyle);
              //AlxdSpreadSheetStyle:=tempStyle;
              FAlxdSpreadSheets.Update;
              AlxdSpreadSheetSelections.Update;
              ActionUpdate([aumBorders, aumCells, aumSelections, aumStyle]);
              RedrawBlockDefinition(0, 0, AlxdSpreadSheetStyle.Motive);
              sbMain.Repaint;
              Invalidate;
            end
            else
              AlxdMessageBox(Self.Handle, MessageMemIniFile(1501), '', MB_OK+MB_ICONERROR);
          finally
            tempStyle.Free;
          end;
        end;
      end;
    151://apply
      begin
        if AlxdSpreadSheetStyle.StyleFileName <> '' then
        begin
          tempStyle:=TAlxdSpreadSheetStyleInt.Create(nil);
          try
            if tempStyle.LoadFrom(AlxdSpreadSheetStyle.StyleFileName) then
            begin

              if AlxdIndexedMessageBox(0, 1502, '', MB_YESNO + MB_ICONQUESTION) = ID_YES then
                if tempStyle.Primary = prColumn then
                begin
                  tempStyle.RowCount:=AlxdSpreadSheetStyle.RowCount;
                  if tempStyle.ColCount < AlxdSpreadSheetStyle.ColCount then
                    tempStyle.ColCount:=AlxdSpreadSheetStyle.ColCount;
                end
                else
                begin
                  tempStyle.ColCount:=AlxdSpreadSheetStyle.ColCount;
                  if tempStyle.RowCount < AlxdSpreadSheetStyle.RowCount then
                    tempStyle.RowCount:=AlxdSpreadSheetStyle.RowCount;
                end;

              AlxdSpreadSheetStyle.Assign(tempStyle);
              FAlxdSpreadSheets.Update;
              AlxdSpreadSheetSelections.Update;
              ActionUpdate([aumBorders, aumCells, aumSelections, aumStyle]);
              RedrawBlockDefinition(0, 0, AlxdSpreadSheetStyle.Motive);
              sbMain.Repaint;
              Invalidate;
            end
            else
              AlxdMessageBox(Self.Handle, MessageMemIniFile(1501), '', MB_OK+MB_ICONERROR);
          finally
            tempStyle.Free;
          end;
        end;
      end;
    152://edit
      begin
        tempStyle:=TAlxdSpreadSheetStyleInt.Create(nil);
        try
          tempStyle.Assign(AlxdSpreadSheetStyle);

          //tempOwner:=FfrmAlxdStyleEditor.Owner;
          //FfrmAlxdStyleEditor.Owner:=Self;

          if FfrmAlxdStyleEditor.Edit(tempStyle) = mrOk then
          begin
            AlxdSpreadSheetStyle.Assign(tempStyle);
            //motive:=AlxdSpreadSheetStyle.Motive;
            //Include(motive, rmAll);
            FAlxdSpreadSheets.Update;
            AlxdSpreadSheetSelections.Update;
            ActionUpdate([aumBorders, aumCells, aumSelections, aumStyle]);
            RedrawBlockDefinition(0, 0, AlxdSpreadSheetStyle.Motive);
            AlxdSpreadSheetStyle.Motive:=[];
            sbMain.Repaint;
            Invalidate;
          end;
        finally
          tempStyle.Free;
        end;
      end;
    153:
      begin
        //make
        AlxdMessageBox(Self.Handle, 'Not available in beta version.', '', MB_OK + MB_ICONINFORMATION);
      end;
    end;
end;

procedure TfrmEditor.stExecute(Sender: TObject);
{$IFDEF DLL}
var
  NewColor: integer;
{$ENDIF}
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    with AlxdSpreadSheetStyle do
      case (Sender as TAction).Tag of
      160:
        begin
          DrawBorder:=TAlxdDrawBorder(not boolean(DrawBorder));
          RedrawBlockDefinition(0, 0, [rmAllBorders]);
        end;
      161:
        begin
          FillCell:=TAlxdFillCell(not boolean(FillCell));
          RedrawBlockDefinition(0, 0, [rmAllFills]);
        end;
      162:
        begin
          TextFit:=TAlxdTextFit(not boolean(TextFit));
          RedrawBlockDefinition(0, 0, [rmAllCells]);
        end;
      163:
        begin
          TextType:=TAlxdTextType(not boolean(TextType));
          RedrawBlockDefinition(0, 0, [rmAllCells]);
        end;
      164:
        begin
          {$IFDEF DLL}
          NewColor:=TextColor;
          if oarxAcEdSetColorDialog(@NewColor, true, 0) then
            TextColor:=NewColor;
          sbMain.Repaint;
          Repaint;
          RedrawBlockDefinition(0, 0, [rmAllCells]);
          {$ELSE}
          AlxdMessageBox(Self.Handle, 'Text Ñolor Select Dialog', '', 0);
          {$ENDIF}
        end;
      165:
        begin
          {$IFDEF DLL}
          NewColor:=VerBorderColor;
          if oarxAcEdSetColorDialog(@NewColor, true, 0) then
            VerBorderColor:=NewColor;
          sbMain.Repaint;
          Repaint;
          RedrawBlockDefinition(0, 0, [rmAllBorders]);
          {$ELSE}
          AlxdMessageBox(Self.Handle, 'Vertical Border Color Select Dialog', '', 0);
          {$ENDIF}
        end;
      166:
        begin
          {$IFDEF DLL}
          NewColor:=HorBorderColor;
          if oarxAcEdSetColorDialog(@NewColor, true, 0) then
            HorBorderColor:=NewColor;
          sbMain.Repaint;
          Repaint;
          RedrawBlockDefinition(0, 0, [rmAllBorders]);
          {$ELSE}
          AlxdMessageBox(Self.Handle, 'Horizontal Border Color Select Dialog', '', 0);
          {$ENDIF}
        end;
      end;
end;

procedure TfrmEditor.jfExecute(Sender: TObject);
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    with AlxdSpreadSheetStyle do
    begin
      Justify:=TAlxdJustify((Sender as TAction).Tag - 180);
      RedrawBlockDefinition;
      Invalidate;
    end;
end;

procedure TfrmEditor.haExecute(Sender: TObject);
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    begin
      AlxdSpreadSheetArray.Cells.HorizontalAlignment:=TAlxdCellTextHorAlignment((Sender as TAction).Tag - 200);
      ActionUpdate([aumCells]);
      RedrawBlockDefinition(0, 0, [rmCells]);
      Invalidate;
    end;
end;

procedure TfrmEditor.vaExecute(Sender: TObject);
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    begin
      AlxdSpreadSheetArray.Cells.VerticalAlignment:=TAlxdCellTextVerAlignment((Sender as TAction).Tag - 210);
      ActionUpdate([aumCells]);
      RedrawBlockDefinition(0, 0, [rmCells]);
      Invalidate;
    end;
end;

procedure TfrmEditor.tfExecute(Sender: TObject);
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    begin
      AlxdSpreadSheetArray.Cells.TextFit:=TAlxdCellTextFit((Sender as TAction).Tag - 240);
      ActionUpdate([aumCells]);
      RedrawBlockDefinition(0, 0, [rmCells]);
      Invalidate;
    end;
end;

procedure TfrmEditor.fcExecute(Sender: TObject);
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    begin
      AlxdSpreadSheetArray.Fills.FillType:=TAlxdFillType((Sender as TAction).Tag - 250);
      ActionUpdate([aumCells]);
      RedrawBlockDefinition(0, 0, [rmFills]);
      Invalidate;
    end;
end;

procedure TfrmEditor.ttExecute(Sender: TObject);
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    begin
      AlxdSpreadSheetArray.Cells.TextType:=TAlxdCellTextType((Sender as TAction).Tag - 260);
      ActionUpdate([aumCells]);
      RedrawBlockDefinition;
      Invalidate;
    end;
end;

procedure TfrmEditor.ftExecute(Sender: TObject);
var
  tmpFormatEditor: TfrmAlxdFormatForm;
  tmpCellsProperty: TAlxdCellInt;
  tmpVerBorderProperty: TAlxdBorderInt;
  tmpHorBorderProperty: TAlxdBorderInt;  
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    case (Sender as TAction).Tag of
    270://format
      begin
        //tmpCellsProperty:=TAlxdCellsInt.Create(AlxdSpreadSheetArray.Cells.Owner);
        tmpCellsProperty:=TAlxdCellInt.Create(nil);
        tmpVerBorderProperty:=TAlxdBorderInt.Create(nil);
        tmpHorBorderProperty:=TAlxdBorderInt.Create(nil);
        tmpFormatEditor:=TfrmAlxdFormatForm.Create(Self);
        try
          tmpHorBorderProperty.Assign(AlxdSpreadSheetArray.HorBorders);
          tmpVerBorderProperty.Assign(AlxdSpreadSheetArray.VerBorders);
          tmpCellsProperty.Assign(AlxdSpreadSheetArray.Cells);

          if tmpFormatEditor.Edit(AlxdSpreadSheetStyle, tmpCellsProperty, tmpVerBorderProperty, tmpHorBorderProperty) = mrOk then
          begin
            AlxdSpreadSheetArray.HorBorders.Assign(tmpHorBorderProperty);
            AlxdSpreadSheetArray.VerBorders.Assign(tmpVerBorderProperty);
            AlxdSpreadSheetArray.Cells.Assign(tmpCellsProperty);

            ActionUpdate([aumCells]);
            RedrawBlockDefinition;
            Invalidate;
          end;
        finally
          tmpHorBorderProperty.Free;
          tmpVerBorderProperty.Free;
          tmpCellsProperty.Free;
          tmpFormatEditor.Free;
        end;
      end;
    271://rotation
      begin
        AlxdSpreadSheetArray.Cells.Rotation:=Ord(not (Sender as TAction).Checked) * 90;
        ActionUpdate([aumCells]);
        RedrawBlockDefinition(0, 0);
        Invalidate;
      end;
    end;//case
end;

procedure TfrmEditor.jcExecute(Sender: TObject);
var
  b: boolean;
  r: integer;
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
  begin
    r:=IDNO;
    
    case (Sender as TAction).Tag of
    280:
      begin
        if AlxdSpreadSheetSelections.HasText then
          r:=AlxdIndexedMessageBox(Handle, 2800, '', MB_YESNOCANCEL + MB_ICONQUESTION);
        if r = IDCANCEL then
          exit;
        b:=(r = IDYES);

        AlxdSpreadSheetSelections.Join(b);
      end;
    281:
      begin
        if AlxdSpreadSheetSelections.HasText then
          r:=AlxdIndexedMessageBox(Handle, 2800, '', MB_YESNOCANCEL + MB_ICONQUESTION);
        if r = IDCANCEL then
          exit;
        b:=(r = IDYES);

        AlxdSpreadSheetSelections.JoinByRow(b);
      end;
    282:
      begin
        if AlxdSpreadSheetSelections.HasText then
          r:=AlxdIndexedMessageBox(Handle, 2800, '', MB_YESNOCANCEL + MB_ICONQUESTION);
        if r = IDCANCEL then
          exit;
        b:=(r = IDYES);

        AlxdSpreadSheetSelections.JoinByColumn(b);
      end;
    283:
      AlxdSpreadSheetSelections.Disjoin;
    end;

    RedrawBlockDefinition;
    Invalidate;
  end;
end;

procedure TfrmEditor.bdExecute(Sender: TObject);
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
  begin
    case (Sender as TAction).Tag of
    290: AlxdSpreadSheetArray.VerBorders.State:=[dbLeft];
    291: AlxdSpreadSheetArray.HorBorders.State:=[dbTop];
    292: AlxdSpreadSheetArray.VerBorders.State:=[dbRight];
    293: AlxdSpreadSheetArray.HorBorders.State:=[dbBottom];
    294: AlxdSpreadSheetArray.VerBorders.State:=[dbVer];
    295: AlxdSpreadSheetArray.HorBorders.State:=[dbHor];
    296: //cross
      begin
        AlxdSpreadSheetArray.VerBorders.State:=[dbVer];
        AlxdSpreadSheetArray.HorBorders.State:=[dbHor];
      end;
    297: //contour
      begin
        AlxdSpreadSheetArray.VerBorders.State:=[dbLeft, dbRight];
        AlxdSpreadSheetArray.HorBorders.State:=[dbTop, dbBottom];
      end;
    298: //all
      begin
        AlxdSpreadSheetArray.VerBorders.State:=[dbLeft, dbRight, dbVer];
        AlxdSpreadSheetArray.HorBorders.State:=[dbTop, dbBottom, dbHor];
      end;
    end;//case
    
    RedrawBlockDefinition(0, 0, [rmVerBorders, rmHorBorders]);
    Invalidate;
  end;
end;

procedure TfrmEditor.iccExecute(Sender: TObject);
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    case (Sender as TAction).Tag of
    300://copy cells all
      begin
        CopyCellsAll(FDragRects.FSourceRect, FDragRects.FDestRect);
        RedrawBlockDefinition(0, 0);
      end;
    301://move cells all
      begin
        MoveCellsAll(FDragRects.FSourceRect, FDragRects.FDestRect);
        RedrawBlockDefinition(0, 0);
      end;
    302://exchange cells all
      begin
        ExchangeCellsAll(FDragRects.FSourceRect, FDragRects.FDestRect);
        RedrawBlockDefinition(0, 0);
      end;
    303://copy cells content
      begin
        CopyCellsContent(FDragRects.FSourceRect, FDragRects.FDestRect);
        RedrawBlockDefinition(0, 0);
      end;
    304://copy cells format
      begin
        CopyCellsFormat(FDragRects.FSourceRect, FDragRects.FDestRect);
        RedrawBlockDefinition(0, 0);
      end;
    305://append cells content
      begin
        AppendCellsContent(FDragRects.FSourceRect, FDragRects.FDestRect);
        RedrawBlockDefinition(0, 0);
      end;
    end;
    ActionUpdate([aumBorders, aumCells, aumSelections]);
end;

procedure TfrmEditor.iceExecute(Sender: TObject);
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    case (Sender as TAction).Tag of
    310://copy cells all
      begin
        ExpandCopyCellsAll(FDragRects.FSourceRect, FDragRects.FDestRect);
        RedrawBlockDefinition(0, 0);
      end;
    311://copy cells content
      begin
        ExpandCopyCellsContent(FDragRects.FSourceRect, FDragRects.FDestRect);
        RedrawBlockDefinition(0, 0);
      end;
    312://copy cells format
      begin
        ExpandCopyCellsFormat(FDragRects.FSourceRect, FDragRects.FDestRect);
        RedrawBlockDefinition(0, 0);
      end;
    313://inc copy cells all
      begin
        ExpandIncCopyCellsAll(FDragRects.FSourceRect, FDragRects.FDestRect);
        RedrawBlockDefinition(0, 0);
      end;
    314://inc copy cells content
      begin
        ExpandIncCopyCellsContent(FDragRects.FSourceRect, FDragRects.FDestRect);
        RedrawBlockDefinition(0, 0);
      end;
    end;//case
end;

procedure TfrmEditor.npExecute(Sender: TObject);
begin
  tbNumProperty.Action:=(Sender as TAction);
  cbNumProperty.Hint:=TAction(tbNumProperty.Action).Hint;
  ActionUpdate([aumCells]);
end;

procedure TfrmEditor.mnExecute(Sender: TObject);
begin
  tbMargin.Action:=(Sender as TAction);
  tbMargin.Hint:=TAction(tbMargin.Action).Hint;
  ActionUpdate([aumCells]);
end;

procedure TfrmEditor.ssExecute(Sender: TObject);
var
  i: integer;
  s: WideString;
begin
  case (Sender as TAction).Tag of
  800://new
    begin
      i:=FAlxdSpreadSheets.Add;
      FAlxdSpreadSheets.Active:=i;
    end;
  801://open
    begin
      {$IFDEF DLL}
      Windows.SetFocus(adsw_acadMainWnd);
      oarxSendStringToExecute('Open ', true, true, true);
      {$ENDIF}
    end;
  802://open from XML
    begin
      odMain.DefaultExt:='xml';
      odMain.Filter:='ATable files (*.xml)|*.xml';
      if odMain.Execute(Handle) then
        with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
        if LoadFromXML(odMain.FileName) then
        begin
          RedrawBlockDefinition(0, 0);
          Invalidate;
          //sbMain.Repaint;
          //ActionUpdate?
        end
        else
          AlxdMessageBox(Self.Handle, MessageMemIniFile(804), '', MB_OK + MB_ICONERROR);
    end;
  803://save
    begin
      if Length(FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active].FullFileName) > 0 then
      begin
        if not FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active].SaveToXML(sdMain.FileName) then
          AlxdMessageBox(Self.Handle, MessageMemIniFile(803), '', MB_OK + MB_ICONERROR);
      end
      else
        ssExecute(ssSaveAsToXML);
    end;
  804://save as
    begin
      sdMain.DefaultExt:='xml';
      sdMain.Filter:='ATable files (*.xml)|*.xml';
      if sdMain.Execute(Handle) then
        if FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active].SaveToXML(sdMain.FileName) then
          FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active].FullFileName:=sdMain.FileName
        else
          AlxdMessageBox(Self.Handle, MessageMemIniFile(803), '', MB_OK + MB_ICONERROR)
    end;
  805://insert
    begin
      {$IFDEF DLL}
      Windows.SetFocus(adsw_acadMainWnd);
      oarxSendStringToExecute('Insert ', true, true, true);
      {$ENDIF}
    end;
  806://close
    begin
      if FAlxdSpreadSheets.Count > 1 then
      begin
        if FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active].BlockReferenceId <> 0 then
        begin
          //FAlxdSpreadSheets.Delete(FAlxdSpreadSheets.Active);
          FAlxdSpreadSheets.Close(FAlxdSpreadSheets.Active);
          exit;
        end;

        i:=AlxdMessageBox(Self.Handle, MessageMemIniFile(801), '', MB_YESNO + MB_ICONQUESTION);

        if i = ID_NO then
        begin
          //i:=FAlxdSpreadSheets.Active;
          //FAlxdSpreadSheets.Delete(FAlxdSpreadSheets.Active);
          //FAlxdSpreadSheets.Active:=i - 1;
          FAlxdSpreadSheets.Close(FAlxdSpreadSheets.Active);
          exit;
        end;

        s:=FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active].FullFileName;
        if Length(s) = 0 then
        begin
          sdMain.DefaultExt:='xml';
          sdMain.Filter:='ATable files (*.xml)|*.XML';
          if sdMain.Execute(Handle) then s:=sdMain.FileName;
        end;

        if Length(s) > 0 then
          if FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active].SaveToXML(s) then
          begin
            FAlxdSpreadSheets.Close(FAlxdSpreadSheets.Active); 
            //i:=FAlxdSpreadSheets.Active;
            //FAlxdSpreadSheets.Delete(FAlxdSpreadSheets.Active);
            //FAlxdSpreadSheets.Active:=i - 1;          
          end
          else
            AlxdMessageBox(Self.Handle, MessageMemIniFile(803), '', MB_OK + MB_ICONERROR)
      end
      else
        AlxdMessageBox(Self.Handle, MessageMemIniFile(802), '', MB_OK + MB_ICONINFORMATION);
    end;
  807:
    begin
      Perform(WM_CLOSE, 0, 0);
    end;
  end;
end;

procedure TfrmEditor.tsExecute(Sender: TObject);
var
  tempForm: TfrmAlxdOptionEditor;
  tempOptions: TAlxdSpreadSheetOptionsInt;
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    with AlxdSpreadSheetStyle do
      case (Sender as TAction).Tag of
      900:
        begin
          tempOptions:=TAlxdSpreadSheetOptionsInt.Create(nil);
          tempOptions.Assign(FvarOptions);

          tempForm:=TfrmAlxdOptionEditor.Create(Self);
          //tempForm.Parent:=Self;
          try
            if tempForm.Edit(tempOptions) = mrOk then
            begin
              FvarOptions.Assign(tempOptions);
              Invalidate;
            end;
          finally
            tempForm.Free;
            tempOptions.Free;
          end;
        end;

      end;
end;

procedure TfrmEditor.msExecute(Sender: TObject);
begin
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
    with AlxdSpreadSheetStyle do
      case (Sender as TAction).Tag of
      1500:
        HtmlHelp(Handle, PAnsiChar(Application.HelpFile), HH_DISPLAY_TOC, 0);
      1501:
        ShellExecute(handle, nil, 'http://www.alx.ncn.ru', nil, nil, SW_SHOWNORMAL);
      1502:
        begin
          frmAbout:=TfrmAbout.Create(Self);
          try
            frmAbout.Caption:=(Sender as TAction).Caption;
            frmAbout.ShowModal;
          finally
            frmAbout.Free;
          end;
        end;
      end;
end;
////////////////////////////////////////////////////////////////////////////////
//
// ComboBoxes begin
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmEditor.cbSelectOrExit(Sender: TObject);
var
  Key: Char;
begin
  Key:=#13;
  (Sender as TTntComboBox).OnKeyPress(Sender, Key);
end;

procedure TfrmEditor.cbNumPropertyKeyPress(Sender: TObject; var Key: Char);
var
  convsuccess: boolean;
  Ret: Double;
//  Code: integer;
  default: boolean;
  canadd: boolean;
  s: WideString;
begin
  try
  if ord(key) = 13 then
  begin
    s:=(Sender as TTntComboBox).Text;
    key:=#0;
    default:=false;

    if IsDefault(s) then
    begin
      Ret:=0.0;
      convsuccess:=True;
      default:=true;
    end
    else
      convsuccess:=AlxdDisToF(s, Ret);

    if convsuccess then
    begin
      canadd:=false;
//      with _Interface.AlxdSpreadSheets, Items[Active] do
      with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
      begin
        case tbNumProperty.Action.Tag of
        220: begin
               AlxdSpreadSheetArray.Cells.Height:=Ret;
               canadd:=true;
             end;
        221: begin
               AlxdSpreadSheetArray.Cells.WidthFactor:=Ret;
               canadd:=true;
             end;
        222: //if (ret>=-85) and (ret<=85) then
               if default then
                 AlxdSpreadSheetArray.Cells.ObliqueAngle:=-86
               else
               begin
                 AlxdSpreadSheetArray.Cells.ObliqueAngle:=Ret;
                 canadd:=true;
               end;
        223: begin
               AlxdSpreadSheetArray.Cells.Between:=Ret;
               canadd:=true;
             end;
        end;

        if canadd then
          if (Ret<>0) and
             ((Sender as TTnTComboBox).Items.IndexOf(s)<0) then
             (Sender as TTnTComboBox).Items.Add(s);

        RedrawBlockDefinition(0, 0);
        //RedrawSelections;
      end;//with
    end;//if
  end
  else
    AlxdFloatKeyPress(Sender, Key, (tbNumProperty.Action.Tag = 222));
  except
    on E:Exception do
      AlxdMessageBox(Self.Handle, 'cbNumPropertyKeyPress', '', 0);
  end;
end;

procedure TfrmEditor.cbMarginKeyPress(Sender: TObject; var Key: Char);
var
  //m: TMargins;
  convsuccess: boolean;
  Ret: Double;
  default: boolean;
  s: string;
//  canadd: boolean;
begin
  try
  if ord(key) = 13 then
  begin
    //m:=ClearMargins;

    s:=(Sender as TTnTComboBox).Text;
    key:=#0;
    default:=false;

    if isDefault(s) then
    begin
      Ret:=0;
      convsuccess:=True;
      default:=true;
    end
    else
      convsuccess:=AlxdDisToF(s, Ret);

    if convsuccess then
    begin
      //with _Interface.AlxdSpreadSheets, Items[Active] do
      with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
      begin
        case tbMargin.Action.Tag of
        230:
          begin
            if default then
              AlxdSpreadSheetArray.Cells.MarginLeft:=-1
            else
              AlxdSpreadSheetArray.Cells.MarginLeft:=Ret;
          end;
        231:
          begin
            if default then
              AlxdSpreadSheetArray.Cells.MarginTop:=-1
            else
              AlxdSpreadSheetArray.Cells.MarginTop:=Ret;
          end;
        232:
          begin
            if default then
              AlxdSpreadSheetArray.Cells.MarginRight:=-1
            else
              AlxdSpreadSheetArray.Cells.MarginRight:=Ret;
          end;
        233:
          begin
            if default then
              AlxdSpreadSheetArray.Cells.MarginBottom:=-1
            else
              AlxdSpreadSheetArray.Cells.MarginBottom:=Ret;
          end;
        end;

        if (Ret>0) and
           ((Sender as TTntComboBox).Items.IndexOf(s)<0) then
           (Sender as TTntComboBox).Items.Add(s);

        RedrawBlockDefinition(0, 0);
        //RedrawSelections;
      end;
    end;
  end
  else
    AlxdFloatKeyPress(Sender, Key, False);
  except
    on E:Exception do
      AlxdMessageBox(Self.Handle, 'cbMarginKeyPress', '', 0);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Status Bar utility
//
////////////////////////////////////////////////////////////////////////////////

function GetStatusBarIndex(StatusBar: TTntStatusBar): integer;
var
  i: integer;
  sx,ex : integer;
  pt : TPoint;
begin
  pt:=StatusBar.ScreenToClient(Mouse.CursorPos);
  sx:=0;
  ex:=0;
  i:=-1;
  result:=i;
  if (pt.Y < 0) or (pt.Y > StatusBar.Height) then
  begin
    exit;
  end;

  while not ((sx < pt.X) and (pt.X < ex)) and (i < StatusBar.Panels.Count-1) do
  begin
    inc(i);
    ex:=ex+StatusBar.Panels.Items[i].Width;
    sx:=ex-StatusBar.Panels.Items[i].Width;
  end;
  result:=i;
end;

procedure TfrmEditor.sbMainResize(Sender: TObject);
var
 summ : integer;
 i : integer;
begin
  summ:=0;
  for i:=sbMain.Panels.Count-1 downto 1 do
    summ:=summ+sbMain.Panels[i].Width;
  sbMain.Panels[0].Width:=sbMain.Width-summ;
end;

procedure TfrmEditor.sbMainMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  j: integer;
begin
  j:=GetStatusBarIndex(sbMain);
  if (j > 0) and (Button = mbLeft) then
  begin
    sbMain.Panels[j].Bevel:=pbLowered;
  end;
end;

procedure TfrmEditor.sbMainMouseLeave(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to 3 do
    sbMain.Panels[i].Bevel:=pbNone;
end;

procedure TfrmEditor.sbMainMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  i, j: integer;
  act: TContainedAction;
begin
  j:=GetStatusBarIndex(sbMain);

  if j > 0 then
  begin
    act:=FindAction(j+163);
    if act<>nil then
      sbMain.Hint:=TAction(act).Hint
    else
      sbMain.Hint:='';
  end
  else
    sbMain.Hint:=MessageMemIniFile(95);

  for i := 1 to 3 do
    if i = j then
    begin
      if sbMain.Panels[i].Bevel <> pbLowered then
        sbMain.Panels[i].Bevel:=pbRaised;
    end
    else
      sbMain.Panels[i].Bevel:=pbNone;
end;

procedure TfrmEditor.sbMainMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  j: integer;
  act: TContainedAction;
begin
  j:=GetStatusBarIndex(sbMain);
  if (j > 0) and (Button = mbLeft) then
    if sbMain.Panels[j].Bevel = pbLowered then
    begin
  //  sbMain.Panels[j].Bevel:=pbRaised;
  //    sbMain.Repaint;
      act:=FindAction(j+163);
      if act<>nil then
        act.Execute;
      //MouseCapture:=False;
      sbMain.Panels[j].Bevel:=pbNone;
    end;

  //reset bevel in statusbar panels
  //for j:=1 to 3 do
  //  sbMain.Panels[j].Bevel:=pbNone;//pbRaised;
  //sbMain.Refresh;
end;

procedure TfrmEditor.sbMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
var
 r: TRect;
begin
  r:=Rect;
  InflateRect(r, -1, -1);
  with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active], Statusbar.Canvas do
    begin
      Pen.Color:=clDkGray;
      //Brush.Color:=clDkGray;
      Rectangle(Rect);
      //with r do
      //  RoundRect(Left, Top, Right, Bottom, 4, 4);
      case Panel.Index of
      1:
        begin
          {$IFDEF DLL}
          Brush.Color:=oarxAcEdGetRGB(AlxdSpreadSheetStyle.TextColor);
          {$ELSE}
          Brush.Color:=clRed;
          {$ENDIF}
        end;
      2:
        begin
          {$IFDEF DLL}
          Brush.Color:=oarxAcEdGetRGB(AlxdSpreadSheetStyle.VerBorderColor);
          {$ELSE}
          Brush.Color:=clBlack;
          {$ENDIF}
        end;
      3:
        begin
          {$IFDEF DLL}
          Brush.Color:=oarxAcEdGetRGB(AlxdSpreadSheetStyle.HorBorderColor);
          {$ELSE}
          Brush.Color:=clBlack;
          {$ENDIF}
        end;
      end;//case
      FillRect(r);
    end;//with
end;

////////////////////////////////////////////////////////////////////////////////
//
// Toolbar
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmEditor.ToolbarCycle(Menu: TMenuItem);
var
  i: integer;
  tb: TToolBar;
  MItem : TMenuItem;
begin
  for i:=0 to cbMain.ControlCount-1 do
  begin
    tb:=TToolBar(cbMain.Controls[i]);
    MItem := TMenuItem.Create(Self);
    MItem.OnClick:=ToolbarMenuClick;

    MItem.Checked := tb.Visible;
    MItem.Caption := tb.Caption;
    MItem.Hint := tb.Hint;
    MItem.Tag := i;

    Menu.Add(MItem);
  end;
end;

procedure TfrmEditor.ToolbarMenuClick(Sender: TObject);
begin
  try
  with (Sender as TMenuItem) do
  begin
    Checked:=not Checked;
    TToolBar(cbMain.Controls[Tag]).Visible:=Checked;
  end;
  except
    on E:Exception do
      AlxdMessageBox(Self.Handle, 'ToolbarMenuClick', '', 0);
  end;
end;

procedure TfrmEditor.mnToolsClick(Sender: TObject);
begin
  mnToolbars.Clear;
  ToolbarCycle(mnToolbars);
end;

////////////////////////////////////////////////////////////////////////////////
//
// Popup
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmEditor.pmMainClear;
var
  i: integer;
begin
//  try
  for i:=0 to pmMain.Items.Count-1 do
    pmMain.Items.Action:=nil;// Delete(i);
  pmMain.Items.Clear;
//  except
//    on E:Exception do
//      AlxdMessageBox(0, 'pmMainClear', nil, 0);
//  end;
end;

procedure TfrmEditor.pmMainAddActions(StartP, EndP, TagP: integer);
var
  j : integer;
  MItem : TMenuItem;
begin
  for j:=0 to alMain.ActionCount-1 do
  begin
    if (alMain.Actions[j].Tag >= StartP) and (alMain.Actions[j].Tag <= EndP) and TAction(alMain.Actions[j]).Enabled then
    begin
      MItem := TMenuItem.Create(Self);
      MItem.Action:=alMain.Actions[j];
      MItem.Checked:=(alMain.Actions[j].Tag = TagP) or TAction(alMain.Actions[j]).Checked;

      pmMain.Items.Add(MItem);
    end;
    //{$IFDEF DEBUG}
    //OutputDebugString(PChar(Format('pmMainAddActions + Tag %d in [%d..%d]', [alMain.Actions[j].Tag, StartP, EndP])));
    //{$ENDIF}
  end;
end;

procedure TfrmEditor.pmMainAddDelimiter;
var
  MItem : TMenuItem;
begin
  MItem := TMenuItem.Create(Self);
  MItem.Caption:='-';

  pmMain.Items.Add(MItem);
end;

procedure TfrmEditor.pmMainPopup(Sender: TObject);

  procedure InsertEditCommands;
  begin
    pmMainAddActions(52, 55, 0);//58?
    pmMainAddDelimiter;
  end;

var
  comp : TComponent;
begin
  try
    comp:=TPopupMenu(Sender).PopupComponent;

    pmMainClear;

    if comp is TTntControlBar then
    begin
      ToolbarCycle(pmMain.Items);
    end;

    if comp is TTntToolBar then
    begin
      case TTntToolButton(comp).Tag of
      220: pmMainAddActions(220, 223, 0);
      230: pmMainAddActions(230, 233, 0);
      end;
    end;

    if comp is TAlxdSpreadSheetInt then
      case pmMain.Tag of
      1://gpTopRow
        begin
          InsertEditCommands;
          pmMainAddActions(120, 124, 0);
          pmMainAddDelimiter;
          pmMainAddActions(100, 102, 0);
        end;
      2://gpLeftCol
        begin
          InsertEditCommands;
          pmMainAddActions(130, 134, 0);
          pmMainAddDelimiter;
          pmMainAddActions(110, 112, 0);
        end;
      3://gpCells (right click under selection - edit, format)
        begin
          InsertEditCommands;
          pmMainAddDelimiter;
          pmMainAddActions(280, 283, 0);//join
          pmMainAddDelimiter;
          pmMainAddActions(111, 112, 0);//insert & delete row
          pmMainAddDelimiter;
          pmMainAddActions(101, 102, 0);//insert & delete column
        end;
      6://gpSelectionBorder (copy & move with drag)
        begin
          //InsertEditCommands;
          //pmMainAddDelimiter;
          pmMainAddActions(300, 305, 0);
          //pmMainAddActions(110, 112, 0);
        end;
      7:
        begin
          pmMainAddActions(310, 314, 0);
        end;

  {    0:
        begin
          pmMainAddActions(272, 272, 0);//format
        end;
}
    end;

  except
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Menu
//
////////////////////////////////////////////////////////////////////////////////
procedure TfrmEditor.miExecute(Sender: TObject);
var
  v: Variant;
  r: integer;
begin
  {$IFDEF DLL}
  oarxAcEdEvaluateLisp('(' + FImport[(Sender as TTntMenuItem).Tag] + ' (vlax-get-object "AlxdGrid.AlxdApplication")) ', v, r);
  oarxSendStringToExecute(#13, true, true, true);
  {$ENDIF}
end;

procedure TfrmEditor.miImport(Value: WideString);
var
  i, j, k: integer;
  r: TRegExpr;
  w: WideString;
  MItem : TTntMenuItem;
begin
  if Length(Value) = 0 then exit;

  for i := 0 to mnGrid.Count - 1 do
    if mnGrid.Items[i].Name = 'nImport' then
      break;

  //Value:='(t1 ; t2; t3)(a1; a2 ; a3)';
  k:=0;
  r:=TRegExpr.Create;
  try
    r.Expression:='\((.+?);(.+?);(.+?)\)';

    if r.Exec(Value) then
    repeat
      SetLength(FImport, k + 1);
      Inc(i);
      MItem := TTntMenuItem.Create(Self);
      MItem.OnClick:=miExecute;
      MItem.Tag:=k;

      for j := 1 to r.SubExprMatchCount do
      begin
        w:=MidStr(Value, r.MatchPos[j], r.MatchLen[j]);

        case j of
        1: MItem.Caption:=w;
        2: MItem.Hint:=MItem.Caption + '|' + w;
        3: FImport[k]:=w;
        end;
      end;
      mnGrid.Insert(i, MItem);

      Inc(k);
    until not r.ExecNext;

  finally
    r.Free;
  end;

  //delimiter
  Inc(i);
  MItem := TTntMenuItem.Create(Self);
  MItem.Caption:='-';
  mnGrid.Insert(i, MItem);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Tab Set utility
//
////////////////////////////////////////////////////////////////////////////////

procedure TfrmEditor.tsAlxdSpreadSheetsChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  if FAlxdSpreadSheets.Active > -1 then
    if tsAlxdSpreadSheets.Tag = 0 then //see uAlxdSpreadSheets for detailing
      if FAlxdSpreadSheets.Active <> NewTab then
      begin
        FAlxdSpreadSheets.Active:=NewTab;

        //ActionUpdate([aumStyle, aumBorders, aumCells, aumSelections]);
      end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Form
//
////////////////////////////////////////////////////////////////////////////////
procedure TfrmEditor.TntFormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF DLL}
  //if FfrmEditor.Visible then
  if FOpened then  
  begin
    Windows.SetFocus(adsw_acadMainWnd);
    oarxSendStringToExecute('eXit ', true, true, true);
    //FOpened:=false;
  end;
  {$ENDIF}
end;

procedure TfrmEditor.WndProc(var Message: TMessage);
begin
  case Message.Msg of
  WM_ALXD_CLOSE:
    begin
      with FAlxdSpreadSheets.Items[FAlxdSpreadSheets.Active] do
        Message.Result:=Ord(not EditorMode);
    end;
  WM_ALXD_SWITCH_TAB:
    begin
      inherited;
    end;
  WM_ALXD_IDLE:
    DoIdle;
  else
    inherited;
  end;
end;

procedure TfrmEditor.Open;
var
  v: WideString;
begin
  {$IFDEF DLL}
  v:=' ';
  //OutputDebugString(PChar(Format('TfrmEditor.Open + v %s = ', [v])));
  //OutputDebugString(PChar(Format('TfrmEditor.Open + v %p = ', [Addr(v)])));
  //AlxdMessageBox(0, Format('TfrmEditor.Open + v %s= ', [v]), '', 0);
  //AlxdMessageBox(0, Format('TfrmEditor.Open + v %p = ', [Addr(v)]), '', 0);
  if oarxImportFuncList(v) then
    miImport(v);
  //AlxdMessageBox(0, Format('TfrmEditor.Open + v %s= ', [v]), '', 0);
  //AlxdMessageBox(0, Format('TfrmEditor.Open + v %p = ', [Addr(v)]), '', 0);

  oarxDisableDocumentActivation;
  {$ENDIF}
  LoadRegistry;
  Show;
  FOpened:=true;
  {$IFDEF DLL}
  oarxRegisterWinMsg(FfrmEditor.Handle);
  oarxRegisterOnIdleWinMsg;
  {$ENDIF}
end;

procedure TfrmEditor.Close;
begin
  {$IFDEF DLL}
  oarxRemoveOnIdleWinMsg;
  oarxRemoveWinMsg;
  {$ENDIF}
  FOpened:=false;  
  SaveRegistry;
  inherited Close;
  {$IFDEF DLL}
  oarxEnableDocumentActivation;
  {$ENDIF}
end;

procedure TfrmEditor.DoHint(Sender: TObject);
begin
  sbMain.Panels[0].Text := GetLongHint(Application.Hint);
end;

procedure TfrmEditor.DoIdle;

  function GetHint(Control: TControl): string;
  begin
    while Control <> nil do
      if Control.Hint = '' then
        Control := Control.Parent
      else
      begin
        Result := Control.Hint;
        Exit;
      end;
    Result := '';
  end;

var
  P: TPoint;
  C: TControl;
begin
  GetCursorPos(P);
  C := FindDragTarget(P, True);
  Application.Hint:=GetHint(C);
end;

constructor TfrmEditor.Create(AOwner: TComponent);
begin
  inherited;
  //FAlxdEditor:=TAlxdEditor.Create(ComServer.TypeLib, IID_IAlxdEditor);
  FAlxdEditor:=TAlxdEditor.Create;
  FAlxdSpreadSheets:=TAlxdSpreadSheetsInt.Create(pBackground);

//  FAlxdSpreadSheets.Items[0].Parent:=Self;

  //replace form icon
  Icon.ReleaseHandle;
  Icon.Handle:=LoadIcon(GetWindowLong(Application.Handle, GWL_HINSTANCE), MakeIntResource(1));

  tbNumProperty.Style:=tbsDropDown;
  tbNumProperty.Width:=36;
  //tbNumProperty
  //tbNumProperties.ButtonWidth:=23;

  tbMargin.Style:=tbsDropDown;
  tbMargin.Width:=36;
  //tbMargins.ButtonWidth:=23;
  
  cbNumProperty.Items.Add(DefaultString);
  cbMargin.Items.Add(DefaultString);

  Application.OnHint:=DoHint;
  Application.HelpFile:=WideChangeFileExt(WideGetModuleFileName(hInstance), '.chm');
  //LoadRegistry;
  LoadCaptions;
  FOpened:=false;
  //alMainUpdate(nil, nil);
end;

destructor  TfrmEditor.Destroy;
begin
  //SaveRegistry;
//  FAlxdSpreadSheets.Free;
//  if Assigned(FAlxdEditor) then
//  if FAlxdEditor.DispTypeInfo <> nil then
//  FAlxdEditor.Free;
  pmMainClear;
  inherited;
end;



end.
