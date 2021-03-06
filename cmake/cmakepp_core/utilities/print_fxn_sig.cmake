include_guard()
include(cmakepp_core/asserts/signature)

#[[[ Creates a pretty, human-readable representation of a function's signature.
#
# This function will combine a function's name, and the types of its arguments,
# to create a string representation of the function declaration.
#
# :param _pfs_result: Name of the variable which will hold the result.
# :type _pfs_result: desc
# :param _pfs_fxn_name: The unmangled name of the function whose signature we
#                        are printing.
# :type _pfs_fxn_name: desc
# :param *args: The types of the arguments to ``_pfs_fxn_name``.
# :returns: ``_pfs_result`` will be set to a human-readable, string
#           representation of this particular overload of ``_pfs_fxn_name``.
# :rtype: desc
#]]
function(cpp_print_fxn_sig _pfs_result _pfs_fxn_name)
    cpp_assert_signature("${ARGV}" desc desc args)

    # Set result to "fxn_name(" and note we have not printed any arg types yet
    set("${_pfs_result}" "${_pfs_fxn_name}(")
    set(_pfs_arg_printed FALSE)

    # Loop over the provided argument types
    foreach(_pfs_arg_i ${ARGN})

        # If not the first arg we need a comma before adding another arg
        if(_pfs_arg_printed)
            set("${_pfs_result}" "${${_pfs_result}}, ")
        endif()

        # Add the current arg and note we have added at least 1 arg to result
        string(APPEND "${_pfs_result}" "${_pfs_arg_i}")
        set(_pfs_arg_printed TRUE)
    endforeach()

    # Put the closing ")" onto the result and return
    set("${_pfs_result}" "${${_pfs_result}})" PARENT_SCOPE)
endfunction()
