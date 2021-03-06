include(cmake_test/cmake_test)

ct_add_test("cpp_is_bool")
    include(cmakepp_core/types/bool)

    ct_add_section("Signature")
        cpp_is_bool(return TRUE hello)
        ct_assert_fails_as("cpp_is_bool accepts exactly 2 arguments")
    ct_end_section()

    ct_add_section("bool")
        ct_add_section("Is case-insensitive")
            cpp_is_bool(return TrUe)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("ON")
            cpp_is_bool(return ON)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("YES")
            cpp_is_bool(return YES)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("TRUE")
            cpp_is_bool(return TRUE)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("Y")
            cpp_is_bool(return Y)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("OFF")
            cpp_is_bool(return OFF)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("NO")
            cpp_is_bool(return NO)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("FALSE")
            cpp_is_bool(return FALSE)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("N")
            cpp_is_bool(return N)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("IGNORE")
            cpp_is_bool(return IGNORE)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("NOTFOUND")
            cpp_is_bool(return NOTFOUND)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("String ending in -NOTFOUND")
            cpp_is_bool(return hello-notfound)
            ct_assert_equal(return TRUE)
        ct_end_section()
    ct_end_section()  # add_section(bool)

    ct_add_section("class")
        include(cmakepp_core/class/class)
        cpp_class(MyClass)

        cpp_is_bool(return MyClass)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("command")
        cpp_is_bool(return add_subdirectory)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("descriptions")
        ct_add_section("description w/o a bool")
            cpp_is_bool(return "Hello World")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("description containing a bool")
            cpp_is_bool(return "Hello World TRUE")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("bool with whitespace")
            cpp_is_bool(return " TRUE")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("contains -notfound, but not as a suffix")
            cpp_is_bool(return "hello-notfound-world")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("float")
        cpp_is_bool(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        ct_add_section("Traditional integer representation of true")
            cpp_is_bool(return 1)
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("Traditional integer representation of false")
            cpp_is_bool(return 0)
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("Not traditionally associated with true or false")
            cpp_is_bool(return 42)
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("list")
        ct_add_section("Normal list")
            cpp_is_bool(return "1;2;3")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("List with boolean literals")
            cpp_is_bool(return "TRUE;FALSE")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("map")
        include(cmakepp_core/map/map)
        cpp_map(CTOR a_map)
        cpp_is_bool(result a_map)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("obj")
        include(cmakepp_core/object/object)
        cpp_is_bool(result "${__CMAKEPP_CORE_OBJECT_SINGLETON__}")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("path")
        ct_add_section("normal path")
            cpp_is_bool(return "${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("path with bool in it")
            cpp_is_bool(return "${CMAKE_CURRENT_LIST_DIR}/TRUE")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("target")
        ct_add_section("normal target name")
            add_library(lib STATIC IMPORTED)
            cpp_is_bool(return lib)
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("target name containing boolean literal")
            add_library(libTRUE STATIC IMPORTED)
            cpp_is_bool(return libTRUE)
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("type")
        cpp_is_bool(return bool)
        ct_assert_equal(return FALSE)
    ct_end_section()
ct_end_test()
