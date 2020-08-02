unit xAlxdFill;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  Classes,  ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdFill = class(TAutoIntfObject, IAlxdFill)
  private
    FOwner: TComponent;
  protected
    function Get_PropertyByNum(Index: Integer): OleVariant; safecall;
    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant); safecall;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TComponent); overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdFill;

function TAlxdFill.Get_PropertyByNum(Index: Integer): OleVariant;
begin
  Result:=(FOwner as TAlxdFillInt).PropertyByNum[Index];
end;

procedure TAlxdFill.Set_PropertyByNum(Index: Integer; Value: OleVariant);
begin
  (FOwner as TAlxdFillInt).PropertyByNum[Index]:=Value;
end;

procedure TAlxdFill.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdFill.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdFill.Create(AOwner: TComponent);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdFill);
  FOwner:=AOwner;
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdFill.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.Destroy');
  {$ENDIF}
  inherited;
end;
{initialization
  TAutoObjectFactory.Create(ComServer, TAlxdFill, Class_AlxdFill,
    ciMultiInstance, tmApartment); }


end.
