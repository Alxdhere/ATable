unit AlxdGrid_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 8291 $
// File generated on 11.06.2009 19:49:25 from Type Library described below.

// ************************************************************************  //
// Type Lib: g:\Александр\AT8x\DLL\AlxdGrid.tlb (1)
// LIBID: {D2DEE2CC-FA88-45B9-95BF-15738EE55F59}
// LCID: 0
// Helpfile: 
// HelpString: AlxdGrid Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  AlxdGridMajorVersion = 1;
  AlxdGridMinorVersion = 0;

  LIBID_AlxdGrid: TGUID = '{D2DEE2CC-FA88-45B9-95BF-15738EE55F59}';

  IID_IAlxdApplication: TGUID = '{802F37A5-AE5E-47FA-816B-82D64BE71963}';
  CLASS_AlxdApplication: TGUID = '{0DA62DC9-B4C4-495B-A819-FD451C346A1F}';
  IID_IAlxdEditor: TGUID = '{BA4809C9-7225-4C9E-8A4C-D118D3FF33C0}';
  CLASS_AlxdEditor: TGUID = '{4E3C34FE-4736-4617-BE2D-BE35FE624F04}';
  IID_IAlxdStyleManager: TGUID = '{52A7AAB2-0A27-40B7-B0D3-98E643167F7C}';
  CLASS_AlxdStyleManager: TGUID = '{48D27E0A-7942-4AF8-8FF5-046467ED0BA3}';
  IID_IAlxdStyleEditor: TGUID = '{A459F0B4-A7F6-48EB-9FD0-0E0F5769E428}';
  CLASS_AlxdStyleEditor: TGUID = '{81654EE7-66A5-4234-8D13-0728014B883F}';
  IID_IAlxdSpreadSheetStyle: TGUID = '{96ED91F3-F061-4559-9751-A84DBDC4EC45}';
  CLASS_AlxdSpreadSheetStyle: TGUID = '{E86511D8-F982-4F32-A158-539B5DD6F496}';
  IID_IAlxdSpreadSheets: TGUID = '{F198C064-FFB4-4A24-A123-E46FFF472E4B}';
  CLASS_AlxdSpreadSheets: TGUID = '{B3B7BA22-BB9E-4E2B-9B77-1785FD739959}';
  IID_IAlxdSpreadSheet: TGUID = '{41185042-5256-43F7-80AA-C38D5DA3C301}';
  CLASS_AlxdSpreadSheet: TGUID = '{7637CA13-24CC-4F96-913D-39B409DB9330}';
  IID_IAlxdCells: TGUID = '{59451D33-94A3-4A9B-8A78-A7EEC2A01D35}';
  CLASS_AlxdCells: TGUID = '{B78BB1AF-934A-45D9-ACFB-FC8D3FC31903}';
  IID_IAlxdCell: TGUID = '{8314D92C-64DD-4FDD-B0D7-8621A2A7381E}';
  CLASS_AlxdCell: TGUID = '{71D9AEB6-05A7-4E17-928C-FD200DD30B86}';
  IID_IAlxdItems: TGUID = '{35EEFA2D-07BA-455A-A3C1-B3B9C23E05D0}';
  CLASS_AlxdItems: TGUID = '{8A738D0E-0602-4E9B-AF7C-6562D76BE792}';
  IID_IAlxdItem: TGUID = '{7DF2E429-12C0-4B8F-BC9A-99E3E1910273}';
  CLASS_AlxdItem: TGUID = '{109DADD7-CF88-4212-B997-BFDB3B737F09}';
  IID_IAlxdFills: TGUID = '{95D5E83E-091D-4BF8-8442-F0C04FACD0C8}';
  CLASS_AlxdFills: TGUID = '{3161914E-F0E6-4327-8CBD-B94B9B38F813}';
  IID_IAlxdFill: TGUID = '{EEBE6113-457C-45B9-A217-881AE2FAC680}';
  CLASS_AlxdFill: TGUID = '{57E8F0D2-2F88-4A6B-85EE-8E0A8BFE38F8}';
  IID_IAlxdBorders: TGUID = '{95E5F0B0-A614-40BD-81E6-BA982355DFDD}';
  CLASS_AlxdBorders: TGUID = '{38D4804A-8267-482D-9FC6-F0D02953D6B8}';
  IID_IAlxdBorder: TGUID = '{1C084E20-F12F-494D-9F59-4A0D719AB4D3}';
  CLASS_AlxdBorder: TGUID = '{5A96B25F-A660-4EAB-B535-531E8296183C}';
  IID_IAlxdSpreadSheetSelections: TGUID = '{CABA1351-9472-4984-AFF7-89D4E93A32CB}';
  CLASS_AlxdSpreadSheetSelections: TGUID = '{FE0D05D5-883B-4D87-B25B-DA5DF674D0D0}';
  IID_IAlxdSpreadSheetSelection: TGUID = '{7E2521D8-3D1F-4F79-8C6D-0FCE2454A384}';
  CLASS_AlxdSpreadSheetSelection: TGUID = '{6B70AAAC-9A42-488C-B7F0-7B13E86DD047}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum AlxdJustify
type
  AlxdJustify = TOleEnum;
