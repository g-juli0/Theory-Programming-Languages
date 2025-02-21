program CaesarCipher;

uses crt;

var
  input: string;
  shift: integer;

procedure Encrypt(var text: string; shift: integer);
var
  i, ascii: integer;
  output: string;
begin
  output := text;
  for i := 1 to Length(text) do
  begin
    ascii := Ord(text[i]);
    if (ascii >= Ord('a')) and (ascii <= Ord('z')) then
      ascii := ascii - Ord('a') + Ord('A');
    if (ascii >= Ord('A')) and (ascii <= Ord('Z')) then
      ascii := ((ascii - Ord('A') + shift) mod 26) + Ord('A');
    output[i] := Chr(ascii);
  end;
  writeln('Encrypted text: ', output);
end;

procedure Decrypt(var text: string; shift: integer);
var
  i, ascii: integer;
  output: string;
begin
  output := text;
  for i := 1 to Length(text) do
  begin
    ascii := Ord(text[i]);
    if (ascii >= Ord('a')) and (ascii <= Ord('z')) then
      ascii := ascii - Ord('a') + Ord('A');
    if (ascii >= Ord('A')) and (ascii <= Ord('Z')) then
      ascii := ((ascii - Ord('A') - shift + 26) mod 26) + Ord('A');
    output[i] := Chr(ascii);
  end;
  writeln('Decrypted text: ', output);
end;

procedure Solve(var text: string);
var
  i, j, ascii: integer;
  output: string;
begin
  writeln('Solving the cipher with all 26 possible shifts:');
  for i := 1 to 26 do
  begin
    output := text;
    for j := 1 to Length(text) do
    begin
      ascii := Ord(text[j]);
      if (ascii >= Ord('a')) and (ascii <= Ord('z')) then
        ascii := ascii - Ord('a') + Ord('A');
      if (ascii >= Ord('A')) and (ascii <= Ord('Z')) then
        ascii := ((ascii - Ord('A') - i + 26) mod 26) + Ord('A');
      output[j] := Chr(ascii);
    end;
    writeln('Shift ', i, ': ', output);
  end;
end;

begin
  clrscr;
  writeln('Enter text to encrypt: ');
  readln(input);
  writeln('Enter shift value: ');
  readln(shift);
  Encrypt(input, shift);
  
  writeln('Enter text to decrypt: ');
  readln(input);
  writeln('Enter shift value: ');
  readln(shift);
  Decrypt(input, shift);
  
  writeln('Enter text for brute-force solve: ');
  readln(input);
  Solve(input);
  
  readln;
end.
