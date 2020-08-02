object frmAlxdSearchForm: TfrmAlxdSearchForm
  Left = 449
  Top = 115
  ActiveControl = cbFindText
  BorderIcons = [biSystemMenu]
  Caption = 'SearchForm'
  ClientHeight = 129
  ClientWidth = 356
  Color = clBtnFace
  Constraints.MinWidth = 354
  ParentFont = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnResize = TntFormResize
  PixelsPerInch = 96
  TextHeight = 13
  object lFindText: TLabel
    Left = 8
    Top = 8
    Width = 44
    Height = 13
    Caption = 'lFindText'
  end
  object lReplaceText: TLabel
    Left = 8
    Top = 40
    Width = 62
    Height = 13
    Caption = 'lReplaceText'
  end
  object cbReplaceText: TTntComboBox
    Left = 104
    Top = 40
    Width = 249
    Height = 21
    ItemHeight = 0
    TabOrder = 1
    Text = 'cbReplaceText'
  end
  object cbFindText: TTntComboBox
    Left = 104
    Top = 8
    Width = 249
    Height = 21
    ItemHeight = 0
    TabOrder = 0
    Text = 'cbFindText'
  end
  object cbCase: TCheckBox
    Left = 8
    Top = 72
    Width = 161
    Height = 17
    Caption = 'cbCase'
    TabOrder = 2
  end
  object bFind: TButton
    Left = 8
    Top = 96
    Width = 75
    Height = 25
    Caption = 'bFind'
    Default = True
    TabOrder = 3
    OnClick = bFindClick
  end
  object bReplace: TButton
    Left = 96
    Top = 96
    Width = 75
    Height = 25
    Caption = 'bReplace'
    Default = True
    TabOrder = 4
    OnClick = bReplaceClick
  end
  object bReplaceAll: TButton
    Left = 184
    Top = 96
    Width = 81
    Height = 25
    Caption = 'bReplaceAll'
    TabOrder = 5
    OnClick = bReplaceAllClick
  end
  object bCancel: TButton
    Left = 272
    Top = 96
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'bCancel'
    ModalResult = 2
    TabOrder = 6
  end
end
