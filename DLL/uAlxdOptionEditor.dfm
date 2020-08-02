object frmAlxdOptionEditor: TfrmAlxdOptionEditor
  Left = 132
  Top = 140
  HelpContext = 1500
  ActiveControl = tvProperties
  BorderIcons = [biSystemMenu]
  Caption = 'frmAlxdOptionEditor'
  ClientHeight = 341
  ClientWidth = 342
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  DesignSize = (
    342
    341)
  PixelsPerInch = 96
  TextHeight = 13
  object bOk: TButton
    Left = 165
    Top = 300
    Width = 74
    Height = 26
    HelpContext = 1500
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object bCancel: TButton
    Left = 259
    Top = 300
    Width = 75
    Height = 26
    HelpContext = 1500
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    Default = True
    ModalResult = 2
    TabOrder = 1
  end
  object PageControl: TPageControl
    Left = 6
    Top = 8
    Width = 313
    Height = 289
    ActivePage = tsProperties
    TabOrder = 2
    object tsProperties: TTabSheet
      Caption = 'tsProperties'
      DesignSize = (
        305
        261)
      object lProperties: TLabel
        Left = 8
        Top = 8
        Width = 49
        Height = 13
        Alignment = taRightJustify
        Caption = 'lProperties'
      end
      object lValue: TLabel
        Left = 8
        Top = 224
        Width = 29
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'lValue'
      end
      object bvBrowse: TBevel
        Left = 263
        Top = 223
        Width = 23
        Height = 23
        Visible = False
      end
      object tvProperties: TTntTreeView
        Left = 8
        Top = 24
        Width = 289
        Height = 188
        HelpContext = 1500
        HideSelection = False
        Indent = 19
        ReadOnly = True
        TabOrder = 0
        OnAdvancedCustomDrawItem = tvPropertiesAdvancedCustomDrawItem
        OnChanging = tvPropertiesChanging
        OnDeletion = tvPropertiesDeletion
        OnKeyPress = tvPropertiesKeyPress
        Items.NodeData = {
          0103000000210000000000000001000000FFFFFFFFFFFFFFFF00000000020000
          000446006F006E007400210000000000000064000000FFFFFFFFFFFFFFFF0000
          000000000000044E0061006D006500210000000000000065000000FFFFFFFFFF
          FFFFFF000000000000000004530069007A006500250000000000000003000000
          FFFFFFFFFFFFFFFF000000000F0000000645006400690074006F0072002B0000
          000000000084030000FFFFFFFFFFFFFFFF000000000000000009500069007800
          65006C002F006D006D0078002B0000000000000085030000FFFFFFFFFFFFFFFF
          00000000000000000950006900780065006C002F006D006D0079003300000000
          0000008C030000FFFFFFFFFFFFFFFF00000000000000000D4600690078006500
          640043006F006C005700690064007400680035000000000000008D030000FFFF
          FFFFFFFFFFFF00000000000000000E4600690078006500640052006F00770048
          00650069006700680074002F0000000000000087030000FFFFFFFFFFFFFFFF00
          000000000000000B45007800690074004F006E0045006E007400650072003500
          0000000000008A030000FFFFFFFFFFFFFFFF00000000000000000E4400690072
          0065006300740069006F006E0045006E0074006500720031000000000000008B
          030000FFFFFFFFFFFFFFFF00000000000000000C440069007200650063007400
          69006F006E0054006100620029000000000000008E030000FFFFFFFFFFFFFFFF
          00000000000000000857006F007200640057007200610070002B000000000000
          0086030000FFFFFFFFFFFFFFFF000000000000000009530068006F0077004C00
          69006E00650073002B000000000000008F030000FFFFFFFFFFFFFFFF00000000
          0000000009530079006E006300440065006C00610079002B0000000000000090
          030000FFFFFFFFFFFFFFFF000000000000000009530065006C0043006F006C00
          6F0072003200350000000000000092030000FFFFFFFFFFFFFFFF000000000000
          00000E530065006C0065006300740069006F006E0043006F006C006F0072002D
          0000000000000093030000FFFFFFFFFFFFFFFF00000000000000000A46006900
          78006500640043006F006C006F00720031000000000000002C010000FFFFFFFF
          FFFFFFFF00000000000000000C5400720061006E00730070006100720065006E
          00730079003B000000000000002D010000FFFFFFFFFFFFFFFF00000000000000
          00115400720061006E00730070006100720065006E0063007900560061006C00
          75006500210000000000000009000000FFFFFFFFFFFFFFFF0000000003000000
          044D00690073006300290000000000000089030000FFFFFFFFFFFFFFFF000000
          0000000000084C0061006E006700750061006700650027000000000000009103
          0000FFFFFFFFFFFFFFFF000000000000000007440079006E00500072006F0070
          002B0000000000000088030000FFFFFFFFFFFFFFFF0000000000000000095300
          740079006C0065005000610074006800}
        Items.Utf8Data = {
          03000000200000000000000001000000FFFFFFFFFFFFFFFF0000000002000000
          07EFBBBF466F6E74200000000000000064000000FFFFFFFFFFFFFFFF00000000
          0000000007EFBBBF4E616D65200000000000000065000000FFFFFFFFFFFFFFFF
          000000000000000007EFBBBF53697A65220000000000000003000000FFFFFFFF
          FFFFFFFF000000000F00000009EFBBBF456469746F7225000000000000008403
          0000FFFFFFFFFFFFFFFF00000000000000000CEFBBBF506978656C2F6D6D7825
          0000000000000085030000FFFFFFFFFFFFFFFF00000000000000000CEFBBBF50
          6978656C2F6D6D7929000000000000008C030000FFFFFFFFFFFFFFFF00000000
          0000000010EFBBBF4669786564436F6C57696474682A000000000000008D0300
          00FFFFFFFFFFFFFFFF000000000000000011EFBBBF4669786564526F77486569
          676874270000000000000087030000FFFFFFFFFFFFFFFF00000000000000000E
          EFBBBF457869744F6E456E7465722A000000000000008A030000FFFFFFFFFFFF
          FFFF000000000000000011EFBBBF446972656374696F6E456E74657228000000
          000000008B030000FFFFFFFFFFFFFFFF00000000000000000FEFBBBF44697265
          6374696F6E54616224000000000000008E030000FFFFFFFFFFFFFFFF00000000
          000000000BEFBBBF576F726457726170250000000000000086030000FFFFFFFF
          FFFFFFFF00000000000000000CEFBBBF53686F774C696E657325000000000000
          008F030000FFFFFFFFFFFFFFFF00000000000000000CEFBBBF53796E6344656C
          6179250000000000000090030000FFFFFFFFFFFFFFFF00000000000000000CEF
          BBBF53656C436F6C6F72322A0000000000000092030000FFFFFFFFFFFFFFFF00
          0000000000000011EFBBBF53656C656374696F6E436F6C6F7226000000000000
          0093030000FFFFFFFFFFFFFFFF00000000000000000DEFBBBF4669786564436F
          6C6F7228000000000000002C010000FFFFFFFFFFFFFFFF00000000000000000F
          EFBBBF5472616E73706172656E73792D000000000000002D010000FFFFFFFFFF
          FFFFFF000000000000000014EFBBBF5472616E73706172656E637956616C7565
          200000000000000009000000FFFFFFFFFFFFFFFF000000000300000007EFBBBF
          4D697363240000000000000089030000FFFFFFFFFFFFFFFF0000000000000000
          0BEFBBBF4C616E6775616765230000000000000091030000FFFFFFFFFFFFFFFF
          00000000000000000AEFBBBF44796E50726F70250000000000000088030000FF
          FFFFFFFFFFFFFF00000000000000000CEFBBBF5374796C6550617468}
      end
      object cbValue: TComboBox
        Left = 104
        Top = 224
        Width = 159
        Height = 21
        HelpContext = 1500
        Style = csSimple
        Anchors = [akLeft]
        ItemHeight = 13
        TabOrder = 1
        OnSelect = cbValueSelect
      end
      object bBrowse: TButton
        Left = 280
        Top = 224
        Width = 21
        Height = 21
        HelpContext = 1500
        Caption = '...'
        TabOrder = 2
        Visible = False
        OnClick = bBrowseClick
      end
      object cbColor: TColorBox
        Left = 84
        Top = 224
        Width = 145
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 3
        Visible = False
      end
    end
    object tsActions: TTabSheet
      Caption = 'tsActions'
      ImageIndex = 1
      DesignSize = (
        305
        261)
      object lActions: TLabel
        Left = 8
        Top = 8
        Width = 37
        Height = 13
        Caption = 'lActions'
      end
      object lHotkey: TLabel
        Left = 8
        Top = 227
        Width = 36
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'lHotkey'
      end
      object bvClear: TBevel
        Left = 263
        Top = 223
        Width = 23
        Height = 23
      end
      object lbActions: TListBox
        Left = 8
        Top = 24
        Width = 289
        Height = 188
        HelpContext = 1500
        Style = lbOwnerDrawFixed
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clBtnFace
        ExtendedSelect = False
        ItemHeight = 18
        TabOrder = 0
        OnClick = lbActionsClick
        OnDrawItem = lbActionsDrawItem
      end
      object hkAction: THotKey
        Left = 104
        Top = 224
        Width = 161
        Height = 19
        HelpContext = 1500
        Anchors = [akLeft, akRight, akBottom]
        HotKey = 0
        Modifiers = []
        TabOrder = 1
        OnChange = hkActionChange
      end
      object bClear: TButton
        Left = 280
        Top = 224
        Width = 21
        Height = 21
        HelpContext = 1500
        Caption = 'X'
        TabOrder = 2
        OnClick = bClearClick
      end
    end
  end
end
