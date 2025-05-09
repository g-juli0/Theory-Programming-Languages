program caesar_cipher
    implicit none

    ! declare variables
    character(len=100) :: input
    integer :: shift, i

    ! prompt user for input text
    print *, 'Enter text to encrypt: '
    read(*, '(A)') input
    ! prompt user for shift value
    print *, 'Enter shift value: '
    read(*,*) shift

    call encrypt(input, shift)

    ! prompt user for input text
    print *, 'Enter text to decrypt: '
    read(*, '(A)') input

    ! prompt user for shift value
    print *, 'Enter shift value: '
    read(*,*) shift

    call decrypt(input, shift)

    ! prompt user for input text
    print *, 'Enter text for brute-force solve: '
    read(*, '(A)') input

    call solve(input)

    contains

    ! subroutine for encryption
    subroutine encrypt(input, shift)
        character(len=100) :: input     ! input text
        integer, intent(in) :: shift    ! shift value
        character(len=100) :: output    ! output encrypted text
        integer :: i, len_text, ascii   ! loop index, text length, and ASCII values

        len_text = len_trim(input)      ! get length
        output = input                  ! initialize output with input text

        ! loop through each character in the input text
        do i = 1, len_text
            ! get ASCII value and convert lowercase to uppercase
            ascii = ichar(input(i:i))  
            if (ascii >= ichar('a') .and. ascii <= ichar('z')) then
                ascii = ascii - ichar('a') + ichar('A')
            end if
            ! encrypt uppercase letters
            if (ascii >= ichar('A') .and. ascii <= ichar('Z')) then
                ascii = mod(ascii - ichar('A') + shift, 26) + ichar('A')
            end if
            ! convert ASCII back to character and store
            output(i:i) = char(ascii)
        end do
        ! print output
        print *, 'Encrypted text: ', trim(output)
    end subroutine encrypt

    ! subroutine for decryption
    subroutine decrypt(input, shift)
        character(len=100) :: input     ! input text
        integer, intent(in) :: shift    ! shift value
        character(len=100) :: output    ! output decrypted text
        integer :: i, len_text, ascii   ! loop index, text length, and ASCII values

        len_text = len_trim(input)      ! get length
        output = input                  ! initialize output with encrypted text

        ! loop through each character in the text
        do i = 1, len_text
            ! get ASCII value and convert lowercase to uppercase
            ascii = ichar(input(i:i))  
            if (ascii >= ichar('a') .and. ascii <= ichar('z')) then
                ascii = ascii - ichar('a') + ichar('A')
            end if
            ! decrypt uppercase letters
            if (ascii >= ichar('A') .and. ascii <= ichar('Z')) then
                ascii = mod(ascii - ichar('A') - shift + 26, 26) + ichar('A')
            end if
            ! convert ASCII back to character and store
            output(i:i) = char(ascii)
        end do
        ! print output
        print *, 'Decrypted text: ', trim(output)
    end subroutine decrypt

    ! subroutine to solve will all possible shifts
    subroutine solve(input)
        character(len=100):: input
        character(len=100) :: output
        integer :: i, j, len_text, ascii

        print *, 'Solving the cipher with all 26 possible shifts:'

        len_text = len_trim(input)

        ! loop through all possible shift values
        do i = 1, 26
            output = input  ! copy input to output

            ! perform manual decryption for shift value i
            do j = 1, len_text
                ascii = ichar(input(j:j))
                if (ascii >= ichar('a') .and. ascii <= ichar('z')) then
                    ascii = ascii - ichar('a') + ichar('A')
                end if
                if (ascii >= ichar('A') .and. ascii <= ichar('Z')) then
                    ascii = mod(ascii - ichar('A') - i + 26, 26) + ichar('A')
                end if
                output(j:j) = char(ascii)
            end do

            ! display decrypted text for this shift
            print *, 'Shift ', i, ': ', trim(output)
        end do
    end subroutine solve
    
end program caesar_cipher