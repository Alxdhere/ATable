unit uAlxdStyleManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  TntForms, Dialogs, StdCtrls, TntStdCtrls, ActnList, TntActnList, TntRegistry,
  uAlxdRegistry, uAlxdLocalizer, uAlxdTreeView, xAlxdStyleManager, AlxdGrid_TLB,
  TntComCtrls, TntSysUtils, ComCtrls, ImgList, uAlxdSpreadSheetStyle, uoarxImport;

type
  TfrmAlxdStyleManager = class(TTntForm, IAlxdStyleManager)
    bSetCurrent: TButton;
    bNew: TButton;
    bNewFolder: TButton;
    lTitleCurrent: TTntLabel;
    bModify: TButton;
    bClose: TButton;
    lStyles: TTntLabel;
    lTitleValue: TTntLabel;
    bApply: TButton;
    tvImages: TImageList;
    tvStyles: TAlxdTreeView;
    gInfo: TGroupBox;
    lInfo: TTntLabel;
    bResetCurrent: TButton;
    
    procedure TntFormResize(Sender: TObject);
    procedure bCloseClick(Sender: TObject);
    procedure bModifyClick(Sender: TObject);

    procedure tvStylesCancelEdit(Sender: TObject; Node: TTreeNode);
    procedure tvStylesChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure tvStylesCompare(Sender: TObject; Node1, Node2: TTreeNode; Data: Integer; var Compare: Integer);
    procedure tvStylesDblClick(Sender: TObject);
    procedure tvStylesEdited(Sender: TObject; Node: TTntTreeNode; var S: WideString);
    procedure tvStylesEditing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
    procedure tvStylesGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure tvStylesGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvStylesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bSetCurrentClick(Sender: TObject);
    procedure bResetCurrentClick(Sender: TObject);

  private
    { Private declarations }
    FAlxdStyleManager: IAlxdStyleManager;

    procedure LoadCaptions;
    procedure LoadRegistry;
    procedure SaveRegistry;

    function  InsertDirs(FindPath: WideString; Node: TTntTreeNode): boolean;
    function  InsertFiles(FindPath: WideString; Node: TTnTTreeNode; Mask: WideString): boolean;
    procedure FillStyleManagerTree(FindPath: WideString);

    function  NodeToName(Node: TTntTreeNode): WideString;
    function  NodeIsDir(Node: TTntTreeNode): boolean;
    function  NodeIsFile(Node: TTntTreeNode): boolean;
    function  NodeToRealDirName(Node: TTntTreeNode): WideString;
    function  NodeToRealFileName(Node: TTntTreeNode): WideString;

    procedure UpdateInfo(Node: TTntTreeNode);

    function  Get_StylePath: WideString;
    function  Get_StyleCurrent: WideString;

    procedure Set_StylePath(Value: WideString);
    procedure Set_StyleCurrent(Value: WideString);

    function  SelectedNodeIsDir: WordBool;
    function  SelectedNodeIsFile: WordBool;
    function  SelectedNodeIsRoot: WordBool;
    function  SelectedNodeFileName: WideString;
    function  SelectedNodeName: WideString;

  public
    { Public declarations }
    property Intf: IAlxdStyleManager read FAlxdStyleManager implements IAlxdStyleManager;

    property StylePath: WideString read Get_StylePath write Set_StylePath;
    property StyleCurrent: WideString read Get_StyleCurrent write Set_StyleCurrent;

    function  Select(var Value: WideString): Integer;
    procedure Show;

    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

var
  FfrmAlxdStyleManager: TfrmAlxdStyleManager;

implementation

uses ComServ, uAlxdOptions, uAlxdStyleEditor;

{$R *.dfm}

