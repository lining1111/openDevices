########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(gflags_FIND_QUIETLY)
    set(gflags_MESSAGE_MODE VERBOSE)
else()
    set(gflags_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/gflagsTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${gflags_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(gflags_VERSION_STRING "2.2.2")
set(gflags_INCLUDE_DIRS ${gflags_INCLUDE_DIRS_DEBUG} )
set(gflags_INCLUDE_DIR ${gflags_INCLUDE_DIRS_DEBUG} )
set(gflags_LIBRARIES ${gflags_LIBRARIES_DEBUG} )
set(gflags_DEFINITIONS ${gflags_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${gflags_BUILD_MODULES_PATHS_DEBUG} )
    message(${gflags_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


