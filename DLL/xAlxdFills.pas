unit xAlxdFills;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  Classes, ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdFills = class(TAutoIntfObject, IAlxdFills)
  private
    FOwner: TComponent;
  protected
    function Get_Items(Col, Row: Integer): AlxdFill; safecall;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TComponent); overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdFills;

function TAlxdFills.Get_Items(Col, Row: Integer): AlxdFill;
begin
  Result:=(FOwner as TAlxdFillsInt).Items[Col, Row].Intf;
end;

procedure TAlxdFills.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdFills.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdFills.Create(AOwner: TComponent);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdFills);
  FOwner:=AOwner;
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdFills.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.Destroy');
  {$ENDIF}
  inherited;
end;

{initialization
  TAutoObjectFactory.Create(ComServer, TAlxdFills, Class_AlxdFills,
    ciMultiInstance, tmApartment);}

end.
