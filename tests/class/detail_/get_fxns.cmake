include(cmake_test/cmake_test)

ct_add_test("_cpp_class_get_fxns")
    include(cmakepp_core/class/class)
    include(cmakepp_core/class/detail_/get_fxns)

    cpp_class(MyClass)

    ct_add_section("Class with no functions")
        _cpp_class_get_fxns(fxns MyClass)
        cpp_map(CTOR corr)
        cpp_are_equal(result "${corr}" "${fxns}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Fails if type has not been registered")
        _cpp_class_get_fxns(result NotAClass)
        ct_assert_fails_as("Can not retrieve member functions for type:")
    ct_end_section()

ct_end_test()