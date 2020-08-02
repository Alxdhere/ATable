unit xAlxdBorder;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  Classes,  ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdBorder = class(TAutoIntfObject, IAlxdBorder)
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

uses ComServ, uAlxdBorder;

function TAlxdBorder.Get_PropertyByNum(Index: Integer): OleVariant;
begin
  Result:=(FOwner as TAlxdBorderInt).PropertyByNum[Index];
end;

procedure TAlxdBorder.Set_PropertyByNum(Index: Integer; Value: OleVariant);
begin
  (FOwner as TAlxdBorderInt).PropertyByNum[Index]:=Value;
end;

procedure TAlxdBorder.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdBorder.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdBorder.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdBorder.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdBorder.Create(AOwner: TComponent);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdBorder.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdBorder);
  FOwner:=AOwner;
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdBorder.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdBorder.Destroy');
  {$ENDIF}
  inherited;
end;

end.
