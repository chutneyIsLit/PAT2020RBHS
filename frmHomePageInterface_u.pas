unit frmHomePageInterface_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, dbDataModule_d;

type
  TfrmHomePage = class(TForm)
    pgcHomePage: TPageControl;
    tbsLogIn: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    edtUsernameLogInPage: TEdit;
    edtPasswordLogInPage: TEdit;
    btnLogInLogInPage: TButton;
    Panel1: TPanel;
    btnSignUp: TButton;
    Button1: TButton;
    tbsHomePage: TTabSheet;
    memCartOnHomePage: TMemo;
    Panel2: TPanel;
    Panel3: TPanel;
    btnGoToCartFromHomePage: TButton;
    btnGoToProductsFromHomePage: TButton;
    btnGoToCardsFromHomePage: TButton;
    btnGoToSignUpFromHomePage: TButton;
    btnSignOutHomePage: TButton;
    btnViewProfileHomePage: TButton;
    tbsSignUp: TTabSheet;
    tbsCart: TTabSheet;
    ledtUserNameSignUp: TLabeledEdit;
    ledtPasswordSignUp: TLabeledEdit;
    ledtConfirmPasswordSignUp: TLabeledEdit;
    Panel4: TPanel;
    Panel5: TPanel;
    ledtEmailSignUp: TLabeledEdit;
    ledtPhoneSignUp: TLabeledEdit;
    ledtFirtNameSignUp: TLabeledEdit;
    ledtLastNameSignUp: TLabeledEdit;
    Label3: TLabel;
    btnSubmitSignUp: TButton;
    btnGoToHomePageFromSignUP: TButton;
    tbsGamePage: TTabSheet;
    shpBall: TShape;
    memCartOnCartPage: TMemo;
    btnClearCart: TButton;
    lblNameOfUserCartPage: TLabel;
    lblCurrentBalence: TLabel;
    btnBuyFromStore: TButton;
    Panel6: TPanel;
    Button3: TButton;
    btnGoToCardsFromCart: TButton;
    btnGoToHomeFromCart: TButton;
    btnGoToLogInFromSignUp: TButton;
    memComunicateErrorsSignUp: TMemo;
    lblNameOfUserHomePage: TLabel;
    procedure btnGoToCartFromHomePageClick(Sender: TObject);
    procedure btnGoToProductsFromHomePageClick(Sender: TObject);
    procedure btnGoToCardsFromHomePageClick(Sender: TObject);
    procedure btnSignOutHomePageClick(Sender: TObject);
    procedure btnSignUpClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnLogInLogInPageClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGoToHomePageFromSignUPClick(Sender: TObject);
    procedure btnViewProfileHomePageClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGoToHomeFromCartClick(Sender: TObject);
    procedure btnGoToCardsFromCartClick(Sender: TObject);
    procedure btnClearCartClick(Sender: TObject);
    procedure btnGoToLogInFromSignUpClick(Sender: TObject);
    procedure btnSubmitSignUpClick(Sender: TObject);
    procedure btnGoToSignUpFromHomePageClick(Sender: TObject);
    procedure btnBuyFromStoreClick(Sender: TObject);
    procedure tbsLogInShow(Sender: TObject);

  private

    { Private declarations }
  public const
    strCartFilePath =
      'C:\Users\chest\Documents\Delphi\IT PAT 2020\PAT\Cart.txt';
    strProductImagesPath = '..\..\productImages\';
    // path to my text file

  var
    arrCurrentUser: array [0 .. 3] of string;
    // AccountType(Admin(A),Staff(S),Customer(C),Geust(G)),Username,ID,Full Name
    procedure proMemToCartChange(arrGiven: array of string);
    procedure proChangeActive(const cTarget: Char);
    procedure proClearTheCart();

    { Public declarations }
  end;

var
  frmHomePage: TfrmHomePage;

implementation

{$R *.dfm}

uses frmMainCardUserInterface_u;

// home page is H ; Log In is L; Cart is T; signUp is S ;cards is C; products is P;
procedure TfrmHomePage.proChangeActive(const cTarget: Char);
// home page is H ; Log In is L; Cart is T; signUp is S ;cards is C; products is P;
var
  txtCart: TextFile;
  line: string;
