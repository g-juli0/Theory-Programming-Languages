(* Shift a single character by n positions *)
fun shiftChar (c: char, shift: int) : char =
  let
    val code = ord c
    val baseUpper = ord #"A"
    val baseLower = ord #"a"
    fun mod26 n = if n < 0 then mod26 (n + 26) else n mod 26
  in
    if code >= ord #"A" andalso code <= ord #"Z" then
      chr (baseUpper + mod26 (code - baseUpper + shift))
    else if code >= ord #"a" andalso code <= ord #"z" then
      chr (baseLower + mod26 (code - baseLower + shift))
    else
      c
  end

(* Encrypt a string by shifting each character *)
fun encrypt (text: string, shift: int) : string =
  String.implode (List.map (fn c => shiftChar (c, shift)) (String.explode text))

(* Decrypt a string by shifting in the opposite direction *)
fun decrypt (text: string, shift: int) : string =
  encrypt (text, ~shift)

(* Brute force all possible Caesar shifts *)
fun bruteForce (text: string) : unit =
  let
    fun tryShifts n =
      if n > 26 then ()
      else (
        print ("Shift " ^ Int.toString n ^ ": " ^ encrypt(text, 26 - n) ^ "\n");
        tryShifts (n + 1)
      )
  in
    tryShifts 1
  end

(* Example I/O interaction *)
val () =
  let
    val _ = print "Enter text to encrypt: "
    val inputEnc = TextIO.inputLine TextIO.stdIn |> valOf |> String.trim
    val _ = print "Enter shift value: "
    val shiftEnc = TextIO.inputLine TextIO.stdIn |> valOf |> Int.fromString |> valOf
    val encrypted = encrypt(inputEnc, shiftEnc)
    val _ = print ("Encrypted text: " ^ encrypted ^ "\n\n")

    val _ = print "Enter text to decrypt: "
    val inputDec = TextIO.inputLine TextIO.stdIn |> valOf |> String.trim
    val _ = print "Enter shift value: "
    val shiftDec = TextIO.inputLine TextIO.stdIn |> valOf |> Int.fromString |> valOf
    val decrypted = decrypt(inputDec, shiftDec)
    val _ = print ("Decrypted text: " ^ decrypted ^ "\n\n")

    val _ = print "Enter text for brute-force solve: "
    val inputBrute = TextIO.inputLine TextIO.stdIn |> valOf |> String.trim
    val _ = print "Solving the cipher with all 26 possible shifts:\n"
    val _ = bruteForce inputBrute
  in
    ()
  end