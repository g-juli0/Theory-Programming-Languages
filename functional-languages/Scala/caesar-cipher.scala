import scala.io.StdIn.readLine

object CaesarCipher {

  def shiftChar(c: Char, shift: Int): Char = {
    val code = c.toInt

    // uppercase
    if (c.isUpper) {
      ('A' + (code - 'A' + shift) % 26).toChar
    // lowercase
    } else if (c.isLower) {
      ('a' + (code - 'a' + shift) % 26).toChar
    // other chars
    } else {
      c
    }
  }

    /**
     * encrypts the given text using the Caesar cipher with the specified shift
     * if the string is empty, return
     * otherwise, reecursively call shift function and add the encrypted char to the result
     *
     * @param text the text to encrypt
     * @param shift number of positions to shift each char
     * @return encrypted text
     */
  def encrypt(text: String, shift: Int): String = {
    def recurse(chars: List[Char]): String = chars match {
      case Nil => ""
      case head :: tail => shiftChar(head, shift) + recurse(tail)
    }
    recurse(text.toList)
  }

  /**
   * decrypts the given text using the Caesar cipher with the specified shift
   * reverses encrypt function by shifting char in the opposite direction
   *
   * @param text the text to decrypt
   * @param shift number of positions to shift each char
   * @return decrypted text
   */
  def decrypt(text: String, shift: Int): String = {
    encrypt(text, (26 - shift % 26) % 26)
  }

  /**
   * brute-force calls decrypt with all 26 possible shifts
   *
   * @param text the text to decrypt
   * @param shift number of positions to shift each char
   */
  def bruteForce(text: String, shift: Int = 1): Unit = {
    if (shift > 26) ()
    else {
      val paddedShift = if (shift < 10) s" $shift" else s"$shift"
      println(s"Shift $paddedShift: ${decrypt(text, shift)}")
      bruteForce(text, shift + 1)
    }
  }

  /**
   * main function
   * encrypt, decrypt, brute-force solve
   *
   * @param args command line arguments (not used)
   */
  def main(args: Array[String]): Unit = {
    val toEncrypt = readLine("Enter text to encrypt: ")
    val shiftEncrypt = readLine("\nEnter shift value: ").toInt
    val encrypted = encrypt(toEncrypt, shiftEncrypt)
    println(s"\nEncrypted text: ${encrypted.toUpperCase()}\n")

    val toDecrypt = readLine("\nEnter text to decrypt: ")
    val shiftDecrypt = readLine("\nEnter shift value: ").toInt
    val decrypted = decrypt(toDecrypt, shiftDecrypt)
    println(s"\nDecrypted text: ${decrypted.toUpperCase()}\n")

    val toBrute = readLine("\nEnter text for brute-force solve: ")
    println("\nSolving the cipher with all 26 possible shifts:")
    bruteForce(toBrute)
  }
}