const
  TopLeft = $00000000;
  TopRight = $00000001;
  BottomLeft = $00000002;
  BottomRight = $00000003;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IAlxdApplication = interface;
  IAlxdApplicationDisp = dispinterface;
  IAlxdEditor = interface;
  IAlxdEditorDisp = dispinterface;
  IAlxdStyleManager = interface;
  IAlxdStyleManagerDisp = dispinterface;
  IAlxdStyleEditor = interface;
  IAlxdStyleEditorDisp = dispinterface;
  IAlxdSpreadSheetStyle = interface;
  IAlxdSpreadSheetStyleDisp = dispinterface;
  IAlxdSpreadSheets = interface;
  IAlxdSpreadSheetsDisp = dispinterface;
  IAlxdSpreadSheet = interface;
  IAlxdSpreadSheetDisp = dispinterface;
  IAlxdCells = interface;
  IAlxdCellsDisp = dispinterface;
  IAlxdCell = interface;
  IAlxdCellDisp = dispinterface;
  IAlxdItems = interface;
  IAlxdItemsDisp = dispinterface;
  IAlxdItem = interface;
  IAlxdItemDisp = dispinterface;
  IAlxdFills = interface;
  IAlxdFillsDisp = dispinterface;
  IAlxdFill = interface;
  IAlxdFillDisp = dispinterface;
  IAlxdBorders = interface;
  IAlxdBordersDisp = dispinterface;
  IAlxdBorder = interface;
  IAlxdBorderDisp = dispinterface;
  IAlxdSpreadSheetSelections = interface;
  IAlxdSpreadSheetSelectionsDisp = dispinterface;
  IAlxdSpreadSheetSelection = interface;
  IAlxdSpreadSheetSelectionDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  AlxdApplication = IAlxdApplication;
  AlxdEditor = IAlxdEditor;
  AlxdStyleManager = IAlxdStyleManager;
  AlxdStyleEditor = IAlxdStyleEditor;
  AlxdSpreadSheetStyle = IAlxdSpreadSheetStyle;
  AlxdSpreadSheets = IAlxdSpreadSheets;
  AlxdSpreadSheet = IAlxdSpreadSheet;
  AlxdCells = IAlxdCells;
  AlxdCell = IAlxdCell;
  AlxdItems = IAlxdItems;
  AlxdItem = IAlxdItem;
  AlxdFills = IAlxdFills;
  AlxdFill = IAlxdFill;
  AlxdBorders = IAlxdBorders;
  AlxdBorder = IAlxdBorder;
  AlxdSpreadSheetSelections = IAlxdSpreadSheetSelections;
  AlxdSpreadSheetSelection = IAlxdSpreadSheetSelection;


// *********************************************************************//
// Interface: IAlxdApplication
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {802F37A5-AE5E-47FA-816B-82D64BE71963}
// *********************************************************************//
  IAlxdApplication = interface(IDispatch)
    ['{802F37A5-AE5E-47FA-816B-82D64BE71963}']
    procedure Quit; safecall;
    function Get_AlxdEditor: IAlxdEditor; safecall;
    function Get_AlxdStyleManager: IAlxdStyleManager; safecall;
    function Get_AlxdStyleEditor: IAlxdStyleEditor; safecall;
    function CreateAlxdSpreadSheetStyle: AlxdSpreadSheetStyle; safecall;
    property AlxdEditor: IAlxdEditor read Get_AlxdEditor;
    property AlxdStyleManager: IAlxdStyleManager read Get_AlxdStyleManager;
    property AlxdStyleEditor: IAlxdStyleEditor read Get_AlxdStyleEditor;
  end;

// *********************************************************************//
// DispIntf:  IAlxdApplicationDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {802F37A5-AE5E-47FA-816B-82D64BE71963}
// *********************************************************************//
  IAlxdApplicationDisp = dispinterface
    ['{802F37A5-AE5E-47FA-816B-82D64BE71963}']
    procedure Quit; dispid 201;
    property AlxdEditor: IAlxdEditor readonly dispid 202;
    property AlxdStyleManager: IAlxdStyleManager readonly dispid 203;
    property AlxdStyleEditor: IAlxdStyleEditor readonly dispid 204;
    function CreateAlxdSpreadSheetStyle: AlxdSpreadSheetStyle; dispid 205;
  end;

// *********************************************************************//
// Interface: IAlxdEditor
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BA4809C9-7225-4C9E-8A4C-D118D3FF33C0}
// *********************************************************************//
  IAlxdEditor = interface(IDispatch)
    ['{BA4809C9-7225-4C9E-8A4C-D118D3FF33C0}']
    procedure Open; safecall;
    procedure Close; safecall;
    function Get_AlxdSpreadSheets: AlxdSpreadSheets; safecall;
    property AlxdSpreadSheets: AlxdSpreadSheets read Get_AlxdSpreadSheets;
  end;

// *********************************************************************//
// DispIntf:  IAlxdEditorDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BA4809C9-7225-4C9E-8A4C-D118D3FF33C0}
// *********************************************************************//
  IAlxdEditorDisp = dispinterface
    ['{BA4809C9-7225-4C9E-8A4C-D118D3FF33C0}']
    procedure Open; dispid 201;
    procedure Close; dispid 202;
    property AlxdSpreadSheets: AlxdSpreadSheets readonly dispid 203;
  end;

