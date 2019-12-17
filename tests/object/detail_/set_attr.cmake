include(cmake_test/cmake_test)

ct_add_test("_cpp_object_set_attr")
    include(cmakepp_core/algorithm/equal)
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/get_state)
    include(cmakepp_core/object/detail_/set_attr)

    _cpp_object_ctor(an_object)
    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg0 must be an object")
            _cpp_object_set_attr(TRUE an_attr a_value)
            ct_assert_fails_as("Assertion: TRUE is obj")
        ct_end_section()

        ct_add_section("Arg1 must be desc")
            _cpp_object_set_attr("${an_object}" TRUE a_value)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Takes 3 arguments")
            _cpp_object_set_attr("${an_object}" foo bar hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Can set an attribute")
        _cpp_object_set_attr("${an_object}" foo bar)
        _cpp_object_get_attrs("${an_object}" attrs)
        cpp_map(CTOR corr foo bar)
        cpp_equal(result "${corr}" "${attrs}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Set overwrites value")
        _cpp_object_set_attr("${an_object}" foo bar)
        _cpp_object_set_attr("${an_object}" foo 42)
        _cpp_object_get_attrs("${an_object}" attrs)
        cpp_map(CTOR corr foo 42)
        cpp_equal(result "${corr}" "${attrs}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Can set multiple attributes")
        _cpp_object_set_attr("${an_object}" foo bar)
        _cpp_object_set_attr("${an_object}" hello world)
        _cpp_object_get_attrs("${an_object}" attrs)
        cpp_map(CTOR corr foo bar hello world)
        cpp_equal(result "${corr}" "${attrs}")
        ct_assert_equal(result TRUE)
    ct_end_section()
ct_end_test()