unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
var zbuffer : array[1..484,0..552] of integer;

procedure iniciazbuffer();
var i,j : integer;
begin
     for i := 1 to 484 do
          for j := 1 to 552 do
             zbuffer[i][j] := 99999;
end;
procedure Objeto3 ();
var x,y,z,alfa : float; t : integer;
begin
     for t := 0 to 50 do
     begin
        alfa := 0;
        while (alfa < 2*pi)do
            begin
                x := 30 + t*cos(alfa);
                y := 50 + t*sin(alfa);
                z := 10 + t;
                if ( z  < zbuffer[round(x)][round(y)] ) then
                  begin
                       Form1.Image1.Canvas.Pixels[round(x),round(y)] := clyellow;
                       zbuffer[round(x)][round(y)] := round(z);
                  end;
               alfa := alfa + 0.001;
            end;
     end;
end;
procedure Objeto1 ();
var x,y,z : integer;
begin

     for x := 10 to 30 do
     begin
         for y:= 20 to 40 do
            begin
                z := x*x + y;
                if ( z  < zbuffer[x][y] ) then
                  begin
                       Form1.Image1.Canvas.Pixels[x,y] := clblue;
                       zbuffer[x][y] := z;
                  end;
            end;
     end;
end;
procedure Objeto2 ();
var x,y,z : integer;
begin

     for x := 50 to 100 do
     begin
         for y:= 30 to 80 do
            begin
                z := 3*x-2*y+5;
                if ( z  < zbuffer[x][y] ) then
                  begin
                       Form1.Image1.Canvas.Pixels[x,y] := clred;
                       zbuffer[x][y] := z;
                  end;
            end;
     end;
end;
procedure Objeto4 ();
var x,y,z,alfa,beta : float;
begin
     alfa := 0;
     while (alfa < 2*pi) do
     begin
        beta := 0;
        while (beta < 2*pi)do
            begin
                x := 100 + 30*cos(alfa)*cos(beta);
                y := 50 + 30*cos(alfa)*sin(beta);
                z := 20 + 30*sin(alfa);
                if ( z  < zbuffer[round(x)][round(y)] ) then
                  begin
                       Form1.Image1.Canvas.Pixels[round(x),round(y)] := clgreen;
                       zbuffer[round(x)][round(y)] := round(z);
                  end;
               beta := beta + 0.01;
            end;
        alfa := alfa + 0.01;
     end;
end;
procedure Objeto5 ();
var x,y,z : integer;
begin

     for x := 0 to 20 do
     begin
         for y:= 0 to 20 do
            begin
                z := x + y;
                if ( z  < zbuffer[x][y] ) then
                  begin
                       Form1.Image1.Canvas.Pixels[x,y] := clwhite;
                       zbuffer[x][y] := z;
                  end;
            end;
     end;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
    iniciazbuffer();
    Image1.Canvas.Brush.Color:=clblack;
    Image1.Canvas.FillRect(0,0,552,484);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    if (RadioButton1.Checked)then
       Objeto1()
    else if (RadioButton2.Checked) then
       Objeto2()
    else if (RadioButton3.Checked) then
       Objeto3()
    else if (RadioButton4.Checked) then
       Objeto4()
    else
       Objeto5;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    iniciazbuffer();
    Image1.Canvas.Brush.Color:=clblack;
    Image1.Canvas.FillRect(0,0,552,484);
end;

end.

