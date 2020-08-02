unit uAlxdParsers;

interface

uses Math, SysUtils;

const TABSYM = #9;

{$RANGECHECKS OFF}
{
Грамматика формул
<cellformula>  ::= <=><expression>
<expression>   ::= <signed_term> [<addop> <term>]*
<signed_term>  ::= [<addop>] <term>
<term>         ::= <factor> [<mulop> <factor>]*
<addop>         ::= <+>|<->
<mulop>         ::= <*>|</>
<relop>         ::=<'='> | <'<>'> | <'<'> | <'>'> | <'<='> | <'>='>
<factor>        ::= <number> | <cell> | <function> | <(><expression><)>
<function>      ::= <ident> <'('> <param>[;<param>]* <')'>
//<param>         ::= <"><strconst><"> | <expression> | <range>
<param>         ::= <"><strconst><"> | <expression> [<relop> <expression>]| <range>
<ident>         ::= <letter> [ <letter> | <digit> ]*
//<cell>          ::=[<letter>]*<integer>
<cell>          ::=[$] [<letter>]* [$] <integer>
<range>         ::=<cell><:><cell>
<integer>       ::=[<digit>]+
<number>        ::= [<digit>]+ [<.>[<digit>]+]

      (Не забудьте, что "*" указывает на ноль или более повторений условия
       в квадратных скобках, а "+" на одно и более.)
}

{--------------------------------------------------------------}
type
  TGetCellValue=function(const ACell: String; var AValue: String): boolean of object;
  TGetRangeValues=function(const AStartCell, AEndCell: String; var AValue: String): boolean of object;
  TGetShiftedCell=function(const ACell: String; const DX, DY: integer; var AValue: String): boolean of object;
  TParserParams = record
    GetCellValue: TGetCellValue;
    GetRangeValues: TGetRangeValues;
    OutStr: String;
    ErrPos: Integer;
  end;
{--------------------------------------------------------------}
function ParseTextAssistToMText(inStr, ldelim, rdelim: String; var outStr: String): Integer;
function ParseMathToLisp(const InStr: String; var Params:TParserParams):boolean;
function IsDigit(c: char): boolean;

{--------------------------------------------------------------}
// Added 27.11.03 by Mamkin M.
//function ShiftCells(const InStr: String; var OutStr: String; dx, dy: integer; GetShiftedCell: TGetShiftedCell): boolean;
//procedure ShiftCells(const InStr: WideString; var OutStr: WideString; dx, dy: integer; GetShiftedCell: TGetShiftedCell); overload;
//procedure ShiftCells(const InStr: String; var OutStr: String; dx, dy: integer; GetShiftedCell: TGetShiftedCell); overload;
procedure ShiftCells(const InStr: String; var OutStr: String; dx, dy: integer; GetShiftedCell: TGetShiftedCell);
// Shifts all cell adresses by dx and dy values
// returns true if success
 
// ====== END =======

implementation

function ParseTextAssistToMText(inStr, ldelim, rdelim: String; var outStr: String): Integer;
var
  lastdir,newdir, posmax, cur, tmppos, inStrlen, ldelimlen, rdelimlen,
  posmin, APos, DelimPos, NextTokenPos, ElemCount: Integer;
  s1: String;
//-----------------------------------
  function ReverseStr(const s: String): String;
  var
    i, j, l:Integer;
  begin
    l := Length(s);
    j := l;
    SetLength(Result, l);
    for i:= 1 to l do
    begin
      Result[i] := s[j];
      Dec(j);
    end;
  end;
//-----------------------------------
  function CheckDelim(const delim:String):boolean;
  begin
    Result := Copy(inStr,tmppos, Length(delim)) = delim;
    if not(Result) then
      Exit;
    NextTokenPos := tmppos + Length(delim);
    DelimPos := tmppos;
  end;
//-----------------------------------
  procedure GetNextDelimPos;
  var
    l: Integer;
  begin
    tmppos := APos;
    newdir := 0;
    while true do
    begin
      l := inStrlen-tmppos+1;
      if l < Min(ldelimlen, rdelimlen) then
      begin
        DelimPos := inStrlen+1;
        NextTokenPos := 0;
      end else if CheckDelim(ldelim) then
        newdir := -1
      else if CheckDelim(rdelim) then
        newdir := 1
      else
      begin
        Inc(tmppos);
        continue;
      end;
      break;
    end;
  end;
//-----------------------------------
  procedure AddElem;
  begin
    if APos > inStrlen then
      Exit;
    s1 := Copy(inStr, APos, DelimPos-APos);
    if lastdir = 0 then outStr := s1
    else if lastdir=-1 then outStr:= s1 + TABSYM + outStr
    else outStr := outStr +  tabsym + s1;
    Inc(ElemCount);
  end;
