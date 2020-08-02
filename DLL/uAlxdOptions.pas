unit uAlxdOptions;

interface

uses
  Windows, Classes, Graphics, TntRegistry, uAlxdSystem, uAlxdRegistry,
  TypInfo, TntClasses, TntSysUtils, SysUtils, IniFiles;

const
  AlxdOptionValues: array[0..22] of string =
    ('Language', 'LanguagePath', 'Transparency', 'TransparencyValue', 'UseDynamicProperties',
     'FontName', 'FontSize', 'FixedColor', 'FixedLineColor', 'FixedColWidth', 'FixedRowHeight', 'PixelToMmX', 'PixelToMmY', 'SelectionColor', 'DrawingSelectionColor',
     'StylePath', 'StyleCurrent',
     'DirectionTab', 'DirectionEnter', 'DrawHidedBorders', 'ExitOnEnter', 'WordWrap', 'SyncDelay');

type
  TAlxdSpreadSheetOptionsInt = class(TComponent)
  private

    FApplicationOption: TApplicationOption;
    FStyleManagerOption: TStyleManagerOption;
    FSpreadSheetOption: TSpreadSheetOption;
    FFindOption: TFind;
    //FStylePath: WideString;
    //FStyleCurrent: WideString;

    procedure Set_FontName(Value: WideString);
    procedure Set_FontSize(Value: Integer);
    procedure Set_LanguagePath(Value: WideString);
    procedure Set_Transparency(Value: boolean);
    procedure Set_TransparencyValue(Value: Integer);

    procedure Set_FixedColor(Value: TColor);
    procedure Set_FixedLineColor(Value: TColor);
    procedure Set_FixedColWidth(Value: integer);
    procedure Set_FixedRowHeight(Value: integer);
    procedure Set_PixelToMmX(Value: double);
    procedure Set_PixelToMmY(Value: double);
    procedure Set_SelectionColor(Value: TColor);
    procedure Set_DrawingSelectionColor(Value: integer);

    procedure Set_StylePath(Value: WideString);
    procedure Set_StyleCurrent(Value: WideString);

    procedure Set_DirectionTab(Value: TAlxdDirectionTab);
    procedure Set_DirectionEnter(Value: TAlxdDirectionEnter);
    procedure Set_DrawHidedBorders(Value: boolean);
    procedure Set_SyncDelay(Value: integer);

    function  GetLanguageTitle(const FileName: WideString): WideString;

  public
    property Find: TFind read FFindOption write FFindOption;
    property FindOffset: integer read FFindOption.FindOffset write FFindOption.FindOffset;
    property FindCell: TPoint read FFindOption.FindCell write FFindOption.FindCell;
    property FindPos: integer read FFindOption.FindPos write FFindOption.FindPos;
    property FindLen: integer read FFindOption.FindLen write FFindOption.FindLen;
    property FindUseCase: boolean read FFindOption.FindUseCase write FFindOption.FindUseCase;
    property FindUseReplace: boolean read FFindOption.FindUseReplace write FFindOption.FindUseReplace;

