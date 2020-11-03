unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls, Menus, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit9: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Escala: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    PageControl1: TPageControl;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PageControl1Enter(Sender: TObject);
    procedure RadioGroup1SelectionChanged(Sender: TObject);


  private
    { private declarations }
  public
    { public declarations }
  end;
Type
    Ponto =   Record
                x,y,z: integer;
               End;
var
  Form1: TForm1;
  x1,x2,y1,y2,cx,cy,cz : integer;
  desenho : array[0..9] of Ponto;
implementation

{$R *.lfm}

{ TForm1 }
function corRGB (r, g, b : integer) : TColor;
begin
    corRGB := 65536 * b + 255 * g + r;
end;

procedure porPontos (x,y,z,i : integer);
begin
          desenho[i].x := x;
          desenho[i].y := y;
          desenho[i].z := z;
end;
procedure BresenhamReta (x1,x2,y1,y2 : integer);
var d,de,dne,dx,dy,inter,i,temp,s1,s2,x,y: integer;
begin
  x:=x1;
  y:=y1;
  dx:=abs(x2-x1);
  dy:=abs(y2-y1);
  s1:=sign(x2-x1);
  s2:=sign(y2-y1);

  if(dy>dx)then
    begin
       temp := dx;
       dx := dy;
       dy := temp;
       inter:=1;
    end
  else
      inter:=0;

  d := 2*dy -dx;
  de := 2*dy;
  dne := 2*dy-2*dx;
  Form1.Image1.Canvas.Pixels[X,Y] := corRGB(0,0,0);

  for i:=1 to dx do
    begin
         if (d < 0)  then
           begin
               if (inter=1) then
                y := y + s2
               else
                x := x + s1;
                d := d + de;
           end
          else
             begin
                y := y + s2 ;
                x := x + s1;
                d := d + dne;
             end;
         Form1.Image1.Canvas.Pixels[X,Y] := corRGB(0,0,0);
    end;
end;
procedure BresenhamCirculo (xc,yc,r : integer);
var x,y,d: integer;
begin
    x :=0;
    y := r;
    d := (1-r);
    Form1.Image2.Canvas.Pixels[xc,yc+r] := corRGB(0,0,0);
    Form1.Image2.Canvas.Pixels[xc,yc-r] := corRGB(0,0,0);
    Form1.Image2.Canvas.Pixels[xc+r,yc] := corRGB(0,0,0);
    Form1.Image2.Canvas.Pixels[xc-r,yc] := corRGB(0,0,0);

    while(y>=x)do
       begin
            if (d<0) then
               begin
                  d := (d + 2*x + 3);
                  x := x + 1;
               end
            else
                begin
                  d := (d + 2*(x-y)+5);
                  x := x + 1;
                  y := y - 1;
                end;
           Form1.Image2.Canvas.Pixels[x+xc,y+yc] := corRGB(0,0,0);
           Form1.Image2.Canvas.Pixels[x+xc,yc-y] := corRGB(0,0,0);
           Form1.Image2.Canvas.Pixels[y+xc,x+yc] := corRGB(0,0,0);
           Form1.Image2.Canvas.Pixels[y+xc,yc-x] := corRGB(0,0,0);
           Form1.Image2.Canvas.Pixels[xc-x,yc+y] := corRGB(0,0,0);
           Form1.Image2.Canvas.Pixels[xc-x,yc-y] := corRGB(0,0,0);
           Form1.Image2.Canvas.Pixels[xc-y,yc-x] := corRGB(0,0,0);
           Form1.Image2.Canvas.Pixels[xc-y,x+yc] := corRGB(0,0,0);
       end;
end;
procedure CohenSutherland(x0,y0,x1,y1,xmin,xmax,ymin,ymax : real);

type
    edge = (LEFT,RIGHT,BOTTOM,TOP);
    outcode = set of edge;
