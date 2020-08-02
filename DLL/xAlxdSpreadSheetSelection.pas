unit xAlxdSpreadSheetSelection;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  Classes, ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdSpreadSheetSelection = class(TAutoIntfObject, IAlxdSpreadSheetSelection)
  private
    FOwner: TComponent;
  protected
    procedure MakeFromDrawingPoint(x, y: Double); safecall;
    function Get_Pointer: Integer; safecall;
    //function Get_Items(Col, Row: Integer): AlxdCell; safecall;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TComponent); overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdSpreadSheetSelection;

procedure TAlxdSpreadSheetSelection.MakeFromDrawingPoint(x, y: Double);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetSelection.MakeFromDrawingPoint');
  {$ENDIF}
  (FOwner as TAlxdSpreadSheetSelectionInt).MakeFromDrawingPoint(x, y);
end;

function TAlxdSpreadSheetSelection.Get_Pointer: Integer;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetSelection.Pointer');
  {$ENDIF}
  Result:=Longint(FOwner);
end;

procedure TAlxdSpreadSheetSelection.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetSelection.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdSpreadSheetSelection.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetSelection.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdSpreadSheetSelection.Create(AOwner: TComponent);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetSelection.Create');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdSpreadSheetSelection);
  FOwner:=AOwner;
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdSpreadSheetSelection.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetSelection.Destroy');
  {$ENDIF}
  inherited;
end;

{initialization
  TAutoObjectFactory.Create(ComServer, TAlxdSpreadSheetSelection, Class_AlxdSpreadSheetSelection,
    ciMultiInstance, tmApartment); }


end.
