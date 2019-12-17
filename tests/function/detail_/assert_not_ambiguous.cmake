include(cmake_test/cmake_test)

ct_add_test("_cpp_function_assert_not_ambiguous")
    include(cmakepp_core/function/ctor)
    include(cmakepp_core/function/detail_/assert_not_ambiguous)
    set(CMAKEPP_CORE_DEBUG_MODE ON)

    ct_add_section("a_fxn()")
        cpp_function_ctor(fxn a_fxn)

        ct_add_section("Can have another function with more args")
            cpp_overload_ctor(overload a_fxn int)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Can not have another function with 0 args")
            cpp_overload_ctor(overload a_fxn)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn() is ambiguous with a_fxn()")
        ct_end_section()

        ct_add_section("Can not have a pure variadic function")
            cpp_overload_ctor(overload a_fxn args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(args) is ambiguous with a_fxn()")
        ct_end_section()
    ct_end_section()

    ct_add_section("a_fxn(args)")
        cpp_function_ctor(fxn a_fxn args)

        ct_add_section("Function with 0 args is ambiguous")
            cpp_overload_ctor(overload a_fxn)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn() is ambiguous with a_fxn(args)")
        ct_end_section()

        ct_add_section("Another pure variadic function is ambiguous")
            cpp_overload_ctor(overload a_fxn args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(args) is ambiguous with a_fxn(args)")
        ct_end_section()

        ct_add_section("Function with 1 arg is ambiguous")
            cpp_overload_ctor(overload a_fxn int)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int) is ambiguous with a_fxn(args)")
        ct_end_section()

        ct_add_section("Variadic function with 1 args is ambiguous")
            cpp_overload_ctor(overload a_fxn int args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int, args) is ambiguous with a_fxn(args)")
        ct_end_section()
    ct_end_section()


    ct_add_section("a_fxn(int)")
        cpp_function_ctor(fxn a_fxn int)

        ct_add_section("No aguments is okay")
            cpp_overload_ctor(overload a_fxn)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Pure variadic is not okay")
            cpp_overload_ctor(overload a_fxn args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(args) is ambiguous with a_fxn(int)")
        ct_end_section()

        ct_add_section("Same signature is not okay")
            cpp_overload_ctor(overload a_fxn int)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int) is ambiguous with a_fxn(int)")
        ct_end_section()

        ct_add_section("Different type is okay")
            cpp_overload_ctor(overload a_fxn bool)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Variadic with same argument is not okay")
            cpp_overload_ctor(overload a_fxn int args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int, args) is ambiguous with a_fxn(int)")
        ct_end_section()

        ct_add_section("Variadic with different argument is okay")
            cpp_overload_ctor(overload a_fxn bool args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("More arguments are okay")
            cpp_overload_ctor(overload a_fxn int bool)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("More arguments and variadic is okay")
            cpp_overload_ctor(overload a_fxn int bool args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()
    ct_end_section()

    ct_add_section("a_fxn(int, args)")
        cpp_function_ctor(fxn a_fxn int args)

        ct_add_section("No arguments is okay")
            cpp_overload_ctor(overload a_fxn)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Pure variadic is not okay")
            cpp_overload_ctor(overload a_fxn args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(args) is ambiguous with a_fxn(int, args)")
        ct_end_section()

        ct_add_section("Same argument is not okay")
            cpp_overload_ctor(overload a_fxn int)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int) is ambiguous with a_fxn(int, args)")
        ct_end_section()

        ct_add_section("Different argument is okay")
            cpp_overload_ctor(overload a_fxn bool)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Same signature is not okay")
            cpp_overload_ctor(overload a_fxn int args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int, args) is ambiguous with")
        ct_end_section()

        ct_add_section("More arguments is not okay if first is same")
            cpp_overload_ctor(overload a_fxn int bool)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int, bool) is ambiguous with")
        ct_end_section()

        ct_add_section("More arguments is okay if first is different")
            cpp_overload_ctor(overload a_fxn bool int)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Variadic with more arguments, but same first is not ok")
            cpp_overload_ctor(overload a_fxn int bool args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int, bool, args) is ambiguous with")
        ct_end_section()

        ct_add_section("Variadic with more arguments, different first is ok")
            cpp_overload_ctor(overload a_fxn bool int args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()
    ct_end_section()

    ct_add_section("a_fxn(int, bool)")
        cpp_function_ctor(fxn a_fxn int bool)

        ct_add_section("Can have no arguments")
            cpp_overload_ctor(overload a_fxn)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Can not have pure variadic")
            cpp_overload_ctor(overload a_fxn args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(args) is ambiguous with")
        ct_end_section()

        ct_add_section("Can have one argument")
            cpp_overload_ctor(overload a_fxn int)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Variadic can not have one common arg")
            cpp_overload_ctor(overload a_fxn int args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int, args) is ambiguous with")
        ct_end_section()

        ct_add_section("Variadic can different 1st arg")
            cpp_overload_ctor(overload a_fxn bool args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Can not have only common arguments")
            cpp_overload_ctor(overload a_fxn int bool)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int, bool) is ambiguous with")
        ct_end_section()

        ct_add_section("Can have a common 1st argument")
            cpp_overload_ctor(overload a_fxn int double)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Can have a common 2nd argument")
            cpp_overload_ctor(overload a_fxn bool bool)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Can not have variadic with 2 common positional args")
            cpp_overload_ctor(overload a_fxn int bool args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int, bool, args) is ambiguous with")
        ct_end_section()

        ct_add_section("Can have variadic with different positional args")
            cpp_overload_ctor(overload a_fxn bool int args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Can have variadic with more positional args")
            cpp_overload_ctor(overload a_fxn int bool int args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()
    ct_end_section()

    ct_add_section("a_fxn(int, bool, args)")
        cpp_function_ctor(fxn a_fxn int bool args)

        ct_add_section("Can have no arguments")
            cpp_overload_ctor(overload a_fxn)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Can not have pure variadic")
            cpp_overload_ctor(overload a_fxn args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(args) is ambiguous with")
        ct_end_section()

        ct_add_section("Can have one argument")
            cpp_overload_ctor(overload a_fxn int)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Variadic can not have one common arg")
            cpp_overload_ctor(overload a_fxn int args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int, args) is ambiguous with")
        ct_end_section()

        ct_add_section("Variadic can have different 1st arg")
            cpp_overload_ctor(overload a_fxn bool args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Can not have only common arguments")
            cpp_overload_ctor(overload a_fxn int bool)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int, bool) is ambiguous with")
        ct_end_section()

        ct_add_section("Can have a common 1st argument")
            cpp_overload_ctor(overload a_fxn int double)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Can have a common 2nd argument")
            cpp_overload_ctor(overload a_fxn bool bool)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Can not have same signature")
            cpp_overload_ctor(overload a_fxn int bool args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int, bool, args) is ambiguous with")
        ct_end_section()

        ct_add_section("Can have variadic with different positional args")
            cpp_overload_ctor(overload a_fxn bool int args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
        ct_end_section()

        ct_add_section("Can not have variadic with more positional args")
            cpp_overload_ctor(overload a_fxn int bool int args)
            _cpp_function_assert_not_ambiguous("${fxn}" "${overload}")
            ct_assert_fails_as("a_fxn(int, bool, int, args) is ambiguous with")
        ct_end_section()
    ct_end_section()
ct_end_test()