// *********************************************************************//
// Interface: IAlxdStyleManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {52A7AAB2-0A27-40B7-B0D3-98E643167F7C}
// *********************************************************************//
  IAlxdStyleManager = interface(IDispatch)
    ['{52A7AAB2-0A27-40B7-B0D3-98E643167F7C}']
    procedure Show; safecall;
    function Select(var Value: WideString): Integer; safecall;
  end;

// *********************************************************************//
// DispIntf:  IAlxdStyleManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {52A7AAB2-0A27-40B7-B0D3-98E643167F7C}
// *********************************************************************//
  IAlxdStyleManagerDisp = dispinterface
    ['{52A7AAB2-0A27-40B7-B0D3-98E643167F7C}']
    procedure Show; dispid 201;
    function Select(var Value: WideString): Integer; dispid 202;
  end;

// *********************************************************************//
// Interface: IAlxdStyleEditor
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A459F0B4-A7F6-48EB-9FD0-0E0F5769E428}
// *********************************************************************//
  IAlxdStyleEditor = interface(IDispatch)
    ['{A459F0B4-A7F6-48EB-9FD0-0E0F5769E428}']
    function Edit(const Value: AlxdSpreadSheetStyle): Integer; safecall;
  end;

// *********************************************************************//
// DispIntf:  IAlxdStyleEditorDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A459F0B4-A7F6-48EB-9FD0-0E0F5769E428}
// *********************************************************************//
  IAlxdStyleEditorDisp = dispinterface
    ['{A459F0B4-A7F6-48EB-9FD0-0E0F5769E428}']
    function Edit(const Value: AlxdSpreadSheetStyle): Integer; dispid 201;
  end;

// *********************************************************************//
// Interface: IAlxdSpreadSheetStyle
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {96ED91F3-F061-4559-9751-A84DBDC4EC45}
// *********************************************************************//
  IAlxdSpreadSheetStyle = interface(IDispatch)
    ['{96ED91F3-F061-4559-9751-A84DBDC4EC45}']
    function Get_ColCount: Integer; safecall;
    procedure Set_ColCount(Value: Integer); safecall;
    function Get_RowCount: Integer; safecall;
    procedure Set_RowCount(Value: Integer); safecall;
    function Get_PropertyByNum(Index: Integer): OleVariant; safecall;
    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant); safecall;
    function LoadFrom(const FullFileName: WideString): WordBool; safecall;
    procedure CopyFrom(const Value: IAlxdSpreadSheetStyle); safecall;
    function Get_Pointer: Integer; safecall;
    function Get_Justify: AlxdJustify; safecall;
    procedure Set_Justify(Value: AlxdJustify); safecall;
    property ColCount: Integer read Get_ColCount write Set_ColCount;
    property RowCount: Integer read Get_RowCount write Set_RowCount;
    property PropertyByNum[Index: Integer]: OleVariant read Get_PropertyByNum write Set_PropertyByNum;
    property Pointer: Integer read Get_Pointer;
    property Justify: AlxdJustify read Get_Justify write Set_Justify;
  end;

// *********************************************************************//
// DispIntf:  IAlxdSpreadSheetStyleDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {96ED91F3-F061-4559-9751-A84DBDC4EC45}
// *********************************************************************//
  IAlxdSpreadSheetStyleDisp = dispinterface
    ['{96ED91F3-F061-4559-9751-A84DBDC4EC45}']
    property ColCount: Integer dispid 201;
    property RowCount: Integer dispid 202;
    property PropertyByNum[Index: Integer]: OleVariant dispid 203;
    function LoadFrom(const FullFileName: WideString): WordBool; dispid 204;
    procedure CopyFrom(const Value: IAlxdSpreadSheetStyle); dispid 205;
    property Pointer: Integer readonly dispid 206;
    property Justify: AlxdJustify dispid 207;
  end;

// *********************************************************************//
// Interface: IAlxdSpreadSheets
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F198C064-FFB4-4A24-A123-E46FFF472E4B}
// *********************************************************************//
  IAlxdSpreadSheets = interface(IDispatch)
    ['{F198C064-FFB4-4A24-A123-E46FFF472E4B}']
    function Add: Integer; safecall;
    procedure Insert(Index: Integer); safecall;
    procedure Delete(Index: Integer); safecall;
    function Get_Count: Integer; safecall;
    function Get_Items(Index: Integer): IAlxdSpreadSheet; safecall;
    procedure Exchange(Index1: Integer; Index2: Integer); safecall;
    function Get_Active: Integer; safecall;
    procedure Set_Active(Value: Integer); safecall;
    function HasByDef(id: Integer): WordBool; safecall;
    function HasByRef(id: Integer): WordBool; safecall;
    property Count: Integer read Get_Count;
    property Items[Index: Integer]: IAlxdSpreadSheet read Get_Items;
    property Active: Integer read Get_Active write Set_Active;
  end;

