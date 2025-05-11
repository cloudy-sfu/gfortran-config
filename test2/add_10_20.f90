module math_operations_1
    use math_operations
    contains
    function add_10_20()
        real :: add_10_20
        add_10_20 = add(10.0, 20.0)
    end function add_10_20
end module math_operations_1