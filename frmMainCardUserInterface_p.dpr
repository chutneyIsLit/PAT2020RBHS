program frmMainCardUserInterface_p;

uses
  Vcl.Forms,
  frmMainCardUserInterface_u in 'frmMainCardUserInterface_u.pas' {frmCardPage},
  frmHomePageInterface_u in 'frmHomePageInterface_u.pas' {frmHomePage},
  dbDataModule_d in 'dbDataModule_d.pas' {dmModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHomePage, frmHomePage);
  Application.CreateForm(TfrmCardPage, frmCardPage);
  Application.CreateForm(TdmModule, dmModule);
  Application.Run;

end.
