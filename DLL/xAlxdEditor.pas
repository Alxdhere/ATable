unit xAlxdEditor;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdEditor = class(TAutoIntfObject, IAlxdEditor)
  protected
    procedure Close; safecall;
    procedure Open; safecall;
    function Get_AlxdSpreadSheets: AlxdSpreadSheets; safecall;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create; overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdEditor;

////////////////////////////////////////////////////////////////////////////////
//
//  Protected
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdEditor.Close;
begin
  FfrmEditor.Close;
end;

procedure TAlxdEditor.Open;
begin
  FfrmEditor.Open;
end;

function TAlxdEditor.Get_AlxdSpreadSheets: AlxdSpreadSheets;
begin
  Result:=FfrmEditor.FAlxdSpreadSheets;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdEditor.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdEditor.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdEditor.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdEditor.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdEditor.Create;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdEditor.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdEditor);
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdEditor.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdEditor.Destroy');
  {$ENDIF}
  inherited;
end;


end.
