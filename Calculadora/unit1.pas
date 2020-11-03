unit Unit1;

{$mode objfpc}{$H+}
{$ASMMODE intel}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,Math,fpexprpars;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button2: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button3: TButton;
    Button30: TButton;
    Button31: TButton;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioGroup1: TRadioGroup;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure Button33Click(Sender: TObject);
    procedure Button34Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  operador : Integer = 0;     //Variáveis Globais utilizadas no programa
  parenteses : Integer = 0;
  FParser: TFPExpressionParser;
  parserResult: TFPExpressionResult;
  resultValue: Real;

implementation

{$R *.lfm}

{ TForm1 }


//Função que converte Graus em radianos
function converte_grau_rad (grau : Real) : real;
var
  x: real;
  y: real = 57.2958;
begin
     asm
       finit
       fld grau
       fld y
       fdiv
       fstp x
     end;
     converte_grau_rad := x;
end;

//Função que converte Radianos em Grau
function converte_rad_grau (rad : Real) : real;
var
  x: real;
  y: real = 57.2958;
begin
     asm
       finit
       fld rad
       fld y
       fmul
       fstp x
     end;
     converte_rad_grau := x;
end;

//Função que calcula o Seno e o Arco-Seno
function calcula_seno (valor : Real; opcao, opcao2 : Integer) : real;
var
  x : real;
begin
     if (opcao = 1) then    //Seno em graus
       begin
           x := converte_grau_rad(valor);
           if (opcao2 = 1) then    // Seno
               asm
                  finit
                  fld x
                  fsin
                  fstp x
               end
           else         //Arco-Seno
             begin
               asm
                  finit
                  fld valor
	          fld st(0)
		  fmul st, st(0)
		  fld1
		  fsubrp st(1), st
		  fsqrt
                  fpatan
                  fstp x
               end;
             x := converte_rad_grau(x);
           end;
      end

      else         //Seno em Radianos
       begin
         if(opcao2 = 1) then //Seno
           asm
              finit
              fld valor
              fsin
              fstp x
           end
          else         //Arco-Seno
               asm
                  finit
                  fld valor
	          fld st(0)
		  fmul st, st(0)
		  fld1
		  fsubrp st(1), st
		  fsqrt
                  fpatan
                  fstp x
               end;
       end;
       calcula_seno := x;
end;

//Função que calcula o Cosseno e o Arco-Cosseno
function calcula_cosseno  (valor : Real; opcao, opcao2 : Integer) : real;
var
  x : real;
begin
     if (opcao = 1) then    //Cosseno em graus
       begin
           x := converte_grau_rad(valor);
           if (opcao2 = 1) then    // Cosseno
               asm
                  finit
                  fld x
                  fcos
                  fstp x
               end
           else         //Arco-Cosseno
             begin
               asm
                  finit
                  fld valor
	          fld st(0)
		  fmul st, st(0)
		  fld1
		  fsubrp st(1), st
		  fsqrt
		  fxch st(1)
		  fpatan
                  fstp x
               end;
             x := converte_rad_grau(x);
           end;
      end

      else         //Cosseno em Radianos
       begin
         if(opcao2 = 1) then //Cosseno
           asm
              finit
              fld valor
              fcos
              fstp x
           end
          else         //Arco-Cosseno
               asm
                  finit
                  fld valor
	          fld st(0)
		  fmul st, st(0)
		  fld1
		  fsubrp st(1), st
		  fsqrt
		  fxch st(1)
		  fpatan
                  fstp x
               end;
       end;
       calcula_cosseno := x;
end;

//Função que calcula a Tangente e a Arco-Tangente
function calcula_tangente  (valor : Real; opcao, opcao2 : Integer) : real;
var
  x : real;
