unit xAlxdCell;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  Classes,  ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdCell = class(TAutoIntfObject, IAlxdCell)
  private
    FOwner: TComponent;
  protected
    function Get_Contain: WideString; safecall;
    procedure Set_Contain(const Value: WideString); safecall;
    function Get_PropertyByNum(Index: Integer): OleVariant; safecall;
    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant); safecall;
{  protected
    function Get_ColCount: Integer; safecall;
    function Get_RowCount: Integer; safecall;
    procedure Set_ColCount(Value: Integer); safecall;
    procedure Set_RowCount(Value: Integer); safecall;
    function Get_PropertyByNum(Index: Integer): OleVariant; safecall;
    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant); safecall;}
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TComponent); overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdCell;

function TAlxdCell.Get_Contain: WideString;
begin
  Result:=(FOwner as TAlxdCellInt).Contain;
end;

procedure TAlxdCell.Set_Contain(const Value: WideString);
begin
  (FOwner as TAlxdCellInt).Contain:=Value;
end;

function TAlxdCell.Get_PropertyByNum(Index: Integer): OleVariant;
begin
  Result:=(FOwner as TAlxdCellInt).PropertyByNum[Index];
end;

procedure TAlxdCell.Set_PropertyByNum(Index: Integer; Value: OleVariant);
begin
  (FOwner as TAlxdCellInt).PropertyByNum[Index]:=Value;
end;

procedure TAlxdCell.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdCell.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdCell.Create(AOwner: TComponent);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdCell);
  FOwner:=AOwner;
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdCell.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.Destroy');
  {$ENDIF}
  inherited;
end;


end.
