object dmModule: TdmModule
  OldCreateOrder = False
  Height = 371
  Width = 870
  object conCards: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=C:\Us' +
      'ers\chest\Documents\Delphi\IT PAT 2020\PAT\MtgCards.mdb;Mode=Rea' +
      'd;Persist Security Info=False;Jet OLEDB:System database="";Jet O' +
      'LEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:E' +
      'ngine Type=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global ' +
      'Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLED' +
      'B:New Database Password="";Jet OLEDB:Create System Database=Fals' +
      'e;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale o' +
      'n Compact=False;Jet OLEDB:Compact Without Replica Repair=False;J' +
      'et OLEDB:SFP=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 88
    Top = 80
  end
  object qryCards: TADOQuery
    Connection = conCards
    Parameters = <>
    Left = 88
    Top = 144
  end
  object dsrCards: TDataSource
    DataSet = qryCards
    Left = 88
    Top = 200
  end
  object conUser: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=C:\Us' +
      'ers\chest\Documents\Delphi\IT PAT 2020\PAT\usersAndTheirRecords.' +
      'mdb;Mode=ReadWrite;Persist Security Info=False;Jet OLEDB:System ' +
      'database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Passwo' +
      'rd="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;' +
      'Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transa' +
      'ctions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Create Sys' +
      'tem Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Do' +
      'n'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Without Repli' +
      'ca Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 224
    Top = 80
  end
  object qryUser: TADOQuery
    Connection = conUser
    Parameters = <>
    Left = 224
    Top = 144
  end
end