begin
  begin

    case cTarget of
      // home page is H ; Log In is L; Cart is T; signUp is S ;cards is C; products is P;
      'H':
        begin
          frmHomePage.Show;
          frmCardPage.Hide;
          pgcHomePage.Pages[0].TabVisible := False;
          pgcHomePage.Pages[1].TabVisible := True;
          pgcHomePage.Pages[2].TabVisible := False;
          pgcHomePage.Pages[3].TabVisible := False;
          pgcHomePage.Pages[4].TabVisible := False;

          if not(arrCurrentUser[3] = 'G') then
            lblNameOfUserHomePage.Caption := 'Welcome ' + arrCurrentUser[3];

          memCartOnHomePage.Lines.Clear;
          AssignFile(txtCart, strCartFilePath);
          Reset(txtCart);

          while not EOF(txtCart) do
          begin
            Readln(txtCart, line);
            memCartOnHomePage.Lines.Add(line);
          end;
          CloseFile(txtCart);
          if memCartOnHomePage.Lines.Count > 0 then
            memCartOnHomePage.Lines.Add('Total price is = ' +
              FloatToStr(frmCardPage.rCurrentCartPrice));
        end;
      'L':
        begin
          frmHomePage.Show;
          frmCardPage.Hide;
          pgcHomePage.Pages[0].TabVisible := True;
          pgcHomePage.Pages[1].TabVisible := False;
          pgcHomePage.Pages[2].TabVisible := False;
          pgcHomePage.Pages[3].TabVisible := False;
          pgcHomePage.Pages[4].TabVisible := False;
          if arrCurrentUser[0] = '' then
            proClearTheCart;
        end;
      'T':
        begin
          frmHomePage.Show;
          frmCardPage.Hide;
          pgcHomePage.Pages[0].TabVisible := False;
          pgcHomePage.Pages[1].TabVisible := False;
          pgcHomePage.Pages[2].TabVisible := False;
          pgcHomePage.Pages[3].TabVisible := True;
          pgcHomePage.Pages[4].TabVisible := False;

          memCartOnCartPage.Lines.Clear;
          AssignFile(txtCart, strCartFilePath);
          Reset(txtCart);

          while not EOF(txtCart) do
          begin
            Readln(txtCart, line);
            memCartOnCartPage.Lines.Add(line);
          end;
          CloseFile(txtCart);
          if memCartOnCartPage.Lines.Count > 0 then
            lblCurrentBalence.Caption := 'Your Current Total is $' +
              FloatToStr(frmCardPage.rCurrentCartPrice);
        end;
      'S':
        begin
          frmHomePage.Show;
          frmCardPage.Hide;
          pgcHomePage.Pages[0].TabVisible := False;
          pgcHomePage.Pages[1].TabVisible := False;
          pgcHomePage.Pages[2].TabVisible := True;
          pgcHomePage.Pages[3].TabVisible := False;
          pgcHomePage.Pages[4].TabVisible := False;
        end;
      'C':
        begin
          frmHomePage.Hide;
          frmCardPage.Show;
          frmCardPage.pgcStock.Pages[0].TabVisible := True;
          frmCardPage.pgcStock.Pages[1].TabVisible := False;

          with dmModule do
          begin
            if qryCards.Active then
              qryCards.Close;
            qryCards.SQL.Clear;
            qryCards.SQL.Add
              ('Select cardName, fullType, set, price, Colours from CardsDatabase');
            qryCards.Open;

          end;

          with frmCardPage do
          begin
            dbgCards.Columns[0].Width := 120;
            dbgCards.Columns[1].Width := 180;
            dbgCards.Columns[2].Width := 100;
            dbgCards.Columns[3].Width := 50;
            dbgCards.Columns[4].Width := 50;
          end;
        end;
      'P':
        begin
          frmHomePage.Hide;
          frmCardPage.Show;
          frmCardPage.pgcStock.Pages[0].TabVisible := False;
          frmCardPage.pgcStock.Pages[1].TabVisible := True;
          with dmModule do
          begin
            if qryCards.Active then
              qryCards.Close;
            qryCards.SQL.Clear;
            qryCards.SQL.Add('Select * from ProductsDatabase');
            qryCards.Open;
          end;
          with frmCardPage do
          begin
            dbgProducts.Columns[0].Width := 0;
            dbgProducts.Columns[1].Width := 250;
            dbgProducts.Columns[2].Width := 50;
            dbgProducts.Columns[3].Width := 0;
            dbgProducts.Columns[4].Width := 0;
          end;

        end;
      'G':
        begin
          frmHomePage.Show;
          frmCardPage.Hide;
          pgcHomePage.Pages[0].TabVisible := False;
          pgcHomePage.Pages[1].TabVisible := False;
          pgcHomePage.Pages[2].TabVisible := False;
          pgcHomePage.Pages[3].TabVisible := False;
          pgcHomePage.Pages[4].TabVisible := True;
        end;
    end;

  end;