begin
     if (opcao = 1) then    //Tangente em graus
       begin
           x := converte_grau_rad(valor);
           if (opcao2 = 1) then    // Tangente
               asm
                  finit
                  fld x
                  fsin
                  fld x
                  fcos
                  fdiv
                  fstp x
               end
           else         //Arco-Tangente
             begin
               asm
                  finit
                  fld valor
                  fld1
	          fpatan
                  fstp x
               end;
             x := converte_rad_grau(x);
           end;
      end

      else         //Tangente em Radianos
       begin
         if(opcao2 = 1) then //Tangente
           asm
              finit
              fld valor
              fsin
              fld valor
              fcos
              fdiv
              fstp x
           end
          else         //Arco-Tangente
               asm
                  finit
                  fld valor
                  fld1
                  fpatan
                  fstp x
               end;
       end;
       calcula_tangente := x;
end;

//Função que calcula 1/x
function calcula_inverso  (valor : Real) : real;
var
   x : real;
begin
    asm
       finit
       fld1
       fld valor
       fdiv
       fstp x
    end;
    calcula_inverso := x;
end;

//Função que calcula quadrado x²
function calcula_quadrado  (valor : Real) : real;
var
   x : real;
begin
     asm
       finit
       fld valor
       fld valor
       fmul
       fstp x
     end;
     calcula_quadrado := x;
end;

//Função que calcula o ln
function calcula_ln  (valor : real) : real;
var
   x : real;
begin
     asm
        finit
        fld valor
        fld1
        fxch
        fyl2x
        fldl2e
        fdiv
        fstp x
     end;
     calcula_ln := x;
end;

//Função que calcula o potencia decimal
function calcula_potencia_decimal  (base, expoente : real) : real;
var
   x : real;
   y : real;
   e : real = 2.718281;
begin
     if(expoente < 0 ) then   //expoente negativo
     begin
             expoente *= -1;
             y := expoente*calcula_ln(base);
             x := power(e,y);           //Não achei funcao em assembly que calcula
             x := calcula_inverso(x);  //potências decimais
     end
     else      //expoente negativo positivo
         begin
            y := expoente*calcula_ln(base);
            x := power(e,y); //Não achei funcao em assembly que calcula
         end;                //potências decimais
      calcula_potencia_decimal := x;
end;

//Função que calcula potencia
function calcula_potencia  (base, expoente : Real) : real;
var
   x : real;
   i,j,k : integer;
begin
           k := 0; //potencia negativa
           j := round(expoente);      //transforma a potencia em inteiro para usar no for
           if ( (expoente - j) = 0) then  //se a potencia é inteira calcula
           begin
               if (expoente = 0) then
                   x := 1
               else
                 begin
                   if (j < 0) then  //potencia negativa
                   begin
                     j *= -1;
                     k := 1;
                   end;

                   x:= base;
                   for i := 2 to j do
                     begin
                         asm
                            finit
                            fld base
                            fld x
                            fmul
                            fstp x
                         end;
                     end;
                 end;
                 if (k = 1) then
                      x:= calcula_inverso(x);
                 calcula_potencia := x;
           end
           else  //se a potencia é decimal
           begin
                x := calcula_potencia_decimal(base,expoente);
                calcula_potencia := x;
           end;
end;

//Função que calcula a raiz quadrada
function calcula_raiz_quadrada  (valor : Real) : real;
var
   x : real;
begin
     asm
       finit
       fld valor
       fsqrt
       fstp x
     end;
     calcula_raiz_quadrada := x;
end;

//Função que calcula o fatorial
function calcula_fatorial  (valor : real) : Integer;
var
   x,y : real;
   a,b : Integer;
begin
     x := 1;
     y := 1;
     a := round(y);        //Não sei o motivo mas o FPU só calcula o valor correto
     b := round(valor);    // se for real e o for usa valores inteiros  por isso o uso das
                           // variáveis auxiliares
     if((valor = 0) or (valor = 1)) then
         calcula_fatorial := 1
     else
     begin
         for a := 1 to b+1 do
           begin
           asm
            finit
            fld y
            fld x
            fmul
            fstp x
           end;
           y := a;
          end;
       calcula_fatorial := round(x);
     end;
end;

