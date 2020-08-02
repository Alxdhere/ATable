unit xAlxdCells;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  Classes, ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdCells = class(TAutoIntfObject, IAlxdCells)
  private
    FOwner: TComponent;
{  protected
    function Get_ColCount: Integer; safecall;
    function Get_RowCount: Integer; safecall;
    procedure Set_ColCount(Value: Integer); safecall;
    procedure Set_RowCount(Value: Integer); safecall;
    function Get_PropertyByNum(Index: Integer): OleVariant; safecall;
    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant); safecall;}
  protected
    function Get_Items(Col, Row: Integer): AlxdCell; safecall;

  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TComponent); overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdCells;

function TAlxdCells.Get_Items(Col, Row: Integer): AlxdCell;
begin
  Result:=(FOwner as TAlxdCellsInt).Items[Col, Row].Intf;
end;

procedure TAlxdCells.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdCells.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdCells.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdCells.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdCells.Create(AOwner: TComponent);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdCells.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdCells);
  FOwner:=AOwner;
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdCells.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdCells.Destroy');
  {$ENDIF}
  inherited;
end;

end.
