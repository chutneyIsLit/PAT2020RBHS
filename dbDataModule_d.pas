unit dbDataModule_d;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TdmModule = class(TDataModule)
    conCards: TADOConnection;
    qryCards: TADOQuery;
    dsrCards: TDataSource;
    conUser: TADOConnection;
    qryUser: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmModule: TdmModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
