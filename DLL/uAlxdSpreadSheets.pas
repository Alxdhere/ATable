unit uAlxdSpreadSheets;

interface

uses Windows, Classes, Controls, uAlxdSystem, uAlxdSpreadSheet,
     xAlxdSpreadSheets, AlxdGrid_TLB, SysUtils;

type
  TAlxdSpreadSheetsInt = class(TComponent, IAlxdSpreadSheets)
  private
    FAlxdSpreadSheets: IAlxdSpreadSheets;
    FAlxdSpreadSheetInts: TList;

    function Get_Count: integer;
    function Get_Active: integer;
    function Get_Items(Index: Integer): TAlxdSpreadSheetInt;

    procedure Set_Active(Value: integer);
  protected
  public
    property Intf: IAlxdSpreadSheets read FAlxdSpreadSheets implements IAlxdSpreadSheets;

    function Add: Integer;
    function HasByDef(id: longint): boolean;
    function HasByRef(id: longint): boolean;
    procedure Delete(Index: integer);
    procedure Close(Index: integer);
    procedure Update;

    property Items[Index: integer]: TAlxdSpreadSheetInt read Get_Items;
    property Count: integer read Get_Count;
    property Active: integer read Get_Active write Set_Active;
{    function Add: Integer; safecall;
    procedure Delete(Index: Integer); safecall;
    procedure Insert(Index: Integer); safecall;
    function Get_Count: Integer; safecall;
    function Get_Items(Index: Integer): IAlxdSpreadSheet; safecall;
    procedure Exchange(Index1, Index2: Integer); safecall;}

    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
  end;

//error group 100 (i.e. 101...199)

implementation

uses uAlxdEditor;

function TAlxdSpreadSheetsInt.Get_Active: integer;
begin
  Result:=FfrmEditor.tsAlxdSpreadSheets.TabIndex;
end;

function TAlxdSpreadSheetsInt.Get_Count: integer;
begin
  Result:=FAlxdSpreadSheetInts.Count;
end;

function TAlxdSpreadSheetsInt.Get_Items(Index: Integer): TAlxdSpreadSheetInt;
begin
  if (Index < 0) or (Index > Count)  then
  begin
    AlxdIndexedMessageBox(0, 102, '', MB_ICONWARNING + MB_OK);
    Result:=nil;
    exit;
  end;

  Result:=FAlxdSpreadSheetInts.Items[Index];
end;

procedure TAlxdSpreadSheetsInt.Set_Active(Value: integer);

  procedure HideInactive;
  var
    i: integer;
  begin
    for i:=0 to Count - 1 do
      if i <> Value then
      with Items[i] do
      begin
        //OnChangedGridProperty:=nil;
        //OnChangedCellProperty:=nil;
        //OnChangedFillProperty:=nil;
        //OnChangedBorderProperty:=nil;
        //OnChangedSelectionProperty:=nil;
        //OnPopupMenu:=nil;
        //OnCustomMovePopupMenu:=nil;
        //OnDragDrop:=nil;
        //OnDragOver:=nil;
        Visible:=False;
      end;//with
  end;//procedure

var
  tmp: TAlxdSpreadSheetInt;
begin
  tmp:=Items[Value];
  if tmp = nil then
    exit;

  tmp.Visible:=True;
  HideInactive;

  FfrmEditor.tsAlxdSpreadSheets.Tag:=-1;
  FfrmEditor.tsAlxdSpreadSheets.TabIndex:=Value;
  FfrmEditor.ActionUpdate([aumStyle, aumBorders, aumCells, aumSelections]);
  FfrmEditor.ActiveControl:=tmp;
  FfrmEditor.tsAlxdSpreadSheets.Tag:=0;
  Update;
end;

function TAlxdSpreadSheetsInt.Add: Integer;
begin
  Result:=FAlxdSpreadSheetInts.Add(TAlxdSpreadSheetInt.Create(Self));
  with Items[Count-1] do
  begin
    Parent:=FfrmEditor.pBackgroundSheets;
    Align:=alClient;
    Visible:=False;
    //TabStop:=True;
    //Items[Count-1].Drop
    //Items[Count-1].P
    PopupMenu:=FfrmEditor.pmMain;

    //FfrmEditor.tsAlxdSpreadSheets.Tabs.Add(Format(AlxdSpreadSheetTitle, [BlockReferenceId, AlxdSpreadSheetStyle.StyleName]));
    FfrmEditor.tsAlxdSpreadSheets.Tabs.Add('');
  end;
  Update;
end;

function TAlxdSpreadSheetsInt.HasByDef(id: longint): boolean;
var
  i: integer;
begin
  Result:=false;

  for i := 0 to Count - 1 do
    if Items[i].BlockDefinitionId = id then
    begin
      Result:=True;
      Break;
    end;
end;

function TAlxdSpreadSheetsInt.HasByRef(id: longint): boolean;
var
  i: integer;
begin
  Result:=false;

  for i := 0 to Count - 1 do
    if Items[i].BlockReferenceId = id then
    begin
      Result:=True;
      Break;
    end;
end;

