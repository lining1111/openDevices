########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(lz4_FIND_QUIETLY)
    set(lz4_MESSAGE_MODE VERBOSE)
else()
    set(lz4_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/lz4Targets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${lz4_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(lz4_VERSION_STRING "1.9.4")
set(lz4_INCLUDE_DIRS ${lz4_INCLUDE_DIRS_DEBUG} )
set(lz4_INCLUDE_DIR ${lz4_INCLUDE_DIRS_DEBUG} )
set(lz4_LIBRARIES ${lz4_LIBRARIES_DEBUG} )
set(lz4_DEFINITIONS ${lz4_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${lz4_BUILD_MODULES_PATHS_DEBUG} )
    message(${lz4_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