end;

procedure TfrmHomePage.proClearTheCart;
var
  txtCart: TextFile;
begin
  AssignFile(txtCart, strCartFilePath);
  Rewrite(txtCart);
  CloseFile(txtCart);
  frmCardPage.rCurrentCartPrice := 0;

end;

procedure TfrmHomePage.proMemToCartChange(arrGiven: array of string);
var
  sCardMem, sCardTxt: string;
  iNumTxt, iNumMem, i, iPosX: integer;
  txtCart: TextFile;
  arrBuild: array of string;
  boolFoundCopy: Boolean;
begin

  SetLength(arrBuild, length(arrGiven));
  for i := 0 to length(arrBuild) - 1 do
  begin
    arrBuild[i] := arrGiven[i];
  end; // this immediatly puts everything in the memo into the array

  AssignFile(txtCart, strCartFilePath);
  Reset(txtCart);

  while not EOF(txtCart) do
  begin
    Readln(txtCart, sCardTxt);
    // finding the name and number of cards in the memo
    iPosX := Pos('x', sCardTxt);
    iNumTxt := StrToInt(Copy(sCardTxt, 0, iPosX - 2));
    // -1 to account for space
    sCardTxt := Copy(sCardTxt, iPosX + 2, length(sCardTxt) + iPosX + 2);
    // 2 one becasue satrts on 0 and one for space
    boolFoundCopy := False;

    i := -1;
    while (not boolFoundCopy) and (i < length(arrBuild) - 1) do
    begin
      i := i + 1;
      // we do this at the beginning of the loop so that at the end of the loop we have i saved as the index and not i+1
      // however this means we must start on minus one not 0
      sCardMem := arrBuild[i];
      // Finding the Name and number of cars in the memo
      iPosX := Pos('x', sCardMem);
      iNumMem := StrToInt(Copy(sCardMem, 0, iPosX - 2));
      // -1 to account for space
      sCardMem := Copy(sCardMem, iPosX + 2, length(sCardMem) + iPosX + 2);
      // 2 one becasue satrts on 0 and one for space

      if sCardTxt = sCardMem then
      begin
        iNumMem := iNumTxt + iNumMem;
        boolFoundCopy := True;
      end;

    end;

    if boolFoundCopy then
    begin
      arrBuild[i] := inttostr(iNumMem) + ' x ' + sCardMem;
    end
    else
    begin
      SetLength(arrBuild, i + 2);
      arrBuild[i + 1] := inttostr(iNumTxt) + ' x ' + sCardTxt;
    end;
  end;

  Rewrite(txtCart);
  Append(txtCart);
  for i := 0 to length(arrBuild) - 1 do
  begin
    Writeln(txtCart, arrBuild[i]);
  end;

  CloseFile(txtCart);

end;

procedure TfrmHomePage.tbsLogInShow(Sender: TObject);
begin
  // if arrCurrentUser[0] = '' then
  // btnClearCartClick(Self.btnClearCart);
  //
  // proChangeActive('L');
end;

procedure TfrmHomePage.btnGoToProductsFromHomePageClick(Sender: TObject);
begin
  proChangeActive('P');
end;

procedure TfrmHomePage.btnGoToSignUpFromHomePageClick(Sender: TObject);
begin
  proChangeActive('S');
end;

procedure TfrmHomePage.btnLogInLogInPageClick(Sender: TObject);
var
  bFound: Boolean;
begin
//  bFound := False;
//  with dmModule do
//  begin
//    qryUser.SQL.Clear;
//    qryUser.SQL.Add
//      ('Select username,password,userStatus,ID,fullName from Accounts');
//    qryUser.Open;
//    qryUser.First;
//    while not qryUser.EOF do
//    begin
//      if (edtUsernameLogInPage.Text = qryUser['username']) and
//        (edtPasswordLogInPage.Text = qryUser['password']) then
//      begin
//        bFound := True;
//        arrCurrentUser[0] := qryUser['userStatus'];
//        arrCurrentUser[1] := qryUser['username'];
//        arrCurrentUser[2] := qryUser['ID'];
//        arrCurrentUser[3] := qryUser['fullName'];
//      end;
//      qryUser.Next;
//    end;
//
//  end;
//
//  if bFound then
//  begin
//    proChangeActive('H');
//  end
//  else
//    ShowMessage('This user does not exist');

   proChangeActive('H');
   arrCurrentUser[0] := 'A';

