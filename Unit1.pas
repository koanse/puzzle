unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, jpeg;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Img: TImage;
    procedure ImgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  positions: array[1..100] of integer; // массив ячеек игрового поля
  selectedPositionIndex: integer; // выбранный сегмент
  Bmp : TBitmap;

implementation

{$R *.dfm}

procedure GenerateRandom();
var
  i, rand, j : Integer;
begin
  // очистка поля
  for i := 1 to 100 do
  begin
    positions[i] := 0;
  end;

  // расстановка 9 элементов пазла
  for i := 1 to 9 do
  begin
    rand := Random(100);
    j := 0;
    if (positions[rand] <> 0) then
    begin
      while positions[j] <> 0 do
      begin
        j := j + 1;
      end;
      rand := j;
    end;
    positions[rand] := i;
  end;

  selectedPositionIndex := -1;
end;

procedure WinCheck();
var
  win : Boolean;
begin
   // проверка на выигрыш (левый верхний элемент пазла лолжен быть в кружке)
   win := False;
   if (
   (positions[11] = 1) and (positions[12] = 2) and (positions[13] = 3)
   and (positions[21] = 4) and (positions[22] = 5) and (positions[23] = 6)
   and (positions[31] = 7) and (positions[32] = 8) and (positions[33] = 9)
   )
   then
   begin
    win := True;
    ShowMessage('Вы выиграли!');
    end;
end;

procedure TForm1.ImgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var jpeg: TJPEGImage;
  rect1, rect2: TRect;
  index : integer;
begin
  WinCheck();
  index := Trunc(Y / 50) * 10 + Trunc(X / 50); // текущий индекс
  if ((selectedPositionIndex = -1) or (positions[index] <> 0)) then
  begin
    // выбранная часть
    selectedPositionIndex := Trunc(Y / 50) * 10 + Trunc(X / 50);
  end
  else
  begin 
    if (index <> selectedPositionIndex) then
      begin
        // перемещение части пазла
        positions[index] := positions[selectedPositionIndex];
        positions[selectedPositionIndex] := 0;
        selectedPositionIndex := -1;
    end;
  end;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
    Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
var jpeg: TJPEGImage;
begin
  jpeg := TJPEGImage.Create;
  Bmp := TBitmap.Create;

  // загрузка пазла из файла
  jpeg.LoadFromFile('rose.jpg');
  Bmp.Assign(jpeg);
  jpeg.Free;

  GenerateRandom();
end;

procedure TForm1.ImgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  i, j, x1, y1, x2, y2 : Integer;
  rect1, rect2 : TRect;
begin
  with Img.Canvas do begin
    Brush.Color := clYellow;
    FillRect(Rect(0,0,ClipRect.Right,ClipRect.Bottom));
  end;

  // кружок-ориентир для левого-верхнего угла пазла
  Img.Canvas.Ellipse(100,100,50,50);

  for i := 1 to 100 do
  begin
    if (positions[i] <> 0) then
    begin
      // прямоугольник пазла
      j := positions[i] - 1;
      y1 := 166 * Trunc(j / 3);
      x1 := 166 * (j Mod 3);
      y2 := y1 + 166;
      x2 := x1 + 166;
      rect1 := Rect(x1, y1, x2, y2);

      // прямоугольник экрана
      y1 := 50 * Trunc(i / 10);
      x1 := 50 * (i Mod 10);
      y2 := y1 + 50;
      x2 := x1 + 50;
      rect2 := Rect(x1, y1, x2, y2);

      Img.Canvas.CopyRect(rect2, Bmp.Canvas, rect1);
    end;

  end;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  GenerateRandom();
end;

end.

