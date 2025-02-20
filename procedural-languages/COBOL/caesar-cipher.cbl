       IDENTIFICATION DIVISION.
       PROGRAM-ID. CaesarCipher.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 inText           PIC X(100).
       01 outText          PIC X(100).
       01 shift            PIC 99.
       01 decrypted        PIC X(100).
       01 i                PIC 99.
       01 j                PIC 99.
       01 code             PIC 99.
       01 decodedChar      PIC X.

       PROCEDURE DIVISION.

           DISPLAY "Enter text to encrypt: ".
           ACCEPT inText.
           DISPLAY "Enter shift value: ".
           ACCEPT shift.
           PERFORM ENCRYPT.
      
           DISPLAY "Enter text to decrypt: ".
           ACCEPT inText.
           DISPLAY "Enter shift value: ".
           ACCEPT shift.
           PERFORM DECRYPT.
      
           DISPLAY "Enter text for brute-force solve: ".
           ACCEPT inText.
           PERFORM BRUTE-FORCE.
      
           STOP RUN.

      * ENCRYPT subroutine to perform Caesar cipher encryption
       ENCRYPT.
           MOVE SPACES TO outText
           PERFORM VARYING i FROM 1 BY 1 UNTIL i > LENGTH OF inText
               IF inText(i:i) >= "A" AND inText(i:i) <= "Z"
                   COMPUTE code = FUNCTION ORD(inText(i:i)) + shift
                   IF code > FUNCTION ORD("Z")
                       COMPUTE code = code - 26
                   END-IF
                   MOVE FUNCTION CHAR(code) TO outText(i:i)
               ELSE IF inText(i:i) >= "a" AND inText(i:i) <= "z"
                   COMPUTE code = FUNCTION ORD(inText(i:i)) + shift
                   IF code > FUNCTION ORD("z")
                       COMPUTE code = code - 26
                   END-IF
                   MOVE FUNCTION CHAR(code) TO outText(i:i)
               ELSE
                   MOVE inText(i:i) TO outText(i:i)
               END-IF
           END-PERFORM
           DISPLAY "Encrypted String: " outText
           EXIT.

      * DECRYPT subroutine to perform Caesar cipher decryption
       DECRYPT.
           MOVE SPACES TO outText
           PERFORM VARYING i FROM 1 BY 1 UNTIL i > LENGTH OF inText
               IF inText(i:i) >= "A" AND inText(i:i) <= "Z"
                   COMPUTE code = FUNCTION ORD(inText(i:i)) - shift
                   IF code < FUNCTION ORD("A")
                       COMPUTE code = code + 26
                   END-IF
                   MOVE FUNCTION CHAR(code) TO outText(i:i)
               ELSE IF inText(i:i) >= "a" AND inText(i:i) <= "z"
                   COMPUTE code = FUNCTION ORD(inText(i:i)) - shift
                   IF code < FUNCTION ORD("a")
                       COMPUTE code = code + 26
                   END-IF
                   MOVE FUNCTION CHAR(code) TO outText(i:i)
               ELSE
                   MOVE inText(i:i) TO outText(i:i)
               END-IF
           END-PERFORM
           DISPLAY "Decrypted String: " outText
           EXIT.

      * BRUTE-FORCE subroutine to try all possible shift values (1-25)
       BRUTE-FORCE.
           PERFORM VARYING shift FROM 1 BY 1 UNTIL shift > 25
               MOVE SPACES TO decrypted
               PERFORM VARYING i FROM 1 BY 1 UNTIL i > LENGTH OF inText
                   IF inText(i:i) >= "A" AND inText(i:i) <= "Z"
                       COMPUTE code = FUNCTION ORD(inText(i:i))-shift
                       IF code < FUNCTION ORD("A")
                           COMPUTE code = code + 26
                       END-IF
                       MOVE FUNCTION CHAR(code) TO decrypted(i:i)
                   ELSE IF inText(i:i) >= "a" AND inText(i:i) <= "z"
                       COMPUTE code = FUNCTION ORD(inText(i:i))-shift
                       IF code < FUNCTION ORD("a")
                           COMPUTE code = code + 26
                       END-IF
                       MOVE FUNCTION CHAR(code) TO decrypted(i:i)
                   ELSE
                       MOVE inText(i:i) TO decrypted(i:i)
                   END-IF
               END-PERFORM
               DISPLAY "Shift Value: "shift" Decrypted Text: "decrypted
           END-PERFORM
           EXIT.
