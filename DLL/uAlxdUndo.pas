unit uAlxdUndo;

interface

uses
  Windows, Classes, TntClasses, SysUtils;

type
  TAlxdUndo = class(TComponent)
  private
    FStringList: TTntStringList;
    FActive: integer;
    FProceed: boolean;

    function  Get_Active: integer;
    function  Get_Count: integer;
    function  Get_Proceed: boolean;
  public
    property  Count: integer read Get_Count;
    property  Active: integer read Get_Active;
    property  Proceed: boolean read Get_Proceed;

    function Fix: boolean;
    function Undo: boolean;
    function Redo: boolean;

    function CanRedo: boolean;
    function CanUndo: boolean;

    procedure Reset;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  uAlxdSpreadSheet, uAlxdEditor;

function  TAlxdUndo.Get_Active: integer;
begin
  Result:=FActive;
end;

function  TAlxdUndo.Get_Count: integer;
begin
  Result:=FStringList.Count;
end;

function  TAlxdUndo.Get_Proceed: boolean;
begin
  Result:=FProceed;
end;

function TAlxdUndo.Fix: boolean;
var
  s: WideString;
begin
  Result:=False;
  with (Owner as TAlxdSpreadSheetInt) do
    if SaveToString(s) then
    begin
      if (Active > -1) and (Active < Count- 1) then
      while FStringList.Count > Active + 1 do
        FStringList.Delete(Active+1);

      FStringList.Add(s);
      FActive:=Count-1;
      Result:=true;

      FfrmEditor.ActionUpdate([]);
    end;
end;

function TAlxdUndo.Undo: boolean;
begin
  Result:=False;
  if CanUndo then
    with (Owner as TAlxdSpreadSheetInt) do
    begin
      FProceed:=true;
      Dec(FActive);
      Result:=LoadFromString(FStringList.Strings[FActive]);
      FProceed:=false;
    {if LoadFromString(FStringList.Strings[FActive]) then
    begin
      Dec(FActive);
      Result:=True;}
    end;
end;

function TAlxdUndo.Redo: boolean;
begin
  Result:=False;
  if CanRedo then
    with (Owner as TAlxdSpreadSheetInt) do
    begin
      FProceed:=true;
      Inc(FActive);
      Result:=LoadFromString(FStringList.Strings[FActive]);
      FProceed:=false;
    end;
end;

function TAlxdUndo.CanRedo: boolean;
begin
  Result:=(Count > 0) and (Active < Count - 1);
end;

function TAlxdUndo.CanUndo: boolean;
begin
  Result:=(Count > 0) and (Active > 0);
end;

procedure TAlxdUndo.Reset;
begin
  FStringList.Clear;
  FActive:=-1;
end;

constructor TAlxdUndo.Create(AOwner: TComponent);
begin
  inherited;
  FStringList:=TTntStringList.Create;
  FActive:=-1;
  FProceed:=false;
end;

destructor TAlxdUndo.Destroy;
begin
  FStringList.Free;
  inherited;
end;

end.
