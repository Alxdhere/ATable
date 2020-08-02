unit uAlxdLocalizer;

interface

uses Windows, Messages, ComObj, SysUtils, ComCtrls, IniFiles, Controls, Menus, ActnList,
TntRegistry, TntComCtrls, TntMenus, uAlxdRegistry, uAlxdSystem;

procedure ReadActionSectionData(ActionList: TActionList);
procedure ReadCaptionSectionData(ParentControl: TControl; ParentControlName: string);
procedure ReadTreeSectionData(TreeControl: TTreeView); overload;
procedure ReadTreeSectionData(TreeControl: TTntTreeView); overload;

function  MessageMemIniFile(Index: integer): string;
procedure SectionValueMemIniFile(const Section, Ident: PChar; pOutput: PChar); cdecl; overload;
function  SectionValueMemIniFile(const Section, Ident: string): string; overload;
procedure SubMessageMemIniFile(Index, SubIndex: integer; pOutput: PChar); cdecl; overload;
function  SubMessageMemIniFile(Index, SubIndex: integer): string; overload;

function  ReadLanguageFileName: WideString;
procedure LoadLanguage(const FileName: WideString);
procedure FreeLanguage;

implementation

var
  MemIniFile: TMemIniFile;

procedure ReadActionSectionData(ActionList: TActionList);
var
  i: integer;
  Action: TAction;
//  buffer: array[0..256] of char;
  s: string;
begin
  for i:=0 to ActionList.ActionCount-1 do
  begin
    Action:=TAction(ActionList.Actions[i]);
    s:=SectionValueMemIniFile(ActionList.Name, Action.Name);
    if s <> '' then
    begin
//      Action.Caption:=s;
      Action.Caption:=GetShortHint(s);
      Action.Hint:=GetLongHint(s);
    end;
  end;
end;

procedure ReadCaptionSectionData(ParentControl: TControl; ParentControlName: string);
var
  i: integer;
  objComp: TControl;
//  buffer: array[0..256] of char;
  s: String;
begin
  for i:=0 to ParentControl.ComponentCount-1 do
  begin
    objComp:=TControl(ParentControl.Components[i]);
    if Length(objComp.Name) <> 0 then
    begin
      s:=SectionValueMemIniFile(ParentControlName, objComp.Name);
//      s:=String(buffer);

      if s <> '' then
      begin
        //if objComp.ClassType = TButton then

        if objComp.ClassType = TTntMenuItem then
        begin
  //        s:=SLHolder.Values[SLHolder.Names[i]];
          TMenuItem(objComp).Caption:=s;//GetShortHint(strHold);
  //        TMenuItem(objComp).Hint:=GetLongHint(strHold);
        end
        else
        begin
          //objComp.Perform(WM_SETTEXT, 0, Longint(PChar(s)));
          //SendMessage(objComp.Handle, WM_SETTEXT, 0, Longint(PWideChar(s)));
          //SendMessage(objComp.Handle, WM_SETTEXT, 0, Longint(Buffer));
          //Perform(CM_TEXTCHANGED, 0, 0);
          objComp.SetTextBuf(PChar(s));
  //        strHold:=SLHolder.Values[SLHolder.Names[i]];
//          TControl(objComp).SetTextBuf(PChar(GetShortHint(s)));
//          TControl(objComp).Hint:=GetLongHint(s);
        end
      end;
    end;
  end;
end;

procedure ReadTreeSectionData(TreeControl: TTreeView);
var
  i: integer;
  Node: TTreeNode;
  s: string;
  p: Pointer;
begin
  for i:=0 to TreeControl.Items.Count-1 do
  begin
    Node:=TreeControl.Items[i];

    s:=SectionValueMemIniFile(TreeControl.Name, IntToStr(Node.SelectedIndex));
    if s <> '' then
    begin
      GetMem(p, Length(s)+1);
      StrCopy(p, PChar(s));
      Node.Data:=p;
    end;
  end;
end;

procedure ReadTreeSectionData(TreeControl: TTntTreeView);
var
  i: integer;
  Node: TTreeNode;
  s: string;
  p: Pointer;
begin
  for i:=0 to TreeControl.Items.Count-1 do
  begin
    Node:=TreeControl.Items[i];

    s:=SectionValueMemIniFile(TreeControl.Name, IntToStr(Node.SelectedIndex));
    if s <> '' then
    begin
      GetMem(p, Length(s)+1);
      StrCopy(p, PChar(s));
      Node.Data:=p;
    end;
  end;
