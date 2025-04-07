-module(caesar).
-export([start/0, encrypt/2, decrypt/2, brute_force/1]).

%%% Entry point for full user interaction
start() ->
    %% Encrypt section
    io:format("Enter text to encrypt: "),
    {ok, EncryptInput} = io:read_line(""),
    CleanEncrypt = string:trim(EncryptInput, both),
    ShiftEncrypt = get_shift_value(),
    Encrypted = encrypt(CleanEncrypt, ShiftEncrypt),
    io:format("Encrypted text: ~s~n~n", [Encrypted]),

    %% Decrypt section
    io:format("Enter text to decrypt: "),
    {ok, DecryptInput} = io:read_line(""),
    CleanDecrypt = string:trim(DecryptInput, both),
    ShiftDecrypt = get_shift_value(),
    Decrypted = decrypt(CleanDecrypt, ShiftDecrypt),
    io:format("Decrypted text: ~s~n~n", [Decrypted]),

    %% Brute-force section
    io:format("Enter text for brute-force solve: "),
    {ok, BruteInput} = io:read_line(""),
    CleanBrute = string:trim(BruteInput, both),
    io:format("Solving the cipher with all 26 possible shifts:~n"),
    brute_force(CleanBrute).

%%% Prompt for a numeric Caesar shift
get_shift_value() ->
    io:format("Enter shift value: "),
    {ok, [Shift]} = io:fread("", "~d"),
    Shift rem 26.

%%% Encrypt text with Caesar shift
encrypt(Text, Shift) ->
    lists:map(fun(Char) -> shift_char(Char, Shift) end, Text).

%%% Decrypt = encrypt with (26 - shift)
decrypt(Text, Shift) ->
    encrypt(Text, 26 - (Shift rem 26)).

%%% Brute force all 26 Caesar shifts
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
