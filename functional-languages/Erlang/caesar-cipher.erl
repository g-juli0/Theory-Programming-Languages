-module(caesar).
-export([main/1, encrypt/2, decrypt/2, brute_force/1]).

%%% Escript entry point
main(_Args) ->
    %% Encrypt section
    EncryptInput = prompt("Enter text to encrypt: "),
    ShiftEncrypt = get_shift_value(),
    Encrypted = encrypt(EncryptInput, ShiftEncrypt),
    io:format("\nEncrypted text: ~s~n~n", [Encrypted]),

    %% Decrypt section
    DecryptInput = prompt("Enter text to decrypt: "),
    ShiftDecrypt = get_shift_value(),
    Decrypted = decrypt(DecryptInput, ShiftDecrypt),
    io:format("\nDecrypted text: ~s~n~n", [Decrypted]),

    %% Brute-force section
    BruteInput = prompt("Enter text for brute-force solve: "),
    io:format("\nSolving the cipher with all 26 possible shifts:~n"),
    brute_force(BruteInput).

%%% Prompt and read trimmed line of input
prompt(Message) ->
    io:format("~s", [Message]),
    string:trim(io:get_line("")).

%%% Prompt for Caesar shift
get_shift_value() ->
    io:format("\nEnter shift value: "),
    {ok, [Shift]} = io:fread("", "~d"),
    Shift rem 26.

%%% Encrypt text with Caesar shift
encrypt(Text, Shift) ->
    lists:map(fun(Char) -> shift_char(Char, Shift) end, Text).

%%% Decrypt = encrypt with (26 - shift)
decrypt(Text, Shift) ->
    encrypt(Text, 26 - (Shift rem 26)).

%%% Brute force all Caesar shifts
brute_force(Text) ->
    brute_force_loop(Text, 1).

brute_force_loop(_, 27) -> ok;
brute_force_loop(Text, Shift) ->
    Dec = decrypt(Text, Shift),
    io:format("Shift ~2w: ~s~n", [Shift, Dec]),
    brute_force_loop(Text, Shift + 1).

%%% Shift a single character
shift_char(Char, Shift) when Char >= $A, Char =< $Z ->
    $A + ((Char - $A + Shift) rem 26);
shift_char(Char, Shift) when Char >= $a, Char =< $z ->
    $a + ((Char - $a + Shift) rem 26);
shift_char(Char, _Shift) ->
    Char.