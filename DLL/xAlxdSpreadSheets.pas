unit xAlxdSpreadSheets;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdSpreadSheets = class(TAutoIntfObject, IAlxdSpreadSheets)
  protected
    function Add: Integer; safecall;
    procedure Delete(Index: Integer); safecall;
    procedure Insert(Index: Integer); safecall;
    function Get_Count: Integer; safecall;
    function Get_Items(Index: Integer): IAlxdSpreadSheet; safecall;
    procedure Exchange(Index1, Index2: Integer); safecall;
    function Get_Active: Integer; safecall;
    procedure Set_Active(Value: Integer); safecall;
    function HasByDef(id: Integer): WordBool; safecall;
    function HasByRef(id: Integer): WordBool; safecall;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create; overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdEditor;

function TAlxdSpreadSheets.Add: Integer;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheets.Add');
  {$ENDIF}
  Result:=FfrmEditor.FAlxdSpreadSheets.Add;
end;

function TAlxdSpreadSheets.HasByDef(id: Integer): WordBool;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheets.HasByDef');
  {$ENDIF}
  Result:=FfrmEditor.FAlxdSpreadSheets.HasByDef(id);
end;

function TAlxdSpreadSheets.HasByRef(id: Integer): WordBool;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheets.HasByRef');
  {$ENDIF}
  Result:=FfrmEditor.FAlxdSpreadSheets.HasByRef(id);
end;

procedure TAlxdSpreadSheets.Delete(Index: Integer);
begin
  FfrmEditor.FAlxdSpreadSheets.Delete(Index);
end;

procedure TAlxdSpreadSheets.Insert(Index: Integer);
begin
  //FfrmEditor.FAlxdSpreadSheets.Insert(Index);
end;

function TAlxdSpreadSheets.Get_Count: Integer;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheets.Get_Count');
  {$ENDIF}
  Result:=FfrmEditor.FAlxdSpreadSheets.Count;
end;

function TAlxdSpreadSheets.Get_Items(Index: Integer): IAlxdSpreadSheet;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheets.Get_Items');
  {$ENDIF}
  Result:=FfrmEditor.FAlxdSpreadSheets.Items[Index];
end;

procedure TAlxdSpreadSheets.Exchange(Index1, Index2: Integer);
begin
//  FfrmEditor.FAlxdSpreadSheets.Exchange(Index1, Index2);
end;

function TAlxdSpreadSheets.Get_Active: Integer;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheets.Get_Active');
  {$ENDIF}
  Result:=FfrmEditor.FAlxdSpreadSheets.Active;
end;

procedure TAlxdSpreadSheets.Set_Active(Value: Integer);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheets.Set_Active');
  {$ENDIF}
  FfrmEditor.FAlxdSpreadSheets.Active:=Value;
end;

procedure TAlxdSpreadSheets.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheets.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdSpreadSheets.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheets.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdSpreadSheets.Create;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheets.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdSpreadSheets);
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdSpreadSheets.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheets.Destroy');
  {$ENDIF}
  inherited;
end;

end.
