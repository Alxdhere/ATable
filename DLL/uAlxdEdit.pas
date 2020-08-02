unit uAlxdEdit;

interface

Uses
  Classes, Windows, Messages, Controls, RichEdit, Forms, StrUtils, TntComCtrls,
  uAlxdSystem, Graphics, regexpr, SysUtils, uAlxdOptions;

type
  TSelection = record
    StartPos, EndPos: Integer;
  end;

  TSyntaxPattern = record
    SyntaxPattern: WideString;
    Color: TColor;
  end;

  TAlxdEdit = class(TTntRichEdit)
  private
    //FExitOnEnter: boolean;
//    FDirectionEnter: TAlxdDirectionEnter;
    FHorizontalAlignment: byte;
    FSyntaxPatternInProcess: boolean;
    FSyntaxPattern: array of TSyntaxPattern;
    FPrevLength: integer;
//    procedure Set_FHorizontalAlignment(Value: byte);

  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure WndProc(var Message: TMessage); override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

    function  Get_SyntaxPatterns(Index: integer): TSyntaxPattern;
    procedure Set_SyntaxPatterns(Index: integer; Value: TSyntaxPattern);
  public
    procedure SyntaxPatternClear;
    procedure SyntaxPatternReset;
    procedure SyntaxPatternRepaint;
    function  SyntaxPatternCount: integer;
    function  SyntaxPatternAdd: integer;
    property  SyntaxPatterns[Index: integer]: TSyntaxPattern read Get_SyntaxPatterns write Set_SyntaxPatterns;

    procedure Insert(Value: WideString);
    //function  Selected: WideString;
    function  PrevSelected: WideChar;
    procedure Move(Loc: TRect);
    procedure Hide;
    function  IsFormula: boolean;
    function  IsTextChanged: boolean;
    constructor Create(AOwner: TComponent); override;

    //property ExitOnEnter: boolean read FExitOnEnter write FExitOnEnter;
//    property DirectionEnter: TAlxdDirectionEnter read FDirectionEnter write FDirectionEnter;
    property HorizontalAlignment: byte read FHorizontalAlignment write FHorizontalAlignment default 0;
  end;

implementation

procedure TAlxdEdit.SyntaxPatternRepaint;
var
  r: TRegExpr;
  i: integer;
  Format: TCharFormat;
  s: TSelection;
begin
  if IsTextChanged then
    if not FSyntaxPatternInProcess then
    begin
      FSyntaxPatternInProcess:=True;
      try
        SendMessage(Handle, EM_GETSEL, Longint(@s.StartPos), Longint(@s.EndPos));

        FillChar(Format, SizeOf(TCharFormat), 0);
        Format.cbSize := SizeOf(TCharFormat);

        Format.dwMask:=CFM_COLOR;
        Format.crTextColor:=clBlack;
        SendMessage(Handle, EM_SETCHARFORMAT, SCF_ALL, LPARAM(@Format));

        for i := 0 to SyntaxPatternCount - 1 do
        begin
          r:=TRegExpr.Create;
          try
            r.Expression:=SyntaxPatterns[i].SyntaxPattern;
            if r.Exec(Text) then
            repeat
              //j:=r.MatchPos[0];
              //j:=r.MatchLen[0];
              //rEdit.SelStart:=r.MatchPos[0]-1;
              //rEdit.SelLength:=r.MatchLen[0];
              //rEdit.SelAttributes.Color:=Get_SyntaxPattern(i).Color;
              //Format.dwMask:=CFM_COLOR;
              Format.crTextColor:=SyntaxPatterns[i].Color;

              SendMessage(Handle, EM_SETSEL, r.MatchPos[0]-1, r.MatchPos[0] + r.MatchLen[0] - 1);
              SendMessage(Handle, EM_SETCHARFORMAT, SCF_SELECTION, LPARAM(@Format));
            until not r.ExecNext;

          finally
            r.Free;
          end;
        end;

        SendMessage(Handle, EM_SETSEL, s.StartPos, s.EndPos);
      finally
        FSyntaxPatternInProcess:=False;
      end;
    end;

  //OutputDebugString(#10'SyntaxPatternRepaint');
end;

