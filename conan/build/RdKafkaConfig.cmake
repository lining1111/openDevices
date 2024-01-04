########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(RdKafka_FIND_QUIETLY)
    set(RdKafka_MESSAGE_MODE VERBOSE)
else()
    set(RdKafka_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/RdKafkaTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${librdkafka_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(RdKafka_VERSION_STRING "2.3.0")
set(RdKafka_INCLUDE_DIRS ${librdkafka_INCLUDE_DIRS_DEBUG} )
set(RdKafka_INCLUDE_DIR ${librdkafka_INCLUDE_DIRS_DEBUG} )
set(RdKafka_LIBRARIES ${librdkafka_LIBRARIES_DEBUG} )
set(RdKafka_DEFINITIONS ${librdkafka_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${librdkafka_BUILD_MODULES_PATHS_DEBUG} )
    message(${RdKafka_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


