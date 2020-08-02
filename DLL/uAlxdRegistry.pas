unit uAlxdRegistry;

interface

uses Windows, Forms, Graphics, TntExtCtrls, ActnList,
     IniFiles, uoarxImport, TntRegistry, SysUtils, uAlxdSystem, TntSysUtils;

const
  REGATABLEKEY = '\Software\Alxd\ATable 8.x';

function  ReadInteger(Reg: TTntRegistry; const Name: String; Default: integer): integer;
function  ReadFloat(Reg: TTntRegistry; const Name: String; Default: double): double;
function  ReadString(Reg: TTntRegistry; const Name: String; Default: string): string;
function  ReadWideString(Reg: TTntRegistry; const Name: String; Default: WideString): WideString;
function  ReadBool(Reg: TTntRegistry; const Name: String; Default: boolean): boolean;

function  LoadPos(Reg: TTntRegistry; Form: TForm; Prefix: string): boolean;
function  LoadSize(Reg: TTntRegistry; Form: TForm; Prefix: string): boolean;

procedure LoadShortcuts(Reg: TTntRegistry; ActionList: TActionList);
procedure LoadToolbars(Reg: TTntRegistry; ControlBar: TTntControlBar; var NumTag, MarTag: integer);

procedure SavePos(Reg: TTntRegistry; Form: TForm; Prefix: string);
procedure SaveSize(Reg: TTntRegistry; Form: TForm; Prefix: string);

procedure SaveShortcuts(Reg: TTntRegistry; ActionList: TActionList);
procedure SaveToolbars(Reg: TTntRegistry; ControlBar: TTntControlBar; NumTag, MarTag: integer);

procedure LoadApplicationOption(var Value: TApplicationOption);
procedure LoadStyleManagerOption(var Value: TStyleManagerOption);
procedure LoadSpreadSheetOption(var Value: TSpreadSheetOption);

procedure FlushApplicationOption(Value: TApplicationOption);
procedure FlushStyleManagerOption(Value: TStyleManagerOption);
procedure FlushSpreadSheetOption(Value: TSpreadSheetOption);

implementation

