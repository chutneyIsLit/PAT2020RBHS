unit frmMainCardUserInterface_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls, frmHomePageInterface_u,
  dbDataModule_d, JPEG;

type
  TfrmCardPage = class(TForm)
    Panel1: TPanel;
    chbCardRarity: TCheckBox;
    chbManaCost: TCheckBox;
    chbCardType: TCheckBox;
    chbCardStats: TCheckBox;
    chbFullCardTypes: TCheckBox;
    btnQueryDatabase: TButton;
    cbxQueryPhrasePerColumn: TComboBox;
    edtQueryPhrase: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    dbgCards: TDBGrid;
    memCardCart: TMemo;
    btnAddCard: TButton;
    btnRemoveCard: TButton;
    Panel2: TPanel;
    btnClearList: TButton;
    btnResetSearches: TButton;
    btnAddToCart: TButton;
    Panel3: TPanel;
    Label3: TLabel;
    Panel4: TPanel;
    btnGoToCartFromCards: TButton;
    GotToHomeFromCards: TButton;
    btnGoToProductsFromCards: TButton;
    Label4: TLabel;
    pgcStock: TPageControl;
    tbsCards: TTabSheet;
    tbsProducts: TTabSheet;
    pnlCartCommunicationCards: TPanel;
    pnlHeader: TPanel;
    chbSet: TCheckBox;
    CheckBox2: TCheckBox;
    cbxOrderQueryOnCardsPage: TComboBox;
    Label5: TLabel;
    chbOrderAscendingCardsPage: TCheckBox;
    chbOrderInDescendingOrderCards: TCheckBox;
    pnlCommunicatrQuery: TPanel;
    dbgProducts: TDBGrid;
    pnlQueryProducts: TPanel;
    pnlMovementOnProductsPage: TPanel;
    Label6: TLabel;
    btnGoToCartFromProductsPage: TButton;
    btnGoToHomeFromProductsPage: TButton;
    btnGoToCardsOnProductsPage: TButton;
    memListOnProductsPage: TMemo;
    btnAddProductToList: TButton;
    btnRemoveProductFromList: TButton;
    pnlListCaption: TPanel;
    Panel5: TPanel;
    Label7: TLabel;
    btnClearProductList: TButton;
    btnClearProductSearch: TButton;
    btnAddProductListToCart: TButton;
    pnlProductDescription: TPanel;
    memProductDescription: TMemo;
    imgProductDisplay: TImage;
    Label8: TLabel;
    Label9: TLabel;
    ledtQueryProducts: TLabeledEdit;
    Button1: TButton;
    procedure btnGoToProductsFromCardsClick(Sender: TObject);
    procedure GotToHomeFromCardsClick(Sender: TObject);
    procedure btnGoToCartFromCardsClick(Sender: TObject);
    procedure btnAddToCartClick(Sender: TObject);
    procedure btnClearListClick(Sender: TObject);
    procedure btnQueryDatabaseClick(Sender: TObject);
    procedure btnAddCardClick(Sender: TObject);
    procedure btnRemoveCardClick(Sender: TObject);
    procedure btnResetSearchesClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chbOrderAscendingCardsPageClick(Sender: TObject);
    procedure chbOrderInDescendingOrderCardsClick(Sender: TObject);
    procedure btnGoToCardsOnProductsPageClick(Sender: TObject);
    procedure dbgProductsCellClick(Column: TColumn);
    procedure Button1Click(Sender: TObject);
    procedure btnClearProductSearchClick(Sender: TObject);
    procedure btnClearProductListClick(Sender: TObject);
    procedure btnAddProductToListClick(Sender: TObject);
    procedure btnRemoveProductFromListClick(Sender: TObject);
    procedure btnAddProductListToCartClick(Sender: TObject);
  private
  var
    rCurrentListPriceCards, rCurrentListPriceProducts: real;
    { Private declarations }
  public
  var
    rCurrentCartPrice: real;

    { Public declarations }
  end;

