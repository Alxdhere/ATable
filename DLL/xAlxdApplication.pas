unit xAlxdApplication;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows,
  ComObj, Forms, SysUtils, ActiveX, AlxdGrid_TLB, StdVcl,
  uAlxdOptions, uAlxdEditor, uAlxdStyleManager, uAlxdStyleEditor,
  uAlxdSpreadSheetStyle, uoarxImport;

type
  TAlxdApplication = class(TAutoObject, IAlxdApplication)
  private
    FRegisterCode: Integer;
    procedure RegisterObject;
    procedure RevokeObject;
  protected
    procedure Quit; safecall;
    function Get_AlxdEditor: IAlxdEditor; safecall;
    function Get_AlxdStyleManager: IAlxdStyleManager; safecall;
    function Get_AlxdStyleEditor: IAlxdStyleEditor; safecall;
    function CreateAlxdSpreadSheetStyle: AlxdSpreadSheetStyle; safecall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses ComServ;

var
  FOldApp: HWND;

////////////////////////////////////////////////////////////////////////////////
//
//  Private
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdApplication.RegisterObject;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdApplication.RegisterObject');
  {$ENDIF}
  OleCheck(RegisterActiveObject(Self, Class_AlxdApplication, ACTIVEOBJECT_STRONG, FRegisterCode));
  CoLockObjectExternal(Self, true, true);
end;

procedure TAlxdApplication.RevokeObject;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdApplication.RevokeObject');
  {$ENDIF}
  CoLockObjectExternal(Self, false, true);
  if FRegisterCode <> 0 then
    OleCheck(RevokeActiveObject(FRegisterCode, nil));
  FRegisterCode:=0;
  CoDisconnectObject(Self, 0);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Protected
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdApplication.Quit;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdApplication.Quit');
  {$ENDIF}

  FfrmAlxdStyleManager.Free;
  FfrmAlxdStyleEditor.Free;
  FfrmEditor.Free;
  FvarOptions.Free;
  RevokeObject;
end;

function TAlxdApplication.Get_AlxdEditor: IAlxdEditor;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdApplication.Get_AlxdEditor');
  {$ENDIF}

  Result:=FfrmEditor;
end;

function TAlxdApplication.Get_AlxdStyleManager: IAlxdStyleManager;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdApplication.Get_AlxdStyleManager');
  {$ENDIF}

  Result:=FfrmAlxdStyleManager;
end;

function TAlxdApplication.Get_AlxdStyleEditor: IAlxdStyleEditor;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdApplication.Get_AlxdStyleEditor');
  {$ENDIF}

  Result:=FfrmAlxdStyleEditor;
end;

function TAlxdApplication.CreateAlxdSpreadSheetStyle: AlxdSpreadSheetStyle;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdApplication.CreateAlxdSpreadSheetStyle');
  {$ENDIF}
  Result:=TAlxdSpreadSheetStyleInt.Create(nil);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdApplication.Initialize;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdApplication.Initialize');
  {$ENDIF}
  inherited Initialize;
  DecimalSeparator:='.';

  RegisterObject;

  FvarOptions:=TAlxdSpreadSheetOptionsInt.Create(Application);
  FvarOptions.Load;

  FfrmEditor:=TfrmEditor.Create(Application);
  FfrmAlxdStyleEditor:=TfrmAlxdStyleEditor.Create(Application);
  FfrmAlxdStyleManager:=TfrmAlxdStyleManager.Create(Application);
end;

destructor TAlxdApplication.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdApplication.Destroy');
  {$ENDIF}
  inherited;
end;


initialization
  TAutoObjectFactory.Create(ComServer, TAlxdApplication, Class_AlxdApplication, ciMultiInstance, tmApartment);
  FOldApp:=Application.Handle;
  {$IFDEF DLL}
  Application.Handle:=adsw_acadMainWnd;
  {$ENDIF}

finalization
  Application.Handle := FOldApp;

end.
