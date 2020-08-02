unit xAlxdStyleManager;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdStyleManager = class(TAutoIntfObject, IAlxdStyleManager)
  protected
    function Select(var Value: WideString): Integer; safecall;
    procedure Show; safecall;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create; overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdStyleManager;

function TAlxdStyleManager.Select(var Value: WideString): Integer;
begin
  Result:=FfrmAlxdStyleManager.Select(Value);
end;

procedure TAlxdStyleManager.Show;
begin
  FfrmAlxdStyleManager.Show;
end;

procedure TAlxdStyleManager.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdStyleManager.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdStyleManager.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdStyleManager.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdStyleManager.Create;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdStyleManager.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdStyleManager);
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdStyleManager.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdStyleManager.Destroy');
  {$ENDIF}
  inherited;
end;

{initialization
  TAutoObjectFactory.Create(ComServer, TAlxdStyleManager, Class_AlxdStyleManager,
    ciMultiInstance, tmApartment);}
end.