var
  frmCardPage: TfrmCardPage;

implementation

{$R *.dfm}

procedure TfrmCardPage.btnAddCardClick(Sender: TObject);
var
  i, iPos, iNum, iCheck: integer;
  cardAdded, cardCheck: string;
  arrMemo: array of string;
  bFound: boolean;
begin
  cardAdded := dmModule.qryCards['cardName'];
  rCurrentListPriceCards := rCurrentListPriceCards + dmModule.qryCards['price'];
  bFound := False;
  i := 0;
  if memCardCart.Lines.Count = 0 then
  // this means our total isn't included in the array that we look throu
  begin
    iCheck := memCardCart.Lines.Count;
  end
  else
    iCheck := memCardCart.Lines.Count - 1;

  while i < iCheck do
  begin
    SetLength(arrMemo, i + 1);
    arrMemo[i] := memCardCart.Lines[i];
    iPos := Pos('x', arrMemo[i]) + 1;
    cardCheck := Copy(arrMemo[i], iPos + 1, Length(arrMemo[i]) - iPos);
    if cardAdded = cardCheck then
    begin
      iNum := StrToInt(Copy(arrMemo[i], 0, iPos - 3)) + 1;
      arrMemo[i] := inttostr(iNum) + ' x ' + cardAdded;
      bFound := True;
    end;
    i := i + 1
  end;
  if bFound = False then
  begin
    SetLength(arrMemo, i + 1);
    arrMemo[Length(arrMemo) - 1] := '1 x ' + cardAdded;
  end;

  memCardCart.Lines.Clear;
  for i := 0 to Length(arrMemo) do
  begin
    if i < Length(arrMemo) then
    begin
      memCardCart.Lines.Add(arrMemo[i]);
    end
    else
      memCardCart.Lines.Add('Your current list price is $' +
        FloatToStr(rCurrentListPriceCards));
  end;
end;

procedure TfrmCardPage.btnAddProductListToCartClick(Sender: TObject);
var
  i: integer;
  arrMemo: array of string;
begin

  if frmHomePage.arrCurrentUser[0] = 'G' then
  begin
    ShowMessage
      ('You are not signed you cannot make a cart unless you have signed in');
  end
  else
  begin // turn memo into an array and then put it into the cart textfile using the procedure

    for i := 0 to memListOnProductsPage.Lines.Count - 2 do
    begin
      SetLength(arrMemo, i + 1);
      arrMemo[i] := memListOnProductsPage.Lines[i];
    end;
    pnlCartCommunicationCards.Caption := 'Adding too cart';
    frmHomePageInterface_u.frmHomePage.proMemToCartChange(arrMemo);
    pnlCartCommunicationCards.Caption := 'Successfuly added too cart';
    memListOnProductsPage.Lines.Clear;
    rCurrentCartPrice := rCurrentListPriceProducts + rCurrentCartPrice;
    rCurrentListPriceCards := 0;
  end;

end;

procedure TfrmCardPage.btnAddProductToListClick(Sender: TObject);
var
  arrList: array of string;
  sListName, sRecordsName: string;
  i, iPosx, iDecreaseLoop, iListNum, iEndNum: integer;
  bFound: boolean;
