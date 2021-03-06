unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids;

type
  TForm1 = class(TForm)
    strngrd1: TStringGrid;
    procedure strngrd1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
//    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  matrix : array[0..4 , 0..4] of Integer;
  included : set of 1..25;

implementation

{$R *.dfm}

//procedure TForm1.FormShow(Sender: TObject);
//var
// st : TStringGrid;
//  i: Integer;
//  j: Integer;
//begin
//    st := TStringGrid.Create(self);
//    st.Parent := Form1;
//    st.Align := alClient;
////    st.Cells[1,2] := '-1';
//    for i := 0 to 5 do
//    begin
//      for j := 0 to 5 do
//      begin
//        st.Cells[i, j] := '-1';
//      end;
//    end;
//end;


procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
for i := 0 to 5 do
for j := 0 to 5 do
  matrix[i, j] := -1;
included := [];

//for i := 0 to 5 do
//for j := 0 to 5 do
//   strngrd1.Cells[i, j] := IntToStr(matrix[i, j]) ;
end;


function isValid(value, ACol, ARow : Integer): Boolean;
var
  i, colIdx, rowIdx : Integer;
  colArr : array[1..4] of Integer;
  rowArr : array[1..4] of Integer;
begin
//      colArr :=  [0, -1, 1, 0];
//      rowArr :=  [-1, 0, 0, 1];
      colArr[1] := 0;
      colArr[2] := -1;
      colArr[3] := 1;
      colArr[4] := 0;
      rowArr[1] := -1;
      rowArr[2] := 0;
      rowArr[3] := 0;
      rowArr[4] := 1;
      for i := 1 to 4 do
      begin
          colIdx := ACol + colArr[i];
          rowIdx := ARow + rowArr[i];
          if((colIdx >= 0) and (colIdx < 5) and (rowIdx >= 0) and (rowIdx < 5)) then
          begin
                if( (matrix[colIdx, rowIdx] = value - 1) or (matrix[colIdx, rowIdx] = value + 1 )) then
                begin
                  Result := False;
                  Exit;
                end;
          end;
      end;

      if value in included  then
      begin
      Result := False;
      Exit;
      end;

     Result := True;
end;


procedure TForm1.strngrd1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
  var
  value : Integer;
begin

    if(matrix[ACol, ARow] = -1) then
    begin
         value  := Random(25)+1;
         while(not isValid(value, ACol, ARow) ) do
         begin
           value := Random(25) + 1;
         end;
         matrix[ACol, ARow] := value;
         strngrd1.Cells[ACol, ARow] := IntToStr(value);
         Include(included, value);
    end;
end;

end.
