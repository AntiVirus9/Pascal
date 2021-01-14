program ReadFile;
uses
    Crt;
var
  F: TextFile;
  S: string;
  Cislo, Max, Min: Real;
  Pocet: Integer;
begin
  Write('Zadej jmeno souboru: ');
  Readln(S);
  AssignFile(F,S);
  Reset(F);
  Pocet:=0;

  while not SeekEof(F) do
  begin
    Read(F, Cislo);
    Inc(Pocet);
    if Pocet = 1 then
     begin
       Min:=Cislo;
       Max:=Cislo;
     end
    else
     begin
      if Cislo>Max then Max:=Cislo
      else if Cislo<Min then min:=Cislo;
     end;
  end;
  Writeln('Pocet hodnost: ', Pocet);
  Writeln('Min: ', Min:0:2);
  Writeln('Max: ', Max:0:2);
  Readln();
end.   