procedure TfrmAlxdStyleManager.LoadCaptions;
begin
  try
    Caption:=MessageMemIniFile(52);
    ReadCaptionSectionData(self, 'StyleManagerForm');
  except
    on E:Exception do
      {$IFDEF DLL}
      oarxAcUtPrintf(#10'Loading Style Manager captions failed! Some values is invalid.');
      {$ENDIF}
  end;
end;

procedure TfrmAlxdStyleManager.LoadRegistry;
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    LoadSize(r, Self, 'StyleManagerForm');
    //LoadPos(r, Self, 'StyleManagerForm');

  finally
    r.Free;
  end;
end;

procedure TfrmAlxdStyleManager.SaveRegistry;
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    SaveSize(r, Self, 'StyleManagerForm');
    //SavePos(r, Self, 'StyleManagerForm');

  finally
    r.Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  Fill Tree functions
////////////////////////////////////////////////////////////////////////////////

function TfrmAlxdStyleManager.InsertDirs(FindPath: WideString; Node: TTntTreeNode): boolean;
var
  Sr: TSearchRecW;
begin
{$IFDEF DEBUG}
  OutputDebugString(PChar(Format(#10'TStyleForm.InsertDirs (FindPath:%s; Node:?)', [FindPath])));
{$ENDIF}
  result:=False;
  if WideFindFirst(FindPath+'*.*', faDirectory, Sr) = 0 then
  begin
    repeat
      if (sr.Attr and faDirectory) <> 0 then
        if PWideChar(Sr.Name)[0] <> '.' then
          tvStyles.Items.AddChild(Node, Sr.Name);
    until WideFindNext(sr) <> 0;
    WideFindClose(sr);
//    Node.AlphaSort(False);
    result:=True;
  end;
end;

function TfrmAlxdStyleManager.InsertFiles(FindPath: WideString; Node: TTnTTreeNode; Mask: WideString): boolean;
var
  Sr: TSearchRecW;
begin
{$IFDEF DEBUG}
  OutputDebugString(PChar(Format(#10'TStyleForm.InsertFiles (FindPath:%s; Node:?)', [FindPath])));
{$ENDIF}
  result:=False;
  if WideFindFirst(FindPath + Mask, faAnyFile, Sr) = 0 then
  begin
    repeat
      tvStyles.Items.AddChild(Node, WideChangeFileExt(Sr.Name,''));
    until WideFindNext(sr) <> 0;
    WideFindClose(sr);
    result:=True;
  end;
end;

procedure TfrmAlxdStyleManager.FillStyleManagerTree(FindPath: WideString);
var
  AddDir: WideString;
  i: integer;
begin
{$IFDEF DEBUG}
  OutputDebugString(PChar(Format(#10'TStyleForm.FillStyleTree (FindPath:%s)', [FindPath])));
{$ENDIF}
  tvStyles.Items.Clear;
  tvStyles.Items.AddChild(nil, 'Root');
  tvStyles.Items[0].Selected;

  i:=1;

  if InsertDirs(FindPath, tvStyles.Items[0]) then
    while (i < tvStyles.Items.Count) do
    begin
      AddDir:=NodeToName(tvStyles.Items[i]);
      InsertDirs(FindPath + AddDir, tvStyles.Items[i]);
      InsertFiles(FindPath + AddDir, tvStyles.Items[i], '*.ats');
      InsertFiles(FindPath + AddDir, tvStyles.Items[i], '*.xml');
      inc(i);
    end;
  InsertFiles(FindPath, tvStyles.Items[0], '*.ats');
  InsertFiles(FindPath, tvStyles.Items[0], '*.xml');
  tvStyles.Items[0].AlphaSort(True); ///Ohoh
  tvStyles.Items[0].Expanded:=True;
end;

////////////////////////////////////////////////////////////////////////////////
// Node functions
////////////////////////////////////////////////////////////////////////////////

function TfrmAlxdStyleManager.NodeToName(Node: TTntTreeNode): WideString;
begin
  result:='';
  if Node <> nil then
    while (Node.Level <> 0) do
    begin
      Result:=Node.Text + '\' + Result;
      Node:=Node.Parent;
    end;
end;

function TfrmAlxdStyleManager.NodeIsDir(Node: TTntTreeNode): boolean;
begin
  result:=WideDirectoryExists(WideIncludeTrailingBackslash(StylePath) + NodeToName(Node));
end;

function TfrmAlxdStyleManager.NodeIsFile(Node: TTntTreeNode): boolean;
begin
  result:=WideFileExists(NodeToRealFileName(Node));
end;

function TfrmAlxdStyleManager.NodeToRealDirName(Node: TTntTreeNode): WideString;
begin
  if NodeIsDir(Node) then
    result:=WideIncludeTrailingBackslash(StylePath) + NodeToName(Node);
end;

function TfrmAlxdStyleManager.NodeToRealFileName(Node: TTntTreeNode): WideString;
var
  ext: WideString;
begin
  if not NodeIsDir(Node) then
  begin
    result:=WideIncludeTrailingBackslash(StylePath) + NodeToName(Node);
    result:=WideExcludeTrailingBackslash(result);
    
    ext:='.ats';
    if WideFileExists(result + ext) then
    begin
      result:=result + ext;
      exit;
    end;

    ext:='.xml';
    if WideFileExists(result + ext) then
    begin
      result:=result + ext;
      exit;
    end;
  end;
end;

procedure TfrmAlxdStyleManager.UpdateInfo(Node: TTntTreeNode);
var
  tmpValue: TAlxdSpreadSheetStyleInt;
  fname: WideString;
  ext: WideString;
begin
  lInfo.Caption:='';
  if NodeIsDir(Node) then
  begin
    fname:=NodeToRealDirName(Node);
    //lInfo.Caption:=Format('Folder: %s', [fname]);
    lInfo.Caption:=Format(MessageMemIniFile(69), [fname]);
  end
  else
  begin
    tmpValue:=TAlxdSpreadSheetStyleInt.Create(self);
    try
      fname:=NodeToRealFileName(Node);
      ext:=WideExtractFileExt(fname);

      if ext = '.ats' then
        tmpValue.LoadFromATS(fname);

      if ext = '.xml' then
        tmpValue.LoadFromXML(fname);

      with tmpValue do
        //lInfo.Caption:=Format('Size: %dx%d Default size: %f Text style: %s [H: %f, W: %f, O: %f]', [ColCount, RowCount, DefaultSize, TextStyleName, TextHeight, TextWidthFactor, TextObliqueAngle]);
        lInfo.Caption:=Format(MessageMemIniFile(70), [ColCount, RowCount, DefaultSize, TextStyleName, TextHeight, TextWidthFactor, TextObliqueAngle]);
    finally
      tmpValue.Free;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Property get
////////////////////////////////////////////////////////////////////////////////

function  TfrmAlxdStyleManager.Get_StylePath: WideString;
begin
  Result:=FvarOptions.StylePath;
//  Result:='d:\Александр\Borland Studio Projects\AlxdGrid9\styles_rus'
end;

function  TfrmAlxdStyleManager.Get_StyleCurrent: WideString;
begin
  Result:=FvarOptions.StyleCurrent;
end;

////////////////////////////////////////////////////////////////////////////////
// Property Set
////////////////////////////////////////////////////////////////////////////////
procedure TfrmAlxdStyleManager.Set_StylePath(Value: WideString);
begin
  FvarOptions.StylePath:=Value;
  FillStyleManagerTree(FvarOptions.StylePath);
end;

procedure TfrmAlxdStyleManager.Set_StyleCurrent(Value: WideString);
begin
  FvarOptions.StyleCurrent:=Value;
  lTitleValue.Caption:=FvarOptions.StyleCurrent;
end;

////////////////////////////////////////////////////////////////////////////////
//  Fill Tree events
////////////////////////////////////////////////////////////////////////////////

function TfrmAlxdStyleManager.SelectedNodeIsDir: WordBool;
begin
  Result:=NodeIsDir(tvStyles.Selected);
end;

function TfrmAlxdStyleManager.SelectedNodeIsFile: WordBool;
begin
  Result:=NodeIsFile(tvStyles.Selected);
end;

function TfrmAlxdStyleManager.SelectedNodeIsRoot: WordBool;
begin
  Result:=(tvStyles.Selected.Level = 0);
end;

function TfrmAlxdStyleManager.SelectedNodeFileName: WideString;
begin
  if SelectedNodeIsDir then
    Result:=NodeToRealDirName(tvStyles.Selected)
  else
  if SelectedNodeIsFile then
    Result:=NodeToRealFileName(tvStyles.Selected);
end;

function TfrmAlxdStyleManager.SelectedNodeName: WideString;
begin
  if NodeIsFile(tvStyles.Selected) then
    Result:=NodeToName(tvStyles.Selected.Parent) + tvStyles.Selected.Text;
end;


////////////////////////////////////////////////////////////////////////////////
//  Form Events
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdStyleManager.TntFormResize(Sender: TObject);
begin
  bClose.Top:=Height - bClose.Height - (Height - ClientHeight) - 6;
  bApply.Top:=bClose.Top - bApply.Height - 6;
  bClose.Left:=Width - bClose.Width - (Width - ClientWidth) - 6;

  bApply.Left:=bClose.Left;
  bModify.Left:=bClose.Left;
  bNewFolder.Left:=bClose.Left;
  bNew.Left:=bClose.Left;
  bSetCurrent.Left:=bClose.Left;
  bResetCurrent.Left:=bClose.Left;

  tvStyles.Top:=48;
  tvStyles.Left:=lStyles.Left;
  //bResetCurrent.Top:=bModify.Top + bModify.Height + 6;
  //bSetCurrent.Top:=tvStyles.Top;
  bResetCurrent.Top:=tvStyles.Top;
  bSetCurrent.Top:=bResetCurrent.Top + bResetCurrent.Height + 6;
  bNew.Top:=bSetCurrent.Top + bSetCurrent.Height + 6;
  bNewFolder.Top:=bNew.Top + bNew.Height + 6;
  bModify.Top:=bNewFolder.Top + bNewFolder.Height + 6;

  lTitleValue.Left:=lTitleCurrent.Left + lTitleCurrent.Width + 8;
  lTitleValue.Width:=ClientWidth - lTitleValue.Left - 8;

  gInfo.Left:=lStyles.Left;
  gInfo.Top:=bApply.Top;
  gInfo.Height:=bClose.Top + bClose.Height - bApply.Top + 1;
  gInfo.Width:=bClose.Left - gInfo.Left - 8;

  tvStyles.Height:=gInfo.Top - tvStyles.Top - 8;
  tvStyles.Width:=bClose.Left - tvStyles.Left - 8;

  lInfo.Left:=8;
  lInfo.Top:=16;
  lInfo.Width:=gInfo.Width - 16;
  lInfo.Height:=gInfo.Height - 24;
end;

////////////////////////////////////////////////////////////////////////////////
//  Button Events
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAlxdStyleManager.bCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAlxdStyleManager.bModifyClick(Sender: TObject);
var
  tmpValue: TAlxdSpreadSheetStyleInt;
  fname: WideString;
  fnamenew: WideString;
  fnamebak: WideString;
//  ext: WideString;
begin
  tmpValue:=TAlxdSpreadSheetStyleInt.Create(self);
  try
    fname:=SelectedNodeFileName;
    tmpValue.LoadFrom(fname);
//    ext:=WideExtractFileExt(fname);

//    if ext = '.ats' then
//      tmpValue.LoadFromATS(fname);

//    if ext = '.xml' then
//      tmpValue.LoadFromXML(fname);

    fnamebak:=WideChangeFileExt(fname, '.bak');
    fnamenew:=WideChangeFileExt(fname, '.xml');

    if FfrmAlxdStyleEditor.Edit(tmpValue) = mrOk then
    begin
      WideDeleteFile(fnamebak);
      WideRenameFile(fname, fnamebak);
      tmpValue.SaveToXML(fnamenew);
    end;
  finally
    tmpValue.Free;
  end;

  UpdateInfo(tvStyles.Selected);
end;

procedure TfrmAlxdStyleManager.bResetCurrentClick(Sender: TObject);
begin
  StyleCurrent:='';
end;

procedure TfrmAlxdStyleManager.bSetCurrentClick(Sender: TObject);
begin
  StyleCurrent:=SelectedNodeName;
end;

procedure TfrmAlxdStyleManager.tvStylesCancelEdit(Sender: TObject; Node: TTreeNode);
begin
  bClose.Default:=True;
  bClose.Cancel:=True;
end;

procedure TfrmAlxdStyleManager.tvStylesChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
begin
  if NodeIsDir(Node as TTntTreeNode) then
  begin
    bSetCurrent.Enabled:=False;
    bNew.Enabled:=True;
    bNewFolder.Enabled:=True;
    bModify.Enabled:=False;
    bApply.Enabled:=False;
  end
  else
  if NodeIsFile(Node as TTntTreeNode) then
  begin
    bSetCurrent.Enabled:=True;
    bNew.Enabled:=True;
    bNewFolder.Enabled:=True;
    bModify.Enabled:=True;
    bApply.Enabled:=True;
  end
  else
  begin
    bSetCurrent.Enabled:=False;
    bNew.Enabled:=False;
    bNewFolder.Enabled:=False;
    bModify.Enabled:=False;
    bApply.Enabled:=False;
  end;

  UpdateInfo(Node as TTntTreeNode);
end;

procedure TfrmAlxdStyleManager.tvStylesCompare(Sender: TObject; Node1, Node2: TTreeNode; Data: Integer; var Compare: Integer);
var
  d1, d2: boolean;
begin
  d1:=NodeIsDir(Node1 as TTntTreeNode);
  d2:=NodeIsDir(Node2 as TTntTreeNode);
  if d1 = d2 then
    Compare := WideCompareText(Node1.Text, Node2.Text)
  else
    Compare := Ord(d2) - Ord(d1);
end;

procedure TfrmAlxdStyleManager.tvStylesDblClick(Sender: TObject);
begin
  if not NodeIsFile(tvStyles.Selected) then exit;

  if bApply.Visible then
    bApply.Click
  else
    bModify.Click;
end;

procedure TfrmAlxdStyleManager.tvStylesEdited(Sender: TObject; Node: TTntTreeNode; var S: WideString);
var
  oldName: WideString;
  newName: WideString;
  ext: WideString;
begin
//Rename dir or file names
  if NodeIsDir(Node) then
  begin
    oldName:=NodeToRealDirName(Node);
    newName:=NodeToRealDirName(Node.Parent) + s + '\';
  end
  else
  begin
    oldName:=NodeToRealFileName(Node);
    ext:=WideExtractFileExt(oldName);
    newName:=NodeToRealDirName(Node.Parent) + s + ext;
  end;

  if WideCompareText(oldName, newName) <> 0 then
  begin
    if not WideRenameFile(oldName, newName) then
    begin
      s:=Node.Text;
      MessageBox(0, PChar(MessageMemIniFile(61)), nil, MB_OK + MB_ICONWARNING);
    end
    else
      Node.Text:=s;
  end;

  bClose.Default:=True;
  bClose.Cancel:=True;
end;

procedure TfrmAlxdStyleManager.tvStylesEditing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
begin
  if Node.Level = 0 then AllowEdit:=False;

  bClose.Cancel:=not AllowEdit;
  bClose.Default:=not AllowEdit;
end;

procedure TfrmAlxdStyleManager.tvStylesGetImageIndex(Sender: TObject; Node: TTreeNode);
var
  fname: WideString;
  ext: WideString;
begin
  if Node.Level = 0 then
    Node.ImageIndex:=0
  else
  if NodeIsDir(Node as TTntTreeNode) then
    Node.ImageIndex:=Ord(Node.Expanded) + 1
  else
  if NodeIsFile(Node as TTntTreeNode) then
  begin
    fname:=NodeToRealFileName(Node as TTntTreeNode);
    ext:=WideExtractFileExt(fname);

    if ext = '.ats' then
      Node.ImageIndex:=4;
      
    if ext = '.xml' then
      Node.ImageIndex:=3;
  end
  else
    Node.ImageIndex:=4;
end;

procedure TfrmAlxdStyleManager.tvStylesGetSelectedIndex(Sender: TObject; Node: TTreeNode);
begin
  Node.SelectedIndex:=Node.ImageIndex;
end;

procedure TfrmAlxdStyleManager.tvStylesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F5 then
  begin
    tvStyles.TopItem.DeleteChildren;
    FillStyleManagerTree(StylePath + '\');
  end;
end;

function  TfrmAlxdStyleManager.Select(var Value: WideString): Integer;
begin
  LoadRegistry;

  FillStyleManagerTree(StylePath + '\');
  StyleCurrent:=StyleCurrent;

  //show/hide
  bResetCurrent.Visible:=False;
  bSetCurrent.Visible:=False;
  bNew.Visible:=False;
  bNewFolder.Visible:=False;
  bModify.Visible:=False;
  bApply.Visible:=True;

  ShowModal;

  if tvStyles.Selected <> nil then
    Value:=NodeToRealFileName(tvStyles.Selected);

  SaveRegistry;
  //FvarOptions.FlushStyleManagerOption;
  
  Result:=ModalResult;
end;

procedure TfrmAlxdStyleManager.Show;
begin
  LoadRegistry;

  FillStyleManagerTree(StylePath + '\');
  StyleCurrent:=StyleCurrent;

  //show/hide
  bResetCurrent.Visible:=True;
  bSetCurrent.Visible:=True;
  bNew.Visible:=True;
  bNewFolder.Visible:=True;
  bModify.Visible:=True;
  bApply.Visible:=False;

  ShowModal;

  SaveRegistry;
  //FvarOptions.FlushStyleManagerOption;
end;

constructor TfrmAlxdStyleManager.Create(AOwner: TComponent);
begin
  inherited;
  FAlxdStyleManager:=TAlxdStyleManager.Create;

  Icon.ReleaseHandle;
  Icon.Handle:=LoadIcon(GetWindowLong(Application.Handle, GWL_HINSTANCE), MakeIntResource(1));

  LoadCaptions;
end;

destructor  TfrmAlxdStyleManager.Destroy;
begin
  //FAlxdStyleManager.Free;
  inherited;
end;

end.
