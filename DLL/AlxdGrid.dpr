library AlxdGrid;

uses
  ComServ,
  AlxdGrid_TLB in 'AlxdGrid_TLB.pas',
  xAlxdApplication in 'xAlxdApplication.pas' {AlxdApplication: CoClass},
  uAlxdEditor in 'uAlxdEditor.pas' {frmEditor: TTntForm},
  xAlxdEditor in 'xAlxdEditor.pas' {AlxdEditor: CoClass},
  xAlxdStyleManager in 'xAlxdStyleManager.pas' {AlxdStyleManager: CoClass},
  uAlxdStyleManager in 'uAlxdStyleManager.pas' {frmAlxdStyleManager: TTntForm},
  uAlxdStyleEditor in 'uAlxdStyleEditor.pas' {frmAlxdStyleEditor: TTntForm},
  xAlxdStyleEditor in 'xAlxdStyleEditor.pas' {AlxdStyleEditor: CoClass},
  uAlxdSystem in 'uAlxdSystem.pas',
  uAlxdSpreadSheetStyle in 'uAlxdSpreadSheetStyle.pas',
  uAlxdSpreadSheets in 'uAlxdSpreadSheets.pas',
  uAlxdSpreadSheet in 'uAlxdSpreadSheet.pas',
  xAlxdSpreadSheetStyle in 'xAlxdSpreadSheetStyle.pas' {AlxdSpreadSheetStyle: CoClass},
  xAlxdSpreadSheets in 'xAlxdSpreadSheets.pas' {AlxdSpreadSheets: CoClass},
  xAlxdSpreadSheet in 'xAlxdSpreadSheet.pas' {AlxdSpreadSheet: CoClass},
  uAlxdCell in 'uAlxdCell.pas',
  uAlxdCells in 'uAlxdCells.pas',
  uAlxdSpreadSheetArray in 'uAlxdSpreadSheetArray.pas',
  uAlxdObjectIDs in 'uAlxdObjectIDs.pas',
  uAlxdOptions in 'uAlxdOptions.pas',
  uAlxdSpreadSheetSelections in 'uAlxdSpreadSheetSelections.pas',
  uAlxdSpreadSheetSelection in 'uAlxdSpreadSheetSelection.pas',
  uAlxdItems in 'uAlxdItems.pas',
  uAlxdItem in 'uAlxdItem.pas',
  uAlxdBorder in 'uAlxdBorder.pas',
  uAlxdBorders in 'uAlxdBorders.pas',
  uvclExport in 'uvclExport.pas',
  uoarxImport in 'uoarxImport.pas',
  uAlxdValue in 'uAlxdValue.pas' {ValueForm: TTntForm},
  xAlxdCells in 'xAlxdCells.pas' {AlxdCells: CoClass},
  xAlxdCell in 'xAlxdCell.pas' {AlxdCell: CoClass},
  xAlxdItems in 'xAlxdItems.pas' {AlxdItems: CoClass},
  xAlxdItem in 'xAlxdItem.pas' {AlxdItem: CoClass},
  uAlxdFills in 'uAlxdFills.pas',
  uAlxdFill in 'uAlxdFill.pas',
  uAlxdTreeView in 'uAlxdTreeView.pas',
  uAlxdLocalizer in 'uAlxdLocalizer.pas',
  uAlxdSpreadSheetStyleItem in 'uAlxdSpreadSheetStyleItem.pas',
  uAlxdSpreadSheetStyleItems in 'uAlxdSpreadSheetStyleItems.pas',
  uAlxdEdit in 'uAlxdEdit.pas',
  uAlxdRegistry in 'uAlxdRegistry.pas',
  uAlxdAbout in 'uAlxdAbout.pas' {frmAbout},
  uAlxdUndo in 'uAlxdUndo.pas',
  uAlxdPasteSpecial in 'uAlxdPasteSpecial.pas',
  xAlxdFills in 'xAlxdFills.pas' {AlxdFills: CoClass},
  xAlxdFill in 'xAlxdFill.pas' {AlxdFill: CoClass},
  xAlxdBorders in 'xAlxdBorders.pas' {AlxdBorders: CoClass},
  xAlxdBorder in 'xAlxdBorder.pas' {AlxdBorder: CoClass},
  uAlxdOptionEditor in 'uAlxdOptionEditor.pas' {frmAlxdOptionEditor},
  uAlxdSearchForm in 'uAlxdSearchForm.pas' {AlxdSearchForm: TTntForm},
  uAlxdFormatEditor in 'uAlxdFormatEditor.pas' {frmAlxdFormatForm},
  xAlxdSpreadSheetSelections in 'xAlxdSpreadSheetSelections.pas' {AlxdSpreadSheetSelections: CoClass},
  xAlxdSpreadSheetSelection in 'xAlxdSpreadSheetSelection.pas' {AlxdSpreadSheetSelection: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,

  vclGetLength,
  vclSetLength,
  vclSetAt,
  vclGetAt,

  vclUpdString,
  vclDelString,

  vclOPMName,
  vclOPMDescription;

{$R *.TLB}

{$R *.RES}

begin
end.
