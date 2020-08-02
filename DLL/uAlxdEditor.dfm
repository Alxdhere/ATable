object frmEditor: TfrmEditor
  Left = 0
  Top = 0
  Action = rcAddRow
  ClientHeight = 609
  ClientWidth = 572
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmMain
  OldCreateOrder = False
  Position = poDesigned
  OnClick = rcExecute
  OnClose = TntFormClose
  PixelsPerInch = 96
  TextHeight = 13
  object TTntToolButton
    Left = 0
    Top = 0
  end
  object TTntToolButton
    Left = 0
    Top = 0
  end
  object TTntToolButton
    Left = 0
    Top = 0
  end
  object TTntToolButton
    Left = 0
    Top = 0
  end
  object TTntToolButton
    Left = 0
    Top = 0
  end
  object TTntToolButton
    Left = 0
    Top = 0
  end
  object TTntToolButton
    Left = 0
    Top = 0
  end
  object TTntToolButton
    Left = 0
    Top = 0
  end
  object TTntToolButton
    Left = 0
    Top = 0
  end
  object TTntToolButton
    Left = 0
    Top = 0
  end
  object TTntToolButton
    Left = 0
    Top = 0
  end
  object TTntToolButton
    Left = 0
    Top = 0
  end
  object sbMain: TTntStatusBar
    Left = 0
    Top = 590
    Width = 572
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Bevel = pbNone
        Style = psOwnerDraw
        Width = 20
      end
      item
        Bevel = pbNone
        Style = psOwnerDraw
        Width = 20
      end
      item
        Bevel = pbNone
        Style = psOwnerDraw
        Width = 20
      end
      item
        Width = 50
      end>
    OnMouseDown = sbMainMouseDown
    OnMouseLeave = sbMainMouseLeave
    OnMouseMove = sbMainMouseMove
    OnMouseUp = sbMainMouseUp
    OnDrawPanel = sbMainDrawPanel
    OnResize = sbMainResize
  end
  object cbMain: TTntControlBar
    Left = 0
    Top = 0
    Width = 572
    Height = 78
    Align = alTop
    AutoSize = True
    BevelInner = bvNone
    BevelOuter = bvNone
    PopupMenu = pmMain
    TabOrder = 1
    object tbRows: TTntToolBar
      Left = 11
      Top = 2
      Width = 71
      Height = 22
      Images = ilMain
      TabOrder = 0
      Wrapable = False
      object tbAddRow: TTntToolButton
        Left = 0
        Top = 0
        Action = rcAddRow
      end
      object tbInsertRow: TTntToolButton
        Left = 23
        Top = 0
        Action = rcInsertRow
      end
      object tbDeleteRow: TTntToolButton
        Left = 46
        Top = 0
        Action = rcDeleteRow
      end
    end
    object tbCols: TTntToolBar
      Left = 95
      Top = 2
      Width = 71
      Height = 22
      Images = ilMain
      TabOrder = 1
      Wrapable = False
      object tbAddColumn: TTntToolButton
        Left = 0
        Top = 0
        Action = ccAddColumn
      end
      object tbInsertColumn: TTntToolButton
        Left = 23
        Top = 0
        Action = ccInsertColumn
      end
      object tbDeleteColumn: TTntToolButton
        Left = 46
        Top = 0
        Action = ccDeleteColumn
      end
    end
    object tbJoins: TTntToolBar
      Left = 179
      Top = 2
      Width = 94
      Height = 22
      Images = ilMain
      TabOrder = 2
      Wrapable = False
      object tbJoin: TTntToolButton
        Left = 0
        Top = 0
        Action = jcJoin
      end
      object tbJoinByRow: TTntToolButton
        Left = 23
        Top = 0
        Action = jcJoinByRow
      end
      object tbJoinByCol: TTntToolButton
        Left = 46
        Top = 0
        Action = jcJoinByCol
      end
      object tbDisjoin: TTntToolButton
        Left = 69
        Top = 0
        Action = jcDisjoin
      end
    end
    object tbhAlign: TTntToolBar
      Left = 11
      Top = 28
      Width = 94
      Height = 22
      Images = ilMain
      TabOrder = 3
      Wrapable = False
      object tbhDefault: TTntToolButton
        Left = 0
        Top = 0
        Action = haDefault
      end
      object tbLeft: TTntToolButton
        Left = 23
        Top = 0
        Action = haLeft
      end
      object tbCenter: TTntToolButton
        Left = 46
        Top = 0
        Action = haCenter
      end
      object tbRight: TTntToolButton
        Left = 69
        Top = 0
        Action = haRight
      end
    end
    object tbvAlign: TTntToolBar
      Left = 118
      Top = 28
      Width = 117
      Height = 22
      Images = ilMain
      TabOrder = 4
      Wrapable = False
      object tbvDefault: TTntToolButton
        Left = 0
        Top = 0
        Action = vaDefault
      end
      object tbBaseline: TTntToolButton
        Left = 23
        Top = 0
        Action = vaBaseline
      end
      object tbBottom: TTntToolButton
        Left = 46
        Top = 0
        Action = vaBottom
      end
      object tbMiddle: TTntToolButton
        Left = 69
        Top = 0
        Action = vaMiddle
      end
      object tbTop: TTntToolButton
        Left = 92
        Top = 0
        Action = vaTop
      end
    end
    object tbTextType: TTntToolBar
      Left = 248
      Top = 28
      Width = 125
      Height = 22
      Images = ilMain
      TabOrder = 5
      Wrapable = False
      object tbtDefault: TTntToolButton
        Left = 0
        Top = 0
        Action = ttDefault
      end
      object tbMText: TTntToolButton
        Left = 23
        Top = 0
        Action = ttMText
      end
      object tbDText: TTntToolButton
        Left = 46
        Top = 0
        Action = ttDText
      end
      object tbBlock: TTntToolButton
        Left = 69
        Top = 0
        Action = ttBlock
      end
      object tbsRotation: TTntToolButton
        Left = 92
        Top = 0
        Width = 8
        Caption = 'tbsRotation'
        Style = tbsSeparator
      end
      object tbRotation: TTntToolButton
        Left = 100
        Top = 0
        Action = trRotation
      end
    end
    object tbFits: TTntToolBar
      Left = 286
      Top = 2
      Width = 117
      Height = 22
      Images = ilMain
      TabOrder = 6
      Wrapable = False
      object tbfDefault: TTntToolButton
        Left = 0
        Top = 0
        Action = tfDefault
      end
      object tbFit: TTntToolButton
        Left = 23
        Top = 0
        Action = tfFit
      end
      object tbBreak: TTntToolButton
        Left = 46
        Top = 0
        Action = tfBreak
      end
      object tbUnbreaked: TTntToolButton
        Left = 69
        Top = 0
        Action = tfUnbreaked
      end
      object tbFitted: TTntToolButton
        Left = 92
        Top = 0
        Action = tfFitted
      end
    end
    object tbBorders: TTntToolBar
      Left = 11
      Top = 54
      Width = 209
      Height = 22
      Images = ilMain
      TabOrder = 7
      Wrapable = False
      object tbbLeft: TTntToolButton
        Left = 0
        Top = 0
        Action = bdLeft
      end
      object tbbTop: TTntToolButton
        Left = 23
        Top = 0
        Action = bdTop
      end
      object tbbRight: TTntToolButton
        Left = 46
        Top = 0
        Action = bdRight
      end
      object tbbBottom: TTntToolButton
        Left = 69
        Top = 0
        Action = bdBottom
      end
      object tbbVer: TTntToolButton
        Left = 92
        Top = 0
        Action = bdVertical
      end
      object tbbHor: TTntToolButton
        Left = 115
        Top = 0
        Action = bdHorizontal
      end
      object tbbCross: TTntToolButton
        Left = 138
        Top = 0
        Action = bdCross
      end
      object tbbContour: TTntToolButton
        Left = 161
        Top = 0
        Action = bdContour
      end
      object tbbAll: TTntToolButton
        Left = 184
        Top = 0
        Action = bdAll
      end
    end
    object tbFills: TTntToolBar
      Left = 233
      Top = 54
      Width = 71
      Height = 22
      Images = ilMain
      TabOrder = 8
      Wrapable = False
      object tbfcDefault: TTntToolButton
        Left = 0
        Top = 0
        Action = fcDefault
      end
      object tbfcEmpty: TTntToolButton
        Left = 23
        Top = 0
        Action = fcEmpty
      end
      object tbfcFill: TTntToolButton
        Left = 46
        Top = 0
        Action = fcFill
      end
    end
    object tbNumProperties: TTntToolBar
      Tag = 220
      Left = 317
      Top = 54
      Width = 165
      Height = 22
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = ilMain
      TabOrder = 9
      Wrapable = False
      object tbNumProperty: TTntToolButton
        Left = 0
        Top = 0
        Action = npHeight
        DropdownMenu = pmMain
      end
      object tbsNumProperty: TTntToolButton
        Left = 23
        Top = 0
        Width = 8
        Caption = 'tbsNumProperty'
        Style = tbsSeparator
      end
      object cbNumProperty: TTntComboBox
        Left = 31
        Top = 0
        Width = 118
        Height = 21
        ItemHeight = 0
        TabOrder = 0
        Text = 'cbNumProperty'
        OnExit = cbSelectOrExit
        OnKeyPress = cbNumPropertyKeyPress
        OnSelect = cbSelectOrExit
      end
    end
    object tbMargins: TTntToolBar
      Tag = 230
      Left = 386
      Top = 28
      Width = 165
      Height = 22
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = ilMain
      TabOrder = 10
      Wrapable = False
      object tbMargin: TTntToolButton
        Left = 0
        Top = 0
        Action = mnLeft
        DropdownMenu = pmMain
      end
      object tbsMargin: TTntToolButton
        Left = 23
        Top = 0
        Width = 8
        Caption = 'tbsMargin'
        Style = tbsSeparator
      end
      object cbMargin: TTntComboBox
        Left = 31
        Top = 0
        Width = 118
        Height = 21
        ItemHeight = 0
        TabOrder = 0
        Text = 'cbMargin'
        OnExit = cbSelectOrExit
        OnKeyPress = cbMarginKeyPress
        OnSelect = cbSelectOrExit
      end
    end
    object tbEdits: TTntToolBar
      Left = 416
      Top = 2
      Width = 125
      Height = 22
      Images = ilMain
      TabOrder = 11
      Wrapable = False
      object tbCut: TTntToolButton
        Left = 0
        Top = 0
        Action = edCut
      end
      object tbCopy: TTntToolButton
        Left = 23
        Top = 0
        Action = edCopy
      end
      object tbPaste: TTntToolButton
        Left = 46
        Top = 0
        Action = edPaste
      end
      object tbsEdit: TTntToolButton
        Left = 69
        Top = 0
        Width = 8
        Caption = 'tbsEdit'
        Style = tbsSeparator
      end
      object tbUndo: TTntToolButton
        Left = 77
        Top = 0
        Action = edUndo
      end
      object tbRedo: TTntToolButton
        Left = 100
        Top = 0
        Action = edRedo
      end
    end
  end
  object pBackground: TTntPanel
    Left = 0
    Top = 78
    Width = 572
    Height = 512
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pBackground'
    TabOrder = 2
    object pBackgroundSheets: TTntPanel
      Left = 0
      Top = 0
      Width = 572
      Height = 512
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pBackgroundSheets'
      TabOrder = 0
      object tsAlxdSpreadSheets: TTabSet
        Left = 0
        Top = 491
        Width = 572
        Height = 21
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        SelectedColor = clWindow
        SoftTop = True
        UnselectedColor = clBtnFace
        OnChange = tsAlxdSpreadSheetsChange
      end
    end
  end
  object mmMain: TTntMainMenu
    Images = ilMain
    Left = 184
    Top = 360
    object mnGrid: TTntMenuItem
      Caption = 'mnGrid'
      object ssNew1: TTntMenuItem
        Action = ssNew
      end
      object ssRead1: TTntMenuItem
        Action = ssOpen
      end
      object gsOpenFromXML1: TTntMenuItem
        Action = ssOpenFromXML
      end
      object nImport: TTntMenuItem
        Caption = '-'
      end
      object gsSaveToXML1: TTntMenuItem
        Action = ssSaveToXML
      end
      object ssSaveAsToXML1: TTntMenuItem
        Action = ssSaveAsToXML
      end
      object ssInsert1: TTntMenuItem
        Action = ssInsert
      end
      object ssClose1: TTntMenuItem
        Action = ssClose
      end
      object N13: TTntMenuItem
        Caption = '-'
      end
      object ssExit1: TTntMenuItem
        Action = ssExit
      end
    end
    object mnEdit: TTntMenuItem
      Caption = 'mnEdit'
      object edUndo1: TTntMenuItem
        Action = edUndo
      end
      object edRedo1: TTntMenuItem
        Action = edRedo
      end
      object N1: TTntMenuItem
        Caption = '-'
      end
      object edCut1: TTntMenuItem
        Action = edCut
      end
      object edCopy1: TTntMenuItem
        Action = edCopy
      end
      object edPaste1: TTntMenuItem
        Action = edPaste
      end
      object edPasteSpecial1: TTntMenuItem
        Action = edPasteSpecial
      end
      object N11: TTntMenuItem
        Caption = '-'
      end
      object mnDel: TTntMenuItem
        Caption = 'mnDel'
        object edDelContent1: TTntMenuItem
          Action = edDelContent
        end
        object edDelFormat1: TTntMenuItem
          Action = edDelFormat
        end
        object edDelAll1: TTntMenuItem
          Action = edDelAll
        end
      end
      object edSelectAll1: TTntMenuItem
        Action = edSelectAll
      end
      object N12: TTntMenuItem
        Caption = '-'
      end
      object edFind1: TTntMenuItem
        Action = edFind
      end
      object edFind2: TTntMenuItem
        Action = edFindAgain
      end
      object edReplace1: TTntMenuItem
        Action = edReplace
      end
    end
    object mnStyle: TTntMenuItem
      Caption = 'mnStyle'
      object slSelect1: TTntMenuItem
        Action = slSelect
      end
      object slApply1: TTntMenuItem
        Action = slApply
      end
      object slChange1: TTntMenuItem
        Action = slChange
      end
      object slMake1: TTntMenuItem
        Action = slMake
      end
      object N5: TTntMenuItem
        Caption = '-'
      end
      object stDrawBorder1: TTntMenuItem
        Action = stDrawBorder
      end
      object stFillCell1: TTntMenuItem
        Action = stFillCell
      end
      object stTextFit1: TTntMenuItem
        Action = stTextFit
      end
      object stTextType1: TTntMenuItem
        Action = stTextType
      end
      object N6: TTntMenuItem
        Caption = '-'
      end
      object jfTopLeft1: TTntMenuItem
        Action = jfTopLeft
      end
      object jfTopRight1: TTntMenuItem
        Action = jfTopRight
      end
      object jfBottomLeft1: TTntMenuItem
        Action = jfBottomLeft
      end
      object jfBottomRight1: TTntMenuItem
        Action = jfBottomRight
      end
    end
    object mnInsert: TTntMenuItem
      Caption = 'mnInsert'
      object rcAddRows1: TTntMenuItem
        Action = rcAddRows
      end
      object ccAddColumns1: TTntMenuItem
        Action = ccAddColumns
      end
      object N2: TTntMenuItem
        Caption = '-'
      end
      object rcAddRow1: TTntMenuItem
        Action = rcAddRow
      end
      object rcInsertRow1: TTntMenuItem
        Action = rcInsertRow
      end
      object rcDeleteRow1: TTntMenuItem
        Action = rcDeleteRow
      end
      object N3: TTntMenuItem
        Caption = '-'
      end
      object ccAddColumn1: TTntMenuItem
        Action = ccAddColumn
      end
      object ccInsertColumn1: TTntMenuItem
        Action = ccInsertColumn
      end
      object ccDeleteColumn1: TTntMenuItem
        Action = ccDeleteColumn
      end
      object N4: TTntMenuItem
        Caption = '-'
      end
      object mnRows: TTntMenuItem
        Caption = 'mnRows'
        object irResetRowSize1: TTntMenuItem
          Action = irResetRowSize
        end
        object irChangeRowSize1: TTntMenuItem
          Action = irChangeRowSize
        end
        object irAutoRowSize1: TTntMenuItem
          Action = irAutoRowSize
        end
        object irChangeRowName1: TTntMenuItem
          Action = irChangeRowName
        end
        object irRowInvisible1: TTntMenuItem
          Action = irRowInvisible
          AutoCheck = True
        end
      end
      object mnCols: TTntMenuItem
        Caption = 'mnCols'
        object icResetColSize1: TTntMenuItem
          Action = icResetColSize
        end
        object icChangeColSize1: TTntMenuItem
          Action = icChangeColSize
        end
        object icAutoColSize1: TTntMenuItem
          Action = icAutoColSize
        end
        object icChangeColName1: TTntMenuItem
          Action = icChangeColName
        end
        object icColInvisible1: TTntMenuItem
          Action = icColInvisible
          AutoCheck = True
        end
      end
    end
    object mnAlign: TTntMenuItem
      Caption = 'mnAlign'
      object haDefault1: TTntMenuItem
        Action = haDefault
      end
      object haLeft1: TTntMenuItem
        Action = haLeft
      end
      object haCenter1: TTntMenuItem
        Action = haCenter
      end
      object haRight1: TTntMenuItem
        Action = haRight
      end
      object N7: TTntMenuItem
        Caption = '-'
      end
      object vaDefault1: TTntMenuItem
        Action = vaDefault
      end
      object vaBaseline1: TTntMenuItem
        Action = vaBaseline
      end
      object vaBottom1: TTntMenuItem
        Action = vaBottom
      end
      object vaMiddle1: TTntMenuItem
        Action = vaMiddle
      end
      object vaTop1: TTntMenuItem
        Action = vaTop
      end
    end
    object mnFormat: TTntMenuItem
      Caption = 'mnFormat'
      object ftFormat1: TTntMenuItem
        Action = ftFormat
      end
      object mnTextFit: TTntMenuItem
        Caption = 'mnTextFit'
        object tfDefault1: TTntMenuItem
          Action = tfDefault
        end
        object tfFit1: TTntMenuItem
          Action = tfFit
        end
        object tfBreak1: TTntMenuItem
          Action = tfBreak
        end
        object tfUnbreaked1: TTntMenuItem
          Action = tfUnbreaked
        end
        object tfFitted1: TTntMenuItem
          Action = tfFitted
        end
      end
      object mnTextFill: TTntMenuItem
        Caption = 'mnTextFill'
        object fcDefault1: TTntMenuItem
          Action = fcDefault
        end
        object fcEmpty1: TTntMenuItem
          Action = fcEmpty
        end
        object fcFill1: TTntMenuItem
          Action = fcFill
        end
      end
      object mnTextType: TTntMenuItem
        Caption = 'mnTextType'
        object ttDefault1: TTntMenuItem
          Action = ttDefault
        end
        object ttMText1: TTntMenuItem
          Action = ttMText
        end
        object ttDText1: TTntMenuItem
          Action = ttDText
        end
        object ttBlock1: TTntMenuItem
          Action = ttBlock
        end
      end
      object mnTextCase: TTntMenuItem
        Caption = 'mnTextCase'
      end
      object N8: TTntMenuItem
        Caption = '-'
      end
      object ftRotate1: TTntMenuItem
        Action = trRotation
      end
      object N9: TTntMenuItem
        Caption = '-'
      end
      object jcJoin1: TTntMenuItem
        Action = jcJoin
      end
      object jcJoinByRow1: TTntMenuItem
        Action = jcJoinByRow
      end
      object jcJoinByCol1: TTntMenuItem
        Action = jcJoinByCol
      end
      object jcDisjoin1: TTntMenuItem
        Action = jcDisjoin
      end
    end
    object mnBorder: TTntMenuItem
      Caption = 'mnBorder'
      object bdLeft1: TTntMenuItem
        Action = bdLeft
      end
      object bdTop1: TTntMenuItem
        Action = bdTop
      end
      object bdRight1: TTntMenuItem
        Action = bdRight
      end
      object bdBottom1: TTntMenuItem
        Action = bdBottom
      end
      object bdVertical1: TTntMenuItem
        Action = bdVertical
      end
      object bdHorizontal1: TTntMenuItem
        Action = bdHorizontal
      end
      object bdCross1: TTntMenuItem
        Action = bdCross
      end
      object bdContour1: TTntMenuItem
        Action = bdContour
      end
      object bdAll1: TTntMenuItem
        Action = bdAll
      end
    end
    object mnTools: TTntMenuItem
      Caption = 'mnTools'
      OnClick = mnToolsClick
      object scSortAO1: TTntMenuItem
        Action = scSortAO
      end
      object scSortNAO1: TTntMenuItem
        Action = scSortNAO
      end
      object scSortNO1: TTntMenuItem
        Action = scSortNO
      end
      object N14: TTntMenuItem
        Caption = '-'
      end
      object msOptions1: TTntMenuItem
        Action = tsOptions
      end
      object mnToolbars: TTntMenuItem
        Caption = 'mnToolbars'
      end
    end
    object mnHelp: TTntMenuItem
      Caption = 'mnHelp'
      object msHelp1: TTntMenuItem
        Action = msHelp
      end
      object msHomepage1: TTntMenuItem
        Action = msHomepage
      end
      object N10: TTntMenuItem
        Caption = '-'
      end
      object msAbout1: TTntMenuItem
        Action = msAbout
      end
    end
  end
  object alMain: TTntActionList
    Images = ilMain
    Left = 216
    Top = 360
    object rcAddRow: TTntAction
      Tag = 110
      Category = 'Rows'
      Caption = 'rcAddRow'
      ImageIndex = 14
      OnExecute = rcExecute
    end
    object rcInsertRow: TTntAction
      Tag = 111
      Category = 'Rows'
      Caption = 'rcInsertRow'
      ImageIndex = 15
      OnExecute = rcExecute
    end
    object rcDeleteRow: TTntAction
      Tag = 112
      Category = 'Rows'
      Caption = 'rcDeleteRow'
      ImageIndex = 16
      OnExecute = rcExecute
    end
    object ccAddColumn: TTntAction
      Tag = 100
      Category = 'Cols'
      Caption = 'ccAddColumn'
      ImageIndex = 10
      OnExecute = ccExecute
    end
    object ccInsertColumn: TTntAction
      Tag = 101
      Category = 'Cols'
      Caption = 'ccInsertColumn'
      ImageIndex = 11
      OnExecute = ccExecute
    end
    object ccDeleteColumn: TTntAction
      Tag = 102
      Category = 'Cols'
      Caption = 'ccDeleteColumn'
      ImageIndex = 12
      OnExecute = ccExecute
    end
    object jcJoin: TTntAction
      Tag = 280
      Category = 'Join'
      Caption = 'jcJoin'
      ImageIndex = 68
      OnExecute = jcExecute
    end
    object jcJoinByRow: TTntAction
      Tag = 281
      Category = 'Join'
      Caption = 'jcJoinByRow'
      ImageIndex = 69
      OnExecute = jcExecute
    end
    object jcJoinByCol: TTntAction
      Tag = 282
      Category = 'Join'
      Caption = 'jcJoinByCol'
      ImageIndex = 70
      OnExecute = jcExecute
    end
    object jcDisjoin: TTntAction
      Tag = 283
      Category = 'Join'
      Caption = 'jcDisjoin'
      ImageIndex = 71
      OnExecute = jcExecute
    end
    object ssNew: TTntAction
      Tag = 800
      Category = 'Grid'
      Caption = 'ssNew'
      ImageIndex = 90
      ShortCut = 16462
      OnExecute = ssExecute
    end
    object ssOpen: TTntAction
      Tag = 801
      Category = 'Grid'
      Caption = 'ssOpen'
      OnExecute = ssExecute
    end
    object ssOpenFromXML: TTntAction
      Tag = 802
      Category = 'Grid'
      Caption = 'ssOpenFromXML'
      ImageIndex = 91
      ShortCut = 16463
      OnExecute = ssExecute
    end
    object ssSaveToXML: TTntAction
      Tag = 803
      Category = 'Grid'
      Caption = 'ssSaveToXML'
      ImageIndex = 92
      ShortCut = 16467
      OnExecute = ssExecute
    end
    object ssSaveAsToXML: TTntAction
      Tag = 804
      Category = 'Grid'
      Caption = 'ssSaveAsToXML'
      OnExecute = ssExecute
    end
    object ssInsert: TTntAction
      Tag = 805
      Category = 'Grid'
      Caption = 'ssInsert'
      OnExecute = ssExecute
    end
    object ssClose: TTntAction
      Tag = 806
      Category = 'Grid'
      Caption = 'ssClose'
      OnExecute = ssExecute
    end
    object ccAddColumns: TTntAction
      Tag = 103
      Category = 'Cols'
      Caption = 'ccAddColumns'
      ImageIndex = 13
      OnExecute = ccExecute
    end
    object rcAddRows: TTntAction
      Tag = 113
      Category = 'Rows'
      Caption = 'rcAddRows'
      ImageIndex = 17
      OnExecute = rcExecute
    end
    object haDefault: TTntAction
      Tag = 200
      Category = 'Horizontal'
      Caption = 'haDefault'
      GroupIndex = 200
      ImageIndex = 35
      OnExecute = haExecute
    end
    object haLeft: TTntAction
      Tag = 201
      Category = 'Horizontal'
      Caption = 'haLeft'
      GroupIndex = 200
      ImageIndex = 36
      ShortCut = 16460
      OnExecute = haExecute
    end
    object haCenter: TTntAction
      Tag = 202
      Category = 'Horizontal'
      Caption = 'haCenter'
      GroupIndex = 200
      ImageIndex = 37
      ShortCut = 16453
      OnExecute = haExecute
    end
    object haRight: TTntAction
      Tag = 203
      Category = 'Horizontal'
      Caption = 'haRight'
      GroupIndex = 200
      ImageIndex = 38
      ShortCut = 16466
      OnExecute = haExecute
    end
    object vaDefault: TTntAction
      Tag = 210
      Category = 'Vertical'
      Caption = 'vaDefault'
      GroupIndex = 210
      ImageIndex = 39
      OnExecute = vaExecute
    end
    object vaBaseline: TTntAction
      Tag = 211
      Category = 'Vertical'
      Caption = 'vaBaseline'
      GroupIndex = 210
      ImageIndex = 40
      OnExecute = vaExecute
    end
    object vaBottom: TTntAction
      Tag = 212
      Category = 'Vertical'
      Caption = 'vaBottom'
      GroupIndex = 210
      ImageIndex = 41
      OnExecute = vaExecute
    end
    object vaMiddle: TTntAction
      Tag = 213
      Category = 'Vertical'
      Caption = 'vaMiddle'
      GroupIndex = 210
      ImageIndex = 42
      OnExecute = vaExecute
    end
    object vaTop: TTntAction
      Tag = 214
      Category = 'Vertical'
      Caption = 'vaTop'
      GroupIndex = 210
      ImageIndex = 43
      OnExecute = vaExecute
    end
    object ttDefault: TTntAction
      Tag = 260
      Category = 'TextType'
      Caption = 'ttDefault'
      GroupIndex = 260
      ImageIndex = 60
      OnExecute = ttExecute
    end
    object ttMText: TTntAction
      Tag = 261
      Category = 'TextType'
      Caption = 'ttMText'
      GroupIndex = 260
      ImageIndex = 61
      OnExecute = ttExecute
    end
    object ttDText: TTntAction
      Tag = 262
      Category = 'TextType'
      Caption = 'ttDText'
      GroupIndex = 260
      ImageIndex = 62
      OnExecute = ttExecute
    end
    object ttBlock: TTntAction
      Tag = 263
      Category = 'TextType'
      Caption = 'ttBlock'
      GroupIndex = 260
      ImageIndex = 63
      OnExecute = ttExecute
    end
    object tfDefault: TTntAction
      Tag = 240
      Category = 'TextFit'
      Caption = 'tfDefault'
      GroupIndex = 240
      ImageIndex = 52
      OnExecute = tfExecute
    end
    object tfFit: TTntAction
      Tag = 241
      Category = 'TextFit'
      Caption = 'tfFit'
      GroupIndex = 240
      ImageIndex = 53
      OnExecute = tfExecute
    end
    object tfBreak: TTntAction
      Tag = 242
      Category = 'TextFit'
      Caption = 'tfBreak'
      GroupIndex = 240
      ImageIndex = 54
      OnExecute = tfExecute
    end
    object tfUnbreaked: TTntAction
      Tag = 243
      Category = 'TextFit'
      Caption = 'tfUnbreaked'
      GroupIndex = 240
      ImageIndex = 55
      OnExecute = tfExecute
    end
    object tfFitted: TTntAction
      Tag = 244
      Category = 'TextFit'
      Caption = 'tfFitted'
      GroupIndex = 240
      ImageIndex = 56
      OnExecute = tfExecute
    end
    object icResetColSize: TTntAction
      Tag = 120
      Category = 'Cols'
      Caption = 'icResetColSize'
      OnExecute = icExecute
    end
    object icChangeColName: TTntAction
      Tag = 121
      Category = 'Cols'
      Caption = 'icChangeColName'
      OnExecute = icExecute
    end
    object icChangeColSize: TTntAction
      Tag = 122
      Category = 'Cols'
      Caption = 'icChangeColSize'
      OnExecute = icExecute
    end
    object icAutoColSize: TTntAction
      Tag = 123
      Category = 'Cols'
      Caption = 'icAutoColSize'
      OnExecute = icExecute
    end
    object icColInvisible: TTntAction
      Tag = 124
      Category = 'Cols'
      AutoCheck = True
      Caption = 'icColInvisible'
      OnExecute = icExecute
    end
    object irResetRowSize: TTntAction
      Tag = 130
      Category = 'Rows'
      Caption = 'irResetRowSize'
      OnExecute = irExecute
    end
    object irChangeRowName: TTntAction
      Tag = 131
      Category = 'Rows'
      Caption = 'irChangeRowName'
      OnExecute = irExecute
    end
    object irChangeRowSize: TTntAction
      Tag = 132
      Category = 'Rows'
      Caption = 'irChangeRowSize'
      OnExecute = irExecute
    end
    object irAutoRowSize: TTntAction
      Tag = 133
      Category = 'Rows'
      Caption = 'irAutoRowSize'
      OnExecute = irExecute
    end
    object irRowInvisible: TTntAction
      Tag = 134
      Category = 'Rows'
      AutoCheck = True
      Caption = 'irRowInvisible'
      OnExecute = irExecute
    end
    object bdLeft: TTntAction
      Tag = 290
      Category = 'Borders'
      Caption = 'bdLeft'
      ImageIndex = 72
      OnExecute = bdExecute
    end
    object bdTop: TTntAction
      Tag = 291
      Category = 'Borders'
      Caption = 'bdTop'
      ImageIndex = 75
      OnExecute = bdExecute
    end
    object bdRight: TTntAction
      Tag = 292
      Category = 'Borders'
      Caption = 'bdRight'
      ImageIndex = 74
      OnExecute = bdExecute
    end
    object bdBottom: TTntAction
      Tag = 293
      Category = 'Borders'
      Caption = 'bdBottom'
      ImageIndex = 73
      OnExecute = bdExecute
    end
    object bdVertical: TTntAction
      Tag = 294
      Category = 'Borders'
      Caption = 'bdVertical'
      ImageIndex = 76
      OnExecute = bdExecute
    end
    object bdHorizontal: TTntAction
      Tag = 295
      Category = 'Borders'
      Caption = 'bdHorizontal'
      ImageIndex = 77
      OnExecute = bdExecute
    end
    object bdCross: TTntAction
      Tag = 296
      Category = 'Borders'
      Caption = 'bdCross'
      ImageIndex = 78
      OnExecute = bdExecute
    end
    object bdContour: TTntAction
      Tag = 297
      Category = 'Borders'
      Caption = 'bdContour'
      ImageIndex = 79
      OnExecute = bdExecute
    end
    object bdAll: TTntAction
      Tag = 298
      Category = 'Borders'
      Caption = 'bdAll'
      ImageIndex = 80
      OnExecute = bdExecute
    end
    object slSelect: TTntAction
      Tag = 150
      Category = 'Style'
      Caption = 'slSelect'
      OnExecute = slExecute
    end
    object slApply: TTntAction
      Tag = 151
      Category = 'Style'
      Caption = 'slApply'
      ImageIndex = 19
      OnExecute = slExecute
    end
    object slChange: TTntAction
      Tag = 152
      Category = 'Style'
      Caption = 'slChange'
      ImageIndex = 18
      OnExecute = slExecute
    end
    object slMake: TTntAction
      Tag = 153
      Category = 'Style'
      Caption = 'slMake'
      ImageIndex = 20
      OnExecute = slExecute
    end
    object stDrawBorder: TTntAction
      Tag = 160
      Category = 'State'
      Caption = 'stDrawBorder'
      ImageIndex = 21
      OnExecute = stExecute
    end
    object stFillCell: TTntAction
      Tag = 161
      Category = 'State'
      Caption = 'stFillCell'
      ImageIndex = 23
      OnExecute = stExecute
    end
    object stTextFit: TTntAction
      Tag = 162
      Category = 'State'
      Caption = 'stTextFit'
      ImageIndex = 25
      OnExecute = stExecute
    end
    object stTextType: TTntAction
      Tag = 163
      Category = 'State'
      Caption = 'stTextType'
      ImageIndex = 27
      OnExecute = stExecute
    end
    object jfTopLeft: TTntAction
      Tag = 180
      Category = 'Justify'
      Caption = 'jfTopLeft'
      GroupIndex = 180
      ImageIndex = 29
      OnExecute = jfExecute
    end
    object jfTopRight: TTntAction
      Tag = 181
      Category = 'Justify'
      Caption = 'jfTopRight'
      GroupIndex = 180
      ImageIndex = 30
      OnExecute = jfExecute
    end
    object jfBottomLeft: TTntAction
      Tag = 182
      Category = 'Justify'
      Caption = 'jfBottomLeft'
      GroupIndex = 180
      ImageIndex = 31
      OnExecute = jfExecute
    end
    object jfBottomRight: TTntAction
      Tag = 183
      Category = 'Justify'
      Caption = 'jfBottomRight'
      GroupIndex = 180
      ImageIndex = 32
      OnExecute = jfExecute
    end
    object fcDefault: TTntAction
      Tag = 250
      Category = 'Fills'
      Caption = 'fcDefault'
      GroupIndex = 250
      ImageIndex = 57
      OnExecute = fcExecute
    end
    object fcEmpty: TTntAction
      Tag = 251
      Category = 'Fills'
      Caption = 'fcEmpty'
      GroupIndex = 250
      ImageIndex = 58
      OnExecute = fcExecute
    end
    object fcFill: TTntAction
      Tag = 252
      Category = 'Fills'
      Caption = 'fcFill'
      GroupIndex = 250
      ImageIndex = 59
      OnExecute = fcExecute
    end
    object msHelp: TTntAction
      Tag = 1500
      Category = 'Help'
      Caption = 'msHelp'
      ImageIndex = 98
      OnExecute = msExecute
    end
    object msHomepage: TTntAction
      Tag = 1501
      Category = 'Help'
      Caption = 'msHomepage'
      ImageIndex = 97
      OnExecute = msExecute
    end
    object msAbout: TTntAction
      Tag = 1502
      Category = 'Help'
      Caption = 'msAbout'
      OnExecute = msExecute
    end
    object npHeight: TTntAction
      Tag = 220
      Category = 'NumProperties'
      Caption = 'npHeight'
      GroupIndex = 220
      ImageIndex = 44
      OnExecute = npExecute
    end
    object npWidthFactor: TTntAction
      Tag = 221
      Category = 'NumProperties'
      Caption = 'npWidthFactor'
      GroupIndex = 220
      ImageIndex = 45
      OnExecute = npExecute
    end
    object npObliqueAngle: TTntAction
      Tag = 222
      Category = 'NumProperties'
      Caption = 'npObliqueAngle'
      GroupIndex = 220
      ImageIndex = 46
      OnExecute = npExecute
    end
    object npBetween: TTntAction
      Tag = 223
      Category = 'NumProperties'
      Caption = 'npBetween'
      GroupIndex = 220
      ImageIndex = 47
      OnExecute = npExecute
    end
    object mnLeft: TTntAction
      Tag = 230
      Category = 'Margins'
      Caption = 'mnLeft'
      GroupIndex = 230
      ImageIndex = 48
      OnExecute = mnExecute
    end
    object mnTop: TTntAction
      Tag = 231
      Category = 'Margins'
      Caption = 'mnTop'
      GroupIndex = 230
      ImageIndex = 51
      OnExecute = mnExecute
    end
    object mnRight: TTntAction
      Tag = 232
      Category = 'Margins'
      Caption = 'mnRight'
      GroupIndex = 230
      ImageIndex = 50
      OnExecute = mnExecute
    end
    object mnBottom: TTntAction
      Tag = 233
      Category = 'Margins'
      Caption = 'mnBottom'
      GroupIndex = 230
      ImageIndex = 49
      OnExecute = mnExecute
    end
    object edUndo: TTntAction
      Tag = 50
      Category = 'Edit'
      Caption = 'edUndo'
      ImageIndex = 0
      ShortCut = 16474
      OnExecute = edExecute
    end
    object edRedo: TTntAction
      Tag = 51
      Category = 'Edit'
      Caption = 'edRedo'
      ImageIndex = 1
      ShortCut = 16473
      OnExecute = edExecute
    end
    object edCut: TTntAction
      Tag = 52
      Category = 'Edit'
      Caption = 'edCut'
      ImageIndex = 2
      ShortCut = 16472
      OnExecute = edExecute
    end
    object edCopy: TTntAction
      Tag = 53
      Category = 'Edit'
      Caption = 'edCopy'
      ImageIndex = 3
      ShortCut = 16451
      OnExecute = edExecute
    end
    object edPaste: TTntAction
      Tag = 54
      Category = 'Edit'
      Caption = 'edPaste'
      ImageIndex = 4
      ShortCut = 16470
      OnExecute = edExecute
    end
    object edPasteSpecial: TTntAction
      Tag = 55
      Category = 'Edit'
      Caption = 'edPasteSpecial'
      OnExecute = edExecute
    end
    object edDelFormat: TTntAction
      Tag = 56
      Category = 'Edit'
      Caption = 'edDelFormat'
      OnExecute = edExecute
    end
    object edDelContent: TTntAction
      Tag = 57
      Category = 'Edit'
      Caption = 'edDelContent'
      ShortCut = 46
      OnExecute = edExecute
    end
    object edDelAll: TTntAction
      Tag = 58
      Category = 'Edit'
      Caption = 'edDelAll'
      ImageIndex = 5
      OnExecute = edExecute
    end
    object edSelectAll: TTntAction
      Tag = 59
      Category = 'Edit'
      Caption = 'edSelectAll'
      ShortCut = 16449
      OnExecute = edExecute
    end
    object edFind: TTntAction
      Tag = 70
      Category = 'Edit'
      Caption = 'edFind'
      ImageIndex = 6
      ShortCut = 16454
      OnExecute = edExecute
    end
    object edFindAgain: TTntAction
      Tag = 71
      Category = 'Edit'
      Caption = 'edFindAgain'
      ImageIndex = 7
      ShortCut = 114
      OnExecute = edExecute
    end
    object edReplace: TTntAction
      Tag = 72
      Category = 'Edit'
      Caption = 'edReplace'
      ImageIndex = 8
      ShortCut = 16466
      OnExecute = edExecute
    end
    object icCopyCellsAll: TTntAction
      Tag = 300
      Category = 'CellsDrag'
      Caption = 'icCopyCellsAll'
      ImageIndex = 81
      OnExecute = iccExecute
    end
    object icMoveCellsAll: TTntAction
      Tag = 301
      Category = 'CellsDrag'
      Caption = 'icMoveCellsAll'
      ImageIndex = 82
      OnExecute = iccExecute
    end
    object icExchangeCellsAll: TTntAction
      Tag = 302
      Category = 'CellsDrag'
      Caption = 'icExchangeCellsAll'
      ImageIndex = 83
      OnExecute = iccExecute
    end
    object icCopyCellsValue: TTntAction
      Tag = 303
      Category = 'CellsDrag'
      Caption = 'icCopyCellsValue'
      OnExecute = iccExecute
    end
    object icCopyCellsFormat: TTntAction
      Tag = 304
      Category = 'CellsDrag'
      Caption = 'icCopyCellsFormat'
      OnExecute = iccExecute
    end
    object icAppendCellsValue: TTntAction
      Tag = 305
      Category = 'CellsDrag'
      Caption = 'icAppendCellsValue'
      OnExecute = iccExecute
    end
    object ftFormat: TTntAction
      Tag = 270
      Category = 'Cells'
      Caption = 'ftFormat'
      OnExecute = ftExecute
    end
    object trRotation: TTntAction
      Tag = 271
      Category = 'Cells'
      Caption = 'trRotation'
      ImageIndex = 64
      OnExecute = ftExecute
    end
    object icExpandCopyCellsAll: TTntAction
      Tag = 310
      Category = 'CellsExpand'
      Caption = 'icExpandCopyCellsAll'
      OnExecute = iceExecute
    end
    object icExpandCopyCellsContent: TTntAction
      Tag = 311
      Category = 'CellsExpand'
      Caption = 'icExpandCopyCellsContent'
      OnExecute = iceExecute
    end
    object icExpandCopyCellsFormat: TTntAction
      Tag = 312
      Category = 'CellsExpand'
      Caption = 'icExpandCopyCellsFormat'
      OnExecute = iceExecute
    end
    object icExpandIncCopyCellsAll: TTntAction
      Tag = 313
      Category = 'CellsExpand'
      Caption = 'icExpandIncCopyCellsAll'
      OnExecute = iceExecute
    end
    object icExpandIncCopyCellsContent: TTntAction
      Tag = 314
      Category = 'CellsExpand'
      Caption = 'icExpandIncCopyCellsContent'
      OnExecute = iceExecute
    end
    object stTextColor: TTntAction
      Tag = 164
      Category = 'State'
      Caption = 'stTextColor'
      OnExecute = stExecute
    end
    object stVerBorderColor: TTntAction
      Tag = 165
      Category = 'State'
      Caption = 'stVerBorderColor'
      OnExecute = stExecute
    end
    object stHorBorderColor: TTntAction
      Tag = 166
      Category = 'State'
      Caption = 'stHorBorderColor'
      OnExecute = stExecute
    end
    object ssExit: TTntAction
      Tag = 807
      Category = 'Grid'
      Caption = 'ssExit'
      OnExecute = ssExecute
    end
    object tsOptions: TTntAction
      Tag = 900
      Category = 'Tools'
      Caption = 'tsOptions'
      OnExecute = tsExecute
    end
    object scSortAO: TTntAction
      Category = 'Tools'
      Caption = 'scSortAO'
      ImageIndex = 87
      OnExecute = scExecute
    end
    object scSortNAO: TTntAction
      Category = 'Tools'
      Caption = 'scSortNAO'
      ImageIndex = 88
      OnExecute = scExecute
    end
    object scSortNO: TTntAction
      Category = 'Tools'
      Caption = 'scSortNO'
      ImageIndex = 89
      OnExecute = scExecute
    end
  end
  object ilMain: TImageList
    Left = 280
    Top = 360
    Bitmap = {
      494C010163006500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000009001000001002000000000000090
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C8E8C009C9E9C009C9E9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C969400BDBEBD00EFEFEF00D6D7D6009C9E9C009C9E9C009C9E9C000000
      0000000000000000000000000000000000000000000000000000734108007341
      0800734108007341080073410800734108007341080073410800734108007341
      08007341080073410800B5967300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009496
      9400C6C7C600FFFFFF00FFFFFF00EFEFEF00EFEFF700BDA694007B4110006B61
      63008C867B009C9E9C000000000000000000000000008C490800946131009461
      3100946131008C5921007B4110000000000000000000B5967300522800007341
      0800633000006330000073410800B59673000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000949E9C00D6D7
      D600FFFFFF00FFFFFF00FFFFFF00F7F7F700F7F7F700BDA69C007B4110007B41
      1000B59E9400C6C7C6009C9E9C007B797B000000000094613100A5714200A571
      4200946131008C5921008C59210000000000FFF7EF00B59673006B2808007341
      10007341080063300000734108008C6131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9E9C00E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F7F7F700F7FFFF00C6AE9C007B4110007B41
      1000BDA69C00D6DFDE00C6C7C6007371730000000000AD714200AD794A00AD79
      4A00A5714200946131008C5921009C7952009C7952008C5921007B4110007B41
      10007341080073410800522800009C614A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003130310031303100313031003130310031303100313031000000
      000000000000000000000000000000000000000000009C9E9C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CEB6A5007B4110007B41
      1000C6AE9C00DEDFDE00C6C7C6007371730000000000AD794A00AD865200AD86
      5200AD794A009461290094592100DECFAD00DECFBD008C5921007B4110007B41
      10007B411000734108006B2808008C694A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000031303100EFDFCE00EFDFCE00EFDFCE00EFE7DE00313031000000
      000000000000000000000000000000000000000000009C9E9C00FFFFFF00FFFF
      FF00CEBEB500AD968400DEDFD600FFFFFF00FFFFFF00C6B6A5007B4110007B41
      1000C6AE9C00E7E7E700CECFCE0073797B0000000000B5865200B5865200B586
      5200AD865200A571420094613100FFFFFF00FFEFDE00BDAE9C006B2008008C59
      21007B4110007B411000633000008C694A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000031303100DECFBD00DED7CE00EFDFCE00EFDFCE00313031000000
      000000000000000000000000000000000000000000009C9E9C00EFEFEF009C86
      73006B3018007B4110007B411000DED7CE00FFFFFF00EFEFE700C6AEA500C6AE
      A500CEBEB500E7EFEF00D6D7D6006B595A0000000000B5865200B58E6300B58E
      6300B5865200A579520094612900CEBE9C00F7E7CE00FFF7EF00BDAE9C006B28
      08008C5921007B411000633000008C694A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000031303100DECFBD00DECFBD00DED7CE00EFDFCE00313031000000
      000000000000000000000000000000000000000000009C9E9C006B3829007B41
      10007B4110007B4110007B4110007B411000DED7CE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7F7F700CECFCE006B38290000000000CE966B00CE966B00CE96
      6B00B5865200AD794A00AD794A008C592100CEBEAD00F7E7CE00FFF7EF00BDA6
      8C00734108008C592100734108009C7952000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000031302900D6CFB500DECFBD00DECFBD00EFDFCE00313031000000
      000000000000000000000000000000000000000000006B3829007B4110007B41
      10007B4110007B4110007B4110007B4110007B411000DED7CE00FFFFFF00FFFF
      FF00FFFFFF00D6CFC6007B4110005238290000000000CE966B00CE9E7300B58E
      6300C6967300CE9E7B00AD865200AD794A008C490800CEBEAD00F7CFA500FFF7
      EF008C5921008C490800734108009C7952000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003130E7003149D600000000000000
      00003149D6003149D60031302900313029003130290031302900313029000000
      000000000000000000000000000000000000000000007B4110007B4110007B41
      10007B4110007B4110007B4110007B4110007B4110006B382900DED7D600FFFF
      FF00B5A69C007B4110007B4110000000000000000000CEA67B00CEA67B00B586
      5200F7EFE700FFFFFF00EFDFCE00945921008C490800CEAE9400FFCFAD00FFF7
      EF00946131008C5921007B411000A57952000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A61EF003130E7003149D6003130
      E7003130E7005A61EF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B4110007B4110007B41
      10007B4110007B4110007B4110007B4110007B4110007B411000734129008471
      63007B4110007B411000000000000000000000000000DEAE7300DEAE8C00B586
      5200DECFBD00F7CFA500F7DFCE00D6CFB500CEAE9400F7DFCE00F7BE8C00FFEF
      EF008C592100946131008C490800AD8652000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009496FF003130E7003130
      E7009496FF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B4110007B41
      10007B4110007B4110007B4110007B4110007B4110007B4110007B4110007B41
      10007B41100000000000000000000000000000000000DEAE7300DEAE8C00D6A6
      8400CE966B00EFEFEF00F7DFAD00F7DFCE00FFEFDE00F7DFAD00FFF7F700AD86
      630094612900A57142008C592100AD8652000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003130E7003130E7003130
      E7003149D6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B41
      10007B4110007B4110007B4110007B4110007B4110007B4110007B4110007B41
      10000000000000000000000000000000000000000000DEAE7300DEAE7300DEB6
      8C00CEA67B00B58E4A00DEB69400EFCFB500DECFBD00DECFBD00AD8652009461
      3100AD794A00AD7142007B410800B59673000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003149D6003130E7005A61EF005A61
      EF003130E7003149D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B4110007B4110007B4110007B4110007B4110007B4110007B4110000000
      0000000000000000000000000000000000000000000000000000DEAE7300DEAE
      7300DEAE7300D69E6300B5865200AD714200AD693100AD693100AD693100AD71
      4200AD693100AD693100B5967300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003130E7005A61EF00000000000000
      00005A61EF003130E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B4110007B411000000000007B4110007B411000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000313031003130
      310031303100313031003130310031303100000000009C8E8C00845952006B30
      31009C8E7B0094716B005A1008009C8E7B009C8E7B009C8E7B009C8E7B006B30
      2900734139006B38310094615A00000000000000000000000000000000000000
      0000000000000000000000000000000000007361520073615200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000031303100EFDF
      CE00EFDFCE00EFDFCE00EFE7DE003130310000000000AD796300EFDF8C00BD86
      6300F7FFEF00F7DFA500CE712100DEC7AD00EFF7F700FFFFEF00F7E7DE00BD79
      3100C68E4A00D6A652006B383100000000000000000000000000000000000000
      00000000000000000000ADAE94008C694A00EFCFB500CEBEAD009C7952007361
      5200B5AEA5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5B6B5003130310031303100DECF
      BD00DED7CE00EFDFCE00EFDFCE003130310000000000BD8E7300EFC78400A569
      5200DEF7DE00DEC79C00BD693100A58E73009CA69400BDBEAD00DED7BD00A569
      3100B5794A00C68E4A0073413900000000000000000000000000000000000000
      0000B5AEA500736152009C867B00EFCFB500CEBE9C00DEBEA500DECFAD00CEBE
      AD009C79520073615200BDBEBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B5B6B5003130310000000000B5B6B50031303100DECF
      BD00DECFBD00DED7CE00EFDFCE003130310000000000B58E7300EFCF8C00A569
      5200DEF7E700E7D7A500CE713100948E6B0094B69C0094B69C00ADCFAD00AD71
      3900B5865200C696520073413900000000000000000000000000ADAEAD008C69
      4A009C867B00EFCFB500EFCFB500BDAE9C00BDA68C00DEB69400CEBE9C00DEB6
      9400DEBEA500CEAE94009C795200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000031302900D6CF
      B500DECFBD00DECFBD00EFDFCE003130310000000000B5866B00EFBE8C00EFC7
      8C00F7C78C00F7BE8400EFB67300E7B67300DEAE7300D6A66B00CE9E6300CE96
      5A00C68E5200CE9E5A007341390000000000BDB6AD00736152009C867B00FFFF
      FF00EFDFD600BDA68C00734929009461310094612900A57142008C4908008C49
      08008C5921008C5921007B4110008C694A000000000000000000000000000000
      0000000000003130310031303100313031003130310031303100313031000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B5B6B500313031000000000000000000313031003130
      29003130290031302900313029003130290000000000B58E7300EFCF9400D6A6
      7B00B5715A00BD796300B5866300B5795A00B5715A00B5715200B5715200AD71
      5A00AD715A00D6A663007B4139000000000000000000DEDFDE00FFF7F700D6CF
      B5008C796B00B596730073492900CE9E7300A5714200CE9E7300CE966B009461
      3100A57142008C6131008C592100945942000000000000000000000000000000
      00000000000031303100EFDFCE00EFDFCE00EFDFCE00EFE7DE00313031000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000313031003130310031303100313031003130310031303100000000000000
      00000000000000000000000000000000000000000000B58E7300EFDFA500BD8E
      5A00A5694200AD714A00AD794A00AD795200AD795200B5795200B5795200AD79
      5200AD795200DEA663007B49390000000000BDBEBD00ADAE94008C796B00BDAE
      9C00EFDFCE00DEB68C0073492900CE9E7300A5714200CE9E7300A5714200A571
      4200A5714200A5714200A5714200845931000000000000000000000000000000
      00000000000031303100DECFBD00DED7CE00EFDFCE00EFDFCE00313031000000
      0000000000000000000000000000000000000000000000000000000000000000
      000031303100EFDFCE00EFDFCE00EFDFCE00EFE7DE0031303100000000000000
      00000000000000000000000000000000000000000000B58E7300EFDFA500C68E
      4A000000000000000000FFFFFF00FFFFF700F7FFEF00EFF7DE00EFEFD600E7EF
      DE00BD9E6B00DEA65A007B494200000000008C796B00BDAE9C00FFF7EF00F7F7
      EF00FFF7EF00CEA6840073492900734929007349290073492900734929007349
      2900844929007349290073492900734929000000000000000000000000000000
      00000000000031303100DECFBD00DECFBD00DED7CE00EFDFCE00313031000000
      0000000000000000000000000000000000000000000000000000000000000000
      000031303100DECFBD00DED7CE00EFDFCE00EFDFCE0031303100000000000000
      00000000000000000000000000000000000000000000B58E7300EFE7AD00C68E
      4A0000000000F7EFE700DED7BD00DEDFC600DED7BD00DED7BD00DED7BD00E7EF
      DE00BD966B00E7AE63007B49420000000000C6CFD600FFF7F700FFFFFF00F7F7
      EF00BDAE9C00A5714200CE966B00CEA67B00CE9E7300CEA67B00CE9E7300CE9E
      7300CEA67B00DEAE7300DEAE7300CECFCE000000000000000000000000000000
      00000000000031302900D6CFB500DECFBD00DECFBD00EFDFCE00313031000000
      0000000000000000000000000000000000000000000000000000000000000000
      000031303100DECFBD00DECFBD00DED7CE00EFDFCE0031303100000000000000
      00000000000000000000000000000000000000000000BD8E7B00EFE7AD00C68E
      4A00FFFFFF00FFFFFF00F7F7EF00F7F7F700F7F7EF00F7F7EF00F7F7EF00EFF7
      EF00C6966B00EFB66B007B49420000000000CECFCE00BDC7CE00BDAE9C008C79
      6B00FFEFDE008C592100B5865200B5865200B5865200B5865200B5865200B586
      5200AD865200B58E6300A5714200000000000000000000000000000000000000
      0000000000003130310031302900313029003130290031302900313029000000
      0000000000000000000000000000000000000000000000000000000000000000
      000031302900D6CFB500DECFBD00DECFBD00EFDFCE0031303100000000000000
      00000000000000000000000000000000000000000000B58E7300EFE7AD00C68E
      4A0000000000EFEFD600D6CFAD00DED7BD00DED7BD00DED7B500DEDFC600FFFF
      FF00C69E6B00EFB66B007B49420000000000948E8C008C796B00D6CFB500EFE7
      DE00CEA67B007B411000A5714200AD794A00A5714200A5714200A5714200A571
      4200AD794A00A5714200B5AEA5000000000000000000CEB68C00633000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEB68C00633000000000
      0000313031003130290031302900313029003130290031302900000000000000
      00000000000000000000000000000000000000000000BD8E7B00F7E7BD00C68E
      5200FFFFFF00FFFFF700F7F7EF00FFF7F700FFF7EF00FFF7EF00FFFFF700FFFF
      FF00D6A67B00EFCF7B007B494A0000000000CECFCE00DEDFDE00FFFFFF00FFFF
      FF00B58E6300633000008C5921008C5921008C5921008C5921008C5921008C59
      21008C6131008C613100000000000000000000000000D6B68C00633000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6B68C00633000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD796300CE9E6300B579
      4200C6A68400CEA68400CEA68400CEA68400CEA68400CEA68400CEAE8400CEAE
      8C00B5865200D69E52007B494200000000000000000000000000BDC7CE00EFEF
      EF00FFF7F700FFEFEF00EFDFD600EFDFCE00EFDFD600BDBEBD00CECFCE00C6CF
      D600000000000000000000000000000000006330000063300000633000006330
      0000633000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006330000063300000633000006330
      0000633000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD8E7B009C614A009C71
      5A00946142009459390094594200945942009459420094594200945939009459
      42009C695200A5715A00A58E8400000000000000000000000000000000000000
      0000CECFCE00DEDFDE00FFF7F700FFEFDE00BDBEBD00CECFCE00000000000000
      000000000000000000000000000000000000CEB68C00D6B68C0063300000CEB6
      8C00CEB68C000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CEB68C00D6B68C0063300000CEB6
      8C00CEB68C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEB68C00633000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEB68C00633000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B96
      AD00000000000000000000000000000000000000000000000000000000009C8E
      7B00A5968C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5BEBD005A8E
      AD002996B5006B96AD0000000000000000000000000000000000000000006330
      10007B51390084615200AD9E9400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AD714200AD714200AD714200AD71
      4200AD714200AD714200AD714200AD714200AD714200AD714200AD714200AD71
      4200AD714200A5714200A5714200A571420000000000000000008CAEBD00738E
      9C006BC7D60052BEDE00398EB5007B9EAD0000000000BDB6B50084614A006330
      100063301000633010007B51390094796B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AD714200F7EFE700EFEFDE00EFE7
      D600E7DFCE00E7DFC600DED7BD00DECFB500D6CFAD00D6CFAD00CEC7A500CEC7
      A500CEC7A500CEC7A500CEC7A500A571420000000000000000006B9EB5008C9E
      940052AEC6007BCFDE006BCFDE0042B6D6006351420063301000633010006330
      10006330100063301000AD968C0000000000ADAEAD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADAEAD000000000000000000000000000000000000000000000000000000
      00000000000000000000ADAEAD0000000000AD714200F7F7EF00F7EFE700EFEF
      DE00E7E7D600E7DFCE00DEDFC600DED7BD00D6CFB500D6CFAD00D6C7A500CEC7
      A500CEC7A500CEC7A500CEC7A500A571420000000000000000006396AD00B5A6
      9C007BAEB5006BC7DE006BC7DE0063867B00633010005A594A006B969400A5AE
      B50073492900A5968C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008486
      840000000000000000000000000000000000A5714200F7F7EF00F7F7E700EFEF
      DE00EFE7D600E7E7CE00E7DFC600DED7BD00DED7B500D6CFAD00D6CFAD00D6C7
      A500CEC7A500CEC7A500CEC7A500AD71420000000000000000005A8EAD00C6BE
      A500B5C7BD004AB6D60084B6C6006330100063716B0031BEDE0021BEDE0021A6
      C6006B71730000000000000000000000000000000000ADAEAD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AD714200FFF7F700F7F7EF00F7EF
      E700EFEFDE00EFE7D600E7DFCE00DEDFC600DED7BD00D6CFB500D6CFAD00D6CF
      A500CEC7A500CEC7A500CEC7A500A5714200000000008CAEBD004A799400C6BE
      AD00EFDFBD005AAECE007B7973006B5139005ABEDE0042BED60029B6D60010B6
      DE0008B6DE005A96AD0000000000000000000000000000000000ADAEAD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AD714200FFFFF700F7F7EF00F7F7
      EF00EFEFE700EFE7DE00E7E7CE00E7DFC600DED7BD00DED7B500D6CFB500D6CF
      AD00D6C7A500CEC7A500CEC7A500AD7142000000000073A6B50052799C00CEC7
      AD00F7DFBD00A5BEB5007BB6BD006330100063868C004ABED60039BED60021B6
      D60010B6DE00109EC60000000000000000000000000000000000000000000000
      0000ADAEAD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AD714200FFFFFF00FFF7F700F7F7
      EF00F7EFE700EFEFDE00EFE7D600E7DFCE00E7DFC600DED7BD00DED7B500D6CF
      AD00D6CFAD00CEC7A500CEC7A500AD714200000000006B9EB50063869C00DECF
      B500EFE7D600D6D7BD0052A6C600737163007BAEB50063BED6004ABED60031B6
      D60021AED60000AED6008CA6B500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADAEAD00000000000000000000000000AD714200FFFFFF00FFFFF700FFF7
      F700F7F7EF00EFEFE700EFE7DE00E7E7D600E7DFCE00DEDFC600DED7BD00D6CF
      B500D6CFAD00D6C7A500CEC7A500A57142009CB6C6006BA6B500949EA500F7DF
      BD00FFF7F700F7F7E70094BEC6004AAECE006B594A007379730073AEBD005AAE
      BD0029B6CE0010B6DE004A9EB500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADAEAD000000000000000000000000000000000000000000000000000000
      00000000000000000000ADAEAD0000000000AD714200FFFFFF00FFFFFF00FFFF
      F700F7F7EF00F7EFE700EFEFDE00EFE7D600E7E7CE00E7DFC600DED7BD00DED7
      B500D6CFAD00D6CFAD00D6C7A500AD7142007BA6BD0052A6BD00639EB500B5C7
      AD00E7D7BD00FFF7E700FFFFF700C6E7D6006BB6C6004AAED6005ABEDE004ABE
      D60039B6D60021B6DE0029A6C600000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B411000BDAE9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B411000BDAE9C000000
      000000000000000000000000000000000000AD71420000000000FFFFFF00FFFF
      F700FFF7F700F7F7EF00F7EFE700EFEFDE00EFE7D600E7DFCE00DEDFC600DED7
      BD00AD714200A5714200A5714200A571420084B6C6005ABECE006BC7DE00399E
      BD004A9EAD0094B6B500D6D7CE00F7EFDE00FFF7EF00B5CFCE005AB6CE0039AE
      CE0039B6D60031BEDE0018B6D6008CAEB5000000000000000000000000000000
      000000000000AD9E8C007B4110007B4110007B4110007B4110007B411000AD9E
      8C00000000000000000000000000000000000000000000000000000000000000
      000000000000AD9E8C007B4110007B4110007B4110007B4110007B411000AD9E
      8C0000000000000000000000000000000000AD7142000000000000000000FFFF
      FF00FFFFF700F7F7EF00F7F7EF00EFEFE700EFE7DE00E7E7CE00E7DFC600DED7
      BD00AD714200E7D7BD00A5714200000000000000000094BEC6005AB6CE0052B6
      D60042A6C600319EBD004A9EB50084AEB50000000000F7E7D600EFEFE700A5CF
      CE0042AEC60018A6CE0018BEE70052A6BD000000000000000000000000000000
      000000000000000000000000000000000000000000007B411000BDAE9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B411000BDAE9C000000
      000000000000000000000000000000000000A57142000000000000000000FFFF
      FF00FFFFFF00FFFFF700F7F7EF00F7EFE700EFEFDE00EFE7D600E7DFCE00E7DF
      C600AD714200AD794A0000000000FFFFFF000000000000000000000000000000
      00000000000000000000ADBEC60063AEBD0052A6BD007BAEB500CED7C600FFF7
      DE00E7E7DE0094C7C60029A6C6002196BD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AD714200AD714200A5714200AD71
      4200AD714200AD714200AD714200AD714200AD714200AD714200A5714200AD71
      4200A57142000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADBEBD005AAEC60052A6C6007BB6
      BD0000000000EFDFC6009496A5006BAEBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5BEBD0073B6
      C6005AAEC60063AEBD00849EAD00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6CFCE00848684008486
      8400848684008486840084868400848684000000000000000000000000000000
      00000000000000000000000000000000000000000000C6CFCE00848684008486
      8400848684008486840084868400848684000000000000000000000000000000
      00000000000000000000000000000000000000000000C6CFCE00848684008486
      8400848684008486840084868400848684000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C6131008C6131008C6131008C61
      31008C6131008C6131008C613100848684000000000000000000000000000000
      0000000000000000000000000000000000008C6131008C6131008C6131008C61
      31008C6131008C6131008C613100848684000000000000000000000000000000
      0000000000000000000000000000000000008C6131008C6131008C6131008C61
      31008C6131008C6131008C613100848684000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C613100F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE008C613100848684000000000000000000000000000000
      0000000000000000000000000000000000008C613100F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE008C613100848684000000000000000000000000000000
      0000000000000000000000000000000000008C613100F7E7CE00EFDFCE008C61
      3100EFDFCE00EFDFCE008C613100848684000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C613100EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE008C613100848684000000000000000000000000000000
      0000000000000000000000000000000000008C613100EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE008C613100848684000000000000000000000000000000
      0000000000000000000063300000000000008C613100EFDFD600EFDFD6008C61
      3100EFDFCE00EFDFCE008C613100848684000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C613100EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE008C613100848684000000000000000000000000000000
      0000000000000000000000000000000000008C6131008C6131008C6131008C61
      31008C6131008C6131008C61310084868400000000000000000000000000BDC7
      CE0094866B008459420063300000633000008C613100EFDFD600EFDFD6008C61
      3100EFDFCE00EFDFCE008C613100848684000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADAE
      AD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C613100EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE008C613100848684000000000000000000000000000000
      0000000000000000000000000000000000008C613100EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE008C613100848684000000000000000000000000008C79
      6B009C795200BDBEBD0063300000000000008C613100EFE7DE00EFE7DE008C61
      3100EFDFD600EFDFCE008C613100848684000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C613100EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD6008C613100C6CFCE000000000000000000000000000000
      0000000000000000000000000000000000008C613100EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD6008C613100C6CFCE000000000000000000000000008459
      3100CECFCE000000000000000000000000008C613100EFE7DE00EFE7DE008C61
      3100EFDFD600EFDFD6008C613100C6CFCE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADAEAD000000000000000000000000000000000000000000000000007379
      7B00000000000000000000000000000000008C6131008C6131008C6131008C61
      31008C6131008C6131008C613100000000000000000000000000000000007379
      7B00000000000000000000000000000000008C6131008C6131008C6131008C61
      31008C6131008C6131008C613100000000000000000000000000CECFCE008459
      3100000000000000000000000000000000008C6131008C6131008C6131008C61
      31008C6131008C6131008C613100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADAEAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006330
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006330
      0000000000000000000000000000000000000000000000000000CECFCE008459
      3100CECFCE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007379
      7B00000000000000000000000000000000000000000000000000633000006330
      0000633000000000000000000000000000000000000000000000000000007379
      7B00000000000000000000000000000000000000000000000000633000006330
      0000633000000000000000000000000000000000000000000000000000008C69
      4A00BDB6AD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000ADAEAD00ADAE
      AD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBEBD008459
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBEBD008459
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BDB6AD00CECFCE0000000000CECFCE009C7952009486
      6B00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BDB6AD00CECFCE0000000000CECFCE009C7952009486
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B411000BDAE9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008C694A008459310084593100845931008C796B00BDC7
      CE00000000000000000000000000000000000000000000000000000000000000
      000000000000000000008C694A008459310084593100845931008C796B00BDC7
      CE00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000073797B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AD9E8C007B4110007B4110007B4110007B4110007B411000AD9E
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CECFCE00CECFCE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CECFCE00CECFCE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B411000BDAE9C000000
      0000000000000000000000000000000000000000000073797B00000000007379
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073797B00000000007379
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073797B00000000007379
      7B0000000000000000000000000073797B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EFDF
      CE00EFDFCE00EFDFCE00EFDFCE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EFDF
      CE00EFDFCE00EFDFCE00EFDFCE00000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EFDFCE00EFDFCE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE00EFDF
      D600EFDFD600EFDFD60000000000000000000000000000000000000000000000
      0000AD9E8C008459310063300000734110008C694A000000000000000000F7DF
      CE00EFDFCE00EFDFCE00EFDFCE00000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFE7DE00EFDFD600EFDFD600EFDF
      D60000000000EFDFCE00EFDFCE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFDFD60000000000000000000000000000000000000000009C79
      520063300000734110008C796B00000000009C867B000000000000000000EFDF
      CE00EFDFCE00EFDFCE00EFDFCE00000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE0000000000EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFE7DE00EFE7DE00EFE7DE00EFDF
      D60000000000EFDFCE00EFDFCE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000AD9E8C006B30
      10007B411000BDB6AD000000000000000000000000000000000000000000EFDF
      D600EFDFCE00EFDFCE00EFDFCE00000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE0000000000EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00000000000000000000000000000000009C7952007341
      08008C694A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE70000000000EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063300000633000006330
      0000633000006330000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006330
      0000000000000000000000000000000000000000000000000000633010006330
      0000633000000000000000000000000000000000000000000000000000000000
      0000633000000000000000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00F7EFE70000000000F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006330
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000633000006330
      0000633010000000000000000000000000000000000000000000000000006330
      0000000000000000000000000000000000000000000000000000000000006330
      0000633000006330100000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE70000000000F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000633000006330
      0000633010000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063300000633000006330
      0000633000006330000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000633000006330
      0000633000006330000063300000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF0000000000F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063300000633000006330
      00006330000063300000000000000000000000000000FFFFFF0000000000F7F7
      EF0000000000F7EFE700000000000000000000000000000000008C694A007341
      08009C7952000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008C69
      4A00734108009C79520000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF0000000000000000000000000000000000FFF7F700FFF7F700FFFF
      FF00F7F7EF0000000000000000000000000000000000000000008C694A007341
      08009C795200000000000000000000000000FFFFFF00FFFFFF00FFF7EF00F7F7
      EF00F7F7EF0000000000000000000000000000000000BDB6AD007B4110006B30
      1000AD9E8C0000000000000000000000000000000000FFF7F700FFF7F700FFFF
      FF00F7F7EF000000000000000000000000000000000000000000BDB6AD007B41
      10006B301000AD9E8C0000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF0000000000FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE70000000000000000000000000000000000FFF7F700FFF7F700FFFF
      FF00FFFFFF0000000000000000000000000000000000BDB6AD007B4110006B30
      1000AD9E8C0000000000000000000000000000000000FFF7F700FFFFFF00F7F7
      EF00F7F7EF00F7F7EF009C867B00000000008C796B0073411000633000009C79
      52000000000000000000000000000000000000000000FFF7F700FFF7F700FFFF
      FF00FFFFFF0000000000000000009C867B00000000008C796B00734110006330
      00009C7952000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFF7F700FFF7F700FFF7
      F700FFF7F700000000009C867B00000000008C796B0073411000633000009C79
      520000000000000000000000000000000000FFF7F700FFF7F700FFFFFF00FFFF
      FF00FFFFFF00000000008C694A00734110006330000084593100AD9E8C000000
      00000000000000000000000000000000000000000000FFF7F700FFF7F700FFF7
      F700FFF7F70000000000000000008C694A00734110006330000084593100AD9E
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFF7F700FFF7
      F700FFF7F700000000008C694A00734110006330000084593100AD9E8C000000
      00000000000000000000000000000000000000000000FFF7F700FFF7F700FFF7
      F700FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFF7F700FFF7
      F700FFF7F7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFF7F7000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE000000
      0000EFE7DE0000000000EFDFD60000000000EFDFCE0000000000EFDFCE000000
      0000EFDFCE000000000000000000000000000000000000000000EFE7DE000000
      0000EFE7DE0000000000EFDFD60000000000EFDFCE0000000000EFDFCE000000
      0000EFDFCE000000000000000000000000000000000000000000EFE7DE000000
      0000EFE7DE0000000000EFDFD60000000000EFDFCE0000000000EFDFCE000000
      0000EFDFCE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE00000000000000000000000000F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE00000000000000000000000000F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE000000000000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE000000000000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE000000000000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE000000000000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE0000000000000000000000000000000000F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE0000000000EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE00000000000000000000000000F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE00000000000000000000000000F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE0000000000EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE000000000000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE0000000000EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD6000000000000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE0000000000EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD6000000000000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE0000000000EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD6000000000000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE0000000000EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD60000000000000000000000000000000000FFEFEF00FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE70000000000EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD600000000000000000000000000FFEFEF00FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD600000000000000000000000000FFEFEF00FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE70000000000EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD6000000000000000000000000000000000000000000FFEFEF000000
      0000FFEFEF0000000000F7EFE70000000000EFE7DE0000000000EFE7DE000000
      0000EFE7DE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFEFEF000000
      0000FFEFEF0000000000F7EFE70000000000EFE7DE0000000000EFE7DE000000
      0000EFE7DE0000000000000000000000000000000000F7F7EF00F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00F7EFE70000000000F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00000000000000000000000000F7F7EF00F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00000000000000000000000000F7F7EF00F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00F7EFE70000000000F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE70000000000F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE70000000000F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE70000000000F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE70000000000F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF0000000000F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE00000000000000000000000000FFFFFF00FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE00000000000000000000000000FFFFFF00FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF0000000000F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE000000000000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF000000000000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF000000000000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF000000000000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF0000000000000000000000000000000000FFF7F700FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF0000000000FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE700000000000000000000000000FFF7F700FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE700000000000000000000000000FFF7F700FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF0000000000FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE7000000000000000000000000000000000000000000FFF7F7000000
      0000FFF7F70000000000FFFFFF0000000000F7F7EF0000000000FFEFEF000000
      0000F7EFE7000000000000000000000000000000000000000000FFF7F7000000
      0000FFF7F70000000000FFFFFF0000000000F7F7EF0000000000FFEFEF000000
      0000F7EFE7000000000000000000000000000000000000000000FFF7F7000000
      0000FFF7F70000000000FFFFFF0000000000F7F7EF0000000000FFEFEF000000
      0000F7EFE7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE000000
      0000EFE7DE0000000000EFDFD60000000000EFDFCE0000000000EFDFCE000000
      0000EFDFCE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE000000
      0000EFE7DE0000000000EFDFD60000000000EFDFCE0000000000EFDFCE000000
      0000EFDFCE000000000000000000000000000000000000000000EFE7DE000000
      0000EFE7DE0000000000EFDFD60000000000EFDFCE0000000000EFDFCE000000
      0000EFDFCE000000000000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE00000000000000000000000000F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE00000000000000000000000000F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE0000000000000000000000000000000000F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE000000000000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE000000000000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE000000000000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE000000000000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE00000000000000000000000000F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE00000000000000000000000000F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE0000000000000000000000000000000000F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE0000000000EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD6000000000000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE0000000000EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD6000000000000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE0000000000EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD6000000000000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE0000000000EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD6000000000000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD600000000000000000000000000FFEFEF00FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD600000000000000000000000000FFEFEF00FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD60000000000000000000000000000000000FFEFEF00FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD60000000000000000000000000000000000FFEFEF000000
      0000FFEFEF0000000000F7EFE70000000000EFE7DE0000000000EFE7DE000000
      0000EFE7DE000000000000000000000000000000000000000000FFEFEF000000
      0000FFEFEF0000000000F7EFE70000000000EFE7DE0000000000EFE7DE000000
      0000EFE7DE000000000000000000000000000000000000000000FFEFEF000000
      0000FFEFEF0000000000F7EFE70000000000EFE7DE0000000000EFE7DE000000
      0000EFE7DE000000000000000000000000000000000000000000FFEFEF000000
      0000FFEFEF0000000000F7EFE70000000000EFE7DE0000000000EFE7DE000000
      0000EFE7DE000000000000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00000000000000000000000000F7F7EF00F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00000000000000000000000000F7F7EF00F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE0000000000000000000000000000000000F7F7EF00F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE70000000000F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE70000000000F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE70000000000F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE70000000000F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE00000000000000000000000000FFFFFF00FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE00000000000000000000000000FFFFFF00FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE0000000000000000000000000000000000FFFFFF00FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF000000000000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF000000000000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF000000000000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF000000000000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE700000000000000000000000000FFF7F700FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE700000000000000000000000000FFF7F700FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE70000000000000000000000000000000000FFF7F700FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F7000000
      0000FFF7F70000000000FFFFFF0000000000F7F7EF0000000000FFEFEF000000
      0000F7EFE7000000000000000000000000000000000000000000FFF7F7000000
      0000FFF7F70000000000FFFFFF0000000000F7F7EF0000000000FFEFEF000000
      0000F7EFE7000000000000000000000000000000000000000000FFF7F7000000
      0000FFF7F70000000000FFFFFF0000000000F7F7EF0000000000FFEFEF000000
      0000F7EFE7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C7C600C6C7C6000000
      0000EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE00EFDFCE000000000000000000F7EFE700F7EFE700EFEF
      EF00EFE7DE00CEB6AD00EFE7DE00EFE7DE00EFDFD600EFDFD600CEB6AD00EFDF
      CE00EFDFCE00EFDFCE00EFDFCE000000000000000000F7EFE700F7EFE700EFEF
      EF00EFE7DE0000000000EFE7DE00EFE7DE00EFDFD600EFDFD60000000000EFDF
      CE00EFDFCE00EFDFCE00EFDFCE000000000000000000C6C7C600C6C7C6000000
      0000EFE7DE00EFE7DE00EFE7DE00CE690000EFDFD600EFDFD600EFDFD600CE69
      0000EFDFCE00EFDFCE00EFDFCE000000000000000000C6C7C600C6C7C6000000
      0000EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE00EFDFCE000000000000000000F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE00EFDFCE000000000000000000F7EFE700F7EFE700F7EF
      E700EFEFEF0000000000EFE7DE00EFE7DE00EFE7DE00EFDFD60000000000EFDF
      D600EFDFCE00EFDFCE00EFDFCE000000000000000000C6C7C600C6C7C6000000
      0000EFEFEF00EFE7DE00EFE7DE00CE690000EFE7DE00EFDFD600EFDFD600CE69
      0000EFDFCE00EFDFCE00EFDFCE000000000000000000C6C7C600C6C7C6000000
      0000F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE00EFDFCE000000000000000000FFEFEF00F7EFE700F7EF
      E700F7EFE700CEB6AD00EFE7DE00EFE7DE00EFE7DE00EFE7DE00CEB6AD00EFDF
      D600EFDFD600EFDFCE00EFDFCE000000000000000000FFEFEF00F7EFE700F7EF
      E700F7EFE70000000000EFE7DE00EFE7DE00EFE7DE00EFE7DE0000000000EFDF
      D600EFDFD600EFDFCE00EFDFCE000000000000000000C6C7C600C6C7C6000000
      0000CE690000CE690000CE690000CE690000CE690000CE690000CE690000CE69
      0000CE690000CE690000CE690000000000000000000000000000000000000000
      0000F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD600EFDFCE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEB6AD00FFEFEF00F7EF
      E700CEB6AD0000000000CEB6AD00EFE7DE00EFE7DE00CEB6AD0000000000CEB6
      AD00EFDFD600EFDFD600CEB6AD000000000000000000C6C7C600C6C7C6000000
      0000F7EFE700F7EFE700F7EFE700CE690000EFE7DE00EFE7DE00EFE7DE00CE69
      0000EFDFD600EFDFD600EFDFCE000000000000000000C6C7C600C6C7C6000000
      0000FFEFEF00F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE00EFDFD600EFDFD6000000000000000000F7F7EF00FFEFEF00FFEF
      EF00FFEFEF00CEB6AD00F7EFE700F7EFE700EFE7DE00EFE7DE00CEB6AD00EFE7
      DE00EFE7DE00EFDFD600EFDFD6000000000000000000F7F7EF00FFEFEF00FFEF
      EF00FFEFEF0000000000F7EFE700F7EFE700EFE7DE00EFE7DE0000000000EFE7
      DE00EFE7DE00EFDFD600EFDFD600000000000000000000000000000000000000
      0000FFEFEF00F7EFE700F7EFE700CE690000EFE7DE00EFE7DE00EFE7DE00CE69
      0000EFE7DE00EFDFD600EFDFD6000000000000000000C6C7C600C6C7C6000000
      0000FFEFEF00FFEFEF00FFEFEF00F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFDFD6000000000000000000F7F7EF00F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00FFEFEF00F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFDFD6000000000000000000F7F7EF00F7F7EF00F7F7
      EF00FFEFEF0000000000FFEFEF00F7EFE700F7EFE700FFEFDE0000000000EFE7
      DE00EFE7DE00EFE7DE00EFDFD6000000000000000000C6C7C600C6C7C6000000
      0000CE690000CE690000CE690000CE690000CE690000CE690000CE690000CE69
      0000CE690000CE690000CE6900000000000000000000C6C7C600C6C7C6000000
      0000F7F7EF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE000000000000000000FFFFFF00FFFFFF00F7F7
      EF00F7F7EF00CEB6AD00F7EFE700F7EFE700F7EFE700F7EFE700CEB6AD00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE000000000000000000FFFFFF00FFFFFF00F7F7
      EF00F7F7EF0000000000F7EFE700F7EFE700F7EFE700F7EFE70000000000EFE7
      DE00EFE7DE00EFE7DE00EFE7DE000000000000000000C6C7C600C6C7C6000000
      0000F7F7EF00FFEFEF00F7EFE700CE690000F7EFE700F7EFE700EFE7DE00CE69
      0000EFE7DE00EFE7DE00EFE7DE000000000000000000C6C7C600C6C7C6000000
      0000F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE00EFE7DE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEB6AD00FFFFFF00FFF7
      EF00CEB6AD0000000000CEB6AD00FFEFEF00F7EFE700CEB6AD0000000000CEB6
      AD00EFE7DE00EFE7DE00CEB6AD000000000000000000C6C7C600C6C7C6000000
      0000F7F7EF00F7F7EF00FFEFEF00CE690000F7EFE700F7EFE700F7EFE700CE69
      0000EFE7DE00EFE7DE00EFE7DE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFF7F700FFF7F700FFFF
      FF00F7F7EF00CEB6AD00F7F7EF00FFEFEF00FFEFEF00F7EFE700CEB6AD00F7EF
      E700EFEFEF00EFE7DE00EFE7DE000000000000000000FFF7F700FFF7F700FFFF
      FF00F7F7EF0000000000F7F7EF00FFEFEF00FFEFEF00F7EFE70000000000F7EF
      E700EFEFEF00EFE7DE00EFE7DE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C7C600C6C7C6000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000000000000FFF7F700FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE000000000000000000FFF7F700FFF7F700FFFF
      FF00FFFFFF0000000000F7F7EF00F7F7EF00FFEFEF00FFEFEF0000000000F7EF
      E700F7EFE700F7EFE700EFE7DE000000000000000000C6C7C600C6C7C6000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C6000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000000000000FFF7F700FFF7F700FFF7
      F700FFF7F700CEB6AD00FFFFFF00F7F7EF00F7F7EF00F7F7EF00CEB6AD00F7EF
      E700F7EFE700F7EFE700EFEFEF000000000000000000FFF7F700FFF7F700FFF7
      F700FFF7F70000000000FFFFFF00F7F7EF00F7F7EF00F7F7EF0000000000F7EF
      E700F7EFE700F7EFE700EFEFEF000000000000000000C6C7C600C6C7C6000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00000000000000000000000000EFDFD600EFDF
      D600EFDFCE00EFDFCE00000000000000000000000000ADAEAD00000000000000
      0000ADAEAD0000000000ADAEAD0000000000ADAEAD0000000000000000000000
      000000000000000000008C8E8C000000000000000000ADAEAD00000000000000
      00000000000000000000000000008C8E8C000000000000000000ADAEAD000000
      000000000000ADAEAD0000000000ADAEAD000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE70000000000EFE7DE0000000000EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE000000000000000000ADAEAD000000000000000000ADAE
      AD0000000000ADAEAD00000000000000000000000000000000008C8E8C000000
      0000ADAEAD000000000000000000000000000000000000000000000000008C8E
      8C0000000000ADAEAD00000000000000000000000000ADAEAD00000000000000
      0000ADAEAD0000000000ADAEAD00000000000000000000000000FFEFEF00F7EF
      E70000000000F7EFE70000000000EFE7DE00EFE7DE0000000000EFE7DE000000
      0000EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700000000000000000000000000EFE7DE00EFE7
      DE00EFDFD600EFDFD6000000000000000000ADAEAD0000000000000000000000
      00000000000000000000000000000000000000000000ADAEAD00000000000000
      0000000000008C8E8C0000000000000000000000000000000000ADAEAD000000
      000000000000000000008C8E8C000000000000000000ADAEAD00000000000000
      0000000000000000000000000000000000000000000000000000FFEFEF00FFEF
      EF00000000000000000000000000F7EFE700EFE7DE000000000000000000EFE7
      DE00EFE7DE00EFDFD60000000000000000000000000000000000FFEFEF00FFEF
      EF00FFEFEF00F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE00EFDFD600000000000000000000000000ADAEAD00000000000000
      000000000000000000000000000000000000000000000000000000000000ADAE
      AD00000000000000000000000000000000000000000000000000000000000000
      0000ADAEAD000000000000000000000000000000000000000000ADAEAD000000
      0000000000000000000000000000000000000000000000000000F7F7EF00F7F7
      EF0000000000FFEFEF0000000000F7EFE700F7EFE70000000000EFE7DE000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF00FFEFEF0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C8E8C000000
      00008C8E8C000000000000000000000000000000000000000000000000008C8E
      8C00000000008C8E8C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF0000000000F7EFE700F7EFE700F7EFE7000000000000000000EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF0000000000F7EFE70000000000F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE000000000000000000000000008C8E8C00000000000000
      00008C8E8C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C8E8C000000
      0000000000008C8E8C0000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF0000000000F7EFE70000000000F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000000000000000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000840000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000CE8E
      4A00000000000000000000000000CE8E4A008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000CE8E4A00000000000000000000000000CE8E4A00840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE8E4A008400
      0000CE8E4A0000000000CE8E4A0084000000CE8E4A0000000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE8E4A0084000000CE8E4A0000000000CE8E4A0084000000CE8E4A000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CE8E
      4A00840000008400000084000000CE8E4A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CE8E4A00840000008400000084000000CE8E4A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDC7CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDC7CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDC7CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDC7CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000949E9C0042414200BDC7CE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000949E9C0042414200BDC7CE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000949E9C0042414200BDC7CE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000949E9C0042414200BDC7CE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFEFEF0008494A0021595A000849
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0031616B000051000063A6AD002159
      5A00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDC7CE0042414200949E9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDC7CE0042414200949E9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDC7CE0042414200949E9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000808080042717B0008494A005AE7F70008416B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDC7CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDC7CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDC7CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F7FFFF0042717B000051000000EFFF004AB6DE006B968C00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000042717B000051000000EFFF0000FFFF0008699400BDD7DE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7FF
      FF0042717B002969290008A6DE0000EFFF0000EFFF0008416B0039698C00F7FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEDF
      DE00000000000000000000000000000000000000000000000000000000006330
      0000633000006330000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001869
      9C000051000008A6DE0000EFFF0000EFFF0021595A0021595A0021595A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DEDFDE0000000000000000000000000000000000DEDFDE00000000000000
      000000000000000000000000000000000000000000000000000000000000E78E
      0000E78E00006330000073411000734110007341100073411000734110007341
      1000734110000000000000000000000000000000000000000000000000002159
      5A00008EB500008EB50008A6DE0000EFFF0000FFFF0008699400398EAD00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEDFDE00DEDFDE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E78E
      0000E78E00006330000094EFEF008CE7EF008CDFE7008CD7DE008CD7DE008CD7
      DE00734110000000000000000000000000000000000000000000000000000000
      0000398EAD0008494A00008EB50000BEEF00109E9C006B968C00F7FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDFDE000000000000000000DEDFDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007341100094F7F70094F7F7008CE7EF008CE7EF008CDFE7008CD7DE008CD7
      DE00734110000000000000000000000000000000000000000000000000000000
      00006B968C0008494A0000BEEF00008EB50039698C00F7F7F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007341100094F7F70094F7F70094EFEF008CE7EF008CDFE7008CDFE7008CD7
      DE0073411000000000000000000000000000000000000000000000000000FFFF
      FF0042717B0008699400008EB50039698C00F7F7F70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ADAEAD00ADAEAD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DEDFDE0000000000000000000000000000000000DEDFDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007341100094F7F70094F7F70094F7F70094EFEF008CE7EF008CDFE7008CDF
      E700734110000000000000000000000000000000000000000000000000001869
      9C002961100031A6C60039698C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ADAEAD000000000000000000ADAEAD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEDF
      DE00000000000000000000000000000000000000000000000000000000000000
      00007341100094F7F70094F7F70094F7F70094F7F7008CE7EF008CE7EF008CDF
      E700734110000000000000000000000000000000000000000000000000001861
      6B0010494200189EA50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000734110007341100073411000734110007341100073411000734110007341
      1000734110000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00DEDFD60008494A0021595A0008494A00EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFE7EF00426973000051000063A6AD0021595A00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E7004269730008494A005AE7F70008416B00EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE0000000000000000000000000000000000CE690000CE69
      0000CE690000CE690000CE690000CE690000CE690000CE690000CE690000CE69
      0000CE690000CE690000000000000000000000000000CECFCE00FFEFEF00CEA6
      8400CE690000F7EFE70000000000EFE7DE00EFE7DE0000000000EFE7DE00CE69
      0000CEA68400EFDFD600CECFCE00000000000000000000000000F7EFEF004269
      73000051000000EFFF004AB6DE00638E8400EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD6000000000000000000CE690000CE690000CE690000CE69
      0000CE690000CE69000000000000000000000000000000000000CE690000CE69
      0000CE690000CE690000CE690000CE6900000000000000000000426973000051
      000000EFFF0000FFFF0008699400BDCFCE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE00EFDFD60000000000000000000000000000000000FFEFEF00FFEF
      EF00FFEFEF00F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE00EFDFD60000000000000000000000000000000000FFEFEF00FFEF
      EF00FFEFEF00F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE00EFDFD600000000000000000000000000CECFCE00F7F7EF00CEA6
      8400CE690000FFEFEF0000000000F7EFE700F7EFE70000000000EFE7DE00CE69
      0000CEA68400EFE7DE00CECFCE0000000000F7FFFF00083039002969290008A6
      DE0000EFFF0000EFFF0008416B0039698C00F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00FFEFEF00F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00FFEFEF00F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE7000000000000000000F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00000000000000000018699C000051000008A6DE0000EF
      FF0000EFFF0021595A0021595A0021595A00F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000CE690000CE69
      0000CE690000CE690000CE690000CE690000CE690000CE690000CE690000CE69
      0000CE690000CE69000000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE00000000000000000021595A00008EB500008EB50008A6
      DE0000EFFF0000FFFF0008699400398EA500F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE000000000000000000000000000051730008494A00008E
      B50000BEEF00109E9C00638E8C00F7EFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE7000000000000000000000000001038390008494A0000BE
      EF00008EB50039698C00EFEFEF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000080808000830390008699400008E
      B500003052001018180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000018699C002961100031A6C6003969
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000018616B0010494200189EA5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF0000000000DEDFD60008494A0021595A0008494A0000000000EFDFD6000000
      0000EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF0000000000EFE7DE0000000000EFE7DE00EFDFD60000000000EFDFD6000000
      0000EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E70008080800083039000051000063A6AD0021595A000000000000000000EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E7000000000000000000EFE7DE00EFE7DE00EFE7DE000000000000000000EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E7000830390008494A005AE7F70008416B00EFE7DE0000000000EFE7DE000000
      0000EFDFD600EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E70000000000F7EFE70000000000EFE7DE00EFE7DE0000000000EFE7DE000000
      0000EFDFD600EFDFCE00000000000000000000000000CECFCE00F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE00CECFCE00000000000000000000000000F7EFEF004269
      73000051000000EFFF004AB6DE00638E8400EFE7DE000000000000000000EFE7
      DE00EFDFD600EFDFD60000000000000000000000000000000000FFEFEF000000
      0000F7EFE70000000000F7EFE70000000000EFE7DE0000000000EFE7DE000000
      0000EFDFD6000000000000000000000000000000000000000000FFEFEF00F7EF
      E7000000000000000000F7EFE700EFE7DE00EFE7DE000000000000000000EFE7
      DE00EFDFD600EFDFD600000000000000000000000000CECFCE0000000000F7EF
      E70000000000F7EFE70000000000EFE7DE00EFE7DE0000000000EFE7DE000000
      0000EFDFD60000000000CECFCE00000000000000000000000000426973000051
      000000EFFF0000FFFF0008699400BDCFCE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE00EFDFD60000000000000000000000000000000000FFEFEF000000
      00000000000000000000F7EFE700000000000000000000000000EFE7DE000000
      000000000000EFDFD60000000000000000000000000000000000FFEFEF00FFEF
      EF00FFEFEF00F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE00EFDFD6000000000000000000000000000000000000000000FFEF
      EF00000000000000000000000000F7EFE700EFE7DE000000000000000000EFE7
      DE00EFE7DE00000000000000000000000000F7FFFF00083039002969290008A6
      DE0000EFFF0000EFFF0008416B0039698C00F7EFE70000000000EFE7DE000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF000000
      0000FFEFEF0000000000FFEFEF0000000000F7EFE70000000000EFE7DE000000
      0000EFE7DE000000000000000000000000000000000000000000F7F7EF00F7F7
      EF0000000000FFEFEF0000000000F7EFE700F7EFE70000000000EFE7DE000000
      0000EFE7DE00EFE7DE00000000000000000000000000CECFCE0000000000F7F7
      EF0000000000FFEFEF0000000000F7EFE700F7EFE70000000000EFE7DE000000
      0000EFE7DE0000000000CECFCE000000000018699C000051000008A6DE0000EF
      FF0000EFFF0021595A0021595A0021595A00F7EFE70000000000000000000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF0000000000FFEFEF00F7EFE700F7EFE70000000000F7EFE700EFE7DE000000
      000000000000EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF00000000000000000000000000F7EFE700F7EFE70000000000000000000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF0000000000F7EFE700F7EFE700F7EFE7000000000000000000EFE7
      DE00EFE7DE0000000000000000000000000021595A00008EB500008EB50008A6
      DE0000EFFF0000FFFF0008699400398EA500F7EFE70000000000F7EFE7000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF0000000000F7F7EF0000000000FFEFEF00F7EFE70000000000F7EFE7000000
      0000EFE7DE00EFE7DE00000000000000000000000000CECFCE00FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE00CECFCE0000000000000000000051730008494A00008E
      B50000BEEF00109E9C00638E8C00F7EFEF00FFEFEF00F7EFE70000000000F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF0000000000F7F7EF00FFEFEF00FFEFEF00F7EFE70000000000F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE000000000000000000000000001038390008494A0000BE
      EF00008EB50039698C00EFEFEF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE7000000000000000000080808000830390008699400008E
      B500003052001018180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000018699C002961100031A6C6003969
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000018616B0010494200189EA5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EFE7
      DE0000000000EFE7DE0000000000EFDFD60000000000EFDFCE0000000000EFDF
      CE0000000000EFDFCE000000000000000000000000000000000000000000EFE7
      DE0000000000EFE7DE0000000000EFDFD60000000000EFDFCE0000000000EFDF
      CE0000000000EFDFCE000000000000000000000000000000000000000000EFE7
      DE0000000000EFE7DE0000000000EFDFD60000000000EFDFCE0000000000EFDF
      CE0000000000EFDFCE000000000000000000000000000000000000000000EFE7
      DE0000000000EFE7DE0000000000EFDFD60000000000EFDFCE0000000000EFDF
      CE0000000000EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00CE690000CEA68400EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE0000000000EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE000000
      0000EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600CE690000CEA68400EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE00000000000000000000000000F7EFE700F7EFE700ADAE
      AD0052515200EFE7DE00CE690000CEA68400EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE00EFDFCE000000000000000000F7EFE700F7EFE700ADAE
      AD0000000000ADAEAD00EFE7DE00EFE7DE00EFDFD600EFDFD600ADAEAD000000
      0000ADAEAD00EFDFCE00EFDFCE000000000000000000F7EFE700F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00CE690000CEA68400EFDFD6005251
      5200ADAEAD00EFDFCE00EFDFCE000000000000000000F7EFE700F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE00EFDFCE00000000000000000000000000000000000000
      00000000000000000000CE690000CEA68400EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE7005251
      52000000000052515200EFE7DE00EFE7DE00EFE7DE00EFDFD600525152000000
      000052515200EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00CE690000CEA68400000000000000
      0000000000000000000000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE00000000000000000000000000FFEFEF00F7EFE700ADAE
      AD0052515200F7EFE700CE690000CEA68400EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE00EFDFCE000000000000000000FFEFEF00F7EFE700F7EF
      E70000000000F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE000000
      0000EFDFD600EFDFCE00EFDFCE000000000000000000FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE00EFE7DE00CE690000CEA68400EFE7DE005251
      5200ADAEAD00EFDFCE00EFDFCE000000000000000000FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE00EFDFCE00000000000000000000000000FFEFEF00F7EF
      E700F7EFE700F7EFE700CE690000CEA68400EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD60000000000000000000000000000000000CE690000CE69
      0000CE690000CE690000CE690000CE690000CE690000CE690000CE690000CE69
      0000CE690000CE69000000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00CE690000CEA68400EFE7DE00EFE7
      DE00EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD600000000000000000000000000F7F7EF00FFEFEF00FFEF
      EF00FFEFEF00F7EFE700CE690000CEA68400EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE00EFDFD600EFDFD6000000000000000000F7F7EF00CEA68400CEA6
      8400CEA68400CEA68400CEA68400CEA68400CEA68400CEA68400CEA68400CEA6
      8400CEA68400CEA68400EFDFD6000000000000000000F7F7EF00FFEFEF00FFEF
      EF00FFEFEF00F7EFE700F7EFE700F7EFE700CE690000CEA68400EFE7DE00EFE7
      DE00EFE7DE00EFDFD600EFDFD6000000000000000000F7F7EF00CE690000CE69
      0000CE690000CE690000CE690000CE690000CE690000CE690000CE690000CE69
      0000CE690000CE690000EFDFD600000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00CE690000CEA68400F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00FFEFEF00F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00FFEFEF00F7EFE700CE690000CEA68400EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000CEA68400CEA6
      8400CEA68400CEA68400CEA68400CEA68400CEA68400CEA68400CEA68400CEA6
      8400CEA68400CEA68400000000000000000000000000FFFFFF00FFFFFF00ADAE
      AD0052515200FFEFEF00CE690000CEA68400F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE000000000000000000FFFFFF00FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE000000000000000000FFFFFF00FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE700F7EFE700CE690000CEA68400EFE7DE005251
      5200ADAEAD00EFE7DE00EFE7DE000000000000000000FFFFFF00FFFFFF00F7F7
      EF0000000000FFEFEF00F7EFE700F7EFE700F7EFE700F7EFE700EFE7DE000000
      0000EFE7DE00EFE7DE00EFE7DE00000000000000000000000000000000000000
      00000000000000000000CE690000CEA68400F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00CE690000CEA68400000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF005251
      52000000000052515200FFEFEF00FFEFEF00F7EFE700F7EFE700525152000000
      000052515200EFE7DE00000000000000000000000000FFF7F700FFF7F700ADAE
      AD0052515200F7F7EF00CE690000CEA68400FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE000000000000000000FFF7F700FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE000000000000000000FFF7F700FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00CE690000CEA68400F7EFE7005251
      5200ADAEAD00EFE7DE00EFE7DE000000000000000000FFF7F700FFF7F700ADAE
      AD0000000000ADAEAD00F7F7EF00FFEFEF00FFEFEF00F7EFE700ADAEAD000000
      0000ADAEAD00EFE7DE00EFE7DE00000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00CE690000CEA68400FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00CE690000CEA68400F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF0000000000FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE7000000
      0000F7EFE700F7EFE7000000000000000000000000000000000000000000FFF7
      F70000000000FFFFFF0000000000F7F7EF0000000000F7F7EF0000000000F7EF
      E70000000000F7EFE7000000000000000000000000000000000000000000FFF7
      F70000000000FFFFFF0000000000F7F7EF0000000000F7F7EF0000000000F7EF
      E70000000000F7EFE7000000000000000000000000000000000000000000FFF7
      F70000000000FFFFFF0000000000F7F7EF0000000000F7F7EF0000000000F7EF
      E70000000000F7EFE7000000000000000000000000000000000000000000FFF7
      F70000000000FFFFFF0000000000F7F7EF0000000000F7F7EF0000000000F7EF
      E70000000000F7EFE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000633010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD86630063301000AD86
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000633010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000633010000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD86630063301000AD86
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000633010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ADAEAD0000000000ADAEAD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF510000FF510000FF51
      0000FF5100000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ADAEAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADAEAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ADAEAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADAEAD00000000000000000000000000ADAEAD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ADAEAD0000000000ADAEAD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADAEAD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ADAEAD0000000000ADAEAD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ADAEAD00000000000000000000000000848684000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADAEAD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADAEAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ADAEAD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ADAEAD00000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000ADAEAD00000000000000000000000000848684000000
      0000000000000000000000000000633010000000000000000000633010000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF510000FF510000FF51
      0000FF5100000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF0000000000000000000000000000000000000000000000FF00
      000000000000AD866300633010000000000000000000AD86630063301000AD86
      6300000000000000000000000000ADAEAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000633010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AD8663000000
      0000FF0000000000000000000000000000000000000000000000FF0000000000
      0000AD866300000000000000000000000000000000000000000000000000AD86
      630000000000FF0000000000000000000000000000000000000000000000FF00
      00000000000063301000AD866300000000000000000000000000633010000000
      000000000000000000000000000000000000ADAEAD0000000000000000000000
      00000000000000000000000000000000000000000000AD86630063301000AD86
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006330100063301000633010006330
      1000FF0000000000000000000000000000000000000000000000FF0000006330
      1000633010006330100063301000633010006330100063301000633010006330
      100063301000FF00000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000633010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000633010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AD8663000000
      0000FF0000000000000000000000000000000000000000000000FF0000000000
      0000AD866300000000000000000000000000000000000000000000000000AD86
      630000000000FF00000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000633010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000633010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000633010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD60000000000EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000CE690000CE69
      0000CE690000CE690000CE690000CE690000CE69000000000000CE690000CE69
      0000CE690000CE69000000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD60000000000EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD60000000000EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000CE690000CE69
      0000CE690000CE690000CE690000CE690000CE690000CE69000000000000CE69
      0000CE690000CE69000000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD60000000000EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD60000000000EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD60000000000EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE70000000000EFE7DE00EFE7DE00EFE7DE00EFE7DE0000000000EFDF
      D600EFDFD600EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE70000000000EFE7DE00EFE7DE00EFE7DE00EFE7DE0000000000EFDF
      D600EFDFD600EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE70000000000EFE7DE00EFE7DE00EFE7DE00EFE7DE0000000000EFDF
      D600EFDFD600EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE70000000000EFE7DE00EFE7DE00EFE7DE00EFE7DE0000000000EFDF
      D600EFDFD600EFDFCE0000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE70000000000F7EFE700EFE7DE00EFE7DE0000000000EFE7DE000000
      0000EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE70000000000F7EFE700EFE7DE00EFE7DE0000000000EFE7DE000000
      0000EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE70000000000F7EFE700EFE7DE00EFE7DE0000000000EFE7DE000000
      0000EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE70000000000F7EFE700EFE7DE00EFE7DE0000000000EFE7DE000000
      0000EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00FFEF
      EF00FFEFEF0000000000F7EFE700F7EFE700EFE7DE0000000000EFE7DE000000
      0000EFE7DE00EFDFD60000000000000000000000000000000000FFEFEF00FFEF
      EF00FFEFEF0000000000F7EFE700F7EFE700EFE7DE0000000000EFE7DE000000
      0000EFE7DE00EFDFD60000000000000000000000000000000000CE690000CE69
      0000CE69000000000000CE690000CE690000CE69000000000000CE6900000000
      0000CE690000CE69000000000000000000000000000000000000FFEFEF00FFEF
      EF00FFEFEF0000000000F7EFE700F7EFE700EFE7DE0000000000EFE7DE000000
      0000EFE7DE00EFDFD60000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF0000000000FFEFEF00F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF0000000000FFEFEF00F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF0000000000FFEFEF00F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF0000000000FFEFEF00F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF0000000000FFEFEF0000000000F7EFE700F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF0000000000FFEFEF0000000000F7EFE700F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF0000000000FFEFEF0000000000F7EFE700F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF0000000000FFEFEF0000000000F7EFE700F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF0000000000F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF0000000000F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF0000000000F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF0000000000F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFF7F7000000
      0000F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F7000000
      0000F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F7000000
      0000F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000CE6900000000
      0000CE690000CE690000CE69000000000000CE690000CE690000CE690000CE69
      0000CE690000CE69000000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00DEDFD60008494A0021595A0008494A0000000000EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7EFE700F7EF
      E700EFE7EF00426973000051000063A6AD0021595A00EFDFD60000000000EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7EFE700F7EF
      E7004269730008494A005AE7F70008416B00EFE7DE00EFE7DE0000000000EFDF
      D600EFDFD600EFDFCE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7EFEF004269
      73000051000000EFFF004AB6DE00638E8400EFE7DE0000000000EFE7DE000000
      0000EFDFD600EFDFD60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000426973000051
      000000EFFF0000FFFF0008699400BDCFCE00EFE7DE0000000000EFE7DE000000
      0000EFE7DE00EFDFD60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7FFFF00083039002969290008A6
      DE0000EFFF0000EFFF0008416B0039698C00F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000018699C000051000008A6DE0000EF
      FF0000EFFF0021595A0021595A0021595A00F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000021595A00008EB500008EB50008A6
      DE0000EFFF0000FFFF0008699400398EA500F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000051730008494A00008E
      B50000BEEF00109E9C00638E8C0010101000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001038390008494A0000BE
      EF00008EB50039698C00EFEFEF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000080808000830390008699400008E
      B500003052001018180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000018699C002961100031A6C6003969
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000018616B0010494200189EA5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B5AEA500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD9E8C00845931006330
      0000734110008C694A00CEAE9400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CE69
      0000CE690000CE69000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD866300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C79520063300000734110008C79
      6B00CEAE94009C867B0073492900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000008080800000808000808
      0800080808000808080008080800080808000808080000000000CE690000EFCF
      A500FFFFFF00EFCFA500CE690000000000000000000000000000000000000000
      000000000000000000000000000000000000EFDFCE008C613100000000000000
      000000000000B5967300BDB6AD00000000000000000000000000000000000000
      0000000000000000000000000000AD9E8C006B3010007B411000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C8E8C008C8E8C008C8E
      8C008C8E8C008C8E8C008C8E8C008C8E8C008C8E8C0000000000CE690000FFFF
      FF00FFFFFF00FFFFFF00CE690000000000000000000000000000000000000000
      0000DEAE7300000000000000000000000000F7E7CE007341080000000000CEBE
      AD00DEAE7300D6CFCE0000000000000000000000000000000000000000000000
      00000000000000000000000000009C795200734108008C694A00000000000000
      0000000000000000000000000000000000000000000000000000000000006B69
      6B0094969400C6C7C60008494A0021595A0008494A00BDBEBD007B797B003938
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE690000EFCF
      A500FFFFFF00EFCFA500CE690000000000000000000000000000000000000000
      000000000000F7DFAD000000000094613100FFF7EF0073492900CE9E7300F7DF
      AD00CEBEAD000000000000000000000000000000000000000000000000000000
      0000000000000000000063300000633000006330000063300000633000000000
      0000000000006330000000000000000000000000000000000000000000000000
      0000FFFFFF0042717B000051000063A6AD0021595A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CE69
      0000CE690000CE69000000000000000000000000000000000000000000000000
      00000000000000000000F7DFAD00EFCFA500FFFFFF00FFD79400FFF7EF00CEA6
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000633010006330000063300000000000000000
      000063300000633000006330100000000000000000006B696B0094969400C6C7
      C6004269730008494A005AE7F70008416B00BDBEBD00A5A6A500737173003130
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EFB67B00FFF7EF000000000000000000FFD79400B596
      7300B5967300B5967300AD866300CECFCE000000000000000000000000000000
      0000000000000000000000000000000000006330000000000000000000006330
      0000633000006330000063300000633000000000000000000000F7FFFF004271
      7B000051000000EFFF004AB6DE006B968C00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C000000000000000000000000000000000000000000FFD7
      9400F7DFAD00F7DFCE00FFEFDE00FFF7EF000000000000000000FFF7F700FFF7
      EF00FFEFDE00EFDFCE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C694A00734108009C79520000000000000000000000000042717B000051
      000000EFFF0000FFFF0008699400A5C7C6009C9E9C006B696B00313031000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C0000000000000000000000000000000000000000000000
      00000000000000000000F7DFAD00FFEFDE00FFF7EF00FFF7EF00F7CFA5007B41
      1000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B4110006B301000AD9E8C0000000000F7FFFF0042717B002969290008A6
      DE0000EFFF0000EFFF0008416B0039698C00F7FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C0000000000000000000000000000000000000000000000
      000000000000C6CFD600F7DFAD00F7DFAD00F7E7CE00FFD79400FFEFDE00CEBE
      AD008C694A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000734929009C867B00CEAE94008C796B007341
      1000633000009C795200000000000000000018699C000051000008A6DE0000EF
      FF0000EFFF0000EFFF0021595A0021595A00BDBEBD007B797B00393839000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C0000000000000000000000000094969400424142000000
      000000000000FFD79400D6CFB50000000000F7DFCE0073615200D6CFCE00F7DF
      CE0000000000AD9E8C00B5AEA500000000000000000094969400424142000000
      00000000000018201800BDBEBD00CEAE94008C694A0073411000633000008459
      3100AD9E8C00DEDFDE00000000000000000021595A00008EB500008EB50008A6
      DE0000EFFF0000FFFF0008699400398EAD00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C00000000000000000094969400424142009C9E9C000000
      000000000000C6CFD6000810080008100800F7DFAD009C867B00BDBEBD00DEDF
      DE00EFDFCE00DED7CE0063616B000000000094969400424142009C9E9C000000
      000000000000C6BEC6004241420073797B00949E9400BDBEBD00EFEFEF00F7F7
      F700DEDFDE004A494A007B797B000000000000000000398EAD0008494A00008E
      B50000BEEF00109E9C00638E8400C6C7C6009496940063616300313031000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C000000000000000000BDBEBD0000000000848684000000
      000000000000000000009496940094969400EFD7BD00BDB6AD00000000000000
      000000000000848684000000000000000000BDBEBD0000000000848684000000
      000000000000000800009C9E9C00A5A6A500ADA6AD00ADAEAD00393839000000
      0000000000008C8E8C000008000000000000000000006B968C0008494A0000BE
      EF00008EB50039698C00F7F7F700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C000000000000000000BDBEBD00424142009C9E9C00DEDF
      DE00BDBEBD00BDBEBD004A49420000000000D6CFCE004A4942009C9E9C00DEDF
      DE00BDBEBD00848684004241420000000000BDBEBD00424142009C9E9C00DEDF
      DE00BDBEBD00BDBEBD004A49420000000000BDBEBD004A4942009C9E9C00DEDF
      DE00BDBEBD00848684004241420000000000FFFFFF004269730008699400008E
      B50039698C00C6C7C600949694006B696B003938390010101000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C00000000000000000000000000DEDFDE00102808001028
      08001028080010280800000000000000000000000000DEDFDE00102808000000
      00000000000042414200000000000000000000000000DEDFDE00102808001028
      08001028080010280800000000000000000000000000DEDFDE00102808000000
      00000000000042414200000000000000000018699C002961100031A6C6003969
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEDFDE00DEDF
      DE00DEDFDE000000000000000000000000000000000000000000DEDFDE00DEDF
      DE00DEDFDE000000000000000000000000000000000000000000DEDFDE00DEDF
      DE00DEDFDE000000000000000000000000000000000000000000DEDFDE00DEDF
      DE00DEDFDE0000000000000000000000000018616B0010494200189EA5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000808
      08008C8E8C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C0000000000000000000000000000000000CE690000CE69
      0000CE6900000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000000000000808
      08008C8E8C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C00000000000000000000000000CE690000EFCFA500FFFF
      FF00EFCFA500CE69000000000000080808000008080008080800080808000808
      0800080808000808080008080800000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000000000000808
      08008C8E8C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C00000000000000000000000000CE690000FFFFFF00FFFF
      FF00FFFFFF00CE690000000000008C8E8C008C8E8C008C8E8C008C8E8C008C8E
      8C008C8E8C008C8E8C008C8E8C00000000000000000000000000F7EFE700F7EF
      E70000000000000000000000000000000000000000000000000000000000DEDF
      DE00EFDFCE00EFDFCE0000000000000000000000000000000000000000000808
      08008C8E8C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C00000000000000000000000000CE690000EFCFA500FFFF
      FF00EFCFA500CE69000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7EFE700F7EF
      E700DEDFDE000000000000000000EFE7DE00EFE7DE00DEDFDE00000000000000
      0000EFDFD600EFDFCE0000000000000000000000000000000000000000000808
      08008C8E8C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C0000000000000000000000000000000000CE690000CE69
      0000CE6900000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE7000000000000000000EFE7DE00EFE7DE00EFE7DE00000000000000
      0000EFDFD600EFDFD60000000000000000000000000000000000000000000808
      08008C8E8C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFEFEF00FFEF
      EF00FFEFEF000000000000000000F7EFE700EFE7DE00EFE7DE00000000000000
      0000EFE7DE00EFDFD60000000000000000000000000000000000000000000808
      08008C8E8C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C0000000000000000000000000000000000080808008C8E
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF000000000000000000F7EFE700F7EFE700FFEFDE00000000000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000000000000808
      08008C8E8C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808008C8E8C0000000000000000000000000000000000080808008C8E
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00F7F7
      EF00DEDFDE000000000000000000F7EFE700F7EFE700DEDFDE00000000000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000080808008C8E
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFF7
      EF0000000000000000000000000000000000000000000000000000000000DEDF
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000CE690000CE69
      0000CE6900000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CE69
      0000CE690000CE69000000000000000000000000000000000000080808008C8E
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE00000000000000000000000000CE690000EFCFA500FFFF
      FF00EFCFA500CE69000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE690000EFCF
      A500FFFFFF00EFCFA500CE690000000000000000000000000000080808008C8E
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE700000000000000000000000000CE690000FFFFFF00FFFF
      FF00FFFFFF00CE69000000000000080808000008080008080800080808000808
      0800080808000808080008080800000000000000000000080800080808000808
      0800080808000808080008080800080808000808080000000000CE690000FFFF
      FF00FFFFFF00FFFFFF00CE690000000000000000000000000000080808008C8E
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE690000EFCFA500FFFF
      FF00EFCFA500CE690000000000008C8E8C008C8E8C008C8E8C008C8E8C008C8E
      8C008C8E8C008C8E8C008C8E8C0000000000000000008C8E8C008C8E8C008C8E
      8C008C8E8C008C8E8C008C8E8C008C8E8C008C8E8C0000000000CE690000EFCF
      A500FFFFFF00EFCFA500CE690000000000000000000000000000080808008C8E
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE690000CE69
      0000CE6900000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CE69
      0000CE690000CE69000000000000000000000000000000000000080808008C8E
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF0000000000EFE7DE0000000000EFE7DE00EFDFD60000000000EFDFD6000000
      0000EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E7000000000000000000EFE7DE00EFE7DE00EFE7DE000000000000000000EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E7000000000000000000EFE7DE00EFE7DE00EFE7DE00EFDFD600000000000000
      0000EFDFCE00EFDFCE0000000000000000000000000000000000CE690000CE69
      0000CE690000CE690000CE690000CE690000CE690000CE690000CE690000CE69
      0000CE690000CE69000000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E70000000000F7EFE70000000000EFE7DE00EFE7DE0000000000EFE7DE000000
      0000EFDFD600EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E7000000000000000000EFE7DE00EFE7DE00EFE7DE00EFE7DE00000000000000
      0000EFDFD600EFDFCE0000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD60000000000000000000000000000000000FFEFEF000000
      0000F7EFE70000000000F7EFE70000000000EFE7DE0000000000EFE7DE000000
      0000EFDFD6000000000000000000000000000000000000000000FFEFEF00F7EF
      E7000000000000000000F7EFE700EFE7DE00EFE7DE000000000000000000EFE7
      DE00EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00F7EF
      E7000000000000000000F7EFE700DEDFDE00DEDFDE00EFE7DE00000000000000
      0000EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00FFEF
      EF00FFEFEF00F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE00EFDFD60000000000000000000000000000000000FFEFEF000000
      00000000000000000000F7EFE700000000000000000000000000EFE7DE000000
      000000000000EFDFD60000000000000000000000000000000000FFEFEF00FFEF
      EF00FFEFEF00F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE00EFDFD60000000000000000000000000000000000FFEFEF00FFEF
      EF000000000000000000DEDFDE000000000000000000DEDFDE00000000000000
      0000EFE7DE00EFDFD60000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00FFEFEF00F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF000000
      0000FFEFEF0000000000FFEFEF0000000000F7EFE70000000000EFE7DE000000
      0000EFE7DE000000000000000000000000000000000000000000F7F7EF00F7F7
      EF0000000000FFEFEF0000000000F7EFE700F7EFE70000000000EFE7DE000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF00F7F7
      EF00000000000000000000000000000000000000000000000000000000000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000CE690000CE69
      0000CE690000CE690000CE690000CE690000CE690000CE690000CE690000CE69
      0000CE690000CE69000000000000000000000000000000000000FFFFFF00F7F7
      EF0000000000FFEFEF00F7EFE700F7EFE70000000000F7EFE700EFE7DE000000
      000000000000EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF00000000000000000000000000F7EFE700F7EFE70000000000000000000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF00000000000000000000000000ADAEAD00ADAEAD0000000000000000000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF0000000000F7F7EF0000000000FFEFEF00F7EFE70000000000F7EFE7000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF000000000000000000ADAEAD00FFEFEF00F7EFE700ADAEAD00000000000000
      0000EFE7DE00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF0000000000F7F7EF00FFEFEF00FFEFEF00F7EFE70000000000F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008486840084868400848684008486
      8400848684008486840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B696B009C9E9C000000
      000000000000000000000000000000000000CECFCE00CECFCE00CECFCE00CECF
      CE00CECFCE00CECFCE0000000000000000000000000000000000EFE7DE000000
      0000EFE7DE0000000000EFDFD60000000000EFDFCE0000000000EFDFCE000000
      0000EFDFCE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBEBD0063696B00948E
      8C00A5A69C00DEDFDE000000000000000000CECFCE0000000000CECFCE00CECF
      CE00CECFCE00CECFCE00000000000000000000000000F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE000000000000000000000000000000000000000000EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600F7E7CE00EFDFCE00F7DF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700BDBE
      C60063696B00A5A6A5000000000000000000CECFCE0000000000CECFCE00CECF
      CE00CECFCE00CECFCE0000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE000000000000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE0000000000EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE000000000000000000000000000000000000000000F7EFE700EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF005A595A000000000000000000CECFCE00CECFCE00CECFCE00CECF
      CE00CECFCE00CECFCE00000000000000000000000000F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE0000000000EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE000000000000000000000000000000000000000000F7EFE700F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE00EFDFCE0000000000000000000000000000000000000000000000
      0000000000005A595A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE0000000000EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD6000000000000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE0000000000EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD6000000000000000000000000000000000000000000F7EFE700F7EF
      E700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD600EFDFCE0000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE7005A595A0000000000F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F7000000000000000000FFEFEF00FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE70000000000EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD6000000000000000000000000000000000000000000FFEFEF00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD600EFDFD60000000000000000000000000000000000FFEFEF00FFEF
      EF00FFEFEF005A595A0000000000F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700000000000000000000000000FFEFEF000000
      0000FFEFEF0000000000F7EFE70000000000EFE7DE0000000000EFE7DE000000
      0000EFE7DE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFEFEF00FFEF
      EF00FFEFEF00F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE00EFDFD60000000000000000000000000000000000000000000000
      0000000000005A595A0000000000F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F7000000000000000000F7F7EF00F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00F7EFE70000000000F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000F7F7EF00F7F7
      EF00FFEFEF00FFEFEF00FFEFEF00F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF005A595A0000000000F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE70000000000F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE70000000000F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE000000000000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF004241420000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF0000000000F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE000000000000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EF
      E700EFE7DE00EFE7DE0000000000000000000000000000000000000000000000
      00000000000010101000424142005A595A005A595A005A595A005A595A005A59
      5A005A595A005A595A005A595A00000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF000000000000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF0000000000FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF000000000000000000000000000000000000000000FFF7F700FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE700F7EF
      E700EFEFEF00EFE7DE0000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF0000000000F7F7EF00F7F7EF00FFEFEF00FFEFEF0000000000F7EF
      E700F7EFE700F7EFE700000000000000000000000000FFF7F700FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF0000000000FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE7000000000000000000000000000000000000000000FFF7F700FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F700FFF7
      F700FFF7F70000000000FFFFFF00F7F7EF00F7F7EF00F7F7EF0000000000F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000FFF7F7000000
      0000FFF7F70000000000FFFFFF0000000000F7F7EF0000000000FFEFEF000000
      0000F7EFE7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B41
      0800734108007338100073380800734108000000000000000000000000000000
      00000000000000000000000000000000000000000000ADA6A50063696B006369
      6B008C969400DED7D60000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ADA6A50063696B006369
      6B008C969400DED7D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007341
      0800AD714200AD714200AD714200AD714200000000006B696B009C9E9C000000
      0000000000000000000000000000D6C7C6005A59520063696B00B5AEA500BDB6
      B500A5A69C0063696B0063616300000000000000000073797300CECFCE00EFEF
      EF00EFEFEF000000000000000000D6C7C6005A59520063696B00B5AEA500BDB6
      B500A5A69C0063696B0063616300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C68E6B0000000000000000007341
      0800AD714200AD714200AD714200AD71420000000000BDBEBD0063696B00948E
      8C00A5A69C00C6C7C600A59E9C005A595A009C9E9C00E7DFCE0000000000F7DF
      CE00EFDFCE00DEDFD60094968C000000000000000000DEDFDE00EFEFEF000051
      000029611000F7EFE700CECFCE006B696B009C9E9C00E7DFCE0000000000F7DF
      CE00EFDFCE00DEDFD60094968C0000000000FFFFFF00FFFFFF00FFEFDE00EFDF
      CE00EFCFB500DECFAD00DECFAD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B5714A007338100000000000000000007341
      0800AD714200AD714200AD714200AD7142000000000000000000F7EFE700BDBE
      C60063696B00000808000008080000080800101010004A494A00BDBEBD00EFDF
      CE00EFDFCE00EFDFCE00000000000000000000000000EFEFEF00296110005A9E
      21005A9E210029611000F7EFE700DEDFD60000000000EFDFD60000000000EFDF
      CE00EFDFCE00EFDFCE000000000000000000FFFFFF00FFFFFF00FFF7EF00FFEF
      DE00EFDFCE00EFCFB500DECFAD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000094592100733810007338100073381000733810006B41
      0800734108007338100073380800734108000000000000000000F7EFE700F7EF
      E700EFEFEF0073797B000008080000080800424142002120210000080800ADAE
      AD00EFDFCE00EFDFCE00000000000000000000000000005100005A9E21005A9E
      21005A9E2100528E290029611000EFE7DE00F7F7EF00EFE7DE0000000000EFDF
      D600EFDFCE00EFDFCE000000000000000000FFFFFF00FFFFFF00FFFFFF00FFF7
      EF00FFEFDE00EFDFCE00EFCFB500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B5714A007338100000000000000000007341
      0800AD714200AD714200AD714200AD7142000000000000000000000000000000
      0000000000000000000094AEAD00000808004A494A004A494A00000808007379
      7B0000000000000000000000000000000000296110005A9E21005A9E21005A9E
      2100BDBEBD005A9E21005A9E210029611000F7F7EF0073717300101010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007338100073381000733810000000
      000000000000C68E6B0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C68E6B0000000000000000007341
      0800AD714200AD714200AD714200AD7142000000000000000000FFEFEF00F7EF
      E700F7EFE70000000000F7EFE700636163000008080021202100313029009486
      6B00EFDFD600EFDFD60000000000000000005A9E21005A9E21005A9E2100FFF7
      F700FFF7EF00737173005A9E21005A9E210029611000F7F7EF0042414200EFE7
      DE00EFDFD600EFDFD6000000000000000000AD714200AD714200AD714200AD71
      4200AD714200AD714200AD714200AD714200AD714200AD714200734108000000
      00000000000073381000B5714A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007341
      0800AD714200AD714200AD714200AD7142000000000000000000FFEFEF00FFEF
      EF00FFEFEF0000000000F7EFE700F7EFE7006361630031302900FFFFFF007361
      5200212021008C9694000000000000000000000000005A9E2100FFF7F700FFF7
      EF00FFEFEF0010101000FFF7EF00FFF7F7005A9E2100296110005A595A00EFE7
      DE00EFE7DE00EFDFD6000000000000000000AD714200AD714200AD714200AD71
      4200AD714200AD714200AD714200AD714200AD714200AD714200734108007338
      100073381000733810007338100094592100FFFFFF00FFEFDE00EFDFCE00EFCF
      B500DECFAD00DECFAD0000000000000000000000000000000000000000007338
      1000733810007338100073381000733810000000000000000000000000000000
      00000000000000000000000000000000000000000000949E9C0084868400FFF7
      F7007361520042414200738E8C00000000000000000029282900101010000000
      000000000000000000000000000010101000737173005A9E2100424142000000
      000000000000000000000000000000000000AD714200AD714200AD714200AD71
      4200AD714200AD714200AD714200AD714200AD714200AD714200734108000000
      00000000000073381000B5714A0000000000FFFFFF00FFF7EF00FFEFDE00EFDF
      CE00EFCFB500DECFAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00F7F7
      EF00F7F7EF0000000000F7EFE700F7EFE700F7EFE700F7EFE7008C8E8C006361
      6300EFF7FF0021496B0021496B00BDC7CE000000000000000000FFFFFF00F7F7
      EF00F7F7EF0000000000F7EFE700F7EFE700FFEFEF00FFF7EF0010101000EFE7
      DE00EFE7DE00EFE7DE0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000073381000734108006B4108000000
      000000000000C68E6B000000000000000000FFFFFF00FFFFFF00FFF7EF00FFEF
      DE00EFDFCE00EFCFB50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFF7
      EF00F7F7EF0000000000FFEFEF00FFEFEF00F7EFE700F7EFE700000000005249
      4A005269AD006BA6E70021496B0021496B000000000000000000FFFFFF00FFF7
      EF00F7F7EF0000000000FFEFEF00FFEFEF00F7EFE700F7EFE70000000000F7EF
      E700EFE7DE00EFE7DE000000000000000000FFFFFF00FFFFFF00FFEFDE00EFDF
      CE00EFCFB500DECFAD00DECFAD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001828520063A6AD006BA6E70021496B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFF7EF00FFEF
      DE00EFDFCE00EFCFB500DECFAD00000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFEFDE00EFDFCE00EFCF
      B500DECFAD00DECFAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFF7F7000000
      0000FFFFFF0000000000F7F7EF00F7F7EF00FFEFEF00FFEFEF0000000000F7EF
      E700F7EFE70021496B005269AD006BA6E7000000000000000000FFF7F700FFFF
      FF00FFFFFF0000000000F7F7EF00F7F7EF00FFEFEF00FFEFEF0000000000F7EF
      E700F7EFE700F7EFE7000000000000000000FFFFFF00FFFFFF00FFFFFF00FFF7
      EF00FFEFDE00EFDFCE00EFCFB500000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFF7EF00FFEFDE00EFDF
      CE00EFCFB500DECFAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFF7F7000000
      0000FFF7F70000000000FFFFFF00F7F7EF00F7F7EF00F7F7EF0000000000F7EF
      E700F7EFE700F7EFE70021496B005269AD000000000000000000FFF7F700FFF7
      F700FFF7F70000000000FFFFFF00F7F7EF00F7F7EF00F7F7EF0000000000F7EF
      E700F7EFE700F7EFE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFF7EF00FFEF
      DE00EFDFCE00EFCFB50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000021496B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000945921000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000073410800AD714200AD714200AD7142007341
      0800AD714200AD714200AD714200733810000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B5714A0073381000B5714A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000073380800AD714200AD714200AD7142007338
      0800AD714200AD714200AD714200733810000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C68E6B00733810007338100073381000C68E6B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000073381000AD714200AD714200AD7142007338
      1000AD714200AD714200AD714200733810000000000000000000000000000000
      000000000000000000000000000000000000C68E6B0000000000000000006B41
      080073410800733810007338080073410800FFFFFF00FFEFDE00EFDFCE00EFCF
      B500DECFAD00DECFAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000733810000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000073410800AD714200AD714200AD7142007341
      0800AD714200AD714200AD714200733810000000000000000000000000000000
      0000000000000000000000000000B5714A007338100000000000000000007341
      0800AD714200AD714200AD714200AD714200FFFFFF00FFF7EF00FFEFDE00EFDF
      CE00EFCFB500DECFAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000733810000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006B4108007341080073410800734108006B41
      0800734108007341080073410800733810000000000000000000000000000000
      0000000000000000000094592100733810007338100073381000733810007341
      0800AD714200AD714200AD714200AD714200FFFFFF00FFFFFF00FFF7EF00FFEF
      DE00EFDFCE00EFCFB50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000733810007341080073410800734108006B410800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007338
      1000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B5714A007338100000000000000000007341
      0800AD714200AD714200AD714200AD7142000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000073381000AD714200AD714200AD71420073410800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007338
      1000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C68E6B0000000000000000007338
      1000733810007338100073381000733810000000000000000000000000000000
      000000000000000000000000000000000000C68E6B0000000000000000006B41
      0800734108007338100073380800734108000000000000000000000000000000
      00000000000073381000AD714200AD714200AD71420073381000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C68E6B00733810007338
      100073381000C68E6B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B5714A007338100000000000000000007341
      0800AD714200AD714200AD714200AD7142000000000000000000000000000000
      00000000000000000000AD714200AD714200AD71420000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5714A007338
      1000B5714A00000000000000000000000000FFFFFF00FFEFDE00EFDFCE00EFCF
      B500DECFAD00DECFAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000094592100733810007338100073381000733810007341
      0800AD714200AD714200AD714200AD7142000000000000000000EFCFB500DECF
      AD00DECFAD0000000000AD714200AD714200AD71420000000000EFCFB500DECF
      AD00DECFAD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009459
      210000000000000000000000000000000000FFFFFF00FFF7EF00FFEFDE00EFDF
      CE00EFCFB500DECFAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B5714A007338100000000000000000007341
      0800AD714200AD714200AD714200AD7142000000000000000000EFDFCE00EFCF
      B500DECFAD0000000000AD714200AD714200AD71420000000000EFDFCE00EFCF
      B500DECFAD0000000000000000000000000000000000EFCFB500DECFAD00DECF
      AD0000000000EFCFB500DECFAD00DECFAD000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFF7EF00FFEF
      DE00EFDFCE00EFCFB50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C68E6B0000000000000000007338
      1000733810007338100073381000733810000000000000000000FFEFDE00EFDF
      CE00EFCFB50000000000AD714200AD714200AD71420000000000FFEFDE00EFDF
      CE00EFCFB50000000000000000000000000000000000EFDFCE00EFCFB500DECF
      AD0000000000EFDFCE00EFCFB500DECFAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFF7EF00FFEF
      DE00EFDFCE0000000000AD714200AD714200AD71420000000000FFF7EF00FFEF
      DE00EFDFCE0000000000000000000000000000000000FFEFDE00EFDFCE00EFCF
      B50000000000FFEFDE00EFDFCE00EFCFB5000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFEFDE00EFDFCE00EFCF
      B500DECFAD00DECFAD0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFEFDE00EFDFCE00EFCF
      B500DECFAD00DECFAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFF7
      EF00FFEFDE0000000000AD714200AD714200AD71420000000000FFFFFF00FFF7
      EF00FFEFDE0000000000000000000000000000000000FFF7EF00FFEFDE00EFDF
      CE0000000000FFF7EF00FFEFDE00EFDFCE000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFF7EF00FFEFDE00EFDF
      CE00EFCFB500DECFAD0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFF7EF00FFEFDE00EFDF
      CE00EFCFB500DECFAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000AD714200AD714200AD71420000000000FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF00FFF7EF00FFEF
      DE0000000000FFFFFF00FFF7EF00FFEFDE000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFF7EF00FFEF
      DE00EFDFCE00EFCFB50000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFF7EF00FFEF
      DE00EFDFCE00EFCFB50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000AD714200AD714200AD71420000000000FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADAE9400B5AEA500C6CFD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073410800AD714200AD71
      4200AD7142007338100000000000000000000000000000000000000000000000
      00000000000073410800AD714200AD714200AD71420073381000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADAE940021496B0063A6AD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073380800AD714200AD71
      4200AD7142007338100000000000000000000000000000000000000000000000
      00000000000073380800AD714200AD714200AD71420073381000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADAE
      940021496B005269AD006BA6E7000000000000000000000000004A494A004A49
      4A004A494A004A494A004A494A004A494A004A494A004A494A004A494A004A49
      4A004A494A004A494A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073381000AD714200AD71
      4200AD7142007338100000000000000000000000000000000000000000000000
      00000000000073381000AD714200AD714200AD71420073381000000000000000
      000000000000000000000000000000000000000000000000000000000000CECF
      CE00BDBEBD00B5AEA500ADAE9400ADAE9400B5AEA500BDBEBD00ADAE94002149
      6B005269AD006BA6E700000000000000000000000000000000004A494A00EFEF
      EF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDFD600EFDF
      CE00EFDFCE004A494A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073410800AD714200AD71
      4200AD7142007338100000000000000000000000000000000000000000000000
      00000000000073410800AD714200AD714200AD71420073381000000000000000
      0000000000000000000000000000000000000000000000000000BDBEBD008C8E
      8C005A595A0031303100313029004A494A0073716B00948E8C00525152005269
      AD006BA6E70000000000000000000000000000000000000000004A494A00F7EF
      E700EFEFEF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDFD600EFDFD600EFDF
      D600EFDFCE004A494A0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B410800734108007341
      0800734108007338100000000000000000000000000000000000000000000000
      0000000000006B41080073410800734108007341080073381000000000000000
      00000000000000000000000000000000000000000000ADB6B500848684008486
      8400AD9E8C00CEA68400CEA68400B59673008C694A005A595A00848684008486
      8400CECFCE0000000000000000000000000000000000000000004A494A00F7EF
      E700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDF
      D600EFDFD6004A494A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007338
      1000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000733810000000000000000000000000000000
      000000000000000000000000000000000000BDC7CE0084868400ADAEAD00CEBE
      AD00CEBE9C00CEAE9400CEA68400CEA68400CEA67B00AD86630052515200948E
      8C00BDBEBD0000000000000000000000000000000000000000004A494A00F7EF
      E700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFDFD6004A494A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007338
      1000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000733810000000000000000000000000000000
      00000000000000000000000000000000000094AEAD00949E9C00D6CFCE00948E
      8C00312800003128000084594200CEA68400CEA67B00CEA67B00000000000000
      000000000000000000008C8E8C000000000000000000000000004A494A00FFEF
      EF00FFEFEF00F7EFE700F7EFE700F7EFE700EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE004A494A0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C68E6B00733810007338
      100073381000C68E6B0000000000000000000000000000000000000000000000
      000000000000C68E6B00733810007338100073381000C68E6B00000000000000
      00000000000000000000000000000000000084868400BDC7CE00D6DFE7003130
      2900D6CFB500CEBEAD0031280000CEAE94000000000000000000000000008C61
      31000000000000000000000000000000000000000000000000004A494A00F7F7
      EF00FFEFEF00FFEFEF00FFEFEF00F7EFE700F7EFE700FFEFDE00EFE7DE00EFE7
      DE00EFE7DE004A494A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5714A007338
      1000B5714A000000000000000000000000000000000000000000000000000000
      00000000000000000000B5714A0073381000B5714A0000000000000000000000
      00000000000000000000000000000000000073716B00DEDFDE00D6DFE700949E
      9C00313029003130290031280000CEBE9C008C6131008C6131008C6131008C61
      31008C61310000000000000000000000000000000000000000004A494A00F7F7
      EF00F7F7EF00FFEFEF00F7EFE700F7EFE700F7EFE700F7EFE700EFE7DE00EFE7
      DE00EFE7DE004A494A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009459
      2100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000945921000000000000000000000000000000
      00000000000000000000000000000000000073716B00D6DFE700D6DFE700D6DF
      E700DEDFDE00D6CFCE0031302900CEBEAD000000000000000000000000008C61
      310000000000000000008C8E8C000000000000000000000000004A494A00FFF7
      EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE700F7EFE7004A494A004A49
      4A004A494A004A494A00000000000000000000000000EFCFB500DECFAD00DECF
      AD0000000000EFCFB500DECFAD00DECFAD000000000000000000000000000000
      00000000000000000000000000000000000000000000EFCFB500DECFAD00DECF
      AD0000000000000000000000000000000000000000000000000000000000EFCF
      B500DECFAD00DECFAD0000000000000000008C969400CECFCE00D6DFE700DEDF
      DE00ADAEAD0042414200ADAE9400D6CFB500D6CFB500CEBE9C00000000000000
      00000000000000000000000000000000000000000000000000004A494A00FFFF
      FF00F7F7EF00F7F7EF00F7F7EF00FFEFEF00FFEFEF00F7EFE7004A494A000000
      00004A494A0000000000000000000000000000000000EFDFCE00EFCFB500DECF
      AD0000000000EFDFCE00EFCFB500DECFAD000000000000000000000000000000
      00000000000000000000000000000000000000000000EFDFCE00EFCFB500DECF
      AD0000000000000000000000000000000000000000000000000000000000EFDF
      CE00EFCFB500DECFAD000000000000000000ADAEAD00ADB6B500D6EFEF00FFFF
      FF00EFF7FF00D6DFE700DEDFDE00D6CFCE00D6CFCE00CEBEAD008C796B008486
      8400CECFCE0000000000000000000000000000000000000000004A494A00FFFF
      FF00FFFFFF00FFFFFF00F7F7EF00F7F7EF00FFEFEF00FFEFEF004A494A004A49
      4A000000000000000000000000000000000000000000FFEFDE00EFDFCE00EFCF
      B50000000000FFEFDE00EFDFCE00EFCFB5000000000000000000000000000000
      00000000000000000000000000000000000000000000FFEFDE00EFDFCE00EFCF
      B50000000000000000000000000000000000000000000000000000000000FFEF
      DE00EFDFCE00EFCFB5000000000000000000BDC7CE00949E9C00CECFCE00D6EF
      EF00D6DFE700D6DFE700D6DFE700DEDFDE00DEDFDE00AD9E8C0073716B00BDBE
      BD000000000000000000000000000000000000000000000000004A494A004A49
      4A004A494A004A494A004A494A004A494A004A494A004A494A004A494A000000
      00000000000000000000000000000000000000000000FFF7EF00FFEFDE00EFDF
      CE0000000000FFF7EF00FFEFDE00EFDFCE000000000000000000000000000000
      00000000000000000000000000000000000000000000FFF7EF00FFEFDE00EFDF
      CE0000000000000000000000000000000000000000000000000000000000FFF7
      EF00FFEFDE00EFDFCE00000000000000000000000000BDC7CE00949E9C00ADB6
      B500CECFCE00DEDFDE00DEDFDE00BDBEBD00948E8C0073797B00ADB6B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFF7EF00FFEF
      DE0000000000FFFFFF00FFF7EF00FFEFDE000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFF7EF00FFEF
      DE0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFF7EF00FFEFDE0000000000000000000000000000000000BDC7CE00ADAE
      AD008C96940073716B0073716B008486840094AEAD00BDC7CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000009496
      B50073718C0094DFE70094DFE7002996BD002996BD0094AEAD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADAE9400B5AEA500C6CFD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADAE9400B5AEA500C6CFD6000000000000000000C6CFD6001869
      9C0094EFF70094EFF70094EFF70094EFF70029AED60029AED6002996BD0094AE
      AD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADAE940021496B0063A6AD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADAE940021496B0063A6AD000000000000000000C6CFD6005269AD0063A6
      AD0094EFF7004AB6DE004AB6DE0094EFF70094EFF7005AE7F7006BA6E70029AE
      D60063A6AD000000000000000000000000000000000000000000ADAEAD000000
      0000ADAEAD000000000000000000000000000000000000000000000000000000
      000000000000ADAEAD0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADAE
      940021496B005269AD006BA6E700000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADAE
      940021496B005269AD006BA6E7000000000000000000BDC7CE00A5795200A571
      4200A5714200A5714200A5714200A5714200A5714200A5714200A5714200A571
      42006BA6E70018699C0000000000000000000000000000000000000000000000
      000000000000ADAEAD0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CECF
      CE00BDBEBD00B5AEA500ADAE9400ADAE9400B5AEA500BDBEBD00ADAE94002149
      6B005269AD006BA6E7000000000000000000000000000000000000000000CECF
      CE00BDBEBD00B5AEA500ADAE9400ADAE9400B5AEA500BDBEBD00ADAE94002149
      6B005269AD006BA6E7000000000000000000C6CFD60063A6AD00B5865200FFFF
      FF00EFE7DE00EFE7DE00DED7CE00DECFAD00DECFAD00DECFAD00DECFAD00A571
      42004AB6DE006BA6E70018699C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADAEAD000000000000000000000000000000000000000000BDBEBD008C8E
      8C005A595A0031303100313029004A494A0073716B00948E8C00525152005269
      AD006BA6E7000000000000000000000000000000000000000000BDBEBD008C8E
      8C005A595A0031303100313029004A494A0073716B00948E8C00525152005269
      AD006BA6E700000000000000000000000000ADB6D60063A6AD00B5865200FFF7
      F700EFE7DE00EFDFCE00DED7CE00DECFBD00DECFAD00DECFAD00DECFAD00A571
      42006BA6E7004AB6DE0018699C00000000000000000000000000ADAEAD000000
      00000000000000000000ADAEAD0000000000000000000000000000000000ADAE
      AD0000000000ADAEAD00000000000000000000000000ADB6B500848684008486
      8400AD9E8C00CEA68400CEA68400B59673008C694A005A595A00848684008486
      8400CECFCE0000000000000000000000000000000000ADB6B500848684008486
      8400AD9E8C00CEA68400CEA68400B59673008C694A005A595A00848684008486
      8400CECFCE000000000000000000000000009496B50029AED600B5865200FFFF
      FF00F7EFE700EFE7DE00EFDFCE00DECFBD00D6CFB500DECFAD00DEBEA500A571
      42004AB6DE004AB6DE0018699C0000000000000000000000000000000000ADAE
      AD00000000000000000000000000ADAEAD000000000000000000ADAEAD000000
      000000000000000000000000000000000000BDC7CE0084868400ADAEAD00CEBE
      AD00CEBE9C00CEAE9400CEA68400CEA68400CEA67B00AD86630052515200948E
      8C00BDBEBD00000000000000000000000000BDC7CE0084868400ADAEAD00CEBE
      AD00CEBE9C00CEAE9400CEA68400CEA68400CEA67B00AD86630052515200948E
      8C00BDBEBD0000000000000000000000000094AEAD0029AED600B5865200FFFF
      FF00F7F7EF00EFEFEF00EFE7DE00EFDFCE00B5865200AD794A00A5714200A571
      42004AB6DE0063A6AD00ADB6D600000000000000000000000000000000000000
      0000ADAEAD00000000000000000000000000ADAEAD00ADAEAD00000000000000
      00000000000000000000000000000000000094AEAD00949E9C00D6CFCE00948E
      8C00312800003128000084594200CEA6840084593100522800006B514A005251
      5200B5AEA500000000008C8E8C000000000094AEAD00949E9C00D6CFCE00948E
      8C00312800003128000084594200CEA68400CEA67B00000000006B514A005251
      5200000000000000000000000000000000000869940029AED600B5865200FFFF
      FF00FFFFFF00F7F7EF00EFE7DE00EFE7DE00AD794A00D6CFB500A57142006BA6
      E70063A6AD0094AEAD0000000000000000000000000000000000000000000000
      000000000000ADAEAD0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084868400BDC7CE00D6DFE7003130
      2900D6CFB500CEBEAD0031280000CEAE940052280000CEA68400B58663003130
      3100ADAE940000000000000000000000000084868400BDC7CE00D6DFE7003130
      2900D6CFB500CEBEAD0031280000CEAE9400CEA67B00948E8C00B58663003130
      3100948E8C000000000000000000948E8C0018699C0029AED600B5865200FFFF
      FF00FFFFFF00FFF7F700FFF7EF00EFEFEF00A5714200A571420029AED60029AE
      D600ADB6D6000000000000000000000000000000000000000000000000000000
      00000000000000000000ADAEAD00000000000000000000000000ADAEAD000000
      00000000000000000000000000000000000073716B00DEDFDE00D6DFE700949E
      9C00313029003130290031280000CEBE9C0031280000CEA68400CEA67B002120
      2100ADAE940000000000000000000000000073716B00DEDFDE00D6DFE700949E
      9C00313029003130290031280000CEBE9C00CEBE9C00CEA68400CEA67B002120
      2100ADAE940000000000000000000000000063A6AD008C9694008C9694005251
      520052515200B5865200B5865200B5865200A571420029AED6004AB6DE002996
      BD00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADAE
      AD000000000000000000000000000000000073716B00D6DFE700D6DFE700D6DF
      E700DEDFDE00D6CFCE0031302900CEBEAD003128000031280000633010003130
      2900B5AEA500000000008C8E8C000000000073716B00D6DFE700D6DFE700D6DF
      E700DEDFDE00D6CFCE0031302900CEBEAD00CEBE9C00CEBE9C00CEA67B003130
      2900B5AEA5000000000000000000000000000000000052515200FFFFFF00EFEF
      EF00BDBEBD0052515200525152005251520029AED6006BA6E70018699C000000
      000000000000000000000000000000000000000000000000000000000000BDC7
      CE00BDC7CE00000000000000000000000000ADAEAD00ADAEAD00000000000000
      0000000000000000000000000000000000008C969400CECFCE00D6DFE700DEDF
      DE00ADAEAD0042414200ADAE9400D6CFB50052280000CEBE9C00AD8663005249
      4A00BDBEBD000000000000000000000000008C969400CECFCE00D6DFE700DEDF
      DE00ADAEAD0042414200ADAE9400D6CFB500D6CFB500CEBE9C00AD8663005249
      4A00BDBEBD000000000000000000000000000000000000000000525152008C8E
      8C00F7EFE700FFFFFF00FFFFFF00EFEFEF00949E9C002996BD00C6CFD6000000
      0000000000000000000000000000000000000000000000000000ADAEAD000000
      0000000000000000000000000000ADAEAD000000000000000000ADAEAD000000
      000000000000000000000000000000000000ADAEAD00ADB6B500D6EFEF00FFFF
      FF00EFF7FF00D6DFE700DEDFDE00D6CFCE0052302900CEBEAD008C796B008486
      8400CECFCE00000000000000000000000000ADAEAD00ADB6B500D6EFEF00FFFF
      FF00EFF7FF00D6DFE700DEDFDE00D6CFCE00D6CFCE00CEBEAD008C796B008486
      8400CECFCE000000000000000000000000000000000000000000000000005251
      5200FFFFFF0052515200CECFCE005251520000000000C6CFD600000000000000
      00000000000000000000000000000000000000000000ADAEAD00000000000000
      00000000000000000000ADAEAD0000000000000000000000000000000000ADAE
      AD0000000000000000000000000000000000BDC7CE00949E9C00CECFCE00D6EF
      EF00D6DFE700D6DFE700D6DFE700DEDFDE0052302900AD9E8C0073716B00BDBE
      BD0000000000000000000000000000000000BDC7CE00949E9C00CECFCE00D6EF
      EF00D6DFE700D6DFE700D6DFE700DEDFDE00DEDFDE00AD9E8C0073716B00BDBE
      BD0000000000000000000000000000000000000000000000000000000000ADAE
      AD0052515200BDBEBD0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ADAEAD00000000000000
      000000000000ADAEAD0000000000000000000000000000000000000000000000
      000000000000ADAEAD00000000000000000000000000BDC7CE00949E9C00ADB6
      B500CECFCE00DEDFDE00DEDFDE00BDBEBD00948E8C0073797B00ADB6B5000000
      00000000000000000000000000000000000000000000BDC7CE00949E9C00ADB6
      B500CECFCE00DEDFDE00DEDFDE00BDBEBD00948E8C0073797B00ADB6B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDC7CE00BDC7
      CE00BDC7CE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDC7CE00ADAE
      AD008C96940073716B0073716B008486840094AEAD00BDC7CE00000000000000
      0000000000000000000000000000000000000000000000000000BDC7CE00ADAE
      AD008C96940073716B0073716B008486840094AEAD00BDC7CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5714200AD71
      4200AD714200A5714200AD714200AD714200AD714200AD714200AD714200AD71
      4200AD714200AD714200A5714200A57142000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADAE94005230290063382900ADB6B5000000000000000000AD714200F7EF
      E700EFE7DE00EFDFCE00DED7CE00DECFBD00D6CFB500DECFAD00DECFAD00DECF
      AD00DECFAD00DECFAD00CEBEAD00AD7142000000000000000000000000000000
      000000000000B5A6940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDAE9C00AD968C00BDAE9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009486
      6B0052280000BDC7CE00AD9E8C00633829000000000000000000A5714200FFF7
      EF00EFE7DE00EFE7DE00EFDFCE00DED7CE00DECFBD00D6CFB500DECFAD00DECF
      AD00DECFAD00CEBE9C00DECFAD00A57142000000000000000000000000000000
      0000DED7C60063381000A5866B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B594A007B513100734129006B3010007B49210000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005230
      2900BDC7CE0000000000ADAEAD006B514A00A5714200AD714200A5714200F7F7
      EF00EFEFEF00EFE7DE00EFE7DE00DED7CE00DECFBD00DECFBD00DECFAD00DECF
      AD00DECFAD00DECFAD00CEBE9C00AD7142000000000000000000000000000000
      00007B5131006330100063301000947963000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD96
      8C00947963000000000000000000A57163006B30100073412900000000000000
      00000000000000000000000000000000000000000000ADAEAD0094866B008C79
      6B008C796B008C796B008C796B008C796B008C796B0073615200AD9E8C003128
      00009C867B00ADAEAD0018201000BDBEBD00AD714200F7EFE700AD714200FFFF
      FF00FFEFEF00EFEFEF00EFE7DE00EFDFCE00DED7CE00EFD7BD00D6CFB500DEBE
      A500DECFAD00CEBE9C00CEBEAD00AD714200000000000000000000000000CEBE
      AD00633010006B3010006B301000733821008C59420000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009479
      6300000000000000000000000000000000008C59420063301000B5967B000000
      000000000000000000000000000000000000736152006B514A008C796B009C86
      7B009C867B00948E8C009C867B009C867B008C796B00B59E8C00523029005230
      29003128000052302900BDC7CE0000000000A5714200FFF7EF00AD714200FFFF
      FF00F7F7EF00FFEFEF00EFE7DE00EFE7DE00EFDFCE00DED7CE00D6CFB500DECF
      AD00DECFAD00CEBE9C00DECFAD00A57142000000000000000000DECFCE007B51
      31006B301000633810006B301000DEBEAD000000000000000000000000000000
      0000CEBEAD00000000000000000000000000000000000000000000000000B596
      7B0000000000000000000000000000000000BDAE9C0063301000733821000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00DEDFDE000000
      000000000000C6CFD600948E8C009C867B009C867B00FFFFFF0031280000BDB6
      AD0000000000000000000000000000000000A5714200F7F7EF00A5714200FFFF
      FF00FFF7EF00F7F7EF00EFEFEF00EFE7DE00EFDFCE00DED7CE00D6CFB500D6CF
      B500DECFAD00DECFAD00CEBE9C00AD7142000000000000000000000000000000
      0000000000007338210063301000BDAE9C000000000000000000000000000000
      0000B5967B00000000000000000000000000000000000000000000000000CEBE
      AD0000000000000000000000000000000000DEBEAD006B301000633810006B30
      10007B513100DECFCE0000000000000000000000000000000000000000000000
      0000ADAEAD008C796B008C796B00D6CFCE00FFFFFF00CECFCE00523029006338
      29005230290031280000523029008C796B00AD714200FFFFFF00AD714200FFFF
      FF00FFFFFF00F7F7EF00F7EFE700EFE7DE00EFE7DE00DED7CE00DECFBD00D6CF
      B500AD693100A5714200AD794A00A57142000000000000000000000000000000
      000000000000B5967B00633010008C5942000000000000000000000000000000
      0000947963000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008C594200733821006B3010006B3010006330
      1000CEBEAD000000000000000000000000000000000000000000BDBEBD008C79
      6B009C867B00DEDFDE00FFFFFF00CECFCE00BDB6AD00CECFCE00000000000000
      00003128000000000000ADAEAD0052302900AD714200FFFFFF00AD714200FFFF
      FF00FFFFFF00FFF7F700F7F7EF00F7EFE700EFE7DE00EFE7DE00EFDFCE00DECF
      BD00A5714200EFCFB500A5714200000000000000000000000000000000000000
      00000000000000000000734129006B301000A571630000000000000000009479
      6300AD968C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009479630063301000633010007B51
      310000000000000000000000000000000000C6CFD6009C867B008C796B00D6CF
      CE00FFFFFF00CECFCE00ADAEAD00C6CFD6000000000000000000000000000000
      000063382900ADAEAD00000000006B514A00A5714200FFFFFF00AD714200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F7F7EF00EFEFEF00EFE7DE00EFE7DE00DED7
      CE00AD693100A571420000000000000000000000000000000000000000000000
      00000000000000000000000000007B4921006B301000734129007B5131007B59
      4A00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5866B0063381000DED7
      C60000000000000000000000000000000000EFEFEF00FFFFFF00EFE7DE00CECF
      CE00C6CFD6000000000000000000000000000000000000000000000000000000
      0000AD9E8C00523029006B514A00ADAEAD00AD714200FFFFFF00AD794A00A571
      4200A5714200A5714200A5714200A5714200A5714200A5714200A5714200AD71
      4200A5714200A571420000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDAE9C00AD968C00BDAE9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5A694000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AD714200FFFFFF00FFFFFF00FFF7
      F700F7F7EF00F7EFE700EFE7DE00EFE7DE00EFDFCE00DECFBD00A5714200EFCF
      B500A57142000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AD714200FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7F7EF00EFEFEF00EFE7DE00EFE7DE00DED7CE00AD693100AD71
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AD794A00A5714200A5714200A571
      4200A5714200A5714200A5714200A5714200A5714200AD714200A57142000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000900100000100010000000000800C00000000000000000000
      000000000000000000000000FFFFFF00FFFFF8FFFFFF0000FFFFF01FC0010000
      FFFFE00381800000FFFFC00081000000FFFF800080000000F81F800080000000
      F81F800080000000F81F800080000000F81F800080000000F81F800080000000
      301F80018000000003FF80038000000087FFC0078000000087FFE00F80000000
      03FFF01FC001000033FFF93FFFFF0000FFFFFFFFFFFFFFC08001FF3FFFFFFFC0
      8001FC07FFFFFF008001F001FFFFFC808001C001FFFFFFC080010000F81FFCC0
      80018000F81FF03F80010000F81FF03F8C010000F81FF03F88010000F81FF03F
      80010001F81FF03F880100019FFF903F800100039FFF9FFF8001C00F07FF07FF
      8001F03F07FF07FFFFFFFFFF9FFF9FFFFFFFFFFFFFFFEFE7FFFFFFFFFFFFC3E1
      FFFFFFFF0000C080FFFFFFFF0000C0010555C5510000C003BFF1B7ED0000C007
      9FF5B7FD00008003CFF5B7F100008003E7FBB7ED00008001F7FFB7E500000001
      87FFC7F100000001FF9FFF9F40000000F80FF80F60018080FF9FFF9F6002FC00
      FFFFFFFF0007FF08FFFFFFFFFFFFFFC1FF80FF80FF80FFFFFF00FF00FF00FFFF
      FF00FF00FF00FFFFFF00FF00FD00FFFFFF00FF00E000B541FF00FF00E100B7F7
      AF00AF00E70087F38F018F01CF01B7F9AFEFAFEFC7FFB7F18FC78FC7E7FF87FF
      FFCFFFCFFFFFCFFFAC8FAC8FAAFFFF9F8C0F8C0F88FFF80FAE7FAE7FAAFFFF9F
      8FFF8FFF88FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0FFFFFFC08003FFC0FF81FFC0
      8003FE00FF81F0408003FE00FF81E1408003FE00FF81C3C08003FE00FF81C7C0
      8003FE07FF8183FF8003FE07FFEFC7F78003FFEFFFC7EFE38003FFC7FF83FFC1
      8003038303C703E3800303C7038703C380030387010F02878003010F001F020F
      FFFF001F03FF03FFFFFF03FF03FF03FFFFFFFFFFFFFFFFFF8003800380038003
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003800380038003800380038003800380038003800380038003
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8003800380038003
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003800380038003800380038003800380038003800380038003
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFFFFBFFDBFFDFFFFFFFF00000000FFFFFFFF
      80018001FE381C7F80018001FF7DBEFF80018001810180C0800180012393C991
      800180013793C99B8001800187C7E3C380018001B7C7E3DB8001800187EFF7C3
      80018001FFFFFFFF80018001FE1FFF8780018001DF1FF7C700000000CE1FF387
      BFFDBFFDC45FF117FFFFFFFFE0FFF83FFFFFFFFFFFFFFFFFB11BB11BB11BB11B
      B71BB71BB71BB71BB10BB1BBB1BBB1BBB60BB71BB71BB71B1011111111111111
      F80FFFFFFFFFFFFFF81FFFFFFFFFFFFFE00FF3CFF00FE3FFE01FF3CFF18FE007
      E00FF24FF9CFE007F01FF00FF9CFF007F03FF00FF9CFF007E07FF00FF18FF007
      E1FFF18FF00FF007E3FFFFFFFFFFF007BFFDBFFDBFFDBFFD0000000000000000
      8001800180018001800180018001800180018001800180018001800180018001
      8001800180018001000080018001800180010001800180018001000180018001
      8001000180018001800180018001800180018001800180010000000000000000
      BFFD0FFDBFFDBFFDFFFF1FFFFFFFFFFFBFFDBFFDBFFDBFFD0000000000000000
      8001800180018001800180018001800180018001800180018001800180018001
      8001800180010000800180018001000100018001800100000001800180018001
      0001800180018001800180018001800180018001800180010000000000000000
      0FFDBFFDBFFDBFFD1FFFFFFFFFFFFFFFBFFDBFFDBFFDBFFD0000000000000000
      8001800180018001800180018001800180018001800180018001800180018001
      8001800180018001800180018001800180018001800180018001800180018001
      8001800180018001800180018001800180018001800180010000000000000000
      BFFDBFFDBFFDBFFDFFFFFFFFFFFFFFFFDFFFFFFFFFFF8FFFDFFFFFFFFFFFDFFF
      8FFFFFFFFFFF837FDFFFFD7FFFFFFB7F83BFFC7FF83FFA7FFBBFF83FF93FF87F
      FBBFF83FF99FFBFFFB3FFBBFF81FFBFFF83FFBBFFFDFFFFFFBFFFFFFFD9F837F
      FBFFF7DFF81EDB7F83FFF7DFFBE98A7FDFFFD7D7EBE9D87F8FFF07C003F7DBFF
      DFFFD7D7EBFBDBFFDFFFFFFFFBFBDFFFBFFDBFFDBFFDBFFD0000000000000000
      8001800180018001800180018001800180018001800180018001800180018001
      8001800180018001800180018001800180018001800180018001800180018001
      8001800180018001800180018001800180018001800180010000000000000000
      BFFDBFFDBFFDBFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFDFFFFFFFFFFFF0000
      FFFFFFFFFFFF8001801FE007F8018001FFFFFFFFFFFF80018001800180018001
      FFFFFFFFFFFF8001801FE007F8018001FFFFFFFFFFFF00018001800180010001
      FFFFFFFFFFFF0001801FE007F8018001FFFFFFFFFFFF80018001800180010000
      FFFFFFFFFFFF0FFDFFFFFFFFFFFF1FFFFFFFFFBFFF81FFFFFFE3FFBFFF01FFFF
      8041FF39FE3FFFFF8041F723FE3FE001FFC1FA07FC1BF07FFFE3FC0FFE318001
      FFFFFCC0FF60C07FFFF3E0C3FFF1C001FFF3FC0FFFF1007FFFF3F807FE030001
      FFF381018003007FFFF3180118018001FFF31819181981FFFFF3010101010001
      FFF3838383830FFFFFFFC7C7C7C71FFFBFFDFFFFFFFFFFFF0000E7FFFFF3C7FF
      8001E7FFFFF382018001E7FFFFF382018001E7FFFFF383FF8001E7FFFFF3C7FF
      8001E7FFFFF3FFFF8001E7FFFFF3CFFF8001E7FFFFF3CFFF8001FFFFFFFFCFFF
      8001C7FFFFE3CFFF800183FFFFC1CFFF800182018041CFFF000082018041CFFF
      BFFDC7FFFFE3CFFFFFFFFFFFFFFFFFFFBFFDBFFDBFFDBFFD0000000000000000
      8001800180018001800180018001800180018001800180018001800180018001
      8001800180018001800180018001800180018001800180018001800180018001
      8001800180018001800180018001800180018001800180010000000000000000
      BFFDBFFDBFFDBFFDFFFFFFFFFFFFFFFFFC00FFFFFFFFBFFD9C00800380030000
      8000800380038001800080038003800180008003800380018000800380038001
      8000800380038001800080038003800180008003800380018000800380038001
      8000800380038001800180038003800180018003800380018001800380030000
      8001FFFFFFFFBFFDFFFFFFFFFFFFFFFFFFFFFFE0FF83FF83FFFFFFE09E018601
      00FFFF608001800100FFFE608001808100FFFC008001800100FFFE6080010001
      001BFF6080010001001901E080018001000001E080018001001901FF80008001
      001B01FF8000800100FF01FF8000800100FF01FF9000800100FF01FF90008001
      00FF01FF80008001FFFF01FFFFFFFFFFFEFFFE00FFFFFFFFFC7FFE00FFFF01FF
      F83FFE00FF6001FFFEFFFE00FE6001FFFEFFFE00FC0001FFF83FFFEFFE6001FF
      F83FFFEFFF60FF60F83FFF8301FFFE608003FFC701FFFC008003006F01FFFE60
      8003007F01FFFF608003007F01FF01FF8003007F01FF01FF8003007F01FF01FF
      8003007F01FF01FF8003007F01FF01FFFFF8FFFFFF83F83FFFF1FFFFFF83F83F
      FFE1C003FF83F83FE003C003FF83F83FC007C003FF83F83F8007C003FFEFFEFF
      0007C003FFEFFEFF003CC003FF83F83F00EDC003FFC7FC7F0005C003006F06C1
      00ECC003007F07C1003FC017007F07C10007C00F007F07C1000FC01F007F07C1
      801FFFFF007F07C1C03FFFFF007F07C1E03FFFFFFFF8FFF8C00FFFFFFFF1FFF1
      8007C7F9FFE1FFE18003C3FFE003E0030001C3F3C007C0070001C1E380078007
      0001E0C7000700070001F00F000400060003F81F000500060007FC1F00050007
      000FFC0F00040007801FE00F00070007C01FC0C700070007E0BF81E3000F000F
      E3FF83F9801F801FFFFFC7FFC03FC03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFC000
      FFFFFFFFFFF0C000FBFFF8FFFFE0C000F1FFF07FFFE40000F0FFE63F80000000
      E07FEF1F00010000C0F7EF1F180F0000F8F7EF03F0000000F8F7FE07C0340001
      FC67FF0F00F20003FE0FFF8F07F00003FF1FFFDFFFFF0007FFFFFFFFFFFF000F
      FFFFFFFFFFFF001FFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object pmMain: TTntPopupMenu
    Images = ilMain
    OnPopup = pmMainPopup
    Left = 248
    Top = 360
  end
  object sdMain: TTntSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 312
    Top = 360
  end
  object odMain: TTntOpenDialog
    Left = 344
    Top = 360
  end
end
