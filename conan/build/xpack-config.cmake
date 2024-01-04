########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(xpack_FIND_QUIETLY)
    set(xpack_MESSAGE_MODE VERBOSE)
else()
    set(xpack_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/xpackTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${xpack_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(xpack_VERSION_STRING "1.0.4")
set(xpack_INCLUDE_DIRS ${xpack_INCLUDE_DIRS_DEBUG} )
set(xpack_INCLUDE_DIR ${xpack_INCLUDE_DIRS_DEBUG} )
set(xpack_LIBRARIES ${xpack_LIBRARIES_DEBUG} )
set(xpack_DEFINITIONS ${xpack_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${xpack_BUILD_MODULES_PATHS_DEBUG} )
    message(${xpack_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


