unit xAlxdItems;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  Classes, ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdItems = class(TAutoIntfObject, IAlxdItems)
  private
    FOwner: TComponent;

  protected
    function Get_Items(Index: Integer): AlxdItem; safecall;
    function Get_Index(Coord: Double): Integer; safecall;
    function Get_Count: Integer; safecall;

  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TComponent); overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdItems;

function TAlxdItems.Get_Items(Index: Integer): AlxdItem;
begin
  Result:=(FOwner as TAlxdItemsInt).Items[Index].Intf;
end;

function TAlxdItems.Get_Index(Coord: Double): Integer;
begin
  Result:=(FOwner as TAlxdItemsInt).Index(Coord);
end;

function TAlxdItems.Get_Count: Integer;
begin
  Result:=(FOwner as TAlxdItemsInt).Count;
end;

procedure TAlxdItems.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdItems.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdItems.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdItems.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdItems.Create(AOwner: TComponent);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdItems.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdItems);
  FOwner:=AOwner;
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdItems.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdItems.Destroy');
  {$ENDIF}
  inherited;
end;


end.