//Função que calcula o logaritmo
function calcula_logaritmo  (valor : real) : real;
var
   x : real;
begin
     asm
        finit
        fld valor
        fld1
        fxch
        fyl2x
        fldl2t
        fdiv
        fstp x
     end;
     calcula_logaritmo := x;
end;

//Função que calcula o exponencial
function calcula_exponencial  (valor : real) : real;
var
   x : real;
   e : real = 2.718281;
begin
     if (valor >= 0) then   //Potencia positiva
         x := calcula_potencia(e,valor)
     else        //Potencia negativa
         begin
             valor *= -1;
             x := calcula_potencia(e,valor);
             x := calcula_inverso(x);
         end;
     calcula_exponencial := x;
end;

//Função que soma dois valores
function calcula_soma  (op1, op2 : real) : real;
var
   x : real;
begin
     asm
     finit
     fld op1
     fld op2
     fadd
     fstp x
     end;
     calcula_soma := x;
end;

 //Função que subtrai dois valores
function calcula_subtrai  (op1, op2 : real) : real;
var
   x : real;
begin
     asm
     finit
     fld op1
     fld op2
     fsub
     fstp x
     end;
     calcula_subtrai := x;
end;

//Função que multiplica dois valores
function calcula_multiplica  (op1, op2 : real) : real;
var
   x : real;
begin
     asm
     finit
     fld op1
     fld op2
     fmul
     fstp x
     end;
     calcula_multiplica := x;
end;

//Função que divide dois valores
function calcula_divide  (op1, op2 : real) : real;
var
   x : real;
begin
     asm
     finit
     fld op1
     fld op2
     fdiv
     fstp x
     end;
     calcula_divide := x;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  if (Label1.Caption <> '0') then
    begin
     operador := 0;
     Label1.Caption:=Concat(Label1.Caption,'0');
    end;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
    parenteses += 1;
    if(Label1.Caption = '0') then
       Label1.Caption:='('
    else
       Label1.Caption:=Concat(Label1.Caption,'(');
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
     if (parenteses <> 0 ) then
     begin
       Label1.Caption:=Concat(Label1.Caption,')');
       parenteses -= 1;
     end;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  if(Label1.Caption = '0') then
      begin
      Label1.Caption:='0-';
      operador := 1;
      end
   else if (operador <> 1) then
     begin
       Label1.Caption:=Concat(Label1.Caption,'-');
       operador := 1;
     end;
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
  if(Label1.Caption = '0') then
      begin
      Label1.Caption:='0*';
      operador := 1;
      end
   else if (operador <> 1) then
     begin
       Label1.Caption:=Concat(Label1.Caption,'*');
       operador := 1;
     end;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
  if(Label1.Caption = '0') then
      begin
      Label1.Caption:='0/';
      operador := 1;
      end
   else if (operador <> 1) then
     begin
       Label1.Caption:=Concat(Label1.Caption,'/');
       operador := 1;
     end;
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
   if(Label1.Caption = '0') then
      begin
      Label1.Caption:='0+';
      operador := 1;
      end
   else if (operador <> 1) then
     begin
       Label1.Caption:=Concat(Label1.Caption,'+');
       operador := 1;
     end;
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
  if(Label1.Caption = '0')then
       Label1.Caption := 'ln'
   else
       Label1.Caption:=Concat(Label1.Caption,'ln');
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
  if(Label1.Caption = '0')then
       Label1.Caption := 'log'
   else
       Label1.Caption:=Concat(Label1.Caption,'log');
end;

