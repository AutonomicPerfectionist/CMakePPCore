include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/copy)
include(cmakepp_core/object/copy)
include(cmakepp_core/types/type_of)
include(cmakepp_core/utilities/return)

#[[[ Creates a new object which is a deep copy of an already existing object.
#
# This function will create a deep copy of an existing object regardless of
# what type it is.
#
# :param _c_result: The name of the variable to return the result in.
# :type _c_result: desc
# :param _c_obj2copy: The object we are deep copying
# :type _c_obj2copy: str
# :returns: ``_c_result`` will be set to a deep copy of ``_c_obj2copy``.
# :rtype: str
#
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode this function will ensure that it has
# been called with exactly two arguments and that those arguments have the
# correct types. If any of these assertions fail, an error will be raised. These
# error checks are done only if CMakePP is being run in debug mode.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
#]]
function(cpp_copy _c_result _c_obj2copy)
    #cpp_assert_signature("${ARGV}" desc str)

    cpp_type_of(_c_type "${_c_obj2copy}")
    cpp_implicitly_convertible(_c_is_obj "${_c_type}" "obj")
    if("${_c_type}" STREQUAL "map")
        cpp_map_copy("${_c_obj2copy}" "${_c_result}")
    elseif(_c_is_obj)
        _cpp_object_copy("${_c_obj2copy}" "${_c_result}")
    else()
        set("${_c_result}" "${_c_obj2copy}")
    endif()
    cpp_return("${_c_result}")
endfunction()