end;

procedure TfrmHomePage.btnSignOutHomePageClick(Sender: TObject);
begin
  arrCurrentUser[0] := '';
  arrCurrentUser[1] := '';
  arrCurrentUser[2] := '';
  proChangeActive('L');
end;

procedure TfrmHomePage.btnSignUpClick(Sender: TObject);
begin
  proChangeActive('S');
end;

procedure TfrmHomePage.btnSubmitSignUpClick(Sender: TObject);
var
  i, test: integer;
  bValid: Boolean;
begin
  memComunicateErrorsSignUp.Lines.Clear;
  bValid := True;
  if length(ledtUserNameSignUp.Text) < 8 then
  begin
    bValid := False;
    memComunicateErrorsSignUp.Lines.Add
      ('Your username is too short (min 8 chars)');
  end;
  if (ledtEmailSignUp.Text = '') or (ledtFirtNameSignUp.Text = '') or
    (ledtLastNameSignUp.Text = '') then
  begin
    bValid := False;
    memComunicateErrorsSignUp.Lines.Add
      ('You have not filled in the neccesary boxes');
  end;
  if (length(ledtPhoneSignUp.Text) < 10) and (length(ledtPhoneSignUp.Text) > 0)
  then
  begin
    for i := 0 to 10 do
    begin
      try
        test := StrToInt(ledtPhoneSignUp.Text[i]);
      except
        bValid := False;
        memComunicateErrorsSignUp.Lines.Add
          ('Your phone numer includes invalid characters');
      end;
    end;
  end;
  if (length(ledtPhoneSignUp.Text) < 10) and (length(ledtPhoneSignUp.Text) > 0)
  then
  begin
    bValid := False;
    memComunicateErrorsSignUp.Lines.Add
      ('Your phone number is too short and therefore invalid');
  end;

  if not(ledtConfirmPasswordSignUp.Text = ledtPasswordSignUp.Text) then
  begin
    bValid := False;
    memComunicateErrorsSignUp.Lines.Add
      ('Your password and confirm password do not match');
  end;

  with dmModule do
  begin

    qryUser.SQL.Clear;
    qryUser.SQL.Add('Select * from Accounts');
    qryUser.Open;
    qryUser.First;
    while not qryUser.EOF do
    begin
      if qryUser['username'] = ledtUserNameSignUp.Text then
      begin
        bValid := False;
        memComunicateErrorsSignUp.Lines.Add('That username is already in use');
      end;
      if qryUser['emailAddress'] = ledtEmailSignUp.Text then
      begin
        bValid := False;
        memComunicateErrorsSignUp.Lines.Add('That email is already in use');
      end;
      qryUser.Next;
    end;

    if bValid then
    begin
      qryUser.Last;
      qryUser.Edit;
      qryUser.Append;
      qryUser['username'] := ledtUserNameSignUp.Text;
      qryUser['password'] := ledtPasswordSignUp.Text;
      qryUser['fullName'] := ledtFirtNameSignUp.Text + ' ' +
        ledtLastNameSignUp.Text;
      qryUser['phoneNumber'] := ledtPhoneSignUp.Text;
      qryUser['emailAddress'] := ledtEmailSignUp.Text;
      qryUser['userStatus'] := 'C';
      qryUser.Post;
      memComunicateErrorsSignUp.Lines.Add('Your account has been added');
    end;
  end;

end;

procedure TfrmHomePage.btnViewProfileHomePageClick(Sender: TObject);
begin
  proChangeActive('G');
end;

procedure TfrmHomePage.Button1Click(Sender: TObject);
begin
  arrCurrentUser[0] := 'G';
  proChangeActive('H');
end;

procedure TfrmHomePage.FormActivate(Sender: TObject);
begin
  proChangeActive('L');
end;

