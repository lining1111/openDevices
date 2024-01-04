########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(libuuid_FIND_QUIETLY)
    set(libuuid_MESSAGE_MODE VERBOSE)
else()
    set(libuuid_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/libuuidTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${libuuid_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(libuuid_VERSION_STRING "1.0.3")
set(libuuid_INCLUDE_DIRS ${libuuid_INCLUDE_DIRS_DEBUG} )
set(libuuid_INCLUDE_DIR ${libuuid_INCLUDE_DIRS_DEBUG} )
set(libuuid_LIBRARIES ${libuuid_LIBRARIES_DEBUG} )
set(libuuid_DEFINITIONS ${libuuid_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${libuuid_BUILD_MODULES_PATHS_DEBUG} )
    message(${libuuid_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