//    procedure LoadApplicationOption;
//    procedure LoadStyleManagerOption;
//    procedure FlushStyleManagerOption;
    procedure Load;
    procedure LoadLanguages(List: TTntStrings);

    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Language: WideString read FApplicationOption.Language write FApplicationOption.Language;
    property LanguagePath: WideString read FApplicationOption.LanguagePath write Set_LanguagePath;

    property Transparency: boolean read FApplicationOption.Transparency write Set_Transparency;
    property TransparencyValue: integer read FApplicationOption.TransparencyValue write Set_TransparencyValue;
    property UseDynamicProperties: boolean read FApplicationOption.UseDynamicProperties write FApplicationOption.UseDynamicProperties;

    property FontName: WideString read FSpreadSheetOption.FontName write Set_FontName;
    property FontSize: integer read FSpreadSheetOption.FontSize write Set_FontSize;

    property FixedColor: TColor read FSpreadSheetOption.FixedColor write Set_FixedColor;
    property FixedLineColor: TColor read FSpreadSheetOption.FixedLineColor write Set_FixedLineColor;
    property FixedColWidth: integer read FSpreadSheetOption.FixedColWidth write Set_FixedColWidth;
    property FixedRowHeight: integer read FSpreadSheetOption.FixedRowHeight write Set_FixedRowHeight;
    property PixelToMmX: double read FSpreadSheetOption.PixelToMmX write Set_PixelToMmX;
    property PixelToMmY: double read FSpreadSheetOption.PixelToMmY write Set_PixelToMmY;
    property SelectionColor: TColor read FSpreadSheetOption.SelectionColor write Set_SelectionColor;
    property DrawingSelectionColor: integer read FSpreadSheetOption.DrawingSelectionColor write Set_DrawingSelectionColor;

    property StylePath: WideString read FStyleManagerOption.StylePath write Set_StylePath;
    property StyleCurrent: WideString read FStyleManagerOption.StyleCurrent write Set_StyleCurrent;

    property DirectionTab: TAlxdDirectionTab read FSpreadSheetOption.DirectionTab write Set_DirectionTab;
    property DirectionEnter: TAlxdDirectionEnter read FSpreadSheetOption.DirectionEnter write Set_DirectionEnter;
    property DrawHidedBorders: boolean read FSpreadSheetOption.DrawHidedBorders write Set_DrawHidedBorders;
    property ExitOnEnter: boolean read FSpreadSheetOption.ExitOnEnter write FSpreadSheetOption.ExitOnEnter;
    property WordWrap: boolean read FSpreadSheetOption.WordWrap write FSpreadSheetOption.WordWrap;

    property SyncDelay: integer read FSpreadSheetOption.SyncDelay write Set_SyncDelay;

    property FindText: WideString read FFindOption.FindText write FFindOption.FindText;
    property ReplaceText: WideString read FFindOption.ReplaceText write FFindOption.ReplaceText;

  end;

var
  FvarOptions: TAlxdSpreadSheetOptionsInt;

implementation

uses uAlxdEditor;

procedure TAlxdSpreadSheetOptionsInt.Set_FontName(Value: WideString);
begin
  FSpreadSheetOption.FontName:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_FontSize(Value: integer);
begin
  FSpreadSheetOption.FontSize:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_LanguagePath(Value: WideString);
begin
  if FApplicationOption.LanguagePath <> Value then
    if WideDirectoryExists(Value) then
      FApplicationOption.LanguagePath:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_Transparency(Value: boolean);
begin
  if FApplicationOption.Transparency <> Value then
  begin
    FApplicationOption.Transparency:=Value;

    if Owner <> nil then
    begin
      FfrmEditor.AlphaBlend:=FApplicationOption.Transparency;
      FfrmEditor.AlphaBlendValue:=FApplicationOption.TransparencyValue;
    end;
  end;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_TransparencyValue(Value: Integer);
begin
  if FApplicationOption.TransparencyValue<>Value then
  begin
    FApplicationOption.TransparencyValue:=Value;

    if Owner <> nil then
    begin
      FfrmEditor.AlphaBlend:=FApplicationOption.Transparency;
      FfrmEditor.AlphaBlendValue:=FApplicationOption.TransparencyValue;
    end;
  end;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_FixedColor(Value: TColor);
begin
  FSpreadSheetOption.FixedColor:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_FixedLineColor(Value: TColor);
begin
  FSpreadSheetOption.FixedLineColor:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_FixedColWidth(Value: integer);
begin
  FSpreadSheetOption.FixedColWidth:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_FixedRowHeight(Value: integer);
begin
  FSpreadSheetOption.FixedRowHeight:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_PixelToMmX(Value: double);
begin
  FSpreadSheetOption.PixelToMmX:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_PixelToMmY(Value: double);
begin
  FSpreadSheetOption.PixelToMmY:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_SelectionColor(Value: TColor);