end;

function  MessageMemIniFile(Index: integer): string;
begin
  Result:=MemIniFile.ReadString('Messages', IntToStr(Index), '');
end;

procedure SectionValueMemIniFile(const Section, Ident: PChar; pOutput: PChar);
var
  s: string;
begin
{$IFDEF DEBUG}
//  OutputDebugString(PChar(Format(#10'Global Procedure: SectionValueMemIniFile(Section:%s; Indent:%s)', [Section, Ident])));
{$ENDIF}
//  OutputDebugString(PChar(Format(#10'SectionValueMemIniFile: Section:%s Ident:%s',[Section, Ident])));
//  s:=MemIniFile.ReadString(Section, Ident, '');
  s:=SectionValueMemIniFile(Section, Ident);
//  AcUtUpdString(PChar(s), pOutput);
  StrCopy(pOutput, PChar(s));
{$IFDEF DEBUG}
//  OutputDebugString(PChar(Format(#10'Global Procedure: SectionValueMemIniFile(... pOutput:%s)', [pOutput])));
{$ENDIF}
end;

function SectionValueMemIniFile(const Section, Ident: string): string;
begin
  Result:=MemIniFile.ReadString(Section, Ident, '');
end;

procedure SubMessageMemIniFile(Index, SubIndex: integer; pOutput: PChar);
var
  subvalue: string;
begin
{$IFDEF DEBUG}
//  OutputDebugString(PChar(Format(#10'Global Procedure: MessageMemIniFile(Index:%d; SubIndex:%d; pOutput:%s %p)', [Index, SubIndex, String(pOutput), pOutput])));
{$ENDIF}
  subvalue:=SubMessageMemIniFile(Index, SubIndex);
  StrCopy(pOutput, PChar(subvalue));
end;

function SubMessageMemIniFile(Index, SubIndex: integer): string;
const
  Delimiter = ',';
  QuoteChar = '"';
var
  P, P1: PChar;
  S: string;
  counter: integer;
  Value: string;
  subvalue: string;
begin
    counter:=0;
//    Value:='"'+MemIniFile.ReadString('Messages', IntToStr(Index), '')+'"';
    Value:=MemIniFile.ReadString('Messages', IntToStr(Index), '');
    P := PChar(Value);

    while P^ in [#1..' '] do
      P := CharNext(P);

    while P^ <> #0 do
    begin
      if P^ = QuoteChar then
        S := AnsiExtractQuotedStr(P, QuoteChar)
      else
      begin
        P1 := P;
        while (P^ > ' ') and (P^ <> Delimiter) do
          P := CharNext(P);
        SetString(S, P1, P - P1);
      end;

      if SubIndex = counter then
      begin
        subvalue:=s;
        break;
      end;
      inc(counter);

      while P^ in [#1..' '] do
        P := CharNext(P);

      if P^ = Delimiter then
      begin
        P1 := P;
        if CharNext(P1)^ = #0 then
        subvalue:='';
        repeat
          P := CharNext(P);
        until not (P^ in [#1..' ']);
      end;
    end;//while

    Result:=subvalue;
end;

function  ReadLanguageFileName: WideString;
var
  //r: TTntRegistry;
  //q: boolean;
  o: TApplicationOption;
begin
  LoadApplicationOption(o);
  {r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;

    q:=LoadAlxdApplicationOption(r, o);
    if not q then
      Raise EOleError.CreateFmt('Loading AlxdApplicationOption keys failed! Some keys has invalid values.', []);

    Result:=o.LanguagePath + '\' + o.Language;
  finally
    r.Free;
  end;}
  //Result:='g:\Александр\Borland Studio Projects\AlxdGrid9\Language\atrus.ini'
  Result:=o.LanguagePath + '\' + o.Language;
end;

procedure LoadLanguage(const FileName: WideString);
//procedure CreateMemIniFile(const FileName: string);
begin
{$IFDEF DEBUG}
  OutputDebugString(#10'Localizer started!');
{$ENDIF}
  MemIniFile:=TMemIniFile.Create(FileName);
//  MemIniFile:=TIniFile.Create(FileName);
end;

procedure FreeLanguage;
//procedure FreeMemIniFile;
begin
{$IFDEF DEBUG}
  OutputDebugString(#10'Localizer stoped!');
{$ENDIF}
  MemInifile.Free;
end;

initialization
  LoadLanguage(ReadLanguageFileName);

finalization
  FreeLanguage;

end.
