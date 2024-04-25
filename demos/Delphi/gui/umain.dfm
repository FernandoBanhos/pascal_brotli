object fMain: TfMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Brotli Compress GUI - Delphi'
  ClientHeight = 133
  ClientWidth = 602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 56
    Height = 13
    Caption = 'File Source:'
  end
  object Label2: TLabel
    Left = 24
    Top = 52
    Width = 55
    Height = 13
    Caption = 'File Target:'
  end
  object btarget: TSpeedButton
    Left = 571
    Top = 48
    Width = 23
    Height = 23
    Glyph.Data = {
      560A0000424D560A000000000000360000002800000024000000120000000100
      200000000000200A000000000000000000000000000000000000EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00C3CACA00C6CDCD00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00C9C9C900CCCCCC00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00C3CACA004497D1444B9AD100EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00C9C9C9009F9F
      9F00A1A1A100EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00D7DFDF00C3CACA00C3CACA00C3CACA00C3CA
      CA004194D08989EFFF434397D100EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00DEDEDE00C9C9C900C9C9
      C900C9C9C900C9C9C9009C9C9C00E8E8E8009F9F9F00EBFBFE00EBFBFE00C6CD
      CD00C3CACA00C3CACA00C3CACA00C3CACA00C3CACA00C3CACA00C3CACA0079B2
      D4003896D6353592D5373793D43B3B93D28787EEFF5656ADDE00EBFBFE00EBFB
      FE00EBFBFE00CCCCCC00C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900C9C9C900B5B5B5009E9E9E009B9B9B009C9C9C009C9C9C00E7E7E700B2B2
      B200EBFBFE00EBFBFE00EBFBFE004C9BD2004094D03E3E92CF3F3F92CE3F3F92
      CE3F3F92CE3F3F92CF4545A3DE7575B7D4FDFDDDA9FFFFEBB7FFFFEEC26A6AA9
      CF3B3B92D100EBFBFE00EBFBFE00EBFBFE00EBFBFE00A2A2A2009C9C9C009B9B
      9B009A9A9A009A9A9A009A9A9A009B9B9B00AAAAAA00B8B8B800D0D0D000DDDD
      DD00E2E2E200ADADAD009B9B9B00EBFBFE00EBFBFE00EBFBFE00EBFBFE004094
      D0ABABFAFF9494F2FF9494F2FF9494F2FF9595F2FF9595F4FF4A4AB5EDF6F6D0
      99FFFFEDD0FFFFEAC5FFFFF4CCFFFFEEC1363692D300EBFBFE00EBFBFE00EBFB
      FE00EBFBFE009C9C9C00F2F2F200EBEBEB00EBEBEB00EBEBEB00EBEBEB00ECEC
      EC00BABABA00C3C3C300E6E6E600E1E1E100E9E9E900E2E2E2009B9B9B00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE003D92CFAEAEF4FF8686E7FF8787E7FE8787E7
      FE8888E7FE8989EAFF4B4BBCF2FDFDCD90FFFFF7E9FAFAEED5FFFFEAC5FFFFEB
      B640409FDC00EBFBFE00EBFBFE00EBFBFE00EBFBFE009A9A9A00EFEFEF00E3E3
      E300E3E3E300E3E3E300E3E3E300E5E5E500BFBFBF00BFBFBF00F3F3F300E7E7
      E700E1E1E100DDDDDD00A6A6A600EBFBFE00EBFBFE00EBFBFE00EBFBFE003C92
      CEB5B5F3FF7C7CE1FD7E7EE1FC7F7FE1FC8080E1FC8181E3FE5353C4F9F2F2C8
      8DFEFEEBD2FFFFF7E9FFFFEDD0FCFCDCAA3A3A99DA00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE009A9A9A00EFEFEF00DEDEDE00DEDEDE00DEDEDE00DEDEDE00E0E0
      E000C7C7C700BABABA00E5E5E500F3F3F300E6E6E600D0D0D000A2A2A200EBFB
      FE00EBFBFE00EBFBFE00EBFBFE003C92CFBFBFF4FF7171DDFC7373DCFB7575DC
      FB7878DDFB7A7ADEFC6868D4FC8888C7D5F2F2C88DFDFDCD90F6F6D09A7D7DB6
      CC42429FDA00EBFBFE00EBFBFE00EBFBFE00EBFBFE009A9A9A00F1F1F100DADA
      DA00D9D9D900D9D9D900DADADA00DCDCDC00D4D4D400C4C4C400BABABA00BFBF
      BF00C3C3C300B6B6B600A6A6A600EBFBFE00EBFBFE00EBFBFE00EBFBFE003D93
      D0DFDFFFFFDADAF9FFDBDBF8FFDEDEF9FF7272DBFC7474DAFB7373DAFC6363D2
      FD5555C8FA4E4EBFF54949B8EE7979CEF53E3E94D100EBFBFE00EBFBFE00EBFB
      FE00EBFBFE009B9B9B00FBFBFB00F7F7F700F6F6F600F7F7F700D9D9D900D8D8
      D800D8D8D800D2D2D200CACACA00C2C2C200BBBBBB00D0D0D0009C9C9C00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE004095D136368ECD34348BCB35358ACA36368A
      CA5A5ABCEA6D6DD8FB6969D5FA6767D5FA6767D5FB6666D5FC6565D6FCBCBCF2
      FF3D3D93D000EBFBFE00EBFBFE00EBFBFE00EBFBFE009D9D9D00979797009494
      94009393930093939300BFBFBF00D6D6D600D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400EFEFEF009B9B9B00EBFBFE00EBFBFE00EBFBFE00EBFBFE003E94
      D0C5C5F7FF7474DEFE7676DEFD7777DFFE5050A9DC5454B8E8D9D9F7FFD5D5F6
      FFD5D5F6FFD5D5F6FFD5D5F7FFDADAFBFF3D3D94D000EBFBFE00EBFBFE00EBFB
      FE00EBFBFE009C9C9C00F3F3F300DBDBDB00DBDBDB00DCDCDC00AEAEAE00BBBB
      BB00F6F6F600F5F5F500F5F5F500F5F5F500F5F5F500F8F8F8009C9C9C00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE003C92CFCBCBF6FF6A6AD6FA6D6DD6FA6C6CD7
      FA6C6CD9FC4747A8DD31318ACB2F2F8ACB2F2F8ACB2F2F8ACB30308BCB35358F
      CD404095D100EBFBFE00EBFBFE00EBFBFE00EBFBFE009A9A9A00F3F3F300D4D4
      D400D5D5D500D5D5D500D7D7D700ADADAD009393930093939300939393009393
      930094949400979797009D9D9D00EBFBFE00EBFBFE00EBFBFE00EBFBFE003B92
      CFD5D5F7FF6060D1F96161D0F8B5B5EBFDDADAF8FFDCDCFBFFDDDDFDFFDDDDFD
      FFDDDDFDFFDDDDFDFFDDDDFEFFE3E3FFFF404096D100EBFBFE00EBFBFE00EBFB
      FE00EBFBFE009A9A9A00F5F5F500D0D0D000CFCFCF00EAEAEA00F6F6F600F8F8
      F800FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFAFA00FBFBFB009E9E9E00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE003D94D0DCDCFCFFD8D8F7FFD8D8F7FFDBDBFA
      FF35358ECD3A3A92CF3B3B92CF3B3B93CF3B3B93CF3B3B93CF3B3B93D03E3E95
      D0434E9ED400EBFBFE00EBFBFE00EBFBFE00EBFBFE009C9C9C00F9F9F900F5F5
      F500F5F5F500F8F8F800979797009A9A9A009A9A9A009B9B9B009B9B9B009B9B
      9B009B9B9B009D9D9D00A5A5A500EBFBFE00EBFBFE00EBFBFE00EBFBFE004E9E
      D4003D94D03A3A92CF3A3A92CF3D3D94D04152A0D500EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00A5A5A5009C9C9C009A9A9A009A9A9A009C9C9C00A7A7A700EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00}
    NumGlyphs = 2
    OnClick = btargetClick
  end
  object bCompress: TSpeedButton
    Left = 24
    Top = 88
    Width = 121
    Height = 33
    Caption = 'Compress'
    Glyph.Data = {
      560A0000424D560A000000000000360000002800000024000000120000000100
      200000000000200A000000000000000000000000000000000000EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00E0E9E900DBE3E300E1EAEA00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00E1EAEA00DBE3E300E0E9E900EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00E8E8E800E2E2E200E9E9E900EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00E9E9E900E2E2E200E8E8E800EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00ADA08F009D897197ADA1
      9100DBE3E300DBE3E300DBE3E300DBE3E300ADA191009D897199ADA08F00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE009C9C
      9C00848484009D9D9D00E2E2E200E2E2E200E2E2E200E2E2E2009D9D9D008484
      84009C9C9C00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE009D8971D3D3BEAB9D9D89719D9D89719D9D89719D9D89719D9D89
      719D9D8971D3D3BEAB9D9D897116EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE0084848400BABABA0084848400848484008484
      8400848484008484840084848400BABABA0084848400EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00C9C0B400BFB1A2AFCBC3
      B700EBFBFE00C5B19C9D9D8971A5EBFBFE00D3CEC400BFB1A2AFC8BFB200EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00BDBD
      BD00AEAEAE00C0C0C000EBFBFE00ACACAC0084848400EBFBFE00CBCBCB00AEAE
      AE00BCBCBC00EBFBFE00EBFBFE00EBFBFE00EBFBFE00E2EBEB00DBE3E300DBE3
      E300DBE3E300DBE3E300DBE3E300DBE3E300EBFBFE00C4B09B9D9D8971BCEBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EAEA
      EA00E2E2E200E2E2E200E2E2E200E2E2E200E2E2E200E2E2E200EBFBFE00ABAB
      AB0084848400EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00DBE3E300C7B8A8009D89719D9D89719D9D89719D9D89719D9D89719D9D89
      7100DBE3E300C1AD999D9D897100DBE3E300E2EBEB00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00E2E2E200B4B4B4008484840084848400848484008484
      84008484840084848400E2E2E200A9A9A90084848400E2E2E200EAEAEA00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00E2EBEB00EBD2B5EBEBD2B5EBEBD2B5EBEBD2
      B5EBEBD2B5EBEBD2B5EBEBD2B59D9D89719D9D89719D9D89719D9D89719D9D89
      71BACABEAE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EAEAEA00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC0084848400848484008484
      84008484840084848400BABABA00EBFBFE00EBFBFE00EBFBFE00EBFBFE005FA6
      DA00298CD729298CD729298CD729298CD729298CD729298CD7275FA6DA00EBD2
      B5EBEBD2B5EBEBD2B5EBEBD2B5EBEBD2B5EBEBD2B5CBEBFBFE00EBFBFE00EBFB
      FE00EBFBFE00ADADAD0097979700979797009797970097979700979797009797
      9700ADADAD00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00298CD76666D5F96666D5F96666D5F96666D5
      F96666D5F96666D5F929298CD7D8EBFBFE00DBE3E300BFAC97B2B2A38F9D9D89
      71CCEBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE0097979700D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D30097979700EBFBFE00E2E2E200A7A7
      A7009E9E9E0084848400EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00298C
      D77070D9FA1B1BADE51B1BADE51B1BADE51B1BADE57070D9FA29298CD7DCEBFB
      FE00CDB59EBEBEAB979D9D897100DBE3E300EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE0097979700D7D7D700ADADAD00ADADAD00ADADAD00ADADAD00D7D7
      D70097979700EBFBFE00B0B0B000A7A7A70084848400E2E2E200EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00298CD77D7DE0FD5D5DCEF95D5DCEF95D5DCE
      F95D5DCEF97D7DE0FD29298CD705EBFBFE00DBE3E300C2AD97B5B5A5919D9D89
      71AAEBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE0097979700DDDDDD00CECE
      CE00CECECE00CECECE00CECECE00DDDDDD0097979700EBFBFE00E2E2E200A8A8
      A800A0A0A00084848400EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00298C
      D78B8BE9FFA2A2EEFFA2A2EDFFA2A2EDFFA2A2EEFF8B8BE9FF29298CD7DEEBFB
      FE00CEB69FBFBFAC989D9D897100DBE3E300EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE0097979700E5E5E500EAEAEA00EAEAEA00EAEAEA00EAEAEA00E5E5
      E50097979700EBFBFE00B1B1B100A8A8A80084848400E2E2E200EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE0066AEE200298CD729298CD729298CD729298C
      D729298CD729298CD72966AEE200DBE3E300DBE3E300C3AE99B6B6A5929D9D89
      7100DBE3E300EBFBFE00EBFBFE00EBFBFE00EBFBFE00B5B5B500979797009797
      970097979700979797009797970097979700B5B5B500E2E2E200E2E2E200AAAA
      AA00A1A1A10084848400E2E2E200EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00E3ECEC00DBE3E300DBE3E300DBE3E300DBE3E300DBE3E300DBE3E300AC99
      82ACAC9982ACAC9982ACAC9982ACAC9982ACAC9982A0EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBEBEB00E2E2E200E2E2E200E2E2E200E2E2E200E2E2
      E200E2E2E200949494009494940094949400949494009494940094949400EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00E3CAB200AC9982ACAC9982ACAC99
      82ACAC9982ACAC9982ACAC9982ACAC9982EBEBD2B5EBEBD2B5EBEBD2B5EBEBD2
      B5C1D0C4B500EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00C5C5C5009494
      9400949494009494940094949400949494009494940094949400CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00C0C0C000EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBD2B5EBEBD2B5EBEBD2B5EBEBD2B5EBEBD2B5EBEBD2B5EBEBD2
      B5BFEBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00}
    NumGlyphs = 2
    OnClick = bCompressClick
  end
  object bDecompress: TSpeedButton
    Left = 151
    Top = 88
    Width = 121
    Height = 33
    Caption = 'Decompress'
    Glyph.Data = {
      560A0000424D560A000000000000360000002800000024000000120000000100
      200000000000200A000000000000000000000000000000000000EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00D2DADA00C3CACA00C3CACA00C3CA
      CA00C3CACA00C3CACA00C3CACA00C3CACA00C3CACA00C3CACA00C3CACA00C3CA
      CA00D2DADA00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00D9D9D900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900C9C9C900C9C9C900D9D9D900EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE009D9282008A7861898977608888765E8888765E8888755E8888765E888876
      5E8989775F8989775F898977608A8A7861809D928200EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE008E8E8E00737373007272720070707000707070007070
      70007070700070707000717171007171710072727200737373008E8E8E00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE008A7860AEAE9A89A8A89380A4A48F
      7BA2A28D78A2A28C78A2A28D78A4A48E7BA6A6917DA6A6917EA9A99481AEAE9A
      898A8A7860FFEBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00727272009797
      97008F8F8F008B8B8B008989890088888800898989008A8A8A008D8D8D008D8D
      8D00909090009797970072727200EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00897760ADAD9A899F9F8C78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF9B9B8671FFFFFFFFA0A08C79ADAD9A8989897760FFEBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00727272009696960088888800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0082828200FFFFFF00888888009696960072727200EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE0089775FB0B09C8C9D9D887496967F
      6A92927B6594947C6695957F6A95957E699696806A9898816D9D9D8874B0B09C
      8C8989775FFFEBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00717171009999
      9900848484007B7B7B0076767600787878007B7B7B007A7A7A007B7B7B007D7D
      7D00848484009999990071717100EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE0089775FB1B19F8F9A9A8471FFFFFFFFFFFFFFFFFFFFFFFF94947E68FFFFFF
      FFFFFFFFFFFFFFFFFF9A9A8471B1B19F8F8989775FFFEBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00717171009C9C9C0080808000FFFFFF00FFFFFF00FFFF
      FF0079797900FFFFFF00FFFFFF00FFFFFF00808080009C9C9C0071717100EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE0089775FB3B3A2919797836E92927D
      6790907B6590907A6390907A638D8D77608D8D775F90907A649797836EB3B3A2
      918989775FFFEBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00717171009E9E
      9E007E7E7E007878780076767600757575007575750072727200727272007575
      75007E7E7E009E9E9E0071717100EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE0089775FB5B5A4949595806AFFFFFFFF8F8F7A62FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF94947F69B5B5A4948989775FFFEBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE0071717100A1A1A1007B7B7B00FFFFFF0075757500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007A7A7A00A1A1A10071717100EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE0089765FB7B7A79793937E688E8E79
      618C8C765E8989735B8989735B8B8B755D8989735B8B8B765E92927D67B7B7A7
      978989765FFFEBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE0071717100A3A3
      A3007979790074747400717171006E6E6E006E6E6E00707070006E6E6E007171
      710078787800A3A3A30071717100EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE0088765FB9B9AA9A8E8E7B64FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF898975
      5CFFFFFFFFFFFFFFFF8C8C7961B9B9A9988888765EFFEBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE0071717100A6A6A60076767600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF006F6F6F00FFFFFF00FFFFFF0073737300A5A5A50070707000EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE0088765EBBBBAD9E8F8F7C658D8D7A
      628B8B78608B8B775F8B8B78609B9B8974B4B4A493B3B3A393B6B6A797B9B9AB
      9C8888765EFFEBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE0070707000AAAA
      AA00777777007474740072727200727272007272720084848400A0A0A0009F9F
      9F00A3A3A300A8A8A80070707000EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE0088765EBDBDB0A18F8F7B6490907D6690907D6790907C668E8E7A64BBBBAE
      9F9696856F7F7F6B517F7F6B51BBBBAD9E8888765EFFEBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE0070707000ACACAC007676760078787800787878007777
      770075757500AAAAAA00808080006565650065656500AAAAAA0070707000EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE0088765EBFBFB2A48B8B78628D8D7B
      658E8E7C668D8D7B658B8B7862BEBEB1A180806C53F7F7FAFEFFFFFFFFA6A696
      8489ACA29200EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE0070707000AFAF
      AF007373730076767600777777007676760073737300ADADAD0066666600FAFA
      FA00FFFFFF00929292009E9E9E00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE0088755EC0C0B4A68686745B8888765E8989765F8888765E8686735BBEBEB2
      A37E7E6A51FFFFFFFFA4A4938086ACA29300EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE0070707000B1B1B1006E6E6E0070707000717171007070
      70006D6D6D00AEAEAE0064646400FFFFFF008F8F8F009E9E9E00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE0089765FC4C4B8A9C3C3B7A8C3C3B7
      A9C3C3B8A9C3C3B7A9C2C2B6A8C1C1B5A6C0C0B4A5A8A8998786ACA39300EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE0071717100B4B4
      B400B3B3B300B4B4B400B4B4B400B4B4B400B3B3B300B1B1B100B0B0B0009595
      95009F9F9F00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE0092806B0089765F8888755E8888755E8888755E8888755E8888755E878775
      5D8888755E8992826C00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE007B7B7B00717171007070700070707000707070007070
      7000707070006F6F6F00707070007D7D7D00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00}
    NumGlyphs = 2
    OnClick = bDecompressClick
  end
  object bsource: TSpeedButton
    Left = 571
    Top = 20
    Width = 23
    Height = 23
    Glyph.Data = {
      560A0000424D560A000000000000360000002800000024000000120000000100
      200000000000200A000000000000000000000000000000000000EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00C3CACA00C6CDCD00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00C9C9C900CCCCCC00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00C3CACA004497D1444B9AD100EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00C9C9C9009F9F
      9F00A1A1A100EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00D7DFDF00C3CACA00C3CACA00C3CACA00C3CA
      CA004194D08989EFFF434397D100EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00DEDEDE00C9C9C900C9C9
      C900C9C9C900C9C9C9009C9C9C00E8E8E8009F9F9F00EBFBFE00EBFBFE00C6CD
      CD00C3CACA00C3CACA00C3CACA00C3CACA00C3CACA00C3CACA00C3CACA0079B2
      D4003896D6353592D5373793D43B3B93D28787EEFF5656ADDE00EBFBFE00EBFB
      FE00EBFBFE00CCCCCC00C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900C9C9C900B5B5B5009E9E9E009B9B9B009C9C9C009C9C9C00E7E7E700B2B2
      B200EBFBFE00EBFBFE00EBFBFE004C9BD2004094D03E3E92CF3F3F92CE3F3F92
      CE3F3F92CE3F3F92CF4545A3DE7575B7D4FDFDDDA9FFFFEBB7FFFFEEC26A6AA9
      CF3B3B92D100EBFBFE00EBFBFE00EBFBFE00EBFBFE00A2A2A2009C9C9C009B9B
      9B009A9A9A009A9A9A009A9A9A009B9B9B00AAAAAA00B8B8B800D0D0D000DDDD
      DD00E2E2E200ADADAD009B9B9B00EBFBFE00EBFBFE00EBFBFE00EBFBFE004094
      D0ABABFAFF9494F2FF9494F2FF9494F2FF9595F2FF9595F4FF4A4AB5EDF6F6D0
      99FFFFEDD0FFFFEAC5FFFFF4CCFFFFEEC1363692D300EBFBFE00EBFBFE00EBFB
      FE00EBFBFE009C9C9C00F2F2F200EBEBEB00EBEBEB00EBEBEB00EBEBEB00ECEC
      EC00BABABA00C3C3C300E6E6E600E1E1E100E9E9E900E2E2E2009B9B9B00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE003D92CFAEAEF4FF8686E7FF8787E7FE8787E7
      FE8888E7FE8989EAFF4B4BBCF2FDFDCD90FFFFF7E9FAFAEED5FFFFEAC5FFFFEB
      B640409FDC00EBFBFE00EBFBFE00EBFBFE00EBFBFE009A9A9A00EFEFEF00E3E3
      E300E3E3E300E3E3E300E3E3E300E5E5E500BFBFBF00BFBFBF00F3F3F300E7E7
      E700E1E1E100DDDDDD00A6A6A600EBFBFE00EBFBFE00EBFBFE00EBFBFE003C92
      CEB5B5F3FF7C7CE1FD7E7EE1FC7F7FE1FC8080E1FC8181E3FE5353C4F9F2F2C8
      8DFEFEEBD2FFFFF7E9FFFFEDD0FCFCDCAA3A3A99DA00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE009A9A9A00EFEFEF00DEDEDE00DEDEDE00DEDEDE00DEDEDE00E0E0
      E000C7C7C700BABABA00E5E5E500F3F3F300E6E6E600D0D0D000A2A2A200EBFB
      FE00EBFBFE00EBFBFE00EBFBFE003C92CFBFBFF4FF7171DDFC7373DCFB7575DC
      FB7878DDFB7A7ADEFC6868D4FC8888C7D5F2F2C88DFDFDCD90F6F6D09A7D7DB6
      CC42429FDA00EBFBFE00EBFBFE00EBFBFE00EBFBFE009A9A9A00F1F1F100DADA
      DA00D9D9D900D9D9D900DADADA00DCDCDC00D4D4D400C4C4C400BABABA00BFBF
      BF00C3C3C300B6B6B600A6A6A600EBFBFE00EBFBFE00EBFBFE00EBFBFE003D93
      D0DFDFFFFFDADAF9FFDBDBF8FFDEDEF9FF7272DBFC7474DAFB7373DAFC6363D2
      FD5555C8FA4E4EBFF54949B8EE7979CEF53E3E94D100EBFBFE00EBFBFE00EBFB
      FE00EBFBFE009B9B9B00FBFBFB00F7F7F700F6F6F600F7F7F700D9D9D900D8D8
      D800D8D8D800D2D2D200CACACA00C2C2C200BBBBBB00D0D0D0009C9C9C00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE004095D136368ECD34348BCB35358ACA36368A
      CA5A5ABCEA6D6DD8FB6969D5FA6767D5FA6767D5FB6666D5FC6565D6FCBCBCF2
      FF3D3D93D000EBFBFE00EBFBFE00EBFBFE00EBFBFE009D9D9D00979797009494
      94009393930093939300BFBFBF00D6D6D600D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400EFEFEF009B9B9B00EBFBFE00EBFBFE00EBFBFE00EBFBFE003E94
      D0C5C5F7FF7474DEFE7676DEFD7777DFFE5050A9DC5454B8E8D9D9F7FFD5D5F6
      FFD5D5F6FFD5D5F6FFD5D5F7FFDADAFBFF3D3D94D000EBFBFE00EBFBFE00EBFB
      FE00EBFBFE009C9C9C00F3F3F300DBDBDB00DBDBDB00DCDCDC00AEAEAE00BBBB
      BB00F6F6F600F5F5F500F5F5F500F5F5F500F5F5F500F8F8F8009C9C9C00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE003C92CFCBCBF6FF6A6AD6FA6D6DD6FA6C6CD7
      FA6C6CD9FC4747A8DD31318ACB2F2F8ACB2F2F8ACB2F2F8ACB30308BCB35358F
      CD404095D100EBFBFE00EBFBFE00EBFBFE00EBFBFE009A9A9A00F3F3F300D4D4
      D400D5D5D500D5D5D500D7D7D700ADADAD009393930093939300939393009393
      930094949400979797009D9D9D00EBFBFE00EBFBFE00EBFBFE00EBFBFE003B92
      CFD5D5F7FF6060D1F96161D0F8B5B5EBFDDADAF8FFDCDCFBFFDDDDFDFFDDDDFD
      FFDDDDFDFFDDDDFDFFDDDDFEFFE3E3FFFF404096D100EBFBFE00EBFBFE00EBFB
      FE00EBFBFE009A9A9A00F5F5F500D0D0D000CFCFCF00EAEAEA00F6F6F600F8F8
      F800FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFAFA00FBFBFB009E9E9E00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE003D94D0DCDCFCFFD8D8F7FFD8D8F7FFDBDBFA
      FF35358ECD3A3A92CF3B3B92CF3B3B93CF3B3B93CF3B3B93CF3B3B93D03E3E95
      D0434E9ED400EBFBFE00EBFBFE00EBFBFE00EBFBFE009C9C9C00F9F9F900F5F5
      F500F5F5F500F8F8F800979797009A9A9A009A9A9A009B9B9B009B9B9B009B9B
      9B009B9B9B009D9D9D00A5A5A500EBFBFE00EBFBFE00EBFBFE00EBFBFE004E9E
      D4003D94D03A3A92CF3A3A92CF3D3D94D04152A0D500EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00A5A5A5009C9C9C009A9A9A009A9A9A009C9C9C00A7A7A700EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFB
      FE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00EBFBFE00}
    NumGlyphs = 2
    OnClick = bsourceClick
  end
  object esource: TEdit
    Left = 86
    Top = 21
    Width = 483
    Height = 21
    TabOrder = 0
  end
  object etarget: TEdit
    Left = 86
    Top = 48
    Width = 483
    Height = 21
    TabOrder = 1
  end
  object diagOpen: TOpenDialog
    Left = 408
    Top = 80
  end
end
