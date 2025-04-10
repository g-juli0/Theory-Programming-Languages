import scala.io.StdIn.readLine

object CaesarCipher {

  def shiftChar(c: Char, shift: Int): Char = {
    val code = c.toInt
    if (c.isUpper) {
      ('A' + (code - 'A' + shift) % 26).toChar
    } else if (c.isLower) {
      ('a' + (code - 'a' + shift) % 26).toChar
    } else {
      c
    }
  }

  def encrypt(text: String, shift: Int): String = {
    def recurse(chars: List[Char]): String = chars match {
      case Nil => ""
      case head :: tail => shiftChar(head, shift) + recurse(tail)
    }
    recurse(text.toList)
  }

  def decrypt(text: String, shift: Int): String = {
    encrypt(text, (26 - shift % 26) % 26)
  }

  def bruteForce(text: String, shift: Int = 1): Unit = {
    if (shift > 26) ()
    else {
      val paddedShift = if (shift < 10) s" $shift" else s"$shift"
      println(s"Shift $paddedShift: ${decrypt(text, shift)}")
      bruteForce(text, shift + 1)
    }
  }

  def main(args: Array[String]): Unit = {
    val toEncrypt = readLine("Enter text to encrypt: ")
    val shiftEncrypt = readLine("Enter shift value: ").toInt
    val encrypted = encrypt(toEncrypt, shiftEncrypt)
    println(s"Encrypted text: ${encrypted.toUpperCase()}\n")

    val toDecrypt = readLine("Enter text to decrypt: ")
    val shiftDecrypt = readLine("Enter shift value: ").toInt
    val decrypted = decrypt(toDecrypt, shiftDecrypt)
    println(s"Decrypted text: ${decrypted.toUpperCase()}\n")

    val toBrute = readLine("Enter text for brute-force solve: ")
    println("Solving the cipher with all 26 possible shifts:")
    bruteForce(toBrute)
  }
}