var
    accept,done : boolean;
    outcode0,outcode1,outcodeOut : outcode;
    {Outcodes para P0,P1, e qualquer outro ponto que se encontra fora do retângulo de recorte}
    x,y : real;

    procedure CompOutCode(x,y: real; var code:outcode);
    {Calcula outcode para o ponto (x,y) }
    begin
      code := [];
      if      y > ymax then code := [TOP]
      else if y < ymin then code := [BOTTOM];

      if      x > xmax then code := code + [RIGHT]
      else if x < xmin then code := code + [LEFT]
    end;

begin
     accept := false;  done := false;
    CompOutCode (x0,y0,outcode0); CompOutCode (x1,y1,outcode1);
    repeat
      if(outcode0=[]) and (outcode1=[]) then {Os dois pontos extremos da reta estão dentro;
                                              do retângulo de recorte}
        begin accept := true; done:=true end
      else if (outcode0*outcode1) <> [] then
        done := true {Há interseção da linha com o retangulo de recorte}
      else
        {Falhou em ambos os teste, calcular o segmento de linha para recortar;
        de um ponto de fora até uma interseção com a borda de recorte.}
        begin
          {Pelo menos um ponto final esta fora do retângulo de recorte ; pegar}
          if outcode0 <> [] then
            outcodeOut := outcode0 else outcodeOut := outcode1;
          {encontrar o ponto de interseção;
          usar formulas y=y0+slope*(x-x0),x=x0+(1/slope)*(y-y0).}

          if TOP in outcodeOut then
            begin     {Divide a linha na borda de cima do retangulo de recorte}
              x := x0 + (x1 - x0) * (ymax - y0) / (y1 - y0);
              y := ymax
            end
          else if BOTTOM in outcodeOut then
            begin     {Divide a linha na borda de baixo  do retangulo de recorte}
              x := x0 + (x1 - x0) * (ymin - y0) / (y1 - y0);
              y := ymin
            end;

          if RIGHT in outcodeOut then
            begin     {Divide a linha na borda direita do retangulo de recorte}
              y := y0 + (y1 - y0) * (xmax - x0) / (x1 - x0);
              x := xmax
            end
          else if LEFT in outcodeOut then
            begin     {Divide a linha na borda esquerda do retangulo de recorte}
              y := y0 + (y1 - y0) * (xmin - x0) / (x1 - x0);
              x := xmin
            end;

          {Mover o ponto de fora para o ponto de interseção para recortar}
          if (outcodeOut = outcode0) then
            begin
              x0 := x; y0 := y; CompOutCode(x0,y0,outcode0)
            end
          else
            begin
              x1 := x; y1 := y; CompOutCode(x1,y1,outcode1);
            end
        end
    until done;
    if accept then Form1.Image3.Canvas.Line(trunc(x0),trunc(y0),trunc(x1),trunc(y1))

