program PrumernaTeplota;
uses Crt;
const RADEK = 9; SLOUPEC = 5;

var
  Teplota : array [1..RADEK, 1..SLOUPEC] of real;
  I,K,x, dny, pocet : integer;
  Soucet, Prumer, Hodnota : real;
begin
  Soucet := 0;
  write('Zadejte pozadovany pocet dni (max ', RADEK,'): ');
  read(dny);
  if(dny>9)
  then
      begin
        TextColor(red);
        writeln('<!> Zadali jste vetsi hodnotu nez je dovoleno <!>');
        TextColor(white);
        writeln('Stiknete jakoukoliv klavesu pro vypnuti programu. . .');
        Readkey();
        Exit;
      end;

  write('Zadejte kolikrat merite za den teplotu (max ', SLOUPEC ,'): ');
  read(pocet);
  if(pocet>5)
  then
      begin
        TextColor(red);
        writeln('<!> Zadali jste vetsi hodnotu nez je dovoleno <!>');
        TextColor(white);
        writeln('Stiknete jakoukoliv klavesu pro vypnuti programu. . .');
        Readkey();
        Exit;
      end;
  //---
  x:=1;
  for I:=1 to dny do

      for K:=1 to pocet do
       begin
         write('Zadejte ', x, '. hodnotu teploty: ');
         readln(Hodnota);
         Soucet:=Soucet+Hodnota;
         x:=x+1;
         Teplota[I,K]:=Hodnota;
       end;
    //---
    for I:=1 to dny do
     begin
       for K:=1 to pocet do
        write(Teplota[I,K]:8:2);
        writeln();
     end;
  //---
  Prumer:=Soucet/(I*K);
  writeln('Prumerna teplota ze ',I*K,' hodnot je : ',Prumer:2:2, 'stupnu Celsia');
  readln;
end.
