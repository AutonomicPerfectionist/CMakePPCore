include(cmake_test/cmake_test)

ct_add_test("_cpp_class_default_ctor")
    include(cmakepp_core/class/class)

    cpp_class(MyClass)
    cpp_object(CTOR corr)
    cpp_object(SET_ATTR "${corr}" _cpp_type "MyClass")

    ct_add_section("Default class")
        _cpp_class_default_ctor("${MyClass}" object)
        cpp_object(PRINT "${object}")
        cpp_object(PRINT "${corr}")
        cpp_object(EQUAL "${object}" result "${corr}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Class with attribute")
        cpp_attr(MyClass foo bar)
        cpp_object(SET_ATTR "${corr}" foo bar)
        _cpp_class_default_ctor("${MyClass}" object)
        cpp_object(EQUAL "${object}" result "${corr}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Derived class with different attribute")
        cpp_attr(MyClass foo bar)
        cpp_object(SET_ATTR "${corr}" foo bar)

        cpp_class(DerivedClass MyClass)
        cpp_attr(DerivedClass hello world)

        ct_add_section("Derived class ctor")
            _cpp_class_default_ctor("${DerivedClass}" object)
            cpp_object(SET_ATTR "${corr}" _cpp_type "DerivedClass")
            cpp_object(SET_ATTR "${corr}" hello world)
            cpp_object(PRINT "${corr}")
            cpp_object(PRINT "${object}")
            cpp_object(EQUAL "${object}" result "${corr}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Base class ctor")
            _cpp_class_default_ctor("${MyClass}" object)
            cpp_object(EQUAL "${object}" result "${corr}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Derived class with same attribute")
        cpp_attr(MyClass foo bar)
        cpp_object(SET_ATTR "${corr}" foo bar)

        cpp_class(DerivedClass MyClass)
        cpp_attr(DerivedClass foo "hello world")

        ct_add_section("Derived class ctor uses derived value")
            _cpp_class_default_ctor("${DerivedClass}" object)
            cpp_object(SET_ATTR "${corr}" _cpp_type "DerivedClass")
            cpp_object(SET_ATTR "${corr}" foo "hello world")
            cpp_object(EQUAL "${object}" result "${corr}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Base class ctor uses base value")
            _cpp_class_default_ctor("${MyClass}" object)
            cpp_object(EQUAL "${object}" result "${corr}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()
ct_end_test()