procedure TAlxdEdit.CreateParams(var Params: TCreateParams);
//const
//  WordWraps: array[Boolean] of DWORD = (0, ES_AUTOHSCROLL);
//  HAlignments: array[0..2] of DWORD = (ES_LEFT, ES_CENTER, ES_RIGHT);
begin
{$IFDEF AEDEBUG}
  OutputDebugString('TAlxdEdit.CreateParams');
{$ENDIF}
  inherited CreateParams(Params);
{  with Params do
  begin
//    Style:=Style and not WordWraps[FWordWrap] or HAlignments[FHorizontalAlignment] or ES_MULTILINE or ES_NOHIDESEL;

//    Style := Style and WS_BORDER;
//    ExStyle := Params.ExStyle or not WS_EX_ACCEPTFILES;
  end;}
end;

procedure TAlxdEdit.CreateWnd;
begin
{$IFDEF AEDEBUG}
  OutputDebugString('TAlxdEdit.CreateWnd');
{$ENDIF}
  inherited;
  Perform(EM_SETTEXTMODE, TM_PLAINTEXT, 0);
  //SendMessage(Handle, EM_SETTEXTMODE, TM_PLAINTEXT, 0);

{  ParentCtl3D := False;
  Ctl3D := False;
//  TabStop := False;
  FWordWrap := False;
  BorderStyle:=bsSingle;
//  BorderStyle:=bsNone;
  DoubleBuffered := False;}

//  SendMessage(Handle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, 0);
end;

procedure TAlxdEdit.WndProc(var Message: TMessage);
//var
//  i: integer;
begin
  case Message.Msg of
  WM_KILLFOCUS:
    begin
      inherited;
      with Message do
        SendMessage(Parent.Handle, Msg, WParam, LParam);
    end;
  WM_MOUSEWHEEL:
    begin
      with Message do
        SendMessage(Parent.Handle, Msg, WParam, LParam);
    end;
  WM_GETDLGCODE:
    begin
      inherited;
      Message.Result := Message.Result or DLGC_WANTTAB;
    end;
  {CN_COMMAND:
  //WM_COMMAND:
    with TWMCommand(Message) do
    begin
      case NotifyCode of
      EN_CHANGE:
        SyntaxPatternRepaint;
      else
        inherited;
      end;
    end;}

