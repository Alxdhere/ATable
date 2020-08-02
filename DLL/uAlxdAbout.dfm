object frmAbout: TfrmAbout
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmAbout'
  ClientHeight = 257
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lUrl1: TLabel
    Left = 307
    Top = 108
    Width = 109
    Height = 13
    Cursor = crHandPoint
    Caption = 'http://www.alx.ncn.ru'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = lUrlClick
  end
  object lMail1: TLabel
    Left = 308
    Top = 75
    Width = 108
    Height = 13
    Cursor = crHandPoint
    Caption = 'alexandrkozin@mail.ru'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = lMailClick
  end
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 162
    Height = 240
  end
  object lCopyright: TLabel
    Left = 176
    Top = 24
    Width = 205
    Height = 13
    Caption = 'Copyright '#169' 2001 - 2008 Alx Development'
  end
  object lRights: TLabel
    Left = 176
    Top = 40
    Width = 87
    Height = 13
    Caption = 'All rights reserved'
  end
  object lTitle: TLabel
    Left = 176
    Top = 8
    Width = 144
    Height = 13
    Caption = 'ATable for AutoCAD v8.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 176
    Top = 56
    Width = 178
    Height = 13
    Caption = 'Development - Alexander Shchetinin:'
  end
  object Label1: TLabel
    Left = 176
    Top = 89
    Width = 85
    Height = 13
    Caption = 'Official web sites:'
  end
  object GroupBox1: TGroupBox
    Left = 175
    Top = 127
    Width = 241
    Height = 121
    Caption = 'Thanks to:'
    TabOrder = 0
    object Label14: TLabel
      Left = 139
      Top = 20
      Width = 60
      Height = 13
      Caption = 'Chen Li Ming'
    end
    object Label15: TLabel
      Left = 140
      Top = 36
      Width = 73
      Height = 13
      Caption = 'Luong Ngoc Thi'
    end
    object Label16: TLabel
      Left = 140
      Top = 52
      Width = 61
      Height = 13
      Caption = 'Jozef Remes'
    end
    object Label17: TLabel
      Tag = 2
      Left = 8
      Top = 100
      Width = 85
      Height = 13
      Cursor = crHandPoint
      Caption = 'Dmitri Tishchenko'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Tag = 2
      Left = 8
      Top = 84
      Width = 71
      Height = 13
      Cursor = crHandPoint
      Caption = 'Denis Shihalev'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Tag = 2
      Left = 8
      Top = 68
      Width = 64
      Height = 13
      Cursor = crHandPoint
      Caption = 'Sergei Rykov'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 8
      Top = 52
      Width = 62
      Height = 13
      Caption = 'Vladimir Zhak'
    end
    object Label21: TLabel
      Left = 8
      Top = 36
      Width = 83
      Height = 13
      Caption = 'Alexander Krutko'
    end
    object Label22: TLabel
      Left = 8
      Top = 20
      Width = 73
      Height = 13
      Caption = 'Mansur Mamkin'
    end
    object Label2: TLabel
      Left = 140
      Top = 68
      Width = 78
      Height = 13
      Caption = 'Alexander Rivilis'
    end
    object Label3: TLabel
      Left = 140
      Top = 84
      Width = 50
      Height = 13
      Caption = 'Ivan Girda'
    end
  end
end