procedure TForm1.Button19Click(Sender: TObject);
begin
    if(Label1.Caption = '0')then
       Label1.Caption := 'fat'
   else
       Label1.Caption:=Concat(Label1.Caption,'fat');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   if(Label1.Caption = '0') then
     begin
       operador := 0;
       Label1.Caption:='1';
     end
   else
     begin
       operador := 0;
       Label1.Caption:=Concat(Label1.Caption,'1');
     end;
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
    if(Label1.Caption = '0')then
       Label1.Caption := 'inv'
    else
       Label1.Caption:=Concat(Label1.Caption,'inv');
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
  if(Label1.Caption = '0') then
     begin
       operador := 0;
       if (CheckBox1.Checked = true)then
           Label1.Caption:='tan⁻¹'
       else
           Label1.Caption:='tan';
     end
   else
     begin
       operador := 0;
       if (CheckBox1.Checked = true)then
           Label1.Caption:=Concat(Label1.Caption,'tan⁻¹')
       else
          Label1.Caption:=Concat(Label1.Caption,'tan')

     end;
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
  if(Label1.Caption = '0') then
     begin
       operador := 0;
       if (CheckBox1.Checked = true)then
           Label1.Caption:='cos⁻¹'
       else
           Label1.Caption:='cos';
     end
   else
     begin
       operador := 0;
       if (CheckBox1.Checked = true)then
           Label1.Caption:=Concat(Label1.Caption,'cos⁻¹')
       else
          Label1.Caption:=Concat(Label1.Caption,'cos')

     end;
end;

procedure TForm1.Button23Click(Sender: TObject);
begin
   if(Label1.Caption = '0') then
     begin
       operador := 0;
       if (CheckBox1.Checked = true)then
           Label1.Caption:='sin⁻¹'
       else
           Label1.Caption:='sin';
     end
   else
     begin
       operador := 0;
       if (CheckBox1.Checked = true)then
           Label1.Caption:=Concat(Label1.Caption,'sin⁻¹')
       else
          Label1.Caption:=Concat(Label1.Caption,'sin')

     end;
end;

procedure TForm1.Button24Click(Sender: TObject);
begin
  if(Label1.Caption = '0')then
       Label1.Caption := 'sqrte'
   else
       Label1.Caption:=Concat(Label1.Caption,'sqrte');
end;

