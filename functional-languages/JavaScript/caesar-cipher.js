const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function shiftChar(c, shift) {
  const A = 'A'.charCodeAt(0);
  const Z = 'Z'.charCodeAt(0);
  const a = 'a'.charCodeAt(0);
  const z = 'z'.charCodeAt(0);
  const code = c.charCodeAt(0);

  if (code >= A && code <= Z) {
    return String.fromCharCode(A + ((code - A + shift) % 26));
  } else if (code >= a && code <= z) {
    return String.fromCharCode(a + ((code - a + shift) % 26));
  } else {
    return c;
  }
}

function encrypt(text, shift) {
  const recurse = (chars, acc) =>
    chars.length === 0 ? acc : recurse(chars.slice(1), acc + shiftChar(chars[0], shift));
  return recurse(text.split(''), '');
}

function decrypt(text, shift) {
  return encrypt(text, (26 - (shift % 26)) % 26);
}

function bruteForce(text, shift = 1) {
  if (shift > 26) return;
  console.log(`Shift ${shift < 10 ? ' ' : ''}${shift}: ${decrypt(text, shift)}`);
  bruteForce(text, shift + 1);
}

function ask(question, callback) {
  rl.question(question, answer => callback(answer));
}

function main() {
  ask('Enter text to encrypt: ', textToEncrypt => {
    ask('Enter shift value: ', shiftEncrypt => {
      const encrypted = encrypt(textToEncrypt, parseInt(shiftEncrypt));
      console.log(`Encrypted text: ${encrypted.toUpperCase()}\n`);

      ask('Enter text to decrypt: ', textToDecrypt => {
        ask('Enter shift value: ', shiftDecrypt => {
          const decrypted = decrypt(textToDecrypt, parseInt(shiftDecrypt));
          console.log(`Decrypted text: ${decrypted.toUpperCase()}\n`);

          ask('Enter text for brute-force solve: ', textToBrute => {
            console.log('Solving the cipher with all 26 possible shifts:');
            bruteForce(textToBrute);
            rl.close();
          });
        });
      });
    });
  });
}

main();
