# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(gflags_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(gflags_FRAMEWORKS_FOUND_DEBUG "${gflags_FRAMEWORKS_DEBUG}" "${gflags_FRAMEWORK_DIRS_DEBUG}")

set(gflags_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET gflags_DEPS_TARGET)
    add_library(gflags_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET gflags_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${gflags_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${gflags_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### gflags_DEPS_TARGET to all of them
conan_package_library_targets("${gflags_LIBS_DEBUG}"    # libraries
                              "${gflags_LIB_DIRS_DEBUG}" # package_libdir
                              "${gflags_BIN_DIRS_DEBUG}" # package_bindir
                              "${gflags_LIBRARY_TYPE_DEBUG}"
                              "${gflags_IS_HOST_WINDOWS_DEBUG}"
                              gflags_DEPS_TARGET
                              gflags_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "gflags"    # package_name
                              "${gflags_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${gflags_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET gflags::gflags
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${gflags_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${gflags_LIBRARIES_TARGETS}>
                 APPEND)

    if("${gflags_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET gflags::gflags
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     gflags_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET gflags::gflags
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${gflags_LINKER_FLAGS_DEBUG}> APPEND)
    set_property(TARGET gflags::gflags
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${gflags_INCLUDE_DIRS_DEBUG}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET gflags::gflags
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${gflags_LIB_DIRS_DEBUG}> APPEND)
    set_property(TARGET gflags::gflags
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${gflags_COMPILE_DEFINITIONS_DEBUG}> APPEND)
    set_property(TARGET gflags::gflags
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${gflags_COMPILE_OPTIONS_DEBUG}> APPEND)

########## For the modules (FindXXX)
set(gflags_LIBRARIES_DEBUG gflags::gflags)
