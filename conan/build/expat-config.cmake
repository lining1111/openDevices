########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(expat_FIND_QUIETLY)
    set(expat_MESSAGE_MODE VERBOSE)
else()
    set(expat_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/expatTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${expat_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(expat_VERSION_STRING "2.5.0")
set(expat_INCLUDE_DIRS ${expat_INCLUDE_DIRS_DEBUG} )
set(expat_INCLUDE_DIR ${expat_INCLUDE_DIRS_DEBUG} )
set(expat_LIBRARIES ${expat_LIBRARIES_DEBUG} )
set(expat_DEFINITIONS ${expat_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${expat_BUILD_MODULES_PATHS_DEBUG} )
    message(${expat_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