begin
  FSpreadSheetOption.SelectionColor:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_DrawingSelectionColor(Value: integer);
begin
  FSpreadSheetOption.DrawingSelectionColor:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_StylePath(Value: WideString);
begin
  FStyleManagerOption.StylePath:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_StyleCurrent(Value: WideString);
begin
  FStyleManagerOption.StyleCurrent:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_DirectionTab(Value: TAlxdDirectionTab);
begin
  FSpreadSheetOption.DirectionTab:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_DirectionEnter(Value: TAlxdDirectionEnter);
begin
  FSpreadSheetOption.DirectionEnter:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_DrawHidedBorders(Value: boolean);
begin
  FSpreadSheetOption.DrawHidedBorders:=Value;
end;

procedure TAlxdSpreadSheetOptionsInt.Set_SyncDelay(Value: integer);
begin
  if (Value > 0) then
    FSpreadSheetOption.SyncDelay:=Value;
end;

function TAlxdSpreadSheetOptionsInt.GetLanguageTitle(const FileName: WideString): WideString;
var
  IniFile: TIniFile;
begin
  Result:='';
  if WideFileExists(FileName) then
  begin
    IniFile:=TIniFile.Create(FileName);
    try
      if inifile.SectionExists('Info') and
         inifile.ValueExists('Info','Language') then
        Result:=inifile.ReadString('Info', 'Language', '');
    finally
      IniFile.Free;
    end;
  end;
end;


procedure TAlxdSpreadSheetOptionsInt.Load;
begin
  LoadApplicationOption(FApplicationOption);
  LoadStyleManagerOption(FStyleManagerOption);
  LoadSpreadSheetOption(FSpreadSheetOption);
end;

procedure TAlxdSpreadSheetOptionsInt.LoadLanguages(List: TTntStrings);
var
  sName: WideString;
  Sr: TSearchRecW;
begin
  if WideFindFirst(WideIncludeTrailingBackslash(LanguagePath)+'*.ini', faAnyFile, Sr) = 0 then
  begin
    repeat
      sName:=GetLanguageTitle(LanguagePath + '\' + Sr.Name);
      if Length(sName) > 0 then
        List.Add(sName + '=' + Sr.Name);
    until WideFindNext(sr) <> 0;
    WideFindClose(sr);
  end;
end;

procedure TAlxdSpreadSheetOptionsInt.Assign(Source: TPersistent);
var
  i: integer;
begin
  if Source is TAlxdSpreadSheetOptionsInt then
  begin
    for i := 0 to High(AlxdOptionValues) do
    begin
      SetPropValue(Self, AlxdOptionValues[i], GetPropValue(Source, AlxdOptionValues[i]));
    end;
  end;
end;

constructor TAlxdSpreadSheetOptionsInt.Create(AOwner: TComponent);
begin
  inherited;
  {FontName:='Tahoma';
  FontSize:=8;
  Transparency:=false;
  TransparencyValue:=150;
  FApplicationOption.Language:='atrus.ini';
  FApplicationOption.LanguagePath:='G:\Александр\AT8.x\DLL\Language';

  FixedColor:=clMenu;
  FixedColWidth:=60;
  FixedRowHeight:=40;
  PixelToMmX:=3.0;
  PixelToMmY:=3.0;
  SelectionColor:=clSkyBlue;
  DirectionTab:=dtLeft2Right;
  DirectionEnter:=deDown;
  SyncDelay:=250;}
  //FSpreadSheetOption.DrawingSelectionColor:=-1;


  //LoadStyleManagerOption;
  //FStylePath:='g:\Александр\Borland Studio Projects\AlxdGrid9\styles_rus';
  //FStyleCurrent:='';
end;

destructor TAlxdSpreadSheetOptionsInt.Destroy;
begin
  FlushSpreadSheetOption(FSpreadSheetOption);
  FlushStyleManagerOption(FStyleManagerOption);
  FlushApplicationOption(FApplicationOption);
  inherited;
end;

end.
