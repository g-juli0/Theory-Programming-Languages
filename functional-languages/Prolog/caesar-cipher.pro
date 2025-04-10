:- use_module(library(readutil)).

% shift_char(+Char, +Shift, -ShiftedChar)
shift_char(Char, Shift, ShiftedChar) :-
    char_code(Char, Code),
    ( Code >= 65, Code =< 90 ->
        Base is 65,
        NewCode is ((Code - Base + Shift) mod 26) + Base,
        char_code(ShiftedChar, NewCode)
    ; Code >= 97, Code =< 122 ->
        Base is 97,
        NewCode is ((Code - Base + Shift) mod 26) + Base,
        char_code(ShiftedChar, NewCode)
    ; ShiftedChar = Char ).

% encrypt(+String, +Shift, -Result)
encrypt([], _, []).
encrypt([H|T], Shift, [EH|ET]) :-
    shift_char(H, Shift, EH),
    encrypt(T, Shift, ET).

% decrypt using negative shift
decrypt(Text, Shift, Result) :-
    PosShift is (26 - (Shift mod 26)) mod 26,
    encrypt(Text, PosShift, Result).

% brute_force(+Text, +CurrentShift)
brute_force(_, 27) :- !.
brute_force(Text, Shift) :-
    decrypt(Text, Shift, Result),
    ( Shift < 10 -> format("Shift  ~w: ", [Shift])
    ; format("Shift ~w: ", [Shift]) ),
    atom_chars(Decrypted, Result),
    writeln(Decrypted),
    Next is Shift + 1,
    brute_force(Text, Next).

% uppercase_output(+Chars)
uppercase_output([], []).
uppercase_output([H|T], [U|UT]) :-
    char_type(H, upper), !, U = H,
    uppercase_output(T, UT).
uppercase_output([H|T], [U|UT]) :-
    char_type(H, lower),
    char_code(H, Code),
    UpperCode is Code - 32,
    char_code(U, UpperCode),
    uppercase_output(T, UT).
uppercase_output([H|T], [H|UT]) :-
    \+ char_type(H, alpha),
    uppercase_output(T, UT).

% read line and convert to char list
read_line_chars(Prompt, Chars) :-
    write(Prompt),
    flush_output,
    read_line_to_string(user_input, Str),
    string_chars(Str, Chars).

% main
main :-
    read_line_chars("Enter text to encrypt: ", ToEncrypt),
    write("Enter shift value: "), flush_output,
    read_line_to_string(user_input, ShiftStr1),
    number_string(ShiftEnc, ShiftStr1),
    encrypt(ToEncrypt, ShiftEnc, EncryptedChars),
    uppercase_output(EncryptedChars, UpperEncrypted),
    atom_chars(EncryptedText, UpperEncrypted),
    format("Encrypted text: ~w~n~n", [EncryptedText]),

    read_line_chars("Enter text to decrypt: ", ToDecrypt),
    write("Enter shift value: "), flush_output,
    read_line_to_string(user_input, ShiftStr2),
    number_string(ShiftDec, ShiftStr2),
    decrypt(ToDecrypt, ShiftDec, DecryptedChars),
    uppercase_output(DecryptedChars, UpperDecrypted),
    atom_chars(DecryptedText, UpperDecrypted),
    format("Decrypted text: ~w~n~n", [DecryptedText]),

    read_line_chars("Enter text for brute-force solve: ", ToBrute),
    writeln("Solving the cipher with all 26 possible shifts:"),
    brute_force(ToBrute, 1).
