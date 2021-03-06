include_guard()

#[[[ Determines if a string is lexically convertible to a CMake list.
#
# CMake lists are strings that contain semicolons. While CMake's list command
# will treat a string without a semicolon as a list with one element, for the
# purposes of determining if a string is a list we require that the list has at
# least two elements (*i.e.*, there must be a semicolon in it). This function
# determines if the provided string meets this definition of a list.
#
# :param _il_result: Used as the name of the returned identifier.
# :type _il_result: desc
# :param _il_str2check: The string whose listy-ness is being questioned.
# :type _il_str2check: str
# :returns: ``_il_result`` will be set to ``TRUE`` if ``_il_str2check`` is a
#           list and ``FALSE`` otherwise.
# :rtype: bool
#
# Error Checking
# ==============
#
# ``cpp_is_list`` will assert that the caller has provided exactly two
# arguments. If the caller has provided a different number of arguments than an
# error will be raised.
#
# Example Usage:
# ==============
#
# The following snippet shows how to determine if a variable contains a list.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/list)
#    set(a_list 1 2 3)
#    cpp_is_list(result "${a_list}")
#    message("Is a list: ${result}")  # Will print TRUE
#]]
function(cpp_is_list _il_result _il_str2check)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "cpp_is_list takes exactly 2 arguments.")
    endif()

    list(LENGTH _il_str2check _il_length)
    if("${_il_length}" GREATER 1)
        set("${_il_result}" TRUE PARENT_SCOPE)
    else()
        set("${_il_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