begin

  sRecordsName := dmModule.qryCards['productName']; // 'productName'

  bFound := False;
  i := 0;
  iDecreaseLoop := 0;
  while (i < memListOnProductsPage.Lines.Count - 1) do
  begin

    sListName := memListOnProductsPage.Lines[i];
    sListName := memListOnProductsPage.Lines[i];
    iPosx := Pos('x', sListName);
    iListNum := StrToInt(Copy(sListName, 0, iPosx - 2));
    sListName := Copy(sListName, iPosx + 2, Length(sListName) - (iPosx + 1));
    SetLength(arrList, i + 1 - iDecreaseLoop);
    if sListName = sRecordsName then
    begin
      bFound := True;
      arrList[i - iDecreaseLoop] := inttostr(iListNum + 1) + ' x ' + sListName;

    end
    else
    begin
      arrList[i - iDecreaseLoop] := memListOnProductsPage.Lines[i];
    end;

    i := i + 1;
  end;
  if not bFound then
  begin
    SetLength(arrList, i + 1);
    arrList[i] := '1 x ' + sRecordsName;
  end;

  rCurrentListPriceProducts := rCurrentListPriceProducts +
    dmModule.qryCards['price'];
  memListOnProductsPage.Lines.Clear;
  for i := 0 to Length(arrList) - 1 do
    memListOnProductsPage.Lines.Add(arrList[i]);
  memListOnProductsPage.Lines.Add('Your current list price is $' +
    FloatToStr(rCurrentListPriceProducts))

end;

procedure TfrmCardPage.btnAddToCartClick(Sender: TObject);
var
  i: integer;
  arrMemo: array of string;
begin

  if frmHomePage.arrCurrentUser[0] = 'G' then
  begin
    ShowMessage
      ('You are not signed you cannot make a cart unless you have signed in');
  end
  else
  begin // turn memo into an array and then put it into the cart textfile using the procedure

    for i := 0 to memCardCart.Lines.Count - 2 do
    begin
      SetLength(arrMemo, i + 1);
      arrMemo[i] := memCardCart.Lines[i];
    end;
    pnlCartCommunicationCards.Caption := 'Adding too cart';
    frmHomePageInterface_u.frmHomePage.proMemToCartChange(arrMemo);
    pnlCartCommunicationCards.Caption := 'Successfuly added too cart';
    memCardCart.Lines.Clear;
    rCurrentCartPrice := rCurrentListPriceCards + rCurrentCartPrice;
    rCurrentListPriceCards := 0;
  end;

end;

procedure TfrmCardPage.btnClearListClick(Sender: TObject);
begin
  rCurrentListPriceCards := 0;
  memCardCart.Lines.Clear;
end;

procedure TfrmCardPage.btnClearProductListClick(Sender: TObject);
begin
  memListOnProductsPage.Lines.Clear;
  rCurrentListPriceProducts := 0;
end;

procedure TfrmCardPage.btnClearProductSearchClick(Sender: TObject);
begin
  imgProductDisplay.Picture.Assign(nil);
  memProductDescription.Lines.Clear;
  ledtQueryProducts.Text := '';
  frmHomePage.proChangeActive('P');
end;

procedure TfrmCardPage.btnGoToCardsOnProductsPageClick(Sender: TObject);
begin
  frmHomePage.proChangeActive('C');
end;

procedure TfrmCardPage.btnGoToCartFromCardsClick(Sender: TObject);
begin
  frmHomePage.proChangeActive('T')
end;

procedure TfrmCardPage.btnGoToProductsFromCardsClick(Sender: TObject);
begin
  frmHomePage.proChangeActive('P');
end;

procedure TfrmCardPage.btnQueryDatabaseClick(Sender: TObject);
var
  iStats, iRarity, iName, iMana, iSubType, iFullType, iSet, iPrice,
    iCol: integer;
  bSelectedField, bOrderByWorks: boolean;
  strSelectQuery: string;