// *********************************************************************//
// DispIntf:  IAlxdSpreadSheetsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F198C064-FFB4-4A24-A123-E46FFF472E4B}
// *********************************************************************//
  IAlxdSpreadSheetsDisp = dispinterface
    ['{F198C064-FFB4-4A24-A123-E46FFF472E4B}']
    function Add: Integer; dispid 201;
    procedure Insert(Index: Integer); dispid 202;
    procedure Delete(Index: Integer); dispid 203;
    property Count: Integer readonly dispid 204;
    property Items[Index: Integer]: IAlxdSpreadSheet readonly dispid 205;
    procedure Exchange(Index1: Integer; Index2: Integer); dispid 206;
    property Active: Integer dispid 207;
    function HasByDef(id: Integer): WordBool; dispid 208;
    function HasByRef(id: Integer): WordBool; dispid 209;
  end;

// *********************************************************************//
// Interface: IAlxdSpreadSheet
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {41185042-5256-43F7-80AA-C38D5DA3C301}
// *********************************************************************//
  IAlxdSpreadSheet = interface(IDispatch)
    ['{41185042-5256-43F7-80AA-C38D5DA3C301}']
    procedure AddRows(Count: Integer); safecall;
    procedure InsertRows; safecall;
    procedure DeleteRows; safecall;
    procedure AddColumns(Count: Integer); safecall;
    procedure InsertColumns; safecall;
    procedure DeleteColumns; safecall;
    procedure CreateBlockDefinition; safecall;
    procedure RedrawBlockDefinition; safecall;
    function Get_BlockDefinitionID: Integer; safecall;
    function Get_BlockReferenceID: Integer; safecall;
    procedure Set_BlockReferenceID(Value: Integer); safecall;
    function WriteToDictionary: WordBool; safecall;
    function ReadFromDictionary: WordBool; safecall;
    function Get_AlxdSpreadSheetStyle: AlxdSpreadSheetStyle; safecall;
    function Get_AlxdCells: AlxdCells; safecall;
    function Get_DictionaryID: Integer; safecall;
    function Get_AlxdColumns: AlxdItems; safecall;
    function Get_AlxdRows: AlxdItems; safecall;
    function Recalculate: WordBool; safecall;
    function Get_AlxdFills: AlxdFills; safecall;
    function Get_AlxdVerticalBorders: AlxdBorders; safecall;
    function Get_AlxdHorizontalBorders: AlxdBorders; safecall;
    function Get_AlxdSpreadSheetSelections: IAlxdSpreadSheetSelections; safecall;
    procedure RedrawBlockDefinitionFull; safecall;
    function Get_BlockReferencePtrByJig: Integer; safecall;
    procedure Set_BlockReferencePtrByJig(Value: Integer); safecall;
    property BlockDefinitionID: Integer read Get_BlockDefinitionID;
    property BlockReferenceID: Integer read Get_BlockReferenceID write Set_BlockReferenceID;
    property AlxdSpreadSheetStyle: AlxdSpreadSheetStyle read Get_AlxdSpreadSheetStyle;
    property AlxdCells: AlxdCells read Get_AlxdCells;
    property DictionaryID: Integer read Get_DictionaryID;
    property AlxdColumns: AlxdItems read Get_AlxdColumns;
    property AlxdRows: AlxdItems read Get_AlxdRows;
    property AlxdFills: AlxdFills read Get_AlxdFills;
    property AlxdVerticalBorders: AlxdBorders read Get_AlxdVerticalBorders;
    property AlxdHorizontalBorders: AlxdBorders read Get_AlxdHorizontalBorders;
    property AlxdSpreadSheetSelections: IAlxdSpreadSheetSelections read Get_AlxdSpreadSheetSelections;
    property BlockReferencePtrByJig: Integer read Get_BlockReferencePtrByJig write Set_BlockReferencePtrByJig;
  end;

// *********************************************************************//
// DispIntf:  IAlxdSpreadSheetDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {41185042-5256-43F7-80AA-C38D5DA3C301}
// *********************************************************************//
  IAlxdSpreadSheetDisp = dispinterface
    ['{41185042-5256-43F7-80AA-C38D5DA3C301}']
    procedure AddRows(Count: Integer); dispid 201;
    procedure InsertRows; dispid 202;
    procedure DeleteRows; dispid 203;
    procedure AddColumns(Count: Integer); dispid 204;
    procedure InsertColumns; dispid 205;
    procedure DeleteColumns; dispid 206;
    procedure CreateBlockDefinition; dispid 207;
    procedure RedrawBlockDefinition; dispid 208;
    property BlockDefinitionID: Integer readonly dispid 209;
    property BlockReferenceID: Integer dispid 210;
    function WriteToDictionary: WordBool; dispid 211;
    function ReadFromDictionary: WordBool; dispid 212;
    property AlxdSpreadSheetStyle: AlxdSpreadSheetStyle readonly dispid 213;
    property AlxdCells: AlxdCells readonly dispid 214;
    property DictionaryID: Integer readonly dispid 215;
    property AlxdColumns: AlxdItems readonly dispid 216;
    property AlxdRows: AlxdItems readonly dispid 217;
    function Recalculate: WordBool; dispid 218;
    property AlxdFills: AlxdFills readonly dispid 219;
    property AlxdVerticalBorders: AlxdBorders readonly dispid 220;
    property AlxdHorizontalBorders: AlxdBorders readonly dispid 221;
    property AlxdSpreadSheetSelections: IAlxdSpreadSheetSelections readonly dispid 222;
    procedure RedrawBlockDefinitionFull; dispid 223;
    property BlockReferencePtrByJig: Integer dispid 224;
  end;

