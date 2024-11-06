module math_operations
    contains
    function add(a, b)
        real :: add
        real, intent(in) :: a, b
        add = a + b
    end function add
end module math_operations
