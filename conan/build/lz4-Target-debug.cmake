# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(lz4_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(lz4_FRAMEWORKS_FOUND_DEBUG "${lz4_FRAMEWORKS_DEBUG}" "${lz4_FRAMEWORK_DIRS_DEBUG}")

set(lz4_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET lz4_DEPS_TARGET)
    add_library(lz4_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET lz4_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${lz4_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${lz4_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### lz4_DEPS_TARGET to all of them
conan_package_library_targets("${lz4_LIBS_DEBUG}"    # libraries
                              "${lz4_LIB_DIRS_DEBUG}" # package_libdir
                              "${lz4_BIN_DIRS_DEBUG}" # package_bindir
                              "${lz4_LIBRARY_TYPE_DEBUG}"
                              "${lz4_IS_HOST_WINDOWS_DEBUG}"
                              lz4_DEPS_TARGET
                              lz4_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "lz4"    # package_name
                              "${lz4_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${lz4_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET LZ4::lz4_static
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${lz4_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${lz4_LIBRARIES_TARGETS}>
                 APPEND)

    if("${lz4_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET LZ4::lz4_static
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     lz4_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET LZ4::lz4_static
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${lz4_LINKER_FLAGS_DEBUG}> APPEND)
    set_property(TARGET LZ4::lz4_static
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${lz4_INCLUDE_DIRS_DEBUG}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET LZ4::lz4_static
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${lz4_LIB_DIRS_DEBUG}> APPEND)
    set_property(TARGET LZ4::lz4_static
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${lz4_COMPILE_DEFINITIONS_DEBUG}> APPEND)
    set_property(TARGET LZ4::lz4_static
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${lz4_COMPILE_OPTIONS_DEBUG}> APPEND)

########## For the modules (FindXXX)
set(lz4_LIBRARIES_DEBUG LZ4::lz4_static)