// *********************************************************************//
// Interface: IAlxdCells
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {59451D33-94A3-4A9B-8A78-A7EEC2A01D35}
// *********************************************************************//
  IAlxdCells = interface(IDispatch)
    ['{59451D33-94A3-4A9B-8A78-A7EEC2A01D35}']
    function Get_Items(Col: Integer; Row: Integer): AlxdCell; safecall;
    property Items[Col: Integer; Row: Integer]: AlxdCell read Get_Items;
  end;

// *********************************************************************//
// DispIntf:  IAlxdCellsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {59451D33-94A3-4A9B-8A78-A7EEC2A01D35}
// *********************************************************************//
  IAlxdCellsDisp = dispinterface
    ['{59451D33-94A3-4A9B-8A78-A7EEC2A01D35}']
    property Items[Col: Integer; Row: Integer]: AlxdCell readonly dispid 201;
  end;

// *********************************************************************//
// Interface: IAlxdCell
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8314D92C-64DD-4FDD-B0D7-8621A2A7381E}
// *********************************************************************//
  IAlxdCell = interface(IDispatch)
    ['{8314D92C-64DD-4FDD-B0D7-8621A2A7381E}']
    function Get_Contain: WideString; safecall;
    procedure Set_Contain(const Value: WideString); safecall;
    function Get_PropertyByNum(Index: Integer): OleVariant; safecall;
    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant); safecall;
    property Contain: WideString read Get_Contain write Set_Contain;
    property PropertyByNum[Index: Integer]: OleVariant read Get_PropertyByNum write Set_PropertyByNum;
  end;

// *********************************************************************//
// DispIntf:  IAlxdCellDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8314D92C-64DD-4FDD-B0D7-8621A2A7381E}
// *********************************************************************//
  IAlxdCellDisp = dispinterface
    ['{8314D92C-64DD-4FDD-B0D7-8621A2A7381E}']
    property Contain: WideString dispid 201;
    property PropertyByNum[Index: Integer]: OleVariant dispid 202;
  end;

// *********************************************************************//
// Interface: IAlxdItems
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {35EEFA2D-07BA-455A-A3C1-B3B9C23E05D0}
// *********************************************************************//
  IAlxdItems = interface(IDispatch)
    ['{35EEFA2D-07BA-455A-A3C1-B3B9C23E05D0}']
    function Get_Items(Index: Integer): AlxdItem; safecall;
    function Get_Index(Coord: Double): Integer; safecall;
    function Get_Count: Integer; safecall;
    property Items[Index: Integer]: AlxdItem read Get_Items;
    property Index[Coord: Double]: Integer read Get_Index;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IAlxdItemsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {35EEFA2D-07BA-455A-A3C1-B3B9C23E05D0}
// *********************************************************************//
  IAlxdItemsDisp = dispinterface
    ['{35EEFA2D-07BA-455A-A3C1-B3B9C23E05D0}']
    property Items[Index: Integer]: AlxdItem readonly dispid 201;
    property Index[Coord: Double]: Integer readonly dispid 202;
    property Count: Integer readonly dispid 203;
  end;

// *********************************************************************//
// Interface: IAlxdItem
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7DF2E429-12C0-4B8F-BC9A-99E3E1910273}
// *********************************************************************//
  IAlxdItem = interface(IDispatch)
    ['{7DF2E429-12C0-4B8F-BC9A-99E3E1910273}']
    function Get_PropertyByNum(Index: Integer): OleVariant; safecall;
    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant); safecall;
    property PropertyByNum[Index: Integer]: OleVariant read Get_PropertyByNum write Set_PropertyByNum;
  end;

// *********************************************************************//
// DispIntf:  IAlxdItemDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7DF2E429-12C0-4B8F-BC9A-99E3E1910273}
// *********************************************************************//
  IAlxdItemDisp = dispinterface
    ['{7DF2E429-12C0-4B8F-BC9A-99E3E1910273}']
    property PropertyByNum[Index: Integer]: OleVariant dispid 201;
  end;

// *********************************************************************//
// Interface: IAlxdFills
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {95D5E83E-091D-4BF8-8442-F0C04FACD0C8}
// *********************************************************************//
  IAlxdFills = interface(IDispatch)
    ['{95D5E83E-091D-4BF8-8442-F0C04FACD0C8}']
    function Get_Items(Col: Integer; Row: Integer): AlxdFill; safecall;
    property Items[Col: Integer; Row: Integer]: AlxdFill read Get_Items;
  end;

// *********************************************************************//
// DispIntf:  IAlxdFillsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {95D5E83E-091D-4BF8-8442-F0C04FACD0C8}
// *********************************************************************//
  IAlxdFillsDisp = dispinterface
    ['{95D5E83E-091D-4BF8-8442-F0C04FACD0C8}']
    property Items[Col: Integer; Row: Integer]: AlxdFill readonly dispid 201;
  end;

// *********************************************************************//
// Interface: IAlxdFill
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EEBE6113-457C-45B9-A217-881AE2FAC680}
// *********************************************************************//
  IAlxdFill = interface(IDispatch)
    ['{EEBE6113-457C-45B9-A217-881AE2FAC680}']
    function Get_PropertyByNum(Index: Integer): OleVariant; safecall;
    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant); safecall;
    property PropertyByNum[Index: Integer]: OleVariant read Get_PropertyByNum write Set_PropertyByNum;
  end;

