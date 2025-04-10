const readline = require('readline');

// setup I/O
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function shiftChar(c, shift) {
  // constants for easier read and writability
  const A = 'A'.charCodeAt(0);
  const Z = 'Z'.charCodeAt(0);
  const a = 'a'.charCodeAt(0);
  const z = 'z'.charCodeAt(0);
  const code = c.charCodeAt(0);

  // uppercase
  if (code >= A && code <= Z) {
    return String.fromCharCode(A + ((code - A + shift) % 26));
  // lowercase
  } else if (code >= a && code <= z) {
    return String.fromCharCode(a + ((code - a + shift) % 26));
  // other chars
  } else {
    return c;
  }
}

// if no chars left to encrypt, return accumulator
// otherwise, recurse through the rest of the chars and add shifted char to acc
function encrypt(text, shift) {
  const recurse = (chars, acc) =>
    chars.length === 0 ? acc : recurse(chars.slice(1), acc + shiftChar(chars[0], shift));
  return recurse(text.split(''), '');
}

// reverses encrypt function
function decrypt(text, shift) {
  return encrypt(text, (26 - (shift % 26)) % 26);
}

// brute-forces encryption by calling decrypt recursively with all 26 possible shifts
function bruteForce(text, shift = 1) {
  if (shift > 26) return;
  console.log(`Shift ${shift < 10 ? ' ' : ''}${shift}: ${decrypt(text, shift)}`);
  bruteForce(text, shift + 1);
}

// simplifies user input by calling the callback function with the answer
function ask(question, callback) {
  rl.question(question, answer => callback(answer));
}

// main function - encrypts, decrypts, brute-forces
function main() {
  ask('\nEnter text to encrypt: ', textToEncrypt => {
    ask('\nEnter shift value: ', shiftEncrypt => {
      const encrypted = encrypt(textToEncrypt, parseInt(shiftEncrypt));
      console.log(`\nEncrypted text: ${encrypted.toUpperCase()}\n`);

      ask('\nEnter text to decrypt: ', textToDecrypt => {
        ask('\nEnter shift value: ', shiftDecrypt => {
          const decrypted = decrypt(textToDecrypt, parseInt(shiftDecrypt));
          console.log(`\nDecrypted text: ${decrypted.toUpperCase()}\n`);

          ask('\nEnter text for brute-force solve: ', textToBrute => {
            console.log('\nSolving the cipher with all 26 possible shifts:');
            bruteForce(textToBrute);
            rl.close();
          });
        });
      });
    });
  });
}

main();
