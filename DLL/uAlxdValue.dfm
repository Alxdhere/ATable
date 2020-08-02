object ValueForm: TValueForm
  Left = 287
  Top = 140
  ActiveControl = eValue
  BorderStyle = bsDialog
  Caption = 'ValueForm'
  ClientHeight = 69
  ClientWidth = 214
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lValue: TLabel
    Left = 8
    Top = 12
    Width = 29
    Height = 13
    Caption = 'lValue'
  end
  object bOk: TButton
    Left = 56
    Top = 40
    Width = 75
    Height = 25
    Caption = 'bOk'
    Default = True
    TabOrder = 0
  end
  object bCancel: TButton
    Left = 136
    Top = 40
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'bCancel'
    ModalResult = 2
    TabOrder = 1
  end
  object eValue: TTntEdit
    Left = 112
    Top = 8
    Width = 99
    Height = 21
    TabOrder = 2
    Text = 'eValue'
  end
end
