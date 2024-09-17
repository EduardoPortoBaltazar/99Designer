object dm: Tdm
  OnCreate = DataModuleCreate
  Height = 550
  Width = 343
  object conn: TFDConnection
    Params.Strings = (
      
        'Database=D:\99Coders\Master Listas\02 - Preparando o app\DB\banc' +
        'o.db'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Left = 56
    Top = 24
  end
  object qry_geral: TFDQuery
    Connection = conn
    Left = 136
    Top = 24
  end
end
