unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls,Math,LCLIntf;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button6: TButton;
    Edit9: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label10: TLabel;
    PageControl1: TPageControl;
    RadioButton1: TRadioButton;
    RadioButton10: TRadioButton;
    RadioButton13: TRadioButton;
    RadioButton14: TRadioButton;
    RadioButton15: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    RadioGroup4: TRadioGroup;
    RadioGroup5: TRadioGroup;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    procedure Button6Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PageControl1Enter(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  cor : TColor;
  cx,cy,cz : integer;
  kd : float = 0.5; // constante de reflexão
  il : integer = 10; //intensidade da luz incidente
Type
    Ponto =   Record
                x,y,z: integer;
               End;
var
    face1 : array[0..3] of Ponto;
    face2 : array[0..3] of Ponto;
    face3 : array[0..3] of Ponto;
    face4 : array[0..3] of Ponto;
    face5 : array[0..3] of Ponto;
    face6 : array[0..3] of Ponto;
    zbuffer : array[1..739,1..473] of integer;
    Luz : Ponto = (x:360;y:220;z:300); // Posição da Luz

implementation

{$R *.lfm}

{ TForm1 }
function cos_teta (nx,ny,nz,lx,ly,lz : float ):float;
begin
    cos_teta := ( ( (nx*lx) + (ny*ly) + (nz*lz) ) / ( sqrt(sqr(nx)+sqr(ny)+sqr(nz)) * sqrt(sqr(lx)+sqr(ly)+sqr(lz)) )   );
end;
function intensidade (): float ;
begin
     intensidade := il*kd;
end;
procedure iniciazbuffer();
var i,j : integer;
begin
     for i := 1 to 739 do
          for j := 1 to 473 do
             zbuffer[i][j] := 99999;
end;
procedure Desenhar ();
begin
   Form1.Image1.Canvas.Brush.Color:=clwhite;
   Form1.Image1.Canvas.Pen.Color:= clblack;

   Form1.Image1.Canvas.FillRect(0,0,538,485);
   Form1.Image1.Canvas.Rectangle(0,0,538,485);
   Form1.Image2.Canvas.FillRect(0,0,538,485);
   Form1.Image2.Canvas.Rectangle(0,0,538,485);
   Form1.Image3.Canvas.FillRect(0,0,538,485);
   Form1.Image3.Canvas.Rectangle(0,0,538,485);
   Form1.Image4.Canvas.Brush.Color:=clblack;
   Form1.Image4.Canvas.FillRect(0,0,739,473);

   Form1.Image1.Canvas.Line(50,50,400,260);
   Form1.Image1.Canvas.Line(400,210,400,260);
   Form1.Image1.Canvas.Line(50,50,50,210);
   Form1.Image1.Canvas.Line(50,210,400,210);
   Form1.Image1.Canvas.Rectangle(50,300,400,450);
   Form1.Image1.Canvas.Line(50,300,400,450);
   Form1.Image1.Canvas.Line(100,300,400,430);

   Form1.Image2.Canvas.Line(70,300,430,300);{P1,P2}
   Form1.Image2.Canvas.Line(70,50,70,300); {P5,P1}
   Form1.Image2.Canvas.Line(430,120,430,300);{P3,P2}
   Form1.Image2.Canvas.Line(70,50,300,200); {P5,P4}
   Form1.Image2.Canvas.Line(300,200,430,120);{P4,P3}
end;
procedure Objeto ();
begin
   face1[0].x:=150;
   face1[0].y:=350;
   face1[0].z:=0;
   face1[1].x:=300;
   face1[1].y:=350;
   face1[1].z:=0;
   face1[2].x:=300;
   face1[2].y:=150;
   face1[2].z:=0;
   face1[3].x:=150;
   face1[3].y:=150;
   face1[3].z:=0;

   face2[0].x:=300;
   face2[0].y:=350;
   face2[0].z:=0;
   face2[1].x:=300;
   face2[1].y:=350;
   face2[1].z:=150;
   face2[2].x:=300;
   face2[2].y:=150;
   face2[2].z:=150;
   face2[3].x:=300;
   face2[3].y:=150;
   face2[3].z:=0;

   face3[0].x:=450;
   face3[0].y:=350;
   face3[0].z:=0;
   face3[1].x:=450;
   face3[1].y:=350;
   face3[1].z:=150;
   face3[2].x:=300;
   face3[2].y:=150;
   face3[2].z:=150;
   face3[3].x:=300;
   face3[3].y:=150;
   face3[3].z:=0;

   face4[0].x:=450;
   face4[0].y:=350;
   face4[0].z:=0;
   face4[1].x:=450;
   face4[1].y:=350;
   face4[1].z:=150;
   face4[2].x:=300;
   face4[2].y:=350;
   face4[2].z:=150;
   face4[3].x:=300;
   face4[3].y:=350;
   face4[3].z:=0;

   face5[0].x:=150;
   face5[0].y:=350;
   face5[0].z:=0;
   face5[1].x:=300;
   face5[1].y:=350;
   face5[1].z:=0;
   face5[2].x:=300;
   face5[2].y:=350;
   face5[2].z:=150;
   face5[3].x:=150;
   face5[3].y:=350;
   face5[3].z:=150;

   face6[0].x:=150;
   face6[0].y:=150;
   face6[0].z:=0;
   face6[1].x:=300;
   face6[1].y:=150;
   face6[1].z:=0;
   face6[2].x:=300;
   face6[2].y:=150;
   face6[2].z:=150;
   face6[3].x:=150;
   face6[3].y:=150;
   face6[3].z:=150;
end;
procedure CentroObjeto ();
var i: integer; soma : integer = 0;

begin
    for i := 0 to 3 do
        begin
          soma := face1[i].x + soma;
          soma := face2[i].x + soma;
          soma := face3[i].x + soma;
          soma := face4[i].x + soma;
          soma := face5[i].x + soma;
          soma := face6[i].x + soma;
        end;
        cx := round(soma/24);

    soma := 0;
    for i := 0 to 3 do
        begin
          soma := face1[i].y + soma;
          soma := face2[i].y + soma;
          soma := face3[i].y + soma;
          soma := face4[i].y + soma;
          soma := face5[i].y + soma;
          soma := face6[i].y + soma;
        end;
        cy := round(soma/24);

    soma := 0;
    for i := 0 to 3 do
        begin
          soma := face1[i].z + soma;
          soma := face2[i].z + soma;
          soma := face3[i].z + soma;
          soma := face4[i].z + soma;
          soma := face5[i].z + soma;
          soma := face6[i].z + soma;
        end;
        cz := round(soma/24);

end;
procedure Translacao (Tx,Ty,Tz:integer);
var i : integer;
begin
     for i := 0 to 3 do
       begin
          face1[i].x := face1[i].x + Tx;
	  face1[i].y := face1[i].y + Ty;
	  face1[i].z := face1[i].z + Tz;
          face2[i].x := face2[i].x + Tx;
	  face2[i].y := face2[i].y + Ty;
	  face2[i].z := face2[i].z + Tz;
          face3[i].x := face3[i].x + Tx;
	  face3[i].y := face3[i].y + Ty;
	  face3[i].z := face3[i].z + Tz;
          face4[i].x := face4[i].x + Tx;
	  face4[i].y := face4[i].y + Ty;
	  face4[i].z := face4[i].z + Tz;
          face5[i].x := face5[i].x + Tx;
	  face5[i].y := face5[i].y + Ty;
	  face5[i].z := face5[i].z + Tz;
          face6[i].x := face6[i].x + Tx;
	  face6[i].y := face6[i].y + Ty;
	  face6[i].z := face6[i].z + Tz;
       end;
end;
procedure Rotacao (ang : float);
var i : integer; xaux, yaux, zaux : float;
begin
     CentroObjeto();
     if (Form1.RadioButton13.Checked) then
     begin
     Translacao(-cx,-cy,-cz);
                  for i := 0 to 3 do
                      begin
                         yaux := (face1[i].y*cos(DegToRad(ang))) + (face1[i].z*sin(DegToRad(ang)));
	                 zaux := (face1[i].y*-sin(DegToRad(ang))) + (face1[i].z*cos(DegToRad(ang)));
	                 face1[i].y := round(yaux);
                         face1[i].z := round(zaux);
                         yaux := (face2[i].y*cos(DegToRad(ang))) + (face2[i].z*sin(DegToRad(ang)));
	                 zaux := (face2[i].y*-sin(DegToRad(ang))) + (face2[i].z*cos(DegToRad(ang)));
	                 face2[i].y := round(yaux);
                         face2[i].z := round(zaux);
                         yaux := (face3[i].y*cos(DegToRad(ang))) + (face3[i].z*sin(DegToRad(ang)));
	                 zaux := (face3[i].y*-sin(DegToRad(ang))) + (face3[i].z*cos(DegToRad(ang)));
	                 face3[i].y := round(yaux);
                         face3[i].z := round(zaux);
                         yaux := (face4[i].y*cos(DegToRad(ang))) + (face4[i].z*sin(DegToRad(ang)));
	                 zaux := (face4[i].y*-sin(DegToRad(ang))) + (face4[i].z*cos(DegToRad(ang)));
	                 face4[i].y := round(yaux);
                         face4[i].z := round(zaux);
                         yaux := (face5[i].y*cos(DegToRad(ang))) + (face5[i].z*sin(DegToRad(ang)));
	                 zaux := (face5[i].y*-sin(DegToRad(ang))) + (face5[i].z*cos(DegToRad(ang)));
	                 face5[i].y := round(yaux);
                         face5[i].z := round(zaux);
                         yaux := (face6[i].y*cos(DegToRad(ang))) + (face6[i].z*sin(DegToRad(ang)));
	                 zaux := (face6[i].y*-sin(DegToRad(ang))) + (face6[i].z*cos(DegToRad(ang)));
	                 face6[i].y := round(yaux);
                         face6[i].z := round(zaux);
                      end;
     Translacao(cx,cy,cz);
     end
     else if (Form1.RadioButton14.Checked) then
     begin
     Translacao(-cx,-cy,-cz);
                  for i := 0 to 3 do
                      begin
                         xaux := (face1[i].x*cos(DegToRad(ang))) + (face1[i].z*-sin(DegToRad(ang)));
	                 zaux := (face1[i].x*sin(DegToRad(ang))) + (face1[i].z*cos(DegToRad(ang)));
	                 face1[i].x := round(xaux);
                         face1[i].z := round(zaux);
                         xaux := (face2[i].x*cos(DegToRad(ang))) + (face2[i].z*-sin(DegToRad(ang)));
	                 zaux := (face2[i].x*sin(DegToRad(ang))) + (face2[i].z*cos(DegToRad(ang)));
	                 face2[i].x := round(xaux);
                         face2[i].z := round(zaux);
                         xaux := (face3[i].x*cos(DegToRad(ang))) + (face3[i].z*-sin(DegToRad(ang)));
	                 zaux := (face3[i].x*sin(DegToRad(ang))) + (face3[i].z*cos(DegToRad(ang)));
	                 face3[i].x := round(xaux);
                         face3[i].z := round(zaux);
                         xaux := (face4[i].x*cos(DegToRad(ang))) + (face4[i].z*-sin(DegToRad(ang)));
	                 zaux := (face4[i].x*sin(DegToRad(ang))) + (face4[i].z*cos(DegToRad(ang)));
	                 face4[i].x := round(xaux);
                         face4[i].z := round(zaux);
                         xaux := (face5[i].x*cos(DegToRad(ang))) + (face5[i].z*-sin(DegToRad(ang)));
	                 zaux := (face5[i].x*sin(DegToRad(ang))) + (face5[i].z*cos(DegToRad(ang)));
	                 face5[i].x := round(xaux);
                         face5[i].z := round(zaux);
                         xaux := (face6[i].x*cos(DegToRad(ang))) + (face6[i].z*-sin(DegToRad(ang)));
	                 zaux := (face6[i].x*sin(DegToRad(ang))) + (face6[i].z*cos(DegToRad(ang)));
	                 face6[i].x := round(xaux);
                         face6[i].z := round(zaux);
                      end;
     Translacao(cx,cy,cz);
     end
     else
     begin
        Translacao(-cx,-cy,-cz);
                  for i := 0 to 3 do
                      begin
                         xaux := (face1[i].x*cos(DegToRad(ang))) + (face1[i].y*sin(DegToRad(ang)));
	                 yaux := (face1[i].x*-sin(DegToRad(ang))) + (face1[i].y*cos(DegToRad(ang)));
	                 face1[i].x := round(xaux);
                         face1[i].y := round(yaux);
                         xaux := (face2[i].x*cos(DegToRad(ang))) + (face2[i].y*sin(DegToRad(ang)));
	                 yaux := (face2[i].x*-sin(DegToRad(ang))) + (face2[i].y*cos(DegToRad(ang)));
	                 face2[i].x := round(xaux);
                         face2[i].y := round(yaux);
                         xaux := (face3[i].x*cos(DegToRad(ang))) + (face3[i].y*sin(DegToRad(ang)));
	                 yaux := (face3[i].x*-sin(DegToRad(ang))) + (face3[i].y*cos(DegToRad(ang)));
	                 face3[i].x := round(xaux);
                         face3[i].y := round(yaux);
                         xaux := (face4[i].x*cos(DegToRad(ang))) + (face4[i].y*sin(DegToRad(ang)));
	                 yaux := (face4[i].x*-sin(DegToRad(ang))) + (face4[i].y*cos(DegToRad(ang)));
	                 face4[i].x := round(xaux);
                         face4[i].y := round(yaux);
                         xaux := (face5[i].x*cos(DegToRad(ang))) + (face5[i].y*sin(DegToRad(ang)));
	                 yaux := (face5[i].x*-sin(DegToRad(ang))) + (face5[i].y*cos(DegToRad(ang)));
	                 face5[i].x := round(xaux);
                         face5[i].y := round(yaux);
                         xaux := (face6[i].x*cos(DegToRad(ang))) + (face6[i].y*sin(DegToRad(ang)));
	                 yaux := (face6[i].x*-sin(DegToRad(ang))) + (face6[i].y*cos(DegToRad(ang)));
	                 face6[i].x := round(xaux);
                         face6[i].y := round(yaux);
                      end;
        Translacao(cx,cy,cz);
     end;
end;
procedure floodfill8 (x,y : integer; velha, nova : TColor);
begin
   if (velha <> nova ) then
   begin
   if (Form1.Image1.Canvas.Pixels[x,y] = velha )then
      begin
          Form1.Image1.Canvas.Pixels[x,y] := nova;
          floodfill8(x+1, y, velha, nova);
          floodfill8(x-1, y, velha, nova);
          floodfill8(x, y+1, velha, nova);
          floodfill8(x, y-1, velha, nova);
          floodfill8(x+1, y+1, velha, nova);
          floodfill8(x-1, y-1, velha, nova);
          floodfill8(x+1, y-1, velha, nova);
          floodfill8(x-1, y+1, velha, nova);
      end;
   end;
end;
procedure floodfill4 (x,y : integer; velha, nova : TColor);
begin
   if (velha <> nova ) then
   begin
   if (Form1.Image1.Canvas.Pixels[x,y] = velha )then
      begin
          Form1.Image1.Canvas.Pixels[x,y] := nova;
          floodfill4(x+1, y, velha, nova);
          floodfill4(x-1, y, velha, nova);
          floodfill4(x, y+1, velha, nova);
          floodfill4(x, y-1, velha, nova);
      end;
   end;
end;
procedure inversaocores (x,y : integer; velha, nova : TColor);
var a,b,c : integer;
begin

      for a := 431 to 536 do      {P3,P2}
          for b := 120 to 300 do
              if(Form1.Image2.Canvas.Pixels[a,b] = nova) then
                      Form1.Image2.Canvas.Pixels[a,b] := velha
              else
                   Form1.Image2.Canvas.Pixels[a,b] := nova;

      Form1.Image2.Refresh;
      Sleep(1000);

      a := 300;
      b := 200;
      c := 200;
      while (a <= 430) do      {P4,P3}
         begin
            b := 200;
            while( b >= c) do
              begin
                 if (Form1.Image2.Canvas.Pixels[a,b] = clblack )then
                   b := c
                 else
                    begin
                       if(Form1.Image2.Canvas.Pixels[a,b] = nova) then
                           Form1.Image2.Canvas.Pixels[a,b] := velha
                       else
                           Form1.Image2.Canvas.Pixels[a,b] := nova;
                   end;
                 b := b - 1;
              end;
          c := c - 1;
          a := a + 1;
          end;



        for a := 431 to 536 do      {P4,P3}
          for b := 120 to 200 do
              begin
                       if(Form1.Image2.Canvas.Pixels[a,b] = nova) then
                           Form1.Image2.Canvas.Pixels[a,b] := velha
                       else
                           Form1.Image2.Canvas.Pixels[a,b] := nova;
              end;

      Form1.Image2.Refresh;
      Sleep(1000);


      a := 70;
      b := 200;
      c := 200;
      while (a <= 300) do      {P5,P4}
         begin
            b := 50;
            while( b <= c) do
              begin
                 if (Form1.Image2.Canvas.Pixels[a,b] = clblack )then
                   b := c
                 else
                    begin
                       if(Form1.Image2.Canvas.Pixels[a,b] = nova) then
                           Form1.Image2.Canvas.Pixels[a,b] := velha
                       else
                           Form1.Image2.Canvas.Pixels[a,b] := nova;
                   end;
                 b := b + 1;
              end;
          c := c + 1;
          a := a + 1;
         end;


        for a := 301 to 536 do      {P5,P4}
          for b := 50 to 200 do
              begin
                  if (Form1.Image2.Canvas.Pixels[a,b] <> clblack )then
                     begin
                       if(Form1.Image2.Canvas.Pixels[a,b] = nova) then
                           Form1.Image2.Canvas.Pixels[a,b] := velha
                       else
                           Form1.Image2.Canvas.Pixels[a,b] := nova;
                     end;
              end;
          Form1.Image2.Refresh;
          Sleep(1000);

          for a := 71 to 536 do      {P5,P1}
            for b := 50 to 300 do
               begin
                   if (Form1.Image2.Canvas.Pixels[a,b] <> clblack )then
                      begin
                         if(Form1.Image2.Canvas.Pixels[a,b] = nova) then
                             Form1.Image2.Canvas.Pixels[a,b] := velha
                         else
                           Form1.Image2.Canvas.Pixels[a,b] := nova;
                      end;
               end;
          Form1.Image2.Refresh;
          Sleep(1000);
end;
procedure InterpolacaoBilinear(var face : array of Ponto; cor : TColor);
var u,v: float; px,py,pz : integer;
begin
     u := 0;
     while (u<=1)do
       begin
           v := 0;
           while (v<=1) do
               begin
                px := round(face[0].x*(1-u)*(1-v) +
                face[3].x*(1-u)*v+
                face[1].x*u*(1-v)+
                face[2].x*u*v);
                py := round(face[0].y*(1-u)*(1-v) +
                face[3].y*(1-u)*v+
                face[1].y*u*(1-v)+
                face[2].y*u*v);
                pz := round(face[0].z*(1-u)*(1-v) +
                face[3].z*(1-u)*v+
                face[1].z*u*(1-v)+
                face[2].z*u*v);
                if ( pz  < zbuffer[px][py] ) then
                  begin
                       Form1.Image3.Canvas.Pixels[px,py] := cor;
                       zbuffer[px][py] := pz;
                  end;
                v := v + 0.003;
               end;
        u := u + 0.003;
       end;
end;
procedure DesenharObjeto(anglo : float);
begin
   Form1.Image3.Canvas.Clear;
   Form1.Image3.Canvas.FillRect(0,0,538,485);
   Form1.Image3.Canvas.Rectangle(0,0,538,485);
   Rotacao(anglo);
   InterpolacaoBilinear(face1,clgreen);
   InterpolacaoBilinear(face2,clyellow);
   InterpolacaoBilinear(face3,clblue);
   InterpolacaoBilinear(face4,clred);
   InterpolacaoBilinear(face5,clgreen);
   InterpolacaoBilinear(face6,clgreen);
end;
procedure iluminacao ();
var
    lx,ly,lz,x,y,z,r,b : integer;  teta,fi : float;
begin
    b:= 255;
    for x := 170 to 550 do
         for y := 50 to 400 do
               begin
                    z := -100;
                    if ( z  < zbuffer[x][y] ) then
                     begin
                       lx := Luz.x - x;
                       ly := Luz.y - y;
                       lz := Luz.z - z;
                       Form1.Image4.Canvas.Pixels[x,y] := RGB(0,0,round(b*intensidade*cos_teta(0,0,1,lx,ly,lz)));
                       zbuffer[x][y] := z;
                     end;
               end;

     r := 50;
     teta := 0;
     while(teta <= pi) do
         begin
         fi := 0;
         while(fi <= 2*pi) do
               begin
                   x := 360+round(80*cos(fi)*sin(teta));
                   y := 220+round(80*sin(teta)*sin(fi));
                   z := -80+round(80*cos(teta));
                   if ( z  < zbuffer[x][y] ) then
                     begin
                       lx := x - Luz.x ;
                       ly := y - Luz.y ;
                       lz := z - Luz.z ;
                       Form1.Image4.Canvas.Pixels[x,y] := RGB(round(r*intensidade*cos_teta(x-360,y-220,z+80,lx,ly,lz)),0,0);
                       zbuffer[x][y] := z;
                     end;
                   fi := fi + 0.004;
               end;
         teta := teta + 0.004;
         end;
end;
procedure TForm1.PageControl1Enter(Sender: TObject);
begin
   cor := clwhite;
   iniciazbuffer();
   Desenhar();
   Objeto();
   DesenharObjeto(0);
   iniciazbuffer();
   iluminacao();
end;
procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if (RadioButton1.Checked)then
      begin
         If (RadioButton3.Checked)then
            begin
             cor := Image1.Canvas.Pixels[x,y];
             floodfill4(x,y,cor,clred)
            end
         else if (RadioButton4.Checked) then
            begin
             cor := Image1.Canvas.Pixels[x,y];
             floodfill4(x,y,cor,clgreen)
            end
         else if (RadioButton5.Checked) then
            begin
             cor := Image1.Canvas.Pixels[x,y];
             floodfill4(x,y,cor,clblue)
            end
         else
            begin
             cor := Image1.Canvas.Pixels[x,y];
             floodfill4(x,y,cor,clyellow)
            end
      end
   else
      begin
         If (RadioButton3.Checked)then
            begin
             cor := Image1.Canvas.Pixels[x,y];
             floodfill8(x,y,cor,clred)
            end
         else if (RadioButton4.Checked) then
            begin
             cor := Image1.Canvas.Pixels[x,y];
             floodfill8(x,y,cor,clgreen)
            end
         else if (RadioButton5.Checked) then
            begin
             cor := Image1.Canvas.Pixels[x,y];
             floodfill8(x,y,cor,clblue)
            end
         else
            begin
             cor := Image1.Canvas.Pixels[x,y];
             floodfill8(x,y,cor,clyellow)
            end
      end;
end;
procedure TForm1.Button6Click(Sender: TObject);
begin
     iniciazbuffer();
     DesenharObjeto(StrToFloat(Edit9.Text));
end;
procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if (RadioButton7.Checked) then
      inversaocores(x,y,clwhite,clred)
   else if (RadioButton8.Checked) then
      inversaocores(x,y,clwhite,clgreen)
   else if (RadioButton9.Checked) then
      inversaocores(x,y,clwhite,clblue)
   else
      inversaocores(x,y,clwhite,clyellow);
end;

end.

