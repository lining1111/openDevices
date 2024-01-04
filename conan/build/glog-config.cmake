########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(glog_FIND_QUIETLY)
    set(glog_MESSAGE_MODE VERBOSE)
else()
    set(glog_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/glogTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${glog_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(glog_VERSION_STRING "0.6.0")
set(glog_INCLUDE_DIRS ${glog_INCLUDE_DIRS_DEBUG} )
set(glog_INCLUDE_DIR ${glog_INCLUDE_DIRS_DEBUG} )
set(glog_LIBRARIES ${glog_LIBRARIES_DEBUG} )
set(glog_DEFINITIONS ${glog_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${glog_BUILD_MODULES_PATHS_DEBUG} )
    message(${glog_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


