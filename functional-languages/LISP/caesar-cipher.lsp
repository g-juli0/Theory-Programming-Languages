(defun char-shift (ch shift)
  (cond
    ((and (char>= ch #\A) (char<= ch #\Z))
     (code-char (+ (char-code #\A) (mod (+ (- (char-code ch) (char-code #\A)) shift) 26))))
    ((and (char>= ch #\a) (char<= ch #\z))
     (code-char (+ (char-code #\a) (mod (+ (- (char-code ch) (char-code #\a)) shift) 26))))
    (t ch)))

(defun caesar-encrypt (text shift)
  (coerce (map 'list (lambda (ch) (char-shift ch shift)) text) 'string))

(defun caesar-decrypt (text shift)
  (caesar-encrypt text (- 26 (mod shift 26))))

(defun prompt (message)
  (format t "~a" message)
  (force-output)
  (read-line))

(defun prompt-int (message)
  (format t "~a" message)
  (force-output)
  (parse-integer (read-line)))

(defun brute-force (text)
  (format t "Solving the cipher with all 26 possible shifts:~%")
  (loop for i from 1 to 26 do
    (format t "Shift ~2d: ~a~%" i (caesar-decrypt text i))))

(defun main ()
  ;; Encrypt
  (let* ((text-to-encrypt (prompt "Enter text to encrypt: "))
         (shift-encrypt (prompt-int "Enter shift value: "))
         (encrypted (caesar-encrypt text-to-encrypt shift-encrypt)))
    (format t "Encrypted text: ~a~%~%" (string-upcase encrypted)))

  ;; Decrypt
  (let* ((text-to-decrypt (prompt "Enter text to decrypt: "))
         (shift-decrypt (prompt-int "Enter shift value: "))
         (decrypted (caesar-decrypt text-to-decrypt shift-decrypt)))
    (format t "Decrypted text: ~a~%~%" (string-upcase decrypted)))

  ;; Brute-force
  (let ((brute-input (prompt "Enter text for brute-force solve: ")))
    (brute-force brute-input)))
