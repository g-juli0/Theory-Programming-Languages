object CaesarCipher {
  def main(args: Array[String]): Unit = {
    print("Enter text to encrypt: ")
    val inputEncrypt = scala.io.StdIn.readLine()
    print("Enter shift value: ")
    val shiftEncrypt = scala.io.StdIn.readInt()
    println("Encrypted text: " + encrypt(inputEncrypt, shiftEncrypt))

    print("Enter text to decrypt: ")
    val inputDecrypt = scala.io.StdIn.readLine()
    print("Enter shift value: ")
    val shiftDecrypt = scala.io.StdIn.readInt()
    println("Decrypted text: " + decrypt(inputDecrypt, shiftDecrypt))

    print("Enter text for brute-force solve: ")
    val inputSolve = scala.io.StdIn.readLine()
    solve(inputSolve)
  }

  def encrypt(input: String, shift: Int): String = {
    val upperInput = input.toUpperCase
    val encrypted = new StringBuilder

    for (char <- upperInput) {
      if (char.isLetter) {
        val shifted = ((char - 'A' + shift) % 26 + 'A').toChar
        encrypted.append(shifted)
      } else {
        encrypted.append(char)
      }
    }
    encrypted.toString()
  }

  def decrypt(input: String, shift: Int): String = {
    encrypt(input, 26 - (shift % 26))
  }

  def solve(input: String): Unit = {
    println("Solving the cipher with all 26 possible shifts:")
    for (shift <- 1 to 26) {
      println(s"Shift $shift: ${decrypt(input, shift)}")
    }
  }
}