// *********************************************************************//
// DispIntf:  IAlxdFillDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EEBE6113-457C-45B9-A217-881AE2FAC680}
// *********************************************************************//
  IAlxdFillDisp = dispinterface
    ['{EEBE6113-457C-45B9-A217-881AE2FAC680}']
    property PropertyByNum[Index: Integer]: OleVariant dispid 201;
  end;

// *********************************************************************//
// Interface: IAlxdBorders
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {95E5F0B0-A614-40BD-81E6-BA982355DFDD}
// *********************************************************************//
  IAlxdBorders = interface(IDispatch)
    ['{95E5F0B0-A614-40BD-81E6-BA982355DFDD}']
    function Get_Items(Col: Integer; Row: Integer): AlxdBorder; safecall;
    property Items[Col: Integer; Row: Integer]: AlxdBorder read Get_Items;
  end;

// *********************************************************************//
// DispIntf:  IAlxdBordersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {95E5F0B0-A614-40BD-81E6-BA982355DFDD}
// *********************************************************************//
  IAlxdBordersDisp = dispinterface
    ['{95E5F0B0-A614-40BD-81E6-BA982355DFDD}']
    property Items[Col: Integer; Row: Integer]: AlxdBorder readonly dispid 201;
  end;

// *********************************************************************//
// Interface: IAlxdBorder
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1C084E20-F12F-494D-9F59-4A0D719AB4D3}
// *********************************************************************//
  IAlxdBorder = interface(IDispatch)
    ['{1C084E20-F12F-494D-9F59-4A0D719AB4D3}']
    function Get_PropertyByNum(Index: Integer): OleVariant; safecall;
    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant); safecall;
    property PropertyByNum[Index: Integer]: OleVariant read Get_PropertyByNum write Set_PropertyByNum;
  end;

// *********************************************************************//
// DispIntf:  IAlxdBorderDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1C084E20-F12F-494D-9F59-4A0D719AB4D3}
// *********************************************************************//
  IAlxdBorderDisp = dispinterface
    ['{1C084E20-F12F-494D-9F59-4A0D719AB4D3}']
    property PropertyByNum[Index: Integer]: OleVariant dispid 201;
  end;

// *********************************************************************//
// Interface: IAlxdSpreadSheetSelections
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CABA1351-9472-4984-AFF7-89D4E93A32CB}
// *********************************************************************//
  IAlxdSpreadSheetSelections = interface(IDispatch)
    ['{CABA1351-9472-4984-AFF7-89D4E93A32CB}']
    function Get_Items(Index: Integer): IAlxdSpreadSheetSelection; safecall;
    function Get_CurrentCell: IAlxdSpreadSheetSelection; safecall;
    procedure Set_CurrentCell(const Value: IAlxdSpreadSheetSelection); safecall;
    function Get_LastSelectedCell: IAlxdSpreadSheetSelection; safecall;
    procedure Set_LastSelectedCell(const Value: IAlxdSpreadSheetSelection); safecall;
    property Items[Index: Integer]: IAlxdSpreadSheetSelection read Get_Items;
    property CurrentCell: IAlxdSpreadSheetSelection read Get_CurrentCell write Set_CurrentCell;
    property LastSelectedCell: IAlxdSpreadSheetSelection read Get_LastSelectedCell write Set_LastSelectedCell;
  end;

// *********************************************************************//
// DispIntf:  IAlxdSpreadSheetSelectionsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CABA1351-9472-4984-AFF7-89D4E93A32CB}
// *********************************************************************//
  IAlxdSpreadSheetSelectionsDisp = dispinterface
    ['{CABA1351-9472-4984-AFF7-89D4E93A32CB}']
    property Items[Index: Integer]: IAlxdSpreadSheetSelection readonly dispid 201;
    property CurrentCell: IAlxdSpreadSheetSelection dispid 202;
    property LastSelectedCell: IAlxdSpreadSheetSelection dispid 203;
  end;

// *********************************************************************//
// Interface: IAlxdSpreadSheetSelection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7E2521D8-3D1F-4F79-8C6D-0FCE2454A384}
// *********************************************************************//
  IAlxdSpreadSheetSelection = interface(IDispatch)
    ['{7E2521D8-3D1F-4F79-8C6D-0FCE2454A384}']
    procedure MakeFromDrawingPoint(x: Double; y: Double); safecall;
    function Get_Pointer: Integer; safecall;
    property Pointer: Integer read Get_Pointer;
  end;

// *********************************************************************//
// DispIntf:  IAlxdSpreadSheetSelectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7E2521D8-3D1F-4F79-8C6D-0FCE2454A384}
// *********************************************************************//
  IAlxdSpreadSheetSelectionDisp = dispinterface
    ['{7E2521D8-3D1F-4F79-8C6D-0FCE2454A384}']
    procedure MakeFromDrawingPoint(x: Double; y: Double); dispid 201;
    property Pointer: Integer readonly dispid 202;
  end;

// *********************************************************************//
// The Class CoAlxdApplication provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdApplication exposed by              
// the CoClass AlxdApplication. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdApplication = class
    class function Create: IAlxdApplication;
    class function CreateRemote(const MachineName: string): IAlxdApplication;
  end;

