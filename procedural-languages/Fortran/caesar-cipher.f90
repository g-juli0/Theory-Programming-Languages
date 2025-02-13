program encrypt
    implicit none

    ! declare variables
    character(len=100) :: text, encrypted, decrypted
    integer :: shift, i

    ! prompt user for input text
    print *, 'Enter text to encrypt:'
    read(*, '(A)') text

    ! prompt user for shift value
    print *, 'Enter shift value:'
    read(*,*) shift

    ! subroutine for encryption
    subroutine encrypt(input, shift)
        ! comment here
    end subroutine encrypt

    ! subroutine for decryption
    subroutine decrypt(input,  shift)
        ! comment here
    end subroutine decrypt

    ! subroutine to solve will all possible shifts
    subroutine solve(input)
        ! comment here
    end subroutine encrypt
    
end program encrypt