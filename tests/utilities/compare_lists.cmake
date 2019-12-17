include(cmake_test/cmake_test)

ct_add_test("cpp_compare_lists")
    include(cmakepp_core/utilities/compare_lists)

    ct_add_section("Empty lists")
        set(a_empty_list)
        set(another_empty_list)
        cpp_compare_lists(result a_empty_list another_empty_list)
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("A single empty list")
        set(a_empty_list)
        set(a_list hello world)
        cpp_compare_lists(result a_empty_list a_list)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("Non-empty, different sized lists")
        set(a_list 42)
        set(another_list hello world)
        cpp_compare_lists(result a_list another_list)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("Non-empty, same-sized lists with different content")
        set(a_list foo bar)
        set(another_list hello world)
        cpp_compare_lists(result a_list another_list)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("Lists which are permutations")
        set(a_list foo bar)
        set(another_list bar foo)
        cpp_compare_lists(result a_list another_list)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("Lists which are same")
        set(a_list foo bar)
        set(another_list foo bar)
        cpp_compare_lists(result a_list another_list)
        ct_assert_equal(result TRUE)
    ct_end_section()
ct_end_test()