procedure TfrmHomePage.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v: integer;
begin
  if ssShift in Shift then
    v := 1
  else
    v := 10;
  case Key of
    VK_UP:
      shpBall.Top := shpBall.Top - v;
    VK_DOWN:
      shpBall.Top := shpBall.Top + v;
    VK_LEFT:
      shpBall.Left := shpBall.Left - v;
    VK_RIGHT:
      shpBall.Left := shpBall.Left + v;
  end;
end;

procedure TfrmHomePage.FormKeyPress(Sender: TObject; var Key: Char);
begin
  // if Key = VK_UP then
  // shpBall.Top := shpBall.Top - 10;
  // if Key = VK_DOWN then
  // shpBall.Top := shpBall.Top + 10;
  // if Key = VK_LEFT then
  // shpBall.Left := shpBall.Left - 10;
  // if Key = VK_RIGHT then
  // shpBall.Left := shpBall.Left + 10;

end;

procedure TfrmHomePage.btnBuyFromStoreClick(Sender: TObject);
var
  txtFile: TextFile;
  arrProducts: array of array [0 .. 1] of string;
  arrTxt: array of string;
  i, iPos, iOrderID, iQuantityAdd, iQuantityTotal, iPrevProcess: integer;
  sName: string;
begin
  if arrCurrentUser[0] = 'C' then
  begin

    AssignFile(txtFile, strCartFilePath);;

    iQuantityTotal := 0;
    i := 0;
    Reset(txtFile);
    while not EOF(txtFile) do
    begin
      SetLength(arrTxt, i + 1);
      Readln(txtFile, arrTxt[i]);
      // split it into the given quantities
      iPos := Pos('x', arrTxt[i]);
      sName := Copy(arrTxt[i], iPos + 2, arrTxt[i].length - (iPos) - 1);
      iQuantityAdd := StrToInt(Copy(arrTxt[i], 0, iPos - 2));
      iQuantityTotal := iQuantityTotal + iQuantityAdd;

      SetLength(arrProducts, i + 1);
      arrProducts[i][0] := sName;
      arrProducts[i][1] := inttostr(iQuantityAdd);

      i := i + 1;
    end;
    CloseFile(txtFile);

    with dmModule do // make order record
    begin
      qryUser.SQL.Clear;
      qryUser.SQL.Add('Select * from Orders');

      qryUser.Open;
      qryUser.Last;
      qryUser.Append;

      qryUser.Last;
      qryUser.Insert;
      qryUser['accountID'] := StrToInt(arrCurrentUser[2]);
      qryUser['numberOfProducts'] := iQuantityTotal;
      qryUser['dateOfOrder'] := date;
      qryUser['totalPrice'] := FloatToStr(frmCardPage.rCurrentCartPrice);
      qryUser['completed'] := False;
      qryUser.Post;

      qryUser.Close;
      qryUser.Open;
      qryUser.Last;
      iOrderID := qryUser['orderID'];

      qryUser.SQL.Clear;
      qryUser.SQL.Add('select ID, ordersInProcessing from Accounts where ID = '
        + arrCurrentUser[2]);
      qryUser.Open;

      iPrevProcess := qryUser['ordersInProcessing'];

      qryUser.First;
      qryUser.Edit;
      qryUser['ordersInProcessing'] := qryUser['ordersInProcessing'] +1;
      qryUser.Post;
    end;

    with dmModule do // record contents of order in record
    begin
      qryUser.SQL.Clear;
      qryUser.SQL.Add('Select * from OrderContents');
      for i := 0 to length(arrTxt) - 1 do
      begin

        qryUser.Open;
        qryUser.Append;
        qryUser.Last;
        qryUser.Insert;

        qryUser['orderID'] := iOrderID;
        qryUser['nameOfProduct'] := arrProducts[i][0];
        qryUser['quantityOfProduct'] := StrToInt(arrProducts[i][1]);

        qryUser.Post;
        qryUser.Close;

      end;
    end;
    proClearTheCart();
    ShowMessage('Your order has been put through you can expect a reply soon.');


  end;
end;

procedure TfrmHomePage.btnClearCartClick(Sender: TObject);
var
  txtCart: TextFile;
begin
  proClearTheCart;
  memCartOnCartPage.Lines.Clear;
  lblCurrentBalence.Caption := '';
  proChangeActive('T');
end;

procedure TfrmHomePage.btnGoToCardsFromCartClick(Sender: TObject);
begin
  proChangeActive('C');
end;

procedure TfrmHomePage.btnGoToCardsFromHomePageClick(Sender: TObject);
begin
  proChangeActive('C');
