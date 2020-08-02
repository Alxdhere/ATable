unit uvclExport;

interface

uses
  Windows, SysUtils, TntWideStrUtils,
  uAlxdSystem, uAlxdLocalizer;

  //array function export
  function  vclGetLength(Value: TObjectIDs): integer; cdecl;
  procedure vclSetLength(var Value: TObjectIDs; NewLength: Integer); cdecl;
  procedure vclSetAt(var Value: TObjectIDs; Index, NewValue: Integer); cdecl;
  function  vclGetAt(Value: TObjectIDs; Index: Integer): Integer; cdecl;

  //string function export
  procedure vclUpdString(const pInput: PWideChar; var pOutput: WideString); cdecl;
  procedure vclDelString(var pString: WideString); cdecl;

  //message function export
  //function vclIndexedMessage(Index: integer): PWideString;
  //procedure vclIndexedMessage(Index: integer; Value: PWideChar); cdecl;
  procedure vclOPMName(Index: integer; Value: PWideChar); cdecl;
  procedure vclOPMDescription(Index: integer; Value: PWideChar); cdecl;

implementation

////////////////////////////////////////////////////////////////////////////////
//
//  array function export
//
////////////////////////////////////////////////////////////////////////////////

function  vclGetLength(Value: TObjectIDs): integer;
var
  c: integer;
begin
  c:=High(Value);
  if c < 0 then
    c:=0
  else
    c:=c+1;
  Result:=c;
end;

procedure vclSetLength(var Value: TObjectIDs; NewLength: Integer);
begin
  SetLength(Value, NewLength);
end;

procedure vclSetAt(var Value: TObjectIDs; Index, NewValue: Integer);
begin
  Value[Index]:=NewValue;
end;

function vclGetAt(Value: TObjectIDs; Index: Integer): Integer;
begin
  Result:=Value[Index];
end;

////////////////////////////////////////////////////////////////////////////////
//
//  string function export
//
////////////////////////////////////////////////////////////////////////////////

procedure vclUpdString(const pInput: PWideChar; var pOutput: WideString);
begin
  pOutput:=pInput;
end;

procedure vclDelString(var pString: WideString);
begin
  SetLength(pString, 0);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  message function export
//
////////////////////////////////////////////////////////////////////////////////

procedure vclOPMName(Index: integer; Value: PWideChar);
var
  s: string;
begin
  s:=SectionValueMemIniFile('tvStyleProperties', IntToStr(Index));
  {Value:=}TntWideStrUtils.WStrECopy(Value, PWideChar(WideString(s)));
end;

procedure vclOPMDescription(Index: integer; Value: PWideChar);
var
  s: string;
begin
  s:=SectionValueMemIniFile('tvStylePropertiesDescription', IntToStr(Index));
  {Value:=}TntWideStrUtils.WStrECopy(Value, PWideChar(WideString(s)));
end;


end.
