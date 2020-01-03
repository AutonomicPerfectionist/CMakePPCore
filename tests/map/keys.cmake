include(cmake_test/cmake_test)

ct_add_test("cpp_map_keys")
    include(cmakepp_core/map/map)
    include(cmakepp_core/utilities/compare_lists)

    ct_add_section("Map with no keys")
        cpp_map_ctor(a_map)
        cpp_map_keys("${a_map}" keys)
        set(corr)
        cpp_compare_lists(result corr keys)
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Map with one key")
        cpp_map_ctor(a_map foo bar)
        cpp_map_keys("${a_map}" keys)
        set(corr foo)
        cpp_compare_lists(result corr keys)
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Map with two keys")
        cpp_map_ctor(a_map foo bar hello world)
        cpp_map_keys("${a_map}" keys)
        set(corr foo hello)
        cpp_compare_lists(result corr keys)
        ct_assert_equal(result TRUE)
    ct_end_section()
ct_end_test()