end;

procedure TfrmHomePage.btnGoToCartFromHomePageClick(Sender: TObject);
begin
  proChangeActive('T');
end;

procedure TfrmHomePage.btnGoToHomeFromCartClick(Sender: TObject);
begin
  proChangeActive('H');
end;

procedure TfrmHomePage.btnGoToHomePageFromSignUPClick(Sender: TObject);
begin
  proChangeActive('H');
end;

procedure TfrmHomePage.btnGoToLogInFromSignUpClick(Sender: TObject);
begin
  proChangeActive('L');
end;

end.


// This used to be my proMemToCartChange procedure but i realized it was innoficcient and changed it (I just left this in, incase you wanted to see my design process)

// procedure TfrmHomePage.proMemToCartChange(arrGiven: array of string);
// var
// sCardMem, sCardTxt: string;
// iNumTxt, iNumMem, i, j, iPosX: integer;
// txtCart: TextFile;
// arrMove, arrBuild: array of string;
// boolFoundCopy: boolean;
// begin
// i := 1;
// AssignFile(txtCart, strCartFilePath);
//
// reset(txtCart);
// while not EOF(txtCart) do // puts text file in an array and clears txt
// begin
// SetLength(arrMove, i);
// Readln(txtCart, arrMove[i - 1]);
// i := i + 1;
// end;
// Rewrite(txtCart);
//
// i := 0;
// while i < Length(arrGiven) do
// begin
// sCardMem := arrGiven[i];
// // finding the name and number of cards in the memo
// iPosX := Pos('x', sCardMem);
// iNumMem := StrToInt(Copy(sCardMem, 0, iPosX - 2));
// // -1 to account for space
// sCardMem := Copy(sCardMem, iPosX + 2, Length(sCardMem) + iPosX + 2);
// // 2 one becasue satrts on 0 and one for space
//
// boolFoundCopy := False;
// j := 0;
// while j < Length(arrMove) do
// begin
// sCardTxt := arrMove[i];
// // Finding the Name and number of cars in the memo
// iPosX := Pos('x', sCardTxt);
// iNumTxt := StrToInt(Copy(sCardTxt, 0, iPosX - 2));
// // -1 to account for space
// sCardTxt := Copy(sCardTxt, iPosX + 2, Length(sCardTxt) + iPosX + 2);
// // 2 one becasue satrts on 0 and one for space
//
// if sCardTxt = sCardMem then
// // if we find a copy increase numberof cards in the copy
// begin
// iNumMem := iNumTxt + iNumMem;
// boolFoundCopy := True;
// end;
// j := j + 1;
// end;
//
// SetLength(arrBuild, i + 1);
// if boolFoundCopy then
// begin
// arrBuild[i] := IntToStr(iNumMem) + ' x ' + sCardMem;
// end
// else
// begin
// arrBuild[i] := arrGiven[i];
// end;
//
// i := i + 1;
//
// end; // by now every card in the mem is now been added too the arr build we need to make sure nothing is left out the txt that was already there
//
// i := 0;
// while i < Length(arrMove) do
// // now we put whats left in the text file back into the built array
// begin
// sCardTxt := arrMove[i]; // Finding the Name
// iPosX := Pos('x', sCardTxt);
// sCardTxt := Copy(sCardTxt, iPosX + 2, Length(sCardTxt) + iPosX + 2);
//
// boolFoundCopy := False;
// j := 0;
// while j < Length(arrGiven) do
// begin
// sCardMem := arrGiven[j];
// // finding the name and number of cards in the memo
// iPosX := Pos('x', sCardMem);
// sCardMem := Copy(sCardMem, iPosX + 2, Length(sCardMem) + iPosX + 2);
//
// if sCardTxt = sCardMem then
// begin
// boolFoundCopy := True;
// end;
// j := j + 1;
// end;
//
// // if you don't find the card in the built array it adds the card on the end
// if Not boolFoundCopy then
// begin
// SetLength(arrBuild, Length(arrBuild) + 1);
// arrBuild[Length(arrBuild) - 1] := arrMove[i];
// end;
//
// i := i + 1;
//
// end;
//
// // Finally we can put the array back in the text file
// append(txtCart);
// for i := 0 to Length(arrBuild) - 1 do
// begin
// Writeln(txtCart, arrBuild[i]);
// end;
// CloseFile(txtCart);
// end;