procedure TAlxdSpreadSheetsInt.Delete(Index: integer);
begin
  if (Index < 0) or (Index > Count)  then
  begin
    AlxdIndexedMessageBox(0, 102, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  FfrmEditor.tsAlxdSpreadSheets.Tabs.Delete(Index);
  Items[Index].Free;
  FAlxdSpreadSheetInts.Delete(Index);
end;

procedure TAlxdSpreadSheetsInt.Close(Index: integer);
var
  i: integer;
begin
  if Count > 1 then
  begin
    i:=Active;
    Delete(Index);
    Active:=i - 1;
  end;
end;

procedure TAlxdSpreadSheetsInt.Update;
var
  i: integer;
begin
  for i:=0 to Count - 1 do
    with Items[i] do
      //FfrmEditor.tsAlxdSpreadSheets.Tabs.Strings[i]:=Format(AlxdSpreadSheetTitle, [BlockReferenceId, AlxdSpreadSheetStyle.StyleName]);
      FfrmEditor.tsAlxdSpreadSheets.Tabs.Strings[i]:=Format(AlxdSpreadSheetTitle, [BlockReferenceHandle, AlxdSpreadSheetStyle.StyleName]);
end;

{

procedure TAlxdSpreadSheetsInt.Delete(Index: Integer);
begin
  if (Index < 0) or (Index > Get_Count)  then
  begin
    AlxdIndexedMessageBox(0, 102, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  TAlxdSpreadSheetInt(FAlxdSpreadSheetInts.Items[Index]).Free;
  FAlxdSpreadSheetInts.Delete(Index);
end;

procedure TAlxdSpreadSheetsInt.Insert(Index: Integer);
begin
  if (Index < 0) or (Index > Get_Count)  then
  begin
    AlxdIndexedMessageBox(0, 102, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  FAlxdSpreadSheetInts.Insert(Index, TAlxdSpreadSheetInt.Create(Self));
end;

function TAlxdSpreadSheetsInt.Get_Count: Integer;
begin
  Result:=FAlxdSpreadSheetInts.Count;
end;

function TAlxdSpreadSheetsInt.Get_Items(Index: Integer): IAlxdSpreadSheet;
begin
  Result:=TAlxdSpreadSheetInt(FAlxdSpreadSheetInts.Items[Index]);
end;

procedure TAlxdSpreadSheetsInt.Exchange(Index1, Index2: Integer);
begin
  if (Index1 < 0) or (Index1 > Get_Count) or
     (Index2 < 0) or (Index2 > Get_Count) then
  begin
    AlxdIndexedMessageBox(0, 102, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  FAlxdSpreadSheetInts.Exchange(Index1, Index2);
end;
}
{function TAlxdSpreadSheetsInt.GetFCount: integer;
var
  c: integer;
begin
  c:=High(FAlxdSpreadSheetInt);
  if c < 0 then
    c:=0
  else
    c:=c+1;
  Result:=c;
end;

function TAlxdSpreadSheetsInt.GetFAlxdSpreadSheetInt(Index: integer): TAlxdSpreadSheetInt;
begin
  if (Index < 0) or (Index > Count)  then
  begin
    AlxdIndexedMessageBox(0, 101, '', MB_ICONWARNING + MB_OK);
    Result:=nil;
    exit;
  end;

  Result:=FAlxdSpreadSheetInt[Index];
end;

procedure TAlxdSpreadSheetsInt.SetFAlxdSpreadSheetInt(Index: integer; Value: TAlxdSpreadSheetInt);
begin
  if (Index < 0) or (Index > Count)  then
  begin
    AlxdIndexedMessageBox(0, 101, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  FAlxdSpreadSheetInt[Index]:=Value;
end;

function  TAlxdSpreadSheetsInt.Add: integer;
begin
  SetLength(FAlxdSpreadSheetInt, Count + 1);
  FAlxdSpreadSheetInt[Count-1]:=TAlxdSpreadSheetInt.Create(Owner);
  with FAlxdSpreadSheetInt[Count-1] do
  begin
//    FAlxdSpreadSheetInt[Count-1].Parent:=(Parent as TAlxdEditorForm).pBackgroundSheets;
  end;
  Result:=Count-1;
end;

procedure TAlxdSpreadSheetsInt.Delete(Index: integer);
begin
  if (Index < 0) or (Index > Count)  then
  begin
    AlxdIndexedMessageBox(0, 102, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  FAlxdSpreadSheetInt[Index].Free;
end;
}
constructor TAlxdSpreadSheetsInt.Create(AOwner: TComponent);
begin
  inherited;
  FAlxdSpreadSheets:=TAlxdSpreadSheets.Create;
  FAlxdSpreadSheetInts:=TList.Create;
  //FfrmEditor.tsAlxdSpreadSheets.Tabs.Clear;
end;

destructor  TAlxdSpreadSheetsInt.Destroy;
{var
  i: integer;}
begin
  //for i := 0 to Count - 1 do
  //  Delete(i);
  FAlxdSpreadSheetInts.Free;
  //FAlxdSpreadSheets.Free;
  inherited;
end;

end.
