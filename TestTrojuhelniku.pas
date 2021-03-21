program TestTrojuhelniku;
uses Crt;

var
  a, b, c : integer;

begin
 writeln('----');
 writeln('Program na test sestrojeni trojuhelniku');
 writeln('----');
 write('Zadejte stranu a: ');
 readln(a);
 write('Zadejte stranu b: ');
 readln(b);
 write('Zadejte stranu c: ');
 readln(c);
 if(a+b>c)
 then
     begin
       if(b+c>a)
       then
           if(c+a>b)
           then
               writeln('Trojuhlenik LZE sestrojit')
           else
             writeln('Trojuhlenik NELZE sestrojit')
       else
         writeln('Trojuhlenik NELZE sestrojit');
     end
 else
 writeln('Trojuhlenik NELZE sestrojit');
 readkey();

end.