begin
  with dmModule do
  begin
    qryCards.SQL.Clear;
    strSelectQuery := 'Select ';
    iName := -1;
    // these keep track of which column indeex they are with reference to Colour column which is always last
    iSubType := -1;
    iFullType := -1;
    iRarity := -1;
    iStats := -1;
    iMana := -1;
    iSet := -1;
    iPrice := -1;

    iCol := 0;
    strSelectQuery := strSelectQuery + 'cardName, ';
    // has to be added because otherwise you cannot add or remove things by card name
    iCol := iCol + 1;
    iName := 0;

    if chbCardType.Checked then
    Begin
      bSelectedField := True;
      strSelectQuery := strSelectQuery + 'cardType, ';
      iCol := iCol + 1;
      iSubType := iCol - 1;
    End;
    if chbManaCost.Checked then
    Begin
      bSelectedField := True;
      strSelectQuery := strSelectQuery + 'manaCost, ';
      iCol := iCol + 1;
      iMana := iCol - 1;
    End;
    if chbCardRarity.Checked then
    Begin
      bSelectedField := True;
      strSelectQuery := strSelectQuery + 'rarity, ';
      iCol := iCol + 1;
      iRarity := iCol - 1;
    End;
    if chbCardStats.Checked then
    Begin
      bSelectedField := True;
      strSelectQuery := strSelectQuery + 'power, toughness, loyalty, ';
      iCol := iCol + 3;
      iStats := iCol - 3;
    End;
    if chbFullCardTypes.Checked then
    Begin
      bSelectedField := True;
      strSelectQuery := strSelectQuery + 'fullType, ';
      iCol := iCol + 1;
      iFullType := iCol - 1;
    End;
    if chbSet.Checked then
    Begin
      bSelectedField := True;
      strSelectQuery := strSelectQuery + 'set, ';
      iCol := iCol + 1;
      iSet := iCol - 1;
    End;
    strSelectQuery := strSelectQuery + 'price, ';
    // not a choice because its neccessary in the cart
    iCol := iCol + 1;
    iPrice := iCol - 1;

    if bSelectedField then
    begin
      strSelectQuery := strSelectQuery + 'Colours'
      // neccessary to end without a comma
    end
    else
    begin
      ShowMessage('You have not selected any fields for display');
      exit;
    end;

    qryCards.SQL.Add(strSelectQuery);
    qryCards.SQL.Add('from CardsDatabase');

    case cbxQueryPhrasePerColumn.ItemIndex of
      0:
        qryCards.SQL.Add('where cardName like "%' + edtQueryPhrase.Text + '%"');
      // Card Name
      1:
        qryCards.SQL.Add('where cardType like "%' + edtQueryPhrase.Text + '%"');
      // Card Type
      2:
        qryCards.SQL.Add('where rarity like "%' + edtQueryPhrase.Text + '%"');
      // Rarity
      3:
        qryCards.SQL.Add('where subTypes like "%' + edtQueryPhrase.Text + '%"');
      // Card Sub Types
      4:
        qryCards.SQL.Add('where superTypes like "%' + edtQueryPhrase.Text +
          '%"'); // Card Supper Types
      5:
        qryCards.SQL.Add('where Colours like "%' + edtQueryPhrase.Text + '%"');
      // Colour
      6:
        qryCards.SQL.Add('where set like "%' + edtQueryPhrase.Text + '%"');
      // Set
    end;

    case cbxOrderQueryOnCardsPage.ItemIndex of
      0:
        if bSelectedField then
        begin
          qryCards.SQL.Add(' order by cardName');
          bOrderByWorks := True;
        end
        else
          bOrderByWorks := False;
      1:
        if bSelectedField then
        begin
          qryCards.SQL.Add(' order by price');
          bOrderByWorks := True;
        end
        else
          bOrderByWorks := False;
      2:
        if chbCardRarity.Checked then
        begin
          qryCards.SQL.Add(' order by rarity');

          bOrderByWorks := True;
        end
        else
          bOrderByWorks := False;
      3:
        if chbCardStats.Checked then
        begin
          qryCards.SQL.Add(' order by power');

          bOrderByWorks := True;
        end
        else
          bOrderByWorks := False;
      4:
        if chbCardStats.Checked then
        begin
          qryCards.SQL.Add(' order by toughness');

          bOrderByWorks := True;
        end
        else
          bOrderByWorks := False;
      5:
        if chbCardStats.Checked then
        begin
          qryCards.SQL.Add(' order by (Power + Toughness)');
          bOrderByWorks := True;
        end
        else
          bOrderByWorks := False;

    end;

    if (Not(cbxOrderQueryOnCardsPage.ItemIndex = -1)) and bOrderByWorks then
    begin
      if chbOrderAscendingCardsPage.Checked then
        qryCards.SQL.Add(' asc');

      if chbOrderInDescendingOrderCards.Checked then
        qryCards.SQL.Add(' desc');
    end;

    qryCards.Open;
    pnlCommunicatrQuery.Caption := 'Number of records: ' +
      inttostr(qryCards.RecordCount);
    if not(iName = -1) then
      dbgCards.Columns[iName].Width := 120;
    if not(iFullType = -1) then
      dbgCards.Columns[iFullType].Width := 180;
    if not(iRarity = -1) then
      dbgCards.Columns[iRarity].Width := 70;
    if not(iStats = -1) then
    begin
      dbgCards.Columns[iStats].Width := 50;
      dbgCards.Columns[iStats + 1].Width := 50;
      dbgCards.Columns[iStats + 2].Width := 40;
    end;
    if not(iSubType = -1) then
      dbgCards.Columns[iSubType].Width := 100;
    if not(iMana = -1) then
      dbgCards.Columns[iMana].Width := 50;
    if not(iPrice = -1) then
      dbgCards.Columns[iPrice].Width := 50;
    if not(iSet = -1) then
      dbgCards.Columns[iSet].Width := 180;

    dbgCards.Columns[iCol].Width := 50;

  end;