// *********************************************************************//
// The Class CoAlxdEditor provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdEditor exposed by              
// the CoClass AlxdEditor. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdEditor = class
    class function Create: IAlxdEditor;
    class function CreateRemote(const MachineName: string): IAlxdEditor;
  end;

// *********************************************************************//
// The Class CoAlxdStyleManager provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdStyleManager exposed by              
// the CoClass AlxdStyleManager. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdStyleManager = class
    class function Create: IAlxdStyleManager;
    class function CreateRemote(const MachineName: string): IAlxdStyleManager;
  end;

// *********************************************************************//
// The Class CoAlxdStyleEditor provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdStyleEditor exposed by              
// the CoClass AlxdStyleEditor. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdStyleEditor = class
    class function Create: IAlxdStyleEditor;
    class function CreateRemote(const MachineName: string): IAlxdStyleEditor;
  end;

// *********************************************************************//
// The Class CoAlxdSpreadSheetStyle provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdSpreadSheetStyle exposed by              
// the CoClass AlxdSpreadSheetStyle. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdSpreadSheetStyle = class
    class function Create: IAlxdSpreadSheetStyle;
    class function CreateRemote(const MachineName: string): IAlxdSpreadSheetStyle;
  end;

// *********************************************************************//
// The Class CoAlxdSpreadSheets provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdSpreadSheets exposed by              
// the CoClass AlxdSpreadSheets. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdSpreadSheets = class
    class function Create: IAlxdSpreadSheets;
    class function CreateRemote(const MachineName: string): IAlxdSpreadSheets;
  end;

// *********************************************************************//
// The Class CoAlxdSpreadSheet provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdSpreadSheet exposed by              
// the CoClass AlxdSpreadSheet. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdSpreadSheet = class
    class function Create: IAlxdSpreadSheet;
    class function CreateRemote(const MachineName: string): IAlxdSpreadSheet;
  end;

// *********************************************************************//
// The Class CoAlxdCells provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdCells exposed by              
// the CoClass AlxdCells. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdCells = class
    class function Create: IAlxdCells;
    class function CreateRemote(const MachineName: string): IAlxdCells;
  end;

// *********************************************************************//
// The Class CoAlxdCell provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdCell exposed by              
// the CoClass AlxdCell. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdCell = class
    class function Create: IAlxdCell;
    class function CreateRemote(const MachineName: string): IAlxdCell;
  end;

// *********************************************************************//
// The Class CoAlxdItems provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdItems exposed by              
// the CoClass AlxdItems. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdItems = class
    class function Create: IAlxdItems;
    class function CreateRemote(const MachineName: string): IAlxdItems;
  end;

// *********************************************************************//
// The Class CoAlxdItem provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdItem exposed by              
// the CoClass AlxdItem. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdItem = class
    class function Create: IAlxdItem;
    class function CreateRemote(const MachineName: string): IAlxdItem;
  end;

// *********************************************************************//
// The Class CoAlxdFills provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdFills exposed by              
// the CoClass AlxdFills. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdFills = class
    class function Create: IAlxdFills;
    class function CreateRemote(const MachineName: string): IAlxdFills;
  end;

// *********************************************************************//
// The Class CoAlxdFill provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdFill exposed by              
// the CoClass AlxdFill. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdFill = class
    class function Create: IAlxdFill;
    class function CreateRemote(const MachineName: string): IAlxdFill;
  end;

// *********************************************************************//
// The Class CoAlxdBorders provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdBorders exposed by              
// the CoClass AlxdBorders. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdBorders = class
    class function Create: IAlxdBorders;
    class function CreateRemote(const MachineName: string): IAlxdBorders;
  end;

// *********************************************************************//
// The Class CoAlxdBorder provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdBorder exposed by              
// the CoClass AlxdBorder. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdBorder = class
    class function Create: IAlxdBorder;
    class function CreateRemote(const MachineName: string): IAlxdBorder;
  end;

// *********************************************************************//
// The Class CoAlxdSpreadSheetSelections provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdSpreadSheetSelections exposed by              
// the CoClass AlxdSpreadSheetSelections. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdSpreadSheetSelections = class
    class function Create: IAlxdSpreadSheetSelections;
    class function CreateRemote(const MachineName: string): IAlxdSpreadSheetSelections;
  end;

// *********************************************************************//
// The Class CoAlxdSpreadSheetSelection provides a Create and CreateRemote method to          
// create instances of the default interface IAlxdSpreadSheetSelection exposed by              
// the CoClass AlxdSpreadSheetSelection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAlxdSpreadSheetSelection = class
    class function Create: IAlxdSpreadSheetSelection;
    class function CreateRemote(const MachineName: string): IAlxdSpreadSheetSelection;
  end;

implementation

uses ComObj;

class function CoAlxdApplication.Create: IAlxdApplication;
begin
  Result := CreateComObject(CLASS_AlxdApplication) as IAlxdApplication;
end;

class function CoAlxdApplication.CreateRemote(const MachineName: string): IAlxdApplication;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdApplication) as IAlxdApplication;
end;

class function CoAlxdEditor.Create: IAlxdEditor;
begin
  Result := CreateComObject(CLASS_AlxdEditor) as IAlxdEditor;
end;

