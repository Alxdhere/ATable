unit uAlxdPasteSpecial;

interface

uses Windows, Messages, Controls, OleDlg, ActiveX;

type
  TAlxdPasteSpecial = class
  private
    FOwner: TWinControl;
    FFormatCount: integer;
    FFormats: POleUIPasteEntry;
    FSelectedIndex: integer;
  public
    procedure   AddFormat(cfFormat: Word; cfFormatName: string; cfFormatDesc: string; dwFlags: integer);
    procedure   ClearFormats;
    function    DoModal: integer;

    constructor Create(Owner: TWinControl);
    destructor  Destroy; override;

    property    FormatCount: integer read FFormatCount;
    property    SelectedIndex: integer read FSelectedIndex;
  end;

var
  CF_AXML: integer;
  CF_HTML: integer;
  
implementation

{
procedure CenterWindow(Wnd: HWnd);
var
  Rect: TRect;
begin
  GetWindowRect(Wnd, Rect);
  SetWindowPos(Wnd, 0,
    (GetSystemMetrics(SM_CXSCREEN) - Rect.Right + Rect.Left) div 2,
    (GetSystemMetrics(SM_CYSCREEN) - Rect.Bottom + Rect.Top) div 3,
    0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;
}
function OleDialogHook(Wnd: HWnd; Msg, WParam, LParam: Longint): Longint; stdcall;
begin
  Result := 0;
  if Msg = WM_INITDIALOG then
  begin
//    if GetWindowLong(Wnd, GWL_STYLE) and WS_CHILD <> 0 then
//      Wnd := GetWindowLong(Wnd, GWL_HWNDPARENT);
    //CenterWindow(Wnd);
    Result := 1;
  end;
end;

procedure  TAlxdPasteSpecial.AddFormat(cfFormat: Word; cfFormatName: string; cfFormatDesc: string; dwFlags: integer);
var
  AFormats: POleUIPasteEntry;
  asize: integer;
  fsize: integer;
begin
  Inc(FFormatCount);

  asize:=SizeOf(TOleUIPasteEntry) * FFormatCount;
  fsize:=SizeOf(TOleUIPasteEntry) * (FFormatCount - 1);

  GetMem(AFormats, asize);
  ZeroMemory(AFormats, asize);
  MoveMemory(AFormats, FFormats, fsize);
  FreeMem(FFormats, fsize);

  with POleUIPasteEntry(Longint(AFormats) + fsize)^ do
  begin
    fmtetc.cfFormat := cfFormat;
    fmtetc.ptd:=nil;
    fmtetc.dwAspect := DVASPECT_CONTENT;
    fmtetc.lIndex := -1;
    fmtetc.tymed := TYMED_HGLOBAL;
    lpstrFormatName := PChar(cfFormatName);
    lpstrResultText := PChar(cfFormatDesc);
    dwFlags := dwFlags;
  end;

  FFormats:=AFormats;
end;

procedure  TAlxdPasteSpecial.ClearFormats;
begin
  FFormatCount:=0;
  if FFormats <> nil then
    FreeMem(FFormats, SizeOf(TOleUIPasteEntry) * FFormatCount);
end;

function   TAlxdPasteSpecial.DoModal: integer;
var
  Data: TOleUIPasteSpecial;
begin
  FillChar(Data, SizeOf(Data), 0);

  Data.cbStruct := SizeOf(Data);
  Data.dwFlags := 0;
  Data.hWndOwner := FOwner.Handle;
  Data.lpfnHook := OleDialogHook;
  Data.arrPasteEntries := FFormats;
  Data.cPasteEntries := FFormatCount;
  Data.arrLinkTypes := nil;
  Data.cLinkTypes := 0;

  Result:=OleUIPasteSpecial(Data);
  FSelectedIndex:=Data.nSelectedIndex;
end;

constructor TAlxdPasteSpecial.Create(Owner: TWinControl);
begin
  inherited Create;
  FOwner:=Owner;
  ClearFormats;
  FSelectedIndex:=-1;
end;

destructor TAlxdPasteSpecial.Destroy;
begin
  FOwner:=nil;
  ClearFormats;
  inherited;
end;

initialization
  OleInitialize(nil);
  CF_AXML:=RegisterClipboardFormat('ATable XML Format');
  CF_HTML:=RegisterClipboardFormat('HTML Format');

finalization
  OleUninitialize;

end.