end;

procedure TfrmCardPage.btnRemoveCardClick(Sender: TObject);
var
  i, iPos, iNum, iCheck: integer;
  cardRemove, cardCheck: string;
  arrMemo: array of string;
  bFound: boolean;
begin
  cardRemove := dmModule.qryCards['cardName'];
  bFound := False;
  i := 0;
  if memCardCart.Lines.Count = 0 then
  // this means our total isn't included in the array that we look throu
  begin
    iCheck := memCardCart.Lines.Count;
  end
  else
    iCheck := memCardCart.Lines.Count - 1;
  while i < iCheck do
  begin
    SetLength(arrMemo, i + 1);
    arrMemo[i] := memCardCart.Lines[i];
    iPos := Pos('x', arrMemo[i]) + 1;
    cardCheck := Copy(arrMemo[i], iPos + 1, Length(arrMemo[i]) - iPos);
    if cardRemove = cardCheck then
    begin
      iNum := StrToInt(Copy(arrMemo[i], 0, iPos - 3)) - 1;

      arrMemo[i] := inttostr(iNum) + ' x ' + cardRemove;
      if iNum < 1 then
        arrMemo[i] := '';
      bFound := True;
    end;
    i := i + 1
  end;
  if not bFound then
  begin
    ShowMessage('You have not added that card to your list');
  end
  else
    rCurrentListPriceCards := rCurrentListPriceCards -
      strtofloat(dmModule.qryCards['price']);

  memCardCart.Lines.Clear;
  for i := 0 to Length(arrMemo) - 1 do
  begin
    if not(arrMemo[i] = '') then
      memCardCart.Lines.Add(arrMemo[i]);
  end;
  if memCardCart.Lines.Count > 0 then
    memCardCart.Lines.Add('Your current list price is $' +
      FloatToStr(rCurrentListPriceCards))

end;

procedure TfrmCardPage.btnRemoveProductFromListClick(Sender: TObject);
var
  i, iPos, iNum, iCheck: integer;
  cardRemove, cardCheck: string;
  arrMemo: array of string;
  bFound: boolean;
