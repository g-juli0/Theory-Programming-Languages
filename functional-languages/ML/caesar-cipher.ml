(* Shift a single character *)
fun shiftChar (c: char, shift: int): char =
  let
    val baseA = ord #"A"
    val basea = ord #"a"
    val code = ord c
    val normalizedShift = shift mod 26
  in
    if Char.isUpper c then
      chr (baseA + ((code - baseA + normalizedShift) mod 26))
    else if Char.isLower c then
      chr (basea + ((code - basea + normalizedShift) mod 26))
    else
      c
  end

(* Encrypt by shifting forward *)
fun encrypt (text: string, shift: int): string =
  String.implode (List.map (fn c => shiftChar (c, shift)) (String.explode text))

(* Decrypt by shifting backward *)
fun decrypt (text: string, shift: int): string =
  encrypt (text, 26 - (shift mod 26))

(* Brute force all 26 shifts *)
fun bruteForce (text: string): unit =
  let
    fun loop i =
      if i > 26 then ()
      else (
        print ("Shift " ^ (if i < 10 then " " else "") ^ Int.toString i ^ ": " ^ decrypt (text, i) ^ "\n");
        loop (i + 1)
      )
  in
    print "Solving the cipher with all 26 possible shifts:\n";
    loop 1
  end

(* Prompt utilities *)
fun prompt msg =
  (print msg; TextIO.inputLine TextIO.stdIn |> valOf |> String.trim)

fun promptInt msg =
  (print msg; valOf (Int.fromString (String.trim (valOf (TextIO.inputLine TextIO.stdIn)))))

(* Main function *)
fun main () =
  let
    val toEncrypt = prompt "Enter text to encrypt: "
    val shiftEncrypt = promptInt "Enter shift value: "
    val encrypted = encrypt (toEncrypt, shiftEncrypt)
    val _ = print ("Encrypted text: " ^ String.map Char.toUpper encrypted ^ "\n\n")

    val toDecrypt = prompt "Enter text to decrypt: "
    val shiftDecrypt = promptInt "Enter shift value: "
    val decrypted = decrypt (toDecrypt, shiftDecrypt)
    val _ = print ("Decrypted text: " ^ String.map Char.toUpper decrypted ^ "\n\n")

    val toBrute = prompt "Enter text for brute-force solve: "
    val _ = bruteForce toBrute
  in
    ()
  end