//Expressão usada no Parser (Tangente)
procedure ExprTan(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if (Form1.RadioButton1.Checked) then
     Result.resFloat := calcula_tangente(x,1,1)
  else
     Result.resFloat := calcula_tangente(x,2,1);
end;

//Expressão usada no Parser (Arco-Tangente)
procedure ExprTanI(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if (Form1.RadioButton1.Checked) then
     Result.resFloat := calcula_tangente(x,1,2)
  else
     Result.resFloat := calcula_tangente(x,2,2);
end;

//Expressão usada no Parser (Seno)
procedure ExprSen(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if (Form1.RadioButton1.Checked) then
     Result.resFloat := calcula_seno(x,1,1)
  else
     Result.resFloat := calcula_seno(x,2,1);
end;

//Expressão usada no Parser (Arco-Seno)
procedure ExprSenI(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if (Form1.RadioButton1.Checked) then
     Result.resFloat := calcula_seno(x,1,2)
  else
     Result.resFloat := calcula_seno(x,2,2);
end;

//Expressão usada no Parser (Cosseno)
procedure ExprCos(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if (Form1.RadioButton1.Checked) then
     Result.resFloat := calcula_cosseno(x,1,1)
  else
     Result.resFloat := calcula_cosseno(x,2,1);
end;

//Expressão usada no Parser (Arco-Cosseno)
procedure ExprCosI(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if (Form1.RadioButton1.Checked) then
     Result.resFloat := calcula_cosseno(x,1,2)
  else
     Result.resFloat := calcula_cosseno(x,2,2);
end;

 //Expressão usada no Parser (Ln)
procedure ExprLn(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  Result.resFloat := calcula_ln(x);
end;

  //Expressão usada no Parser (Logaritmo)
procedure ExprLog(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  Result.resFloat := calcula_logaritmo(x);
end;

//Expressão usada no Parser (Exponencial)
procedure ExprExp(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  Result.resFloat := calcula_exponencial(x);
end;

//Expressão usada no Parser (Raiz Quadrada)
procedure ExprRaizQ(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  Result.resFloat := calcula_raiz_quadrada (x);
end;

//Expressão usada no Parser (Quadrado)
procedure ExprQuadrado(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  Result.resFloat := calcula_quadrado(x);
end;

 //Expressão usada no Parser (Potencia)
procedure ExprPot(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
  y: Double;
begin
  x := ArgToFloat(Args[0]);
  y := ArgToFloat(Args[1]);
  Result.resFloat := calcula_potencia(x,y);
end;

//Expressão usada no Parser (Fatorial)
procedure ExprFat(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
 x: Double;
begin
 x := ArgToFloat(Args[0]);
 Result.resFloat := calcula_fatorial(x);
end;

 //Expressão usada no Parser (1/x)
procedure ExprInv(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
 x: Double;
begin
 x := ArgToFloat(Args[0]);
 Result.resFloat := calcula_inverso(x);
end;

//Expressão usada no Parser (Raiz Enésima)
procedure ExprRaizE(var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
  y: Double;
begin
  x := ArgToFloat(Args[0]);
  y := ArgToFloat(Args[1]);
  y := calcula_inverso(y);
  Result.resFloat := calcula_potencia_decimal(x,y);
end;

//Botão "=" quando o usuário insere uma expressão e aparte esse botão
//é calculado o resultado da expressão matemática inserida

// É utilizado um Parser para pegar a expressão inserida pelo o usuáio e quebrar em tokens
//para ser calculado, funciona semelhante a notação Polonesa.
//A expressão é avaliada e os operadores com maior precedência são colocados no
//topo de uma pilha para ser calculado.
procedure TForm1.Button25Click(Sender: TObject);
begin
  if (Label1.Caption = '0') then
     Label1.Caption := '0'
  else
       begin
          FParser := TFPExpressionParser.Create(nil); //Cria um Parser para ler
                                                     //e avaliar a expressão
                                                     //inserida pelo o usuário
          try
            FParser.BuiltIns := [bcMath];            //Parser criado para reconhecer expressões matemáticas
            FParser.Identifiers.AddFunction('tan', 'F', 'F', @ExprTan);
            FParser.Identifiers.AddFunction('tan⁻¹', 'F', 'F', @ExprTanI); //Adiciona as expressões
            FParser.Identifiers.AddFunction('sin', 'F', 'F', @ExprSen);    //matemáticas, calculadas em Assembly,
            FParser.Identifiers.AddFunction('sin⁻¹', 'F', 'F', @ExprSenI); //Para o Parser reconhece-las
            FParser.Identifiers.AddFunction('cos', 'F', 'F', @ExprCos);
            FParser.Identifiers.AddFunction('cos⁻¹', 'F', 'F', @ExprCosI);
            FParser.Identifiers.AddFunction('ln', 'F', 'F', @ExprLn);
            FParser.Identifiers.AddFunction('log', 'F', 'F', @ExprLog);
            FParser.Identifiers.AddFunction('e', 'F', 'F', @ExprExp);
            FParser.Identifiers.AddFunction('sqrt', 'F', 'F', @ExprRaizQ);
            FParser.Identifiers.AddFunction('sqr', 'F', 'F', @ExprQuadrado);
            FParser.Identifiers.AddFunction('pot', 'F', 'FF', @ExprPot);
            FParser.Identifiers.AddFunction('fat', 'F', 'F', @ExprFat);
            FParser.Identifiers.AddFunction('inv', 'F', 'F', @ExprInv);
            FParser.Identifiers.AddFunction('sqrte', 'F', 'FF', @ExprRaizE);
            FParser.Expression := Label1.Caption;
            parserResult := FParser.Evaluate; //Parser lê a expressão que o usuário inseriu
            resultValue := ArgToFloat(parserResult); //e calcula o resultado usando as funções em Assembly
            Label1.Caption:=FloatToStr(resultValue);
          finally
            FParser.Free;
        end;
     end;
end;

procedure TForm1.Button26Click(Sender: TObject);
begin
  if(Label1.Caption = '0')then
       Label1.Caption := 'sqrt'
   else
       Label1.Caption:=Concat(Label1.Caption,'sqrt');
end;

procedure TForm1.Button27Click(Sender: TObject);
begin
   if(Label1.Caption = '0')then
       Label1.Caption := 'sqr'
   else
       Label1.Caption:=Concat(Label1.Caption,'sqr');
end;

procedure TForm1.Button28Click(Sender: TObject);
begin
    if(Label1.Caption = '0')then
       Label1.Caption := 'pot'
   else
       Label1.Caption:=Concat(Label1.Caption,'pot');
end;

procedure TForm1.Button29Click(Sender: TObject);
begin
   if(Label1.Caption = '0')then
       Label1.Caption := 'e'
   else
       Label1.Caption:=Concat(Label1.Caption,'e');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    if(Label1.Caption = '0') then
     begin
       operador := 0;
       Label1.Caption:='2';
     end
   else
     begin
       operador := 0;
       Label1.Caption:=Concat(Label1.Caption,'2');
     end;
end;

procedure TForm1.Button30Click(Sender: TObject);
begin
    if(Label1.Caption = '0') then
     begin
       operador := 0;
       Label1.Caption:='3.1415';
     end
   else
     begin
       operador := 0;
       Label1.Caption:=Concat(Label1.Caption,'3.1415');
     end;
end;

procedure TForm1.Button31Click(Sender: TObject);
begin
    if(Label1.Caption = '0') then
      Label1.Caption:='0.'
   else
       Label1.Caption:=Concat(Label1.Caption,'.');
end;

procedure TForm1.Button32Click(Sender: TObject);
var
   s : string;
   t : Integer;
begin
     s := Label1.Caption;
     t := Length(Label1.Caption);
     if(t = 1) then
      Label1.Caption:='0'
     else
       begin
         if(s[t] = ')') then
            parenteses += 1
         else if (s[t] = '(') then
            parenteses -= 1
         else if ( (s[t] = '-') or (s[t] = '+') or (s[t] = '*') or (s[t] = '/') ) then
            operador := 0;
         Delete(s,t,1);
         Label1.Caption:=s;
       end;
end;

procedure TForm1.Button33Click(Sender: TObject);
begin
     Label1.Caption:=Concat(Label1.Caption,',');
end;

procedure TForm1.Button34Click(Sender: TObject);
begin
   Label1.Caption:='0';
   operador  := 0;
   parenteses  := 0;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    if(Label1.Caption = '0') then
     begin
       operador := 0;
       Label1.Caption:='3';
     end
   else
     begin
       operador := 0;
       Label1.Caption:=Concat(Label1.Caption,'3');
     end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
    if(Label1.Caption = '0') then
     begin
       operador := 0;
       Label1.Caption:='4';
     end
   else
     begin
       operador := 0;
       Label1.Caption:=Concat(Label1.Caption,'4');
     end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
    if(Label1.Caption = '0') then
     begin
       operador := 0;
       Label1.Caption:='5';
     end
   else
     begin
       operador := 0;
       Label1.Caption:=Concat(Label1.Caption,'5');
     end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
    if(Label1.Caption = '0') then
     begin
       operador := 0;
       Label1.Caption:='6';
     end
   else
     begin
       operador := 0;
       Label1.Caption:=Concat(Label1.Caption,'6');
     end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
    if(Label1.Caption = '0') then
     begin
       operador := 0;
       Label1.Caption:='7';
     end
   else
     begin
       operador := 0;
       Label1.Caption:=Concat(Label1.Caption,'7');
     end;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
    if(Label1.Caption = '0') then
     begin
       operador := 0;
       Label1.Caption:='8';
     end
   else
     begin
       operador := 0;
       Label1.Caption:=Concat(Label1.Caption,'8');
     end;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
   if(Label1.Caption = '0') then
     begin
       operador := 0;
       Label1.Caption:='9';
     end
   else
     begin
       operador := 0;
       Label1.Caption:=Concat(Label1.Caption,'9');
     end;
end;

end.

