# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libuuid_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(libuuid_FRAMEWORKS_FOUND_DEBUG "${libuuid_FRAMEWORKS_DEBUG}" "${libuuid_FRAMEWORK_DIRS_DEBUG}")

set(libuuid_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libuuid_DEPS_TARGET)
    add_library(libuuid_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libuuid_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${libuuid_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${libuuid_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libuuid_DEPS_TARGET to all of them
conan_package_library_targets("${libuuid_LIBS_DEBUG}"    # libraries
                              "${libuuid_LIB_DIRS_DEBUG}" # package_libdir
                              "${libuuid_BIN_DIRS_DEBUG}" # package_bindir
                              "${libuuid_LIBRARY_TYPE_DEBUG}"
                              "${libuuid_IS_HOST_WINDOWS_DEBUG}"
                              libuuid_DEPS_TARGET
                              libuuid_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "libuuid"    # package_name
                              "${libuuid_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libuuid_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET libuuid::libuuid
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${libuuid_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${libuuid_LIBRARIES_TARGETS}>
                 APPEND)

    if("${libuuid_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET libuuid::libuuid
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     libuuid_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET libuuid::libuuid
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${libuuid_LINKER_FLAGS_DEBUG}> APPEND)
    set_property(TARGET libuuid::libuuid
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${libuuid_INCLUDE_DIRS_DEBUG}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET libuuid::libuuid
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${libuuid_LIB_DIRS_DEBUG}> APPEND)
    set_property(TARGET libuuid::libuuid
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${libuuid_COMPILE_DEFINITIONS_DEBUG}> APPEND)
    set_property(TARGET libuuid::libuuid
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${libuuid_COMPILE_OPTIONS_DEBUG}> APPEND)

########## For the modules (FindXXX)
set(libuuid_LIBRARIES_DEBUG libuuid::libuuid)
