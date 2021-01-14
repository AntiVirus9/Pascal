program matrix;
uses Crt;

      // maximalni hodnota, kterou muze nabyvat barva
const MAX_HODNOTA_BARVA = 10;
      // limit pro zobrazeni svetle barvy kodu
      LIMIT_SVETLE_ZELENA = 6;
      // limit pro zobrazeni tmave barvy kodu
      LIMIT_TMAVE_ZELENA = 3;
      // udava rozpeti v delce svetleho proudu, ktery steka po obrazovce
      ROZPTYL_PROUDU = 3;

      // sirka a vyska obrazovky (velikost okna konzole)
      MAX_SIRKA_OBRAZOVKA_X = 80;
      MAX_VYSKA_OBRAZOVKA_Y = 25;

    // promenne pro ulozeni nahodne generovanych pozic na obrazovce
var poziceX, poziceY : Integer;
    // pole pro ulozeni barev, ktere 'stekaji' dolu v proudech po obrazovce
    obrazovkaBarvyPole : array[1..MAX_VYSKA_OBRAZOVKA_Y,
                              1..MAX_SIRKA_OBRAZOVKA_X] of Byte;
    // pocitadlo pruchodu v cyklech s podminkou
    pocitadlo : Integer;


// procedura vygeneruje nahodne novy radek s cisly pro ruzne barvy
procedure NovyRadek(vypnout : Boolean);
    // index pro pole, nahodne cislo
var x, nahodneCislo : Integer;
begin
   // projdi indexy celeho vrchniho radku
   for x:=1 to MAX_SIRKA_OBRAZOVKA_X do
      begin
         // vygeneruje se nahodne cislo 0-14, sance 1/15 pro novy proud, když se vylosuje 0
         nahodneCislo := Random(15);

         // pokud je vygenerovana 0 a vypnout není TRUE tak
         if(nahodneCislo = 0) and (not vypnout) then
            begin
              // generuje se cislo od 1 do 3, proud bude mit vzdy delku
              // MAX_HODNOTA_BARVA - (1 az 3)
              nahodneCislo := Random(MAX_HODNOTA_BARVA-(MAX_HODNOTA_BARVA-ROZPTYL_PROUDU))+1;

              // cislo se zapise do pole
              obrazovkaBarvyPole[1, x] := (MAX_HODNOTA_BARVA-ROZPTYL_PROUDU)+nahodneCislo;

            end
         // pokud neni hodnota na predchazejicim radku na 0
         else if (obrazovkaBarvyPole[2,x]>0) then
            // uloz do polozky pole hodnotu o 1 mensi
            obrazovkaBarvyPole[1,x]:= obrazovkaBarvyPole[2,x]-1
         // jinak hodnota barvy zustava na 0
         else
            obrazovkaBarvyPole[1,x]:= 0;
      end;
end;

// posune obsah pole s cisly pro barvy o jeden radek dolu (jako posuvny registr)
procedure PosunRadkyBarvy(vypnout : Boolean);
var y, x : Integer;
begin
   // posune obsah celeho pole o jeden radek dolu
   for y:=MAX_VYSKA_OBRAZOVKA_Y downto 1 do
     // posune jeden radek dolu
     for x:=1 to MAX_SIRKA_OBRAZOVKA_X do
        // posune jednu polozku dolu
        obrazovkaBarvyPole[y,x]:=obrazovkaBarvyPole[y-1,x];

   // vygeneruje se novy radek
   NovyRadek(vypnout);
end;

// vypise barevne znak na pozadovane pozici
procedure VypisZnak(znak : Char; poziceX, poziceY : Integer);
begin
   // kdyz je hodnota pro barvu v poli barev vetsi nez limit pro svetle zelenou
   if(obrazovkaBarvyPole[poziceY, poziceX]>LIMIT_SVETLE_ZELENA) then
     // nastavime svetle zelenou barvu
     TextColor(LightGreen)
   // jinak kdyz je hodnota v poli vyssi nez limit pro zelenou
   else if(obrazovkaBarvyPole[poziceY, poziceX]>LIMIT_TMAVE_ZELENA) then
     // nastavime zelenou barvu
     TextColor(Green)
   // jinak limity se nesplnili
   else
     // nastavime cernou barvu
     TextColor(Black);

   // presunout kurzor na pozici
   GotoXY(poziceX, poziceY);
   // zapsat znak
   Write(znak);
end;

begin
  // nastavi 'nahodne' generator pseudonahodnych cisel
  Randomize;
  // vypne zobrazovani kurzoru
  Cursoroff;
  // vynulovat pocitadlo
  pocitadlo:=0;

  // opakuj - 1. faze matrixu
  repeat
    poziceX := Random(80)+1;
    poziceY := Random(24)+1;

    // presuneme kurzor na nahodnou pozici
    // pozice je od 1 do 80 pro sloupec(X) a od 1 do 24 pro radek(Y)
    GotoXY(poziceX, poziceY);

    // vypiseme nahodny znak od 0 do 1
    VypisZnak(Chr(Random(2)+48),poziceX, poziceY);


    pocitadlo:=pocitadlo+1;

    // kdyz pocitadlo dosahne hodnoty rovne nebo vyssi 2000
    // - se prekreslily vsechny znaky
    if(pocitadlo >= 2000) then
      begin
        // posunou se barvy o jeden radek dolu
        PosunRadkyBarvy(false);
        // pocitadlo se vynuluje
        pocitadlo := 0;
      end;

  // dokud neni stisknuta klavesa
  until (KeyPressed());

  // precist znak z klavesnice, jinak druhy cyklus hned skonci
  ReadKey();

  //............................................................................
  // opakuj - 2. faze matrixu
 repeat
    poziceX := Random(80)+1;
    poziceY := Random(24)+1;

    // presuneme kurzor na nahodnou pozici
    GotoXY(poziceX, poziceY);

    // pokud je vygenerovan radek 13
    if(poziceY = 13)then
      begin
        TextColor(LightGreen);

        // pokud je generovana konkretni pozice (poziceX) s pismenem
        case poziceX of
          // zapis pismeno
          27:
            Write('M');
          33:
            Write('A');
          39:
            Write('T');
          45:
            Write('R');
          51:
            Write('I');
          57:
            Write('X');
          // jinak zapis mezeru
          else
              VypisZnak(' ',poziceX, poziceY);
        end;
      end
    // jinak je vygenerovan jiny radek nez 13
    else
          // vypsat nahodny znak 0 (číslo znaku v ASCII 48) nebo 1 (49)
          VypisZnak(Chr(Random(2)+48),poziceX, poziceY);

    // kdyz pocitadlo dosahne hodnoty rovne nebo vyssi 2000
    // - se prekreslily vsechny znaky
    if(pocitadlo >= 2000) then
      begin
        // posunou se barvy o jeden radek dolu
        PosunRadkyBarvy(true);
        // pocitadlo se vynuluje
        pocitadlo := 0;
      end;


    pocitadlo:=pocitadlo+1;
  // dokud neni stisknuta klavesa
  until (KeyPressed());

end.