function ReadInteger(Reg: TTntRegistry; const Name: String; Default: integer): integer;
begin
  Result:=Default;
  if Reg.ValueExists(Name) then
    Result:=Reg.ReadInteger(Name)
  else
  begin
    Reg.WriteInteger(Name, Default);
    //WideFormat('test');
    //oarxAcUtPrintf(Format(Tnt_WideFormat(#10'Created key: %s=%d', [Name, Default]));
    {$IFDEF DLL}
    //oarxAcUtPrintf(WideString(Format(#10'Created key: %s=%d', [Name, Default])));
    oarxAcUtPrintf(WideFormat(#10'Created key: %s=%d', [Name, Default]));
    {$ENDIF DLL}
  end;
end;

function ReadFloat(Reg: TTntRegistry; const Name: String; Default: double): double;
begin
  Result:=Default;
  if Reg.ValueExists(Name) then
    Result:=Reg.ReadFloat(Name)
  else
  begin
    Reg.WriteFloat(Name, Default);
    //AlxdPrintf(PChar(String(Tnt_WideFormat(#10'Created key: %s=%f', [Name, Default]))));
    {$IFDEF DLL}
    oarxAcUtPrintf(WideFormat(#10'Created key: %s=%f', [Name, Default]));
    {$ENDIF DLL}
  end;
end;

function ReadString(Reg: TTntRegistry; const Name: String; Default: string): string;
begin
  Result:=Default;
  if Reg.ValueExists(Name) then
    Result:=Reg.ReadString(Name)
  else
  begin
    Reg.WriteString(Name, Default);
    //AlxdPrintf(PChar(String(Tnt_WideFormat(#10'Created key: %s=%s', [Name, Default]))));
    {$IFDEF DLL}
    oarxAcUtPrintf(WideFormat(#10'Created key: %s=%s', [Name, Default]));
    {$ENDIF DLL}
  end;
end;

function ReadWideString(Reg: TTntRegistry; const Name: String; Default: WideString): WideString;
begin
  Result:=Default;
  if Reg.ValueExists(Name) then
    Result:=Reg.ReadString(Name)
  else
  begin
    Reg.WriteString(Name, Default);
    //AlxdPrintf(PChar(String(Tnt_WideFormat(#10'Created key: %s=%s', [Name, String(Default)]))));
    {$IFDEF DLL}
    oarxAcUtPrintf(WideFormat(#10'Created key: %s=%s', [Name, Default]));
    {$ENDIF DLL}
  end;
end;

function ReadBool(Reg: TTntRegistry; const Name: String; Default: boolean): boolean;
begin
  Result:=Default;
  if Reg.ValueExists(Name) then
    Result:=Reg.ReadBool(Name)
  else
  begin
    Reg.WriteBool(Name, Default);
    //AlxdPrintf(PChar(String(Tnt_WideFormat(#10'Created key: %s=%d', [Name, Integer(Default)]))));
    {$IFDEF DLL}
    oarxAcUtPrintf(WideFormat(#10'Created key: %s=%d', [Name, Integer(Default)]));
    {$ENDIF DLL}
  end;
end;

function LoadPos(Reg: TTntRegistry; Form: TForm; Prefix: string): boolean;
begin
  reg.OpenKey(REGATABLEKEY+'\Positions', True);
  with Form do
  begin
    Left:=ReadInteger(Reg, Prefix + 'Left', Left);
    Top:=ReadInteger(Reg, Prefix + 'Top', Top);
    //Width:=ReadInteger(Reg, Prefix + 'Width', Width);
    //Height:=ReadInteger(Reg, Prefix + 'Height', Height);

    if Width > Screen.Width then Width:=Screen.Width;
    if Height > Screen.Height then Height:=Screen.Height;
    if Left < 0 then Left:=0;
    if Left+Width > Screen.Width then Left:=Screen.Width - Width;
    if Top < 0 then Top:=0;
    if Top+Height > Screen.Height then Top:=Screen.Height - Height;
  end;
  Result:=True;
end;

function LoadSize(Reg: TTntRegistry; Form: TForm; Prefix: string): boolean;
begin
  reg.OpenKey(REGATABLEKEY+'\Sizes', True);
  with Form do
  begin
    Width:=ReadInteger(Reg, Prefix + 'Width', Width);
    Height:=ReadInteger(Reg, Prefix + 'Height', Height);

    if Width > Screen.Width then Width:=Screen.Width;
    if Height > Screen.Height then Height:=Screen.Height;
  end;
  Result:=True;
end;

procedure LoadShortcuts(Reg: TTntRegistry; ActionList: TActionList);
var
  i: integer;
begin
  if reg.OpenKey(REGATABLEKEY+'\Shortcuts', True) then
    for i:=0 to ActionList.ActionCount-1 do
      TAction(ActionList[i]).ShortCut:=ReadInteger(Reg, ActionList[i].Name, TAction(ActionList[i]).ShortCut);
end;

procedure LoadToolbars(Reg: TTntRegistry; ControlBar: TTntControlBar; var NumTag, MarTag: integer);
var
  i: integer;
begin
  if reg.OpenKey(REGATABLEKEY+'\Toolbars', True) then
  begin
    with ControlBar do
    for i:=0 to ControlCount-1 do
    begin
      Controls[i].Visible:=ReadBool(Reg, Controls[i].Name+'Visible', Controls[i].Visible);
      Controls[i].Left:=ReadInteger(Reg, Controls[i].Name+'Left', Controls[i].Left);
      Controls[i].Top:=ReadInteger(Reg, Controls[i].Name+'Top', Controls[i].Top);
    end;
    NumTag:=ReadInteger(Reg, 'tbNumPropertyAction', 220);
    MarTag:=ReadInteger(Reg, 'tbMarginAction', 230);
  end;
end;

procedure SavePos(Reg: TTntRegistry; Form: TForm; Prefix: string);
begin
  reg.OpenKey(REGATABLEKEY+'\Positions',True);
  with Form do
  begin
    reg.WriteInteger(Prefix + 'Left', Left);
    reg.WriteInteger(Prefix + 'Top', Top);
    //reg.WriteInteger(Prefix + 'Width', Width);
    //reg.WriteInteger(Prefix + 'Height', Height);
  end;
end;

procedure SaveSize(Reg: TTntRegistry; Form: TForm; Prefix: string);
begin
  reg.OpenKey(REGATABLEKEY+'\Sizes',True);
  with Form do
  begin
    reg.WriteInteger(Prefix + 'Width', Width);
    reg.WriteInteger(Prefix + 'Height', Height);
  end;
end;

procedure SaveShortcuts(Reg: TTntRegistry; ActionList: TActionList);
var
  i: integer;
begin
  reg.OpenKey(REGATABLEKEY+'\Shortcuts',True);
  for i:=0 to ActionList.ActionCount-1 do
    Reg.WriteInteger(ActionList[i].Name, TAction(ActionList[i]).ShortCut);
end;

procedure SaveToolbars(Reg: TTntRegistry; ControlBar: TTntControlBar; NumTag, MarTag: integer);
var
  i: integer;
begin
  reg.OpenKey(REGATABLEKEY+'\Toolbars',True);
  for i:=0 to ControlBar.ControlCount-1 do
  begin
    Reg.WriteBool(ControlBar.Controls[i].Name+'Visible',ControlBar.Controls[i].Visible);
    Reg.WriteInteger(ControlBar.Controls[i].Name+'Left',ControlBar.Controls[i].Left);
    Reg.WriteInteger(ControlBar.Controls[i].Name+'Top',ControlBar.Controls[i].Top);
  end;
  reg.WriteInteger('tbNumPropertyAction', NumTag);
  reg.WriteInteger('tbMarginAction', MarTag);
end;

procedure TestWideStringValue(Name: string; Value: WideString; Condition: boolean);
begin
  if not Condition then
  begin
    {$IFDEF DLL}
    oarxAcUtPrintf(WideFormat(#10'Key has invalid value: %s=%s', [Name, Value]));
    {$ENDIF DLL}
    //AlxdPrintf(PChar(String(Tnt_WideFormat(#10'Key has invalid value: %s=%s', [Name, String(Value)]))));
  end;
end;

procedure LoadApplicationOption(var Value: TApplicationOption);
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;
    r.OpenKey(REGATABLEKEY+'\Application', True);

    Value.LanguagePath:=ReadWideString(r, 'LanguagePath', WideExtractFileDir(WideGetModuleFileName(hInstance)) + '\Language');
    TestWideStringValue('LanguagePath', Value.LanguagePath, WideDirectoryExists(Value.LanguagePath));

    Value.Language:=ReadWideString(r, 'Language', 'ateng.ini');
    TestWideStringValue('Language', Value.Language, WideFileExists(WideIncludeTrailingBackslash(Value.LanguagePath) + Value.Language));

    Value.UseDynamicProperties:=ReadBool(r, 'UseDynamicProperties', True);

    Value.Transparency:=ReadBool(r, 'Transparency', false);
    Value.TransparencyValue:=ReadInteger(r, 'TransparencyValue', 210);
//    Result:=WideFileExists(WideIncludeTrailingBackslash(LanguagePath) + Language);
  finally
    r.Free;
  end;
end;

procedure LoadStyleManagerOption(var Value: TStyleManagerOption);
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;
    r.OpenKey(REGATABLEKEY+'\StyleManager', True);
    Value.StylePath:=ReadWideString(R, 'StylePath', WideExtractFileDir(WideGetModuleFileName(hInstance)) + '\Styles');
    Value.StyleCurrent:=ReadWideString(R, 'StyleCurrent', '');

  finally
    r.Free;
  end;
end;

procedure LoadSpreadSheetOption(var Value: TSpreadSheetOption);
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;
    r.OpenKey(REGATABLEKEY+'\SpreadSheet', True);

    Value.FontSize:=ReadInteger(r, 'FontSize', 8);
    Value.FontName:=ReadWideString(r, 'FontName', 'Tahoma');
    TestWideStringValue('FontName', Value.FontName, (Screen.Fonts.IndexOf(Value.FontName) >= 0));

    Value.FixedColWidth:=ReadInteger(r, 'FixedColWidth', 60);
    Value.FixedRowHeight:=ReadInteger(r, 'FixedRowHeight', 50);
    Value.PixelToMmX:=ReadFloat(r, 'PixelToMmX', 3.0);
    Value.PixelToMmY:=ReadFloat(r, 'PixelToMmY', 3.0);

    Value.FixedColor:=ReadInteger(r, 'FixedColor', clBtnFace);
    Value.FixedLineColor:=ReadInteger(r, 'FixedLineColor', clGray);
    Value.SelectionColor:=ReadInteger(r, 'SelectionColor', clSkyBlue);
    Value.DrawingSelectionColor:=ReadInteger(r, 'DrawingSelectionColor', -1);

    Value.DirectionTab:=TAlxdDirectionTab(ReadInteger(r, 'DirectionTab', Ord(dtLeft2Right)));
    Value.DirectionEnter:=TAlxdDirectionEnter(ReadInteger(r, 'DirectionEnter', Ord(deDown)));
    Value.DrawHidedBorders:=ReadBool(r, 'DrawHidedBorders', False);
    Value.ExitOnEnter:=ReadBool(r, 'ExitOnEnter', False);
    Value.WordWrap:=ReadBool(r, 'WordWrap', False);
    Value.SyncDelay:=ReadInteger(r, 'SyncDelay', 250);
  finally
    r.Free;
  end;
end;

procedure FlushApplicationOption(Value: TApplicationOption);
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;
    r.OpenKey(REGATABLEKEY+'\Application', True);
    r.WriteString('LanguagePath', Value.LanguagePath);
    r.WriteString('Language', Value.Language);
    r.WriteBool('UseDynamicProperties', Value.UseDynamicProperties);
    r.WriteBool('Transparency', Value.Transparency);
    r.WriteInteger('TransparencyValue', Value.TransparencyValue);

  finally
    r.Free;
  end;
end;

procedure FlushStyleManagerOption(Value: TStyleManagerOption);
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;
    r.OpenKey(REGATABLEKEY+'\StyleManager',True);
    r.WriteString('StylePath', Value.StylePath);
    r.WriteString('StyleCurrent', Value.StyleCurrent);

  finally
    r.Free;
  end;
end;

procedure FlushSpreadSheetOption(Value: TSpreadSheetOption);
var
  r: TTntRegistry;
begin
  r:=TTntRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;
    r.OpenKey(REGATABLEKEY+'\SpreadSheet', True);
    r.WriteInteger('FontSize', Value.FontSize);
    r.WriteString('FontName', Value.FontName);
    r.WriteInteger('FixedColWidth', Value.FixedColWidth);
    r.WriteInteger('FixedRowHeight', Value.FixedRowHeight);
    r.WriteFloat('PixelToMmX', Value.PixelToMmX);
    r.WriteFloat('PixelToMmY', Value.PixelToMmY);
    r.WriteInteger('FixedColor', Value.FixedColor);
    r.WriteInteger('FixedLineColor', Value.FixedLineColor);
    r.WriteInteger('SelectionColor', Value.SelectionColor);
    r.WriteInteger('DrawingSelectionColor', Value.DrawingSelectionColor);
    r.WriteInteger('DirectionTab', Ord(Value.DirectionTab));
    r.WriteInteger('DirectionEnter', Ord(Value.DirectionEnter));
    r.WriteBool('DrawHidedBorders', Value.DrawHidedBorders);
    r.WriteBool('ExitOnEnter', Value.ExitOnEnter);
    r.WriteBool('WordWrap', Value.WordWrap);
    r.WriteInteger('SyncDelay', Value.SyncDelay);

  finally
    r.Free;
  end;
end;


end.