end;
procedure Projecao();
begin
  if (Form1.RadioGroup1.ItemIndex = 1) then  {Ortogonal}
  begin
  Form1.Image4.Canvas.Clear;
  Form1.Image4.Canvas.Rectangle(0,0,335,420);
  Form1.Image4.Canvas.Line(desenho[0].x,desenho[0].y,desenho[1].x,desenho[1].y);
  Form1.Image4.Canvas.Line(desenho[1].x,desenho[1].y,desenho[4].x,desenho[4].y);
  Form1.Image4.Canvas.Line(desenho[4].x,desenho[4].y,desenho[3].x,desenho[3].y);
  Form1.Image4.Canvas.Line(desenho[3].x,desenho[3].y,desenho[2].x,desenho[2].y);
  Form1.Image4.Canvas.Line(desenho[2].x,desenho[2].y,desenho[0].x,desenho[0].y);
  Form1.Image4.Canvas.Line(desenho[5].x,desenho[5].y,desenho[6].x,desenho[6].y);
  Form1.Image4.Canvas.Line(desenho[6].x,desenho[6].y,desenho[9].x,desenho[9].y);
  Form1.Image4.Canvas.Line(desenho[9].x,desenho[9].y,desenho[8].x,desenho[8].y);
  Form1.Image4.Canvas.Line(desenho[8].x,desenho[8].y,desenho[7].x,desenho[7].y);
  Form1.Image4.Canvas.Line(desenho[7].x,desenho[7].y,desenho[5].x,desenho[5].y);
  Form1.Image4.Canvas.Line(desenho[1].x,desenho[1].y,desenho[6].x,desenho[6].y);
  Form1.Image4.Canvas.Line(desenho[0].x,desenho[0].y,desenho[5].x,desenho[5].y);
  Form1.Image4.Canvas.Line(desenho[4].x,desenho[4].y,desenho[9].x,desenho[9].y);
  Form1.Image4.Canvas.Line(desenho[2].x,desenho[2].y,desenho[7].x,desenho[7].y);
  Form1.Image4.Canvas.Line(desenho[3].x,desenho[3].y,desenho[8].x,desenho[8].y);
  end
  else    {Cavaleira}
    begin
       Form1.Image4.Canvas.Clear;
       Form1.Image4.Canvas.Rectangle(0,0,335,420);
       Form1.Image4.Canvas.Line(trunc(desenho[0].x+(desenho[0].z*cos(45))),trunc(desenho[0].y+(desenho[0].z*sin(45))),trunc(desenho[1].x+(desenho[1].z*cos(45))),trunc(desenho[1].y+(desenho[1].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[1].x+(desenho[1].z*cos(45))),trunc(desenho[1].y+(desenho[1].z*sin(45))),trunc(desenho[4].x+(desenho[4].z*cos(45))),trunc(desenho[4].y+(desenho[4].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[4].x+(desenho[4].z*cos(45))),trunc(desenho[4].y+(desenho[4].z*sin(45))),trunc(desenho[3].x+(desenho[3].z*cos(45))),trunc(desenho[3].y+(desenho[3].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[3].x+(desenho[3].z*cos(45))),trunc(desenho[3].y+(desenho[3].z*sin(45))),trunc(desenho[2].x+(desenho[2].z*cos(45))),trunc(desenho[2].y+(desenho[2].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[2].x+(desenho[2].z*cos(45))),trunc(desenho[2].y+(desenho[2].z*sin(45))),trunc(desenho[0].x+(desenho[0].z*cos(45))),trunc(desenho[0].y+(desenho[0].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[5].x+(desenho[5].z*cos(45))),trunc(desenho[5].y+(desenho[5].z*sin(45))),trunc(desenho[6].x+(desenho[6].z*cos(45))),trunc(desenho[6].y+(desenho[6].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[6].x+(desenho[6].z*cos(45))),trunc(desenho[6].y+(desenho[6].z*sin(45))),trunc(desenho[9].x+(desenho[9].z*cos(45))),trunc(desenho[9].y+(desenho[9].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[9].x+(desenho[9].z*cos(45))),trunc(desenho[9].y+(desenho[9].z*sin(45))),trunc(desenho[8].x+(desenho[8].z*cos(45))),trunc(desenho[8].y+(desenho[8].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[8].x+(desenho[8].z*cos(45))),trunc(desenho[8].y+(desenho[8].z*sin(45))),trunc(desenho[7].x+(desenho[7].z*cos(45))),trunc(desenho[7].y+(desenho[7].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[7].x+(desenho[7].z*cos(45))),trunc(desenho[7].y+(desenho[7].z*sin(45))),trunc(desenho[5].x+(desenho[5].z*cos(45))),trunc(desenho[5].y+(desenho[5].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[1].x+(desenho[1].z*cos(45))),trunc(desenho[1].y+(desenho[1].z*sin(45))),trunc(desenho[6].x+(desenho[6].z*cos(45))),trunc(desenho[6].y+(desenho[6].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[0].x+(desenho[0].z*cos(45))),trunc(desenho[0].y+(desenho[0].z*sin(45))),trunc(desenho[5].x+(desenho[5].z*cos(45))),trunc(desenho[5].y+(desenho[5].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[4].x+(desenho[4].z*cos(45))),trunc(desenho[4].y+(desenho[4].z*sin(45))),trunc(desenho[9].x+(desenho[9].z*cos(45))),trunc(desenho[9].y+(desenho[9].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[2].x+(desenho[2].z*cos(45))),trunc(desenho[2].y+(desenho[2].z*sin(45))),trunc(desenho[7].x+(desenho[7].z*cos(45))),trunc(desenho[7].y+(desenho[7].z*sin(45))));
       Form1.Image4.Canvas.Line(trunc(desenho[3].x+(desenho[3].z*cos(45))),trunc(desenho[3].y+(desenho[3].z*sin(45))),trunc(desenho[8].x+(desenho[8].z*cos(45))),trunc(desenho[8].y+(desenho[8].z*sin(45))));
    end;
 end;
procedure Translacao (Tx,Ty,Tz:integer);
var i : integer;
begin
     for i := 0 to 9 do
       begin
          desenho[i].x := desenho[i].x + Tx;
	  desenho[i].y := desenho[i].y + Ty;
	  desenho[i].z := desenho[i].z + Tz;
       end;
     Projecao();
end;
procedure Escala3 (Sx,Sy,Sz,g: float; x,y,z:integer);
var i : integer;
begin
     Translacao(-x,-y,-z);
     for i := 0 to 9 do
       begin
          desenho[i].x := trunc(desenho[i].x*Sx);
	  desenho[i].y := trunc(desenho[i].y*Sy);
	  desenho[i].z := trunc(desenho[i].z*Sz);
          if g < 1 then
             begin
                  desenho[i].x := trunc(desenho[i].x*(1/g));
	          desenho[i].y := trunc(desenho[i].y*(1/g));
	          desenho[i].z := trunc(desenho[i].z*(1/g));
             end
          else
             begin
                  desenho[i].x := trunc(desenho[i].x/g);
	          desenho[i].y := trunc(desenho[i].y/g);
	          desenho[i].z := trunc(desenho[i].z/g);
             end;
       end;
     Translacao(x,y,z);
     Projecao();
end;
procedure Rotacao (ang : float);
var i : integer; xaux, yaux, zaux : float;
begin

     if (Form1.RadioButton1.Checked) then
      begin
             if (Form1.RadioButton3.Checked) then
                  begin
                  Translacao(-cx,-cy,-cz);
                  for i := 0 to 9 do
                      begin
                         yaux := (desenho[i].y*cos(DegToRad(ang))) + (desenho[i].z*sin(DegToRad(ang)));
	                 zaux := (desenho[i].y*-sin(DegToRad(ang))) + (desenho[i].z*cos(DegToRad(ang)));
	                 desenho[i].y := round(yaux);
                         desenho[i].z := round(zaux);
                      end;
                  Translacao(cx,cy,cz);
                  end
             else if (Form1.RadioButton4.Checked) then
                  begin
                  Translacao(-cx,-cy,-cz);
                  for i := 0 to 9 do
                      begin
                         xaux := (desenho[i].x*cos(DegToRad(ang))) + (desenho[i].z*-sin(DegToRad(ang)));
	                 zaux := (desenho[i].x*sin(DegToRad(ang))) + (desenho[i].z*cos(DegToRad(ang)));
	                 desenho[i].x := round(xaux);
                         desenho[i].z := round(zaux);
                      end;
                  Translacao(cx,cy,cz);
                  end
            else
                  begin
                  Translacao(-cx,-cy,-cz);
                  for i := 0 to 9 do
                      begin
                         xaux := (desenho[i].x*cos(DegToRad(ang))) + (desenho[i].y*sin(DegToRad(ang)));
	                 yaux := (desenho[i].x*-sin(DegToRad(ang))) + (desenho[i].y*cos(DegToRad(ang)));
	                 desenho[i].x := round(xaux);
                         desenho[i].y := round(yaux);
                      end;
                  Translacao(cx,cy,cz);
                  end;
     end
     else
           begin
             if (Form1.RadioButton3.Checked) then
                  begin
                  Translacao(0,0,0);
                  for i := 0 to 9 do
                      begin
                         yaux := (desenho[i].y*cos(DegToRad(ang))) + (desenho[i].z*sin(DegToRad(ang)));
	                 zaux := (desenho[i].y*-sin(DegToRad(ang))) + (desenho[i].z*cos(DegToRad(ang)));
	                 desenho[i].y := round(yaux);
                         desenho[i].z := round(zaux);
                      end;
                  Translacao(0,0,0);
                  end
             else if (Form1.RadioButton4.Checked) then
                  begin
                  Translacao(0,0,0);
                  for i := 0 to 9 do
                      begin
                         xaux := (desenho[i].x*cos(DegToRad(ang))) + (desenho[i].z*-sin(DegToRad(ang)));
	                 zaux := (desenho[i].x*sin(DegToRad(ang))) + (desenho[i].z*cos(DegToRad(ang)));
	                 desenho[i].x := round(xaux);
                         desenho[i].z := round(zaux);
                      end;
                  Translacao(0,0,0);
                  end
            else
                  begin
                  Translacao(0,0,0);
                  for i := 0 to 9 do
                      begin
                         xaux := (desenho[i].x*cos(DegToRad(ang))) + (desenho[i].y*sin(DegToRad(ang)));
	                 yaux := (desenho[i].x*-sin(DegToRad(ang))) + (desenho[i].y*cos(DegToRad(ang)));
	                 desenho[i].x := round(xaux);
                         desenho[i].y := round(yaux);
                      end;
                  Translacao(0,0,0);
                  end;
            end
end;
procedure  CentroObjeto ();
var i: integer; soma : integer = 0;

begin
    for i := 0 to 9 do
          soma := desenho[i].x + soma;
          cx := trunc(soma/10);

    soma := 0;
    for i := 0 to 9 do
          soma := desenho[i].y + soma;
          cy := trunc(soma/10);

    soma := 0;
    for i := 0 to 9 do
          soma := desenho[i].z + soma;
          cz := trunc(soma/10);

end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     BresenhamReta(x1,x,y1,y);
end;

procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    x1 := x;
    y1 := y;
end;

procedure TForm1.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var r: integer;
begin
    r := trunc(sqrt(power((x-x1),2)+power((y-y1),2)));
    BresenhamCirculo(x1,y1,r);
end;

procedure TForm1.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  x1 := x;
  y1 := y;
end;

procedure TForm1.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  CohenSutherland(x1,y1,x,y,140,600,70,400);
end;

procedure TForm1.PageControl1Enter(Sender: TObject);
begin
  Image1.Canvas.Brush.Color:=clwhite;
  Image1.Canvas.FillRect(Form1.Image1.BoundsRect);
  Image2.Canvas.Brush.Color:=clwhite;
  Image2.Canvas.FillRect(Form1.Image2.BoundsRect);
  Image3.Canvas.Brush.Color:=clwhite;
  Image3.Canvas.FillRect(Form1.Image3.BoundsRect);
  Image3.Canvas.Rectangle(140,70,600,400);
  Image4.Canvas.Rectangle(0,0,335,420);
  porPontos(100,230,0,0);
  porPontos(200,230,0,1);
  porPontos(100,100,0,2);
  porPontos(150,40,0,3);
  porPontos(200,100,0,4);
  porPontos(100,230,70,5);
  porPontos(200,230,70,6);
  porPontos(100,100,70,7);
  porPontos(150,40,70,8);
  porPontos(200,100,70,9);
  Projecao();
end;

procedure TForm1.RadioGroup1SelectionChanged(Sender: TObject);
begin
     Projecao();
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  x1 := x;
  y1 := y;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Image1.Canvas.Clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Image2.Canvas.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Image3.Canvas.Clear;
  Image3.Canvas.Rectangle(140,70,600,400);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
      Translacao(StrToInt(Edit1.Text),StrToInt(Edit2.Text),StrToInt(Edit3.Text))
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
   Escala3(StrToFloat(Edit4.Text),StrToFloat(Edit5.Text),StrToFloat(Edit6.Text),StrToFloat(Edit7.Text),desenho[0].x,desenho[0].y,desenho[0].z);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
        centroObjeto();
        Rotacao(StrToFloat(Edit9.Text));
end;



end.





