include(cmake_test/cmake_test)

ct_add_test("_cpp_overload_is_variadic")
    include(cmakepp_core/overload/ctor)
    include(cmakepp_core/overload/is_variadic)

    ct_add_section("Overload with no arguments")
        cpp_overload_ctor(an_overload a_fxn)
        cpp_overload_is_variadic("${an_overload}" is_variadic)
        ct_assert_equal(is_variadic FALSE)
    ct_end_section()

    ct_add_section("Pure variadic")
        cpp_overload_ctor(an_overload a_fxn args)
        cpp_overload_is_variadic("${an_overload}" is_variadic)
        ct_assert_equal(is_variadic TRUE)
    ct_end_section()

    ct_add_section("Non-variadic 1 argument")
        cpp_overload_ctor(an_overload a_fxn int)
        cpp_overload_is_variadic("${an_overload}" is_variadic)
        ct_assert_equal(is_variadic FALSE)
    ct_end_section()

    ct_add_section("Variadic 1 argument")
        cpp_overload_ctor(an_overload a_fxn int args)
        cpp_overload_is_variadic("${an_overload}" is_variadic)
        ct_assert_equal(is_variadic TRUE)
    ct_end_section()

    ct_add_section("Non-variadic 2 arguments")
        cpp_overload_ctor(an_overload a_fxn int bool)
        cpp_overload_is_variadic("${an_overload}" is_variadic)
        ct_assert_equal(is_variadic FALSE)
    ct_end_section()

    ct_add_section("Variadic 2 arguments")
        cpp_overload_ctor(an_overload a_fxn int bool args)
        cpp_overload_is_variadic("${an_overload}" is_variadic)
        ct_assert_equal(is_variadic TRUE)
    ct_end_section()
ct_end_test()