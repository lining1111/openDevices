########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(LibLZMA_FIND_QUIETLY)
    set(LibLZMA_MESSAGE_MODE VERBOSE)
else()
    set(LibLZMA_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/module-LibLZMATargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${xz_utils_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(LibLZMA_VERSION_STRING "5.4.2")
set(LibLZMA_INCLUDE_DIRS ${xz_utils_INCLUDE_DIRS_DEBUG} )
set(LibLZMA_INCLUDE_DIR ${xz_utils_INCLUDE_DIRS_DEBUG} )
set(LibLZMA_LIBRARIES ${xz_utils_LIBRARIES_DEBUG} )
set(LibLZMA_DEFINITIONS ${xz_utils_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${xz_utils_BUILD_MODULES_PATHS_DEBUG} )
    message(${LibLZMA_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


include(FindPackageHandleStandardArgs)
set(LibLZMA_FOUND 1)
set(LibLZMA_VERSION "5.4.2")

find_package_handle_standard_args(LibLZMA
                                  REQUIRED_VARS LibLZMA_VERSION
                                  VERSION_VAR LibLZMA_VERSION)
mark_as_advanced(LibLZMA_FOUND LibLZMA_VERSION)
