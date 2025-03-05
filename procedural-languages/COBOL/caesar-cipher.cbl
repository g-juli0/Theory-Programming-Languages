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
       01 encoded          PIC 99.
       01 decoded          PIC X.

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
           MOVE SPACES TO outText.
           PERFORM VARYING i FROM 1 BY 1 UNTIL i > LENGTH OF inText
               IF inText(i:1) >= "A" AND inText(i:1) <= "Z"
                   COMPUTE encoded = FUNCTION ORD(inText(i:1)) + shift
                   IF encoded > FUNCTION ORD("Z")
                       COMPUTE encoded = encoded - 26
                   END-IF
                   MOVE FUNCTION CHAR(encoded) TO outText(i:1)
               ELSE IF inText(i:1) >= "a" AND inText(i:1) <= "z"
                   COMPUTE encoded = FUNCTION ORD(inText(i:1)) + shift
                   IF encoded > FUNCTION ORD("z")
                       COMPUTE encoded = encoded - 26
                   END-IF
                   MOVE FUNCTION CHAR(encoded) TO outText(i:1)
               ELSE
                   MOVE inText(i:1) TO outText(i:1)
               END-IF
           END-PERFORM.
           DISPLAY "Encrypted String: " outText.
           EXIT.

      * DECRYPT subroutine to perform Caesar cipher decryption
       DECRYPT.
           MOVE SPACES TO outText.
           PERFORM VARYING i FROM 1 BY 1 UNTIL i > LENGTH OF inText
               IF inText(i:1) >= "A" AND inText(i:1) <= "Z"
                   COMPUTE encoded = FUNCTION ORD(inText(i:1)) - shift
                   IF encoded < FUNCTION ORD("A")
                       COMPUTE encoded = encoded + 26
                   END-IF
                   MOVE FUNCTION CHAR(encoded) TO outText(i:1)
               ELSE IF inText(i:1) >= "a" AND inText(i:1) <= "z"
                   COMPUTE encoded = FUNCTION ORD(inText(i:1)) - shift
                   IF encoded < FUNCTION ORD("a")
                       COMPUTE encoded = encoded + 26
                   END-IF
                   MOVE FUNCTION CHAR(encoded) TO outText(i:1)
               ELSE
                   MOVE inText(i:1) TO outText(i:1)
               END-IF
           END-PERFORM.
           DISPLAY "Decrypted String: " outText.
           EXIT.

      * BRUTE-FORCE subroutine to try all possible shift values (1-25)
       BRUTE-FORCE.
           PERFORM VARYING shift FROM 1 BY 1 UNTIL shift > 25
               MOVE SPACES TO decrypted
               PERFORM VARYING i FROM 1 BY 1 UNTIL i > LENGTH OF inText
                   IF inText(i:1) >= "A" AND inText(i:1) <= "Z"
                       COMPUTE encoded = FUNCTION ORD(inText(i:1))-shift
                       IF encoded < FUNCTION ORD("A")
                           COMPUTE encoded = encoded + 26
                       END-IF
                       MOVE FUNCTION CHAR(encoded) TO decrypted(i:1)
                   ELSE IF inText(i:1) >= "a" AND inText(i:1) <= "z"
                       COMPUTE encoded = FUNCTION ORD(inText(i:1))-shift
                       IF encoded < FUNCTION ORD("a")
                           COMPUTE encoded = encoded + 26
                       END-IF
                       MOVE FUNCTION CHAR(encoded) TO decrypted(i:1)
                   ELSE
                       MOVE inText(i:1) TO decrypted(i:1)
                   END-IF
               END-PERFORM.
               DISPLAY "Shift Value: "shift" Decrypted Text: " decrypted
           END-PERFORM.
           EXIT.