//-----------------------------------
begin
//  Writeln('In: ',inStr);
  inStr:= ReverseStr(inStr);
  ldelim := ReverseStr(ldelim);
  rdelim := ReverseStr(rdelim);
  ldelimlen := Length(ldelim);
  rdelimlen := Length(rdelim);
  inStrlen := Length(inStr);
  ElemCount := 0;
  cur := 0;
  lastdir := 0;
  newdir := 0;
  posmax := -1;
  posmin := 1;
  NextTokenPos := 1;

  while true do
  begin
    APos := NextTokenPos;
    if APos=0 then
      break;
    Inc(cur,lastdir);
    GetNextDelimPos;
    if DelimPos = 1 then continue;
    if (cur >= posmin) and (cur <=posmax) then
      continue;
    AddElem;
    lastdir := newdir;
    posmin := min(posmin, cur);
    posmax := max(posmax, cur);
  end;
  Result := ElemCount;

  outStr := ReverseStr(outStr);
//  Writeln('Out: ',outStr, ' ElemCount: ', ElemCount);
end;

////////////////////////////////////////////////////////////////////////////////
//
//
//  Math To Lisp
//
//
////////////////////////////////////////////////////////////////////////////////

{--------------------------------------------------------------}
procedure Expected(const str: String);
begin
  raise Exception.CreateFmt('%s expected',[str]);
end;
{--------------------------------------------------------------}
{ Scanner part }
function IsAlpha(c: char): boolean;
begin
// Result := UpCase(c) in ['A'..'Z'];
 Result := UpCase(c) in ['A'..'Z', '$', '?'];
end;
{--------------------------------------------------------------}
function IsDigit(c: char): boolean;
begin
 Result := c in ['0'..'9'];
end;
{--------------------------------------------------------------}
function IsAlnum(c: char): boolean;
begin
 Result := IsAlpha(c) or IsDigit(c);
end;
{--------------------------------------------------------------}
function IsAddop(c: char): boolean;
begin
 Result := c in ['+','-'];
end;
{--------------------------------------------------------------}
function IsRelop(c: char): boolean;
begin
 Result := c in ['<','>','='];
end;
{--------------------------------------------------------------}
function IsMulop(c: char): boolean;
begin
 Result := c in ['*','/'];
end;
{---------------------------------------------------------------}
function ParseMathToLisp(const InStr: String; var Params:TParserParams): boolean;
var
  ScanPos: Integer;
  Look: Char;
{---------------------------------------------------------------}
procedure GetChar;
begin
  if ScanPos>Length(Instr)+1 then
    raise Exception.Create('Out of string bounds');
  Look:=InStr[ScanPos];
  Inc(ScanPos);
end;
{---------------------------------------------------------------}
{ Skip Over Leading White Space }
procedure SkipWhite;
begin
   while Look = ' ' do
      GetChar;
end;
{---------------------------------------------------------------}
procedure Match(x: char);
begin
  if Look = x then
    GetChar
  else
    Expected(''' '+x+' ''');
  SkipWhite;
