# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(xz_utils_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(xz_utils_FRAMEWORKS_FOUND_DEBUG "${xz_utils_FRAMEWORKS_DEBUG}" "${xz_utils_FRAMEWORK_DIRS_DEBUG}")

set(xz_utils_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET xz_utils_DEPS_TARGET)
    add_library(xz_utils_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET xz_utils_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${xz_utils_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${xz_utils_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### xz_utils_DEPS_TARGET to all of them
conan_package_library_targets("${xz_utils_LIBS_DEBUG}"    # libraries
                              "${xz_utils_LIB_DIRS_DEBUG}" # package_libdir
                              "${xz_utils_BIN_DIRS_DEBUG}" # package_bindir
                              "${xz_utils_LIBRARY_TYPE_DEBUG}"
                              "${xz_utils_IS_HOST_WINDOWS_DEBUG}"
                              xz_utils_DEPS_TARGET
                              xz_utils_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "xz_utils"    # package_name
                              "${xz_utils_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${xz_utils_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET LibLZMA::LibLZMA
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${xz_utils_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${xz_utils_LIBRARIES_TARGETS}>
                 APPEND)

    if("${xz_utils_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET LibLZMA::LibLZMA
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     xz_utils_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET LibLZMA::LibLZMA
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${xz_utils_LINKER_FLAGS_DEBUG}> APPEND)
    set_property(TARGET LibLZMA::LibLZMA
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${xz_utils_INCLUDE_DIRS_DEBUG}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET LibLZMA::LibLZMA
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${xz_utils_LIB_DIRS_DEBUG}> APPEND)
    set_property(TARGET LibLZMA::LibLZMA
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${xz_utils_COMPILE_DEFINITIONS_DEBUG}> APPEND)
    set_property(TARGET LibLZMA::LibLZMA
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${xz_utils_COMPILE_OPTIONS_DEBUG}> APPEND)

########## For the modules (FindXXX)
set(xz_utils_LIBRARIES_DEBUG LibLZMA::LibLZMA)
