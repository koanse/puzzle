object Form1: TForm1
  Left = 192
  Top = 125
  Width = 567
  Height = 608
  Caption = #1048#1075#1088#1072' "'#1055#1072#1079#1079#1083'"'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Img: TImage
    Left = 24
    Top = 16
    Width = 500
    Height = 500
    OnMouseDown = ImgMouseDown
    OnMouseMove = ImgMouseMove
  end
  object MainMenu1: TMainMenu
    Left = 96
    Top = 32
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N2: TMenuItem
        Caption = #1047#1072#1085#1086#1074#1086
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = N3Click
      end
    end
  end
end