begin
  cardRemove := dmModule.qryCards['productName'];
  bFound := False;
  i := 0;
  if memListOnProductsPage.Lines.Count = 0 then
  // this means our total isn't included in the array that we look throu
  begin
    iCheck := memListOnProductsPage.Lines.Count;
  end
  else
    iCheck := memListOnProductsPage.Lines.Count - 1;
  while i < iCheck do
  begin
    SetLength(arrMemo, i + 1);
    arrMemo[i] := memListOnProductsPage.Lines[i];
    iPos := Pos('x', arrMemo[i]) + 1;
    cardCheck := Copy(arrMemo[i], iPos + 1, Length(arrMemo[i]) - iPos);
    if cardRemove = cardCheck then
    begin
      iNum := StrToInt(Copy(arrMemo[i], 0, iPos - 3)) - 1;

      arrMemo[i] := inttostr(iNum) + ' x ' + cardRemove;
      if iNum < 1 then
        arrMemo[i] := '';
      bFound := True;
    end;
    i := i + 1
  end;
  if not bFound then
  begin
    ShowMessage('You have not added that card to your list');
  end
  else
    rCurrentListPriceProducts := rCurrentListPriceProducts -
      strtofloat(dmModule.qryCards['price']);

  memListOnProductsPage.Lines.Clear;
  for i := 0 to Length(arrMemo) - 1 do
  begin
    if not(arrMemo[i] = '') then
      memListOnProductsPage.Lines.Add(arrMemo[i]);
  end;
  if memListOnProductsPage.Lines.Count > 0 then
    memListOnProductsPage.Lines.Add('Your current list price is $' +
      FloatToStr(rCurrentListPriceProducts))

end;

procedure TfrmCardPage.btnResetSearchesClick(Sender: TObject);
begin
  cbxOrderQueryOnCardsPage.ItemIndex := -1;
  chbOrderAscendingCardsPage.Checked := True;
  chbOrderInDescendingOrderCards.Checked := False;
  cbxQueryPhrasePerColumn.ItemIndex := -1;
  edtQueryPhrase.Text := '';
  chbCardRarity.Checked := False;
  chbCardType.Checked := False;
  chbCardStats.Checked := False;
  chbManaCost.Checked := False;
  chbFullCardTypes.Checked := False;
  chbSet.Checked := False;

  with dmModule do
  begin
    qryCards.SQL.Clear;
    qryCards.Close;
  end;
end;

procedure TfrmCardPage.Button1Click(Sender: TObject);
begin
  if NOT(ledtQueryProducts.Text = '') then
  begin

    with dmModule do
    begin
      qryCards.SQL.Clear;
      qryCards.SQL.Add
        ('Select * from ProductsDatabase where productName like "%' +
        ledtQueryProducts.Text + '%"');
      qryCards.Open;
    end;

    dbgProducts.Columns[0].Width := 0;
    dbgProducts.Columns[1].Width := 250;
    dbgProducts.Columns[2].Width := 50;
    dbgProducts.Columns[3].Width := 0;
    dbgProducts.Columns[4].Width := 0;
  end
  else
  begin
    ShowMessage('You need to include a phrase to search for');
  end;

end;

procedure TfrmCardPage.chbOrderAscendingCardsPageClick(Sender: TObject);
begin
  chbOrderInDescendingOrderCards.Checked := False;
end;

procedure TfrmCardPage.chbOrderInDescendingOrderCardsClick(Sender: TObject);
begin
  chbOrderAscendingCardsPage.Checked := False;
end;

procedure TfrmCardPage.dbgProductsCellClick(Column: TColumn);
begin
  with dmModule do
  begin
    memProductDescription.Lines.Clear;
    memProductDescription.Lines.Add(qryCards['productDescription']);
    imgProductDisplay.Picture.LoadFromFile(frmHomePage.strProductImagesPath +
      qryCards['productDisplay']);
  end;
end;

procedure TfrmCardPage.FormActivate(Sender: TObject);
begin
  rCurrentListPriceCards := 0;
  rCurrentListPriceProducts := 0;
end;

procedure TfrmCardPage.GotToHomeFromCardsClick(Sender: TObject);
begin
  frmHomePage.proChangeActive('H');
end;

end.