class function CoAlxdEditor.CreateRemote(const MachineName: string): IAlxdEditor;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdEditor) as IAlxdEditor;
end;

class function CoAlxdStyleManager.Create: IAlxdStyleManager;
begin
  Result := CreateComObject(CLASS_AlxdStyleManager) as IAlxdStyleManager;
end;

class function CoAlxdStyleManager.CreateRemote(const MachineName: string): IAlxdStyleManager;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdStyleManager) as IAlxdStyleManager;
end;

class function CoAlxdStyleEditor.Create: IAlxdStyleEditor;
begin
  Result := CreateComObject(CLASS_AlxdStyleEditor) as IAlxdStyleEditor;
end;

class function CoAlxdStyleEditor.CreateRemote(const MachineName: string): IAlxdStyleEditor;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdStyleEditor) as IAlxdStyleEditor;
end;

class function CoAlxdSpreadSheetStyle.Create: IAlxdSpreadSheetStyle;
begin
  Result := CreateComObject(CLASS_AlxdSpreadSheetStyle) as IAlxdSpreadSheetStyle;
end;

class function CoAlxdSpreadSheetStyle.CreateRemote(const MachineName: string): IAlxdSpreadSheetStyle;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdSpreadSheetStyle) as IAlxdSpreadSheetStyle;
end;

class function CoAlxdSpreadSheets.Create: IAlxdSpreadSheets;
begin
  Result := CreateComObject(CLASS_AlxdSpreadSheets) as IAlxdSpreadSheets;
end;

class function CoAlxdSpreadSheets.CreateRemote(const MachineName: string): IAlxdSpreadSheets;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdSpreadSheets) as IAlxdSpreadSheets;
end;

class function CoAlxdSpreadSheet.Create: IAlxdSpreadSheet;
begin
  Result := CreateComObject(CLASS_AlxdSpreadSheet) as IAlxdSpreadSheet;
end;

class function CoAlxdSpreadSheet.CreateRemote(const MachineName: string): IAlxdSpreadSheet;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdSpreadSheet) as IAlxdSpreadSheet;
end;

class function CoAlxdCells.Create: IAlxdCells;
begin
  Result := CreateComObject(CLASS_AlxdCells) as IAlxdCells;
end;

class function CoAlxdCells.CreateRemote(const MachineName: string): IAlxdCells;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdCells) as IAlxdCells;
end;

class function CoAlxdCell.Create: IAlxdCell;
begin
  Result := CreateComObject(CLASS_AlxdCell) as IAlxdCell;
end;

class function CoAlxdCell.CreateRemote(const MachineName: string): IAlxdCell;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdCell) as IAlxdCell;
end;

class function CoAlxdItems.Create: IAlxdItems;
begin
  Result := CreateComObject(CLASS_AlxdItems) as IAlxdItems;
end;

class function CoAlxdItems.CreateRemote(const MachineName: string): IAlxdItems;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdItems) as IAlxdItems;
end;

class function CoAlxdItem.Create: IAlxdItem;
begin
  Result := CreateComObject(CLASS_AlxdItem) as IAlxdItem;
end;

class function CoAlxdItem.CreateRemote(const MachineName: string): IAlxdItem;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdItem) as IAlxdItem;
end;

class function CoAlxdFills.Create: IAlxdFills;
begin
  Result := CreateComObject(CLASS_AlxdFills) as IAlxdFills;
end;

class function CoAlxdFills.CreateRemote(const MachineName: string): IAlxdFills;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdFills) as IAlxdFills;
end;

class function CoAlxdFill.Create: IAlxdFill;
begin
  Result := CreateComObject(CLASS_AlxdFill) as IAlxdFill;
end;

class function CoAlxdFill.CreateRemote(const MachineName: string): IAlxdFill;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdFill) as IAlxdFill;
end;

class function CoAlxdBorders.Create: IAlxdBorders;
begin
  Result := CreateComObject(CLASS_AlxdBorders) as IAlxdBorders;
end;

class function CoAlxdBorders.CreateRemote(const MachineName: string): IAlxdBorders;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdBorders) as IAlxdBorders;
end;

class function CoAlxdBorder.Create: IAlxdBorder;
begin
  Result := CreateComObject(CLASS_AlxdBorder) as IAlxdBorder;
end;

class function CoAlxdBorder.CreateRemote(const MachineName: string): IAlxdBorder;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdBorder) as IAlxdBorder;
end;

class function CoAlxdSpreadSheetSelections.Create: IAlxdSpreadSheetSelections;
begin
  Result := CreateComObject(CLASS_AlxdSpreadSheetSelections) as IAlxdSpreadSheetSelections;
end;

class function CoAlxdSpreadSheetSelections.CreateRemote(const MachineName: string): IAlxdSpreadSheetSelections;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdSpreadSheetSelections) as IAlxdSpreadSheetSelections;
end;

class function CoAlxdSpreadSheetSelection.Create: IAlxdSpreadSheetSelection;
begin
  Result := CreateComObject(CLASS_AlxdSpreadSheetSelection) as IAlxdSpreadSheetSelection;
end;

class function CoAlxdSpreadSheetSelection.CreateRemote(const MachineName: string): IAlxdSpreadSheetSelection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AlxdSpreadSheetSelection) as IAlxdSpreadSheetSelection;
end;

end.
