unit xAlxdBorders;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  Classes, ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdBorders = class(TAutoIntfObject, IAlxdBorders)
  private
    FOwner: TComponent;
  protected
    function Get_Items(Col, Row: Integer): AlxdBorder; safecall;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TComponent); overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdBorders;

function TAlxdBorders.Get_Items(Col, Row: Integer): AlxdBorder;
begin
  Result:=(FOwner as TAlxdBordersInt).Items[Col, Row].Intf;
end;

procedure TAlxdBorders.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdBorders.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdBorders.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdBorders.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdBorders.Create(AOwner: TComponent);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdBorders.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdBorders);
  FOwner:=AOwner;
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdBorders.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdBorders.Destroy');
  {$ENDIF}
  inherited;
end;

end.
