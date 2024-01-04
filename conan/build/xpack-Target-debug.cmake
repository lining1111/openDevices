# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(xpack_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(xpack_FRAMEWORKS_FOUND_DEBUG "${xpack_FRAMEWORKS_DEBUG}" "${xpack_FRAMEWORK_DIRS_DEBUG}")

set(xpack_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET xpack_DEPS_TARGET)
    add_library(xpack_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET xpack_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${xpack_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${xpack_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:rapidjson;rapidxml::rapidxml>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### xpack_DEPS_TARGET to all of them
conan_package_library_targets("${xpack_LIBS_DEBUG}"    # libraries
                              "${xpack_LIB_DIRS_DEBUG}" # package_libdir
                              "${xpack_BIN_DIRS_DEBUG}" # package_bindir
                              "${xpack_LIBRARY_TYPE_DEBUG}"
                              "${xpack_IS_HOST_WINDOWS_DEBUG}"
                              xpack_DEPS_TARGET
                              xpack_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "xpack"    # package_name
                              "${xpack_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${xpack_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET xpack::xpack
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${xpack_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${xpack_LIBRARIES_TARGETS}>
                 APPEND)

    if("${xpack_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET xpack::xpack
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     xpack_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET xpack::xpack
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${xpack_LINKER_FLAGS_DEBUG}> APPEND)
    set_property(TARGET xpack::xpack
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${xpack_INCLUDE_DIRS_DEBUG}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET xpack::xpack
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${xpack_LIB_DIRS_DEBUG}> APPEND)
    set_property(TARGET xpack::xpack
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${xpack_COMPILE_DEFINITIONS_DEBUG}> APPEND)
    set_property(TARGET xpack::xpack
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${xpack_COMPILE_OPTIONS_DEBUG}> APPEND)

########## For the modules (FindXXX)
set(xpack_LIBRARIES_DEBUG xpack::xpack)
