# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(expat_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(expat_FRAMEWORKS_FOUND_DEBUG "${expat_FRAMEWORKS_DEBUG}" "${expat_FRAMEWORK_DIRS_DEBUG}")

set(expat_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET expat_DEPS_TARGET)
    add_library(expat_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET expat_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${expat_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${expat_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### expat_DEPS_TARGET to all of them
conan_package_library_targets("${expat_LIBS_DEBUG}"    # libraries
                              "${expat_LIB_DIRS_DEBUG}" # package_libdir
                              "${expat_BIN_DIRS_DEBUG}" # package_bindir
                              "${expat_LIBRARY_TYPE_DEBUG}"
                              "${expat_IS_HOST_WINDOWS_DEBUG}"
                              expat_DEPS_TARGET
                              expat_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "expat"    # package_name
                              "${expat_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${expat_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET expat::expat
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${expat_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${expat_LIBRARIES_TARGETS}>
                 APPEND)

    if("${expat_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET expat::expat
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     expat_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET expat::expat
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${expat_LINKER_FLAGS_DEBUG}> APPEND)
    set_property(TARGET expat::expat
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${expat_INCLUDE_DIRS_DEBUG}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET expat::expat
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${expat_LIB_DIRS_DEBUG}> APPEND)
    set_property(TARGET expat::expat
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${expat_COMPILE_DEFINITIONS_DEBUG}> APPEND)
    set_property(TARGET expat::expat
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${expat_COMPILE_OPTIONS_DEBUG}> APPEND)

########## For the modules (FindXXX)
set(expat_LIBRARIES_DEBUG expat::expat)