{  WM_CHAR:
    with Message do
    begin
      if Char(WParam) in [^H, #32..#255] then
      begin
        SelStart:=SelStart+SelLength;
        SelLength:=0;

        //EditorMode:=True;
        //FEditInfo.FEditor.SelectAll;
        //PostMessage(FEditInfo.FEditor.Handle, Msg, WParam, 0);
      end;
      inherited;
      if IsFormula then
        Parent.Perform(Msg, WParam, LParam);
    end;}
  //WM_KEYDOWN, WM_KEYUP,
  //WM_MOUSEACTIVATE,
  //WM_MOUSEMOVE,
  {WM_LBUTTONDOWN..WM_RBUTTONDBLCLK:
    begin
      //StateMachine(Message);
      with Message do
        SendMessage(Parent.Handle, Msg, WParam, LParam);
    end;}
  {WM_SYSKEYDOWN, WM_SYSKEYUP:
    begin
      inherited;
      //StateMachine(Message);
      with Message do
        SendMessage(Parent.Handle, Msg, WParam, LParam);
    end;}
  else
    inherited;
  end;

end;

procedure TAlxdEdit.WMPaint(var Message: TWMPaint);
{var
  b: TBitmap;}
begin
  if not FSyntaxPatternInProcess then
  begin
    inherited;
    //OutputDebugString(PChar(Format('WM_PAINT FSyntaxPatternInProcess: %d', [Integer(FSyntaxPatternInProcess)])));
  end;
  //SyntaxPatternRepaint;
//  Canvas.Lock;
//  try
//    inherited;
//  finally
//    Canvas.Unlock;
//  end;
{  b:=TBitmap.Create;
  try
    b.Height:=Height;
    b.Width:=Width;
    //PaintTo(b.Canvas, 0, 0);
    inherited;

  finally
    b.Free;
  end;}
end;

procedure TAlxdEdit.KeyDown(var Key: Word; Shift: TShiftState);
const
  Empty: PChar = '';

  procedure SendToParent;
  begin
  //  FGrid.KeyDown(Key, Shift);
   Parent.Perform(WM_KEYDOWN, Key, 0);
   Key := 0;
  end;

  function Selection: TSelection;
  begin
   SendMessage(Handle, EM_GETSEL, Longint(@Result.StartPos), Longint(@Result.EndPos));
  end;

  function LCount: Integer;
  begin
   //Result:=SendMessage(Handle, EM_GETLINECOUNT,0,0);
    Result:=Lines.Count;
  end;

  function GetCarPos: TPoint;
  begin
    Result:=CaretPos;
   //Result.X :=Selection.StartPos;
   //Result.Y := SendMessage(Handle, EM_LINEFROMCHAR, Result.X, 0);
   //Result.X := Result.X - SendMessage(Handle, EM_LINEINDEX, -1, 0);
  end;

//var
//  ss: TSelection;
begin
{$IFDEF AEDEBUG}
  OutputDebugString(PChar(Format(#10'TAlxdEdit.KeyDown (Key:%d)', [Key])));
{$ENDIF}
  FPrevLength:=Length(Text);

  if IsFormula then
  case key of
    VK_DOWN:
      if Parent.Perform(WM_ALXD_SELTEXTISSELECTION, 0, 0) < 0 then
      begin
        if (Shift = []) and (GetCarPos.Y >= (LCount-1)) then
          SendToParent;
      end
      else
        SendToParent;
    VK_RIGHT:
      if Parent.Perform(WM_ALXD_SELTEXTISSELECTION, 0, 0) < 0 then
      begin
        if (Shift = []) and (SendMessage(Handle, EM_LINELENGTH, Selection.StartPos, 0) = GetCarPos.X) then
          SendToParent;
      end
      else
        SendToParent;
    VK_LEFT:
      if Parent.Perform(WM_ALXD_SELTEXTISSELECTION, 0, 0) < 0 then
      begin
        if (Shift = []) and (GetCarPos.X = 0) then
          SendToParent;
      end
      else
        SendToParent;
    VK_UP:
      if Parent.Perform(WM_ALXD_SELTEXTISSELECTION, 0, 0) < 0 then
      begin
        if (Shift = []) and (GetCarPos.Y = 0) then
          SendToParent;
      end
      else
        SendToParent;
    VK_ESCAPE:
      SendToParent;
    VK_RETURN:
      begin
        //if FExitOnEnter and not (ssCtrl in Shift) then
        //begin
          //Parent.Perform(WM_ALXD_EDITORMODE, 0, 0);
          case FvarOptions.DirectionEnter of
          deLeft:Key:=VK_LEFT;
          deDown:Key:=VK_DOWN;
          deRight:Key:=VK_RIGHT;
          deUp:Key:=VK_UP;
          end;
          Shift:=[];
          SendToParent;
        //end;
      end;
  else
    inherited KeyDown(Key, Shift);
    if Parent.Perform(WM_ALXD_SELTEXTISSELECTION, 0, 0) >= 0 then
      SendToParent;
  end
  else
  case key of
    VK_DOWN:
      if (Shift = []) and (GetCarPos.Y >= (LCount-1)) then
        SendToParent;
    VK_RIGHT:
      if (Shift = []) and (SendMessage(Handle, EM_LINELENGTH, Selection.StartPos, 0) = GetCarPos.X) then
        SendToParent;
    VK_LEFT:
      if (Shift = []) and (GetCarPos.X = 0) then
        SendToParent;
    VK_UP:
      if (Shift = []) and (GetCarPos.Y = 0) then
        SendToParent;
    VK_TAB:
      if not (ssAlt in Shift) then
        SendToParent;
    VK_ESCAPE:
      SendToParent;
{    VK_ESCAPE:
      begin
        Parent.Perform(WM_ALXD_RESETEDITTEXT, 0, 0);
        Parent.Perform(WM_ALXD_EDITORMODEOFF, 0, 0);
        Parent.Perform(WM_ALXD_REDRAWSELECTION, 0, 0);
      end;}
    VK_RETURN:
      begin
        if FvarOptions.ExitOnEnter and not (ssCtrl in Shift) then
        begin
          //Parent.Perform(WM_ALXD_EDITORMODEOFF, 0, 0);
          Parent.Perform(WM_ALXD_EDITORMODE, 0, 0);
          case FvarOptions.DirectionEnter of
          deLeft:Key:=VK_LEFT;
          deDown:Key:=VK_DOWN;
          deRight:Key:=VK_RIGHT;
          deUp:Key:=VK_UP;
          end;
          Shift:=[];
          SendToParent;
        end;

      end;
  else
    inherited KeyDown(Key, Shift);
  end;
end;

procedure TAlxdEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  if IsFormula then
    Parent.Perform(WM_KEYUP, Key, 0);
end;

function  TAlxdEdit.Get_SyntaxPatterns(Index: integer): TSyntaxPattern;
begin
  if (Index < 0) or (Index > SyntaxPatternCount)  then
    exit;

  Result:=FSyntaxPattern[Index];
end;

procedure TAlxdEdit.Set_SyntaxPatterns(Index: integer; Value: TSyntaxPattern);
begin
  if (Index < 0) or (Index > SyntaxPatternCount)  then
    exit;

  FSyntaxPattern[Index]:=Value;
end;

procedure TAlxdEdit.SyntaxPatternClear;
begin
  SetLength(FSyntaxPattern, 0);
end;

procedure TAlxdEdit.SyntaxPatternReset;
begin
//read from config array of values (pattern + color)
end;

function  TAlxdEdit.SyntaxPatternCount: integer;
var
  c: integer;
begin
  c:=High(FSyntaxPattern);
  if c < 0 then
    c:=0
  else
    c:=c+1;
  Result:=c;
end;

function  TAlxdEdit.SyntaxPatternAdd: integer;
begin
  SetLength(FSyntaxPattern, SyntaxPatternCount + 1);
  Result:=SyntaxPatternCount - 1;
end;

procedure TAlxdEdit.Insert(Value: WideString);
var
  sp, ep: Integer;
begin
  SendMessage(Handle, EM_GETSEL, Longint(@sp), Longint(@ep));
  SendMessage(Handle, EM_REPLACESEL, 0, Longint(PChar(String(Value))));
  SendMessage(Handle, EM_SETSEL, sp, sp + Length(String(Value)));
end;

{function  TAlxdEdit.Selected: WideString;
var
  sp, ep: Integer;
begin
  SendMessage(Handle, EM_GETSEL, Longint(@sp), Longint(@ep));
  Result:=MidStr(Text, sp+1, ep-sp);
end;}

function  TAlxdEdit.PrevSelected: WideChar;
var
  sp, ep: Integer;
begin
  SendMessage(Handle, EM_GETSEL, Longint(@sp), Longint(@ep));
  Result:=#0;
  if sp > 0 then
    Result:=Text[sp];
end;

procedure TAlxdEdit.Move(Loc: TRect);
//var
  //keeptext: string;
begin
{$IFDEF AEDEBUG}
  OutputDebugString('TAlxdEdit.Move');
{$ENDIF}

//  if Handle = 0 then
//  begin
    //keeptext:=Text;
  HandleNeeded;
  HideSelection:=False;
  
  WordWrap:=FvarOptions.WordWrap;
  Font.Name:=FvarOptions.FontName;
  Font.Size:=FvarOptions.FontSize;  
    //Text:=keeptext;
//  end;

//  HideSelection:=False;
//  Color:=clGray;

  with Loc do
    SetWindowPos(Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top, SWP_SHOWWINDOW{ or SWP_NOREDRAW});

//  UpdateBoundsRect(Loc);
  //SetBounds();
  Perform(EM_SCROLLCARET, 0, 0);
  if Parent.Focused then
    Windows.SetFocus(Handle);
end;

procedure TAlxdEdit.Hide;
begin
{$IFDEF AEDEBUG}
  OutputDebugString('TAlxdEdit.Hide');
{$ENDIF}
  if HandleAllocated and IsWindowVisible(Handle) then
  begin
    Invalidate;
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_HIDEWINDOW or SWP_NOZORDER or SWP_NOREDRAW);
    if Focused then
      Windows.SetFocus(Parent.Handle);
  end;
end;

function  TAlxdEdit.IsFormula: boolean;
begin
  Result:=uAlxdSystem.IsFormula(Text);
end;

function  TAlxdEdit.IsTextChanged: boolean;
begin
  Result:=(FPrevLength <> Length(Text));
end;

constructor TAlxdEdit.Create(AOwner: TComponent);
begin
{$IFDEF AEDEBUG}
  OutputDebugString('TAlxdEdit.Create');
{$ENDIF}
  FSyntaxPatternInProcess:=False;
  
  inherited Create(AOwner);
  ParentCtl3D := False;
  Ctl3D := False;

{//  TabStop := False;
  FWordWrap := False;
  BorderStyle:=bsSingle;
//  BorderStyle:=bsNone;
  DoubleBuffered := False;}

  //ExitOnEnter:=False;
  BorderWidth:=1;
  BevelKind:=bkFlat;
  BorderStyle:=bsNone;
  //WordWrap:=False;
  Width:=1;
  //Height:=1;
end;

end.
