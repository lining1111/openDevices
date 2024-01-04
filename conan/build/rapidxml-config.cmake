########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(rapidxml_FIND_QUIETLY)
    set(rapidxml_MESSAGE_MODE VERBOSE)
else()
    set(rapidxml_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/rapidxmlTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${rapidxml_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(rapidxml_VERSION_STRING "1.13")
set(rapidxml_INCLUDE_DIRS ${rapidxml_INCLUDE_DIRS_DEBUG} )
set(rapidxml_INCLUDE_DIR ${rapidxml_INCLUDE_DIRS_DEBUG} )
set(rapidxml_LIBRARIES ${rapidxml_LIBRARIES_DEBUG} )
set(rapidxml_DEFINITIONS ${rapidxml_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${rapidxml_BUILD_MODULES_PATHS_DEBUG} )
    message(${rapidxml_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