end;
{--------------------------------------------------------------}
function GetStrConst: String;
begin
  Match('"');
  Result:='';
  while Look<>'"' do
  begin
    if Look = #0 then
      Raise Exception.Create(''' " '' expected');
    Result:=Result+Look;
    GetChar;
  end;
  Match('"');
end;
{--------------------------------------------------------------}
{ Get an Identifier }
function GetName: string;
begin
 Result := '';
 if not IsAlpha(Look) then Expected('Name');
 while IsAlnum(Look) do begin
  Result := Result + UpperCase(Look);
  GetChar;
 end;
 SkipWhite;
end;
{--------------------------------------------------------------}
{ Get a Number }
function GetNumber: string;
begin
 result := '';
 if not IsDigit(Look) then Expected('number');
 while IsDigit(Look) do begin
  Result := Result + Look;
  GetChar;
 end;
 if Look = '.' then
 begin
   Result := Result + Look;
   Match('.');
   while IsDigit(Look) do begin
    Result := Result + Look;
    GetChar;
   end;
 end;
 SkipWhite;
end;
{--------------------------------------------------------------}
function Expression: string; forward;
function FuncParams: String; forward;
{--------------------------------------------------------------}
function Param: String;
var s1, s2: String;
  SavedPos: Integer;
begin
  if (Look = ')') or (Look = #0) then
    Raise Exception.Create('Error in expression');
  if Look='"' then
  begin
    Result:='"'+GetStrConst+'"';
    Exit;
  end;
  if IsAlpha(Look) then
  begin
    SavedPos := ScanPos;
    s1:=GetName;
    if Look = ':' then
    begin
      Match(':');
      s2 := GetName;
      if not Params.GetRangeValues(s1, s2, Result) then
        Raise Exception.Create('Error getting range values');
      Exit;
    end;
    ScanPos:=SavedPos-1;
    GetChar;
  end;
  Result:= Expression;
  if IsRelOp(Look) then
  begin
    s1:= Look;
    GetChar;
    if IsRelOp(Look) then
    begin
      s1:= s1+Look;
      if not((s1 = '>=') or (s1 = '<=') or (s1 = '<>')) then
        Raise Exception.Create('Error in expression');
      if s1='<>' then s1 :='/=';
      GetChar;
      SkipWhite;
    end else
      SkipWhite;
    Result:= '('+ s1 + ' ' + Result + ' ' + Expression + ')';
  end;
end;
{---------------------------------------------------------------}
function FuncParams: String;
begin
if Look = ')' then
   Exit;
Result:=Param;
while Look=';' do
begin
  Match(';');
  Result := Result + ' ' + Param;
end;
end;
{---------------------------------------------------------------}
function Factor: String;
var
  s: String;
begin
  if Look = '(' then
  begin
    Match('(');
    Result := Expression;
    Match(')');
  end else if IsAlpha(Look) then
  begin
    s := GetName;
    if Look = '(' then
    begin
      Match('(');
      Result :='(' + s +' ' + FuncParams + ')';
      Match(')');
    end else
    begin
      if @Params.GetCellValue<>nil then
//        if Params.GetCellValue(s, Result)=false then
        if Params.GetCellValue(StringReplace(s, '$', '',[rfReplaceAll]), Result)=false then
          Raise Exception.CreateFmt('Error getting cell ''%s'' value',[s]);
    end;
  end
  else
    Result := GetNumber;
end;
{---------------------------------------------------------------}
function Term: String;
var MulOp: Char;
begin
   Result := Factor;
   while IsMulOp(Look) do begin
     MulOp:=Look;
     GetChar;
     SkipWhite;
     Result:=Format('(%s %s %s)',[MulOp, Result, Factor]);
   end;
end;
{---------------------------------------------------------------}
{ Parse and Translate an Expression }
function Expression: string;
var
  Sign: Char;
begin
  Sign := Look;
  if IsAddop(Look) then
    GetChar;
  if Sign = '-' then
    Result:='(- '+Term+')'
  else
    Result:=Term;
  while IsAddop(Look) do begin
    Sign:=Look;
    GetChar;
    SkipWhite;
    Result := Format('(%s %s %s)',[Sign, Result, Term]);
  end;
end;
{--------------------------------------------------------------}
begin
  Params.OutStr:='';
  ScanPos:=1;
  try
    if Length(Instr) = 0 then
      Expected('''=''');
    GetChar;
    Match('=');
    SkipWhite;
    Params.OutStr:=Expression;
    if Look = ')' then
      Raise Exception.Create('Extra right paren');
    if Look <> #0 then
      Raise Exception.Create('Error in expression');
    Params.ErrPos:=0;
    result:=true;
  except
  on E: Exception do begin
    Params.ErrPos:=ScanPos-1;
    Params.OutStr:=E.Message;
    result:=false;
  end;
  end;
end;

// Added 27.11.03 by Mamkin M.
type
 TshState = (shWait, shStrConst, shIdent);
var
  s_cur: String;

//function ShiftCells(const InStr: String; var OutStr: String; dx, dy: integer; GetShiftedCell: TGetShiftedCell): boolean;
{
procedure ShiftCells(const InStr: WideString; var OutStr: WideString; dx, dy: integer; GetShiftedCell: TGetShiftedCell);
var
  sInStr: string;
  sOutStr: string;
begin
  sInStr:=InStr;
  sOutStr:=OutStr;
  ShiftCells(sInStr, sOutStr, dx, dy, GetShiftedCell);
  OutStr:=sOutStr;
end;
}
procedure ShiftCells(const InStr: String; var OutStr: String; dx, dy: integer; GetShiftedCell: TGetShiftedCell);
var
  state: TshState;
  n, ln: Integer;
  ch: Char;

  procedure ShiftCell;
//  var
//    r: string;
  begin
    if @GetShiftedCell <> nil then
      if GetShiftedCell(UpperCase(s_cur), dx, dy, s_cur)=false then
        Raise Exception.CreateFmt('Error shift cell ''%s''value',[s_cur])
  // TODO
  // take "s_cur" value and add dx to "column" part
  // and add dy to "row" part
  // example : dx = 2; dy = -3; A5 -> C2; Z10 -> AA7
  end;

begin
  state := shWait;
  s_cur:='';
  OutStr:='';
  n := 1;
  ln := Length(InStr);
  while n<=ln do
  begin
    ch := InStr[n];

    if state = shWait then
    begin // --
      if ch = '"' then
      begin
        state := shStrConst;
        OutStr := OutStr + ch;
      end
      else if IsAlpha(ch) then
      begin
        state := shIdent;
        s_cur := ch;
      end else
      begin
        OutStr := OutStr + ch;
      end;
    end  // --
    else if state = shStrConst then
    begin // --
      if ch = '"' then
      begin
        state := shWait;
      end;
      OutStr := OutStr + ch;
    end  // --
    else if state = shIdent then
    begin
      if ch = '(' then
      begin
        OutStr := OutStr + s_cur + ch;
        SetLength(s_cur,0);
        state := shWait;
      end else if IsAlnum(ch) then
      begin
        s_cur := s_cur + ch;
      end else
      begin
        state := shWait;
        ShiftCell;
        OutStr := OutStr + s_cur + ch;
        SetLength(s_cur,0);
      end;
    end;
    Inc(n);
  end; // while
  if state = shIdent then
  begin
    ShiftCell;
    OutStr := OutStr + s_cur;
  end;  
end;

// ====== END =======
{--------------------------------------------------------------}


end.
