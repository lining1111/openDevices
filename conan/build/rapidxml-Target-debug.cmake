# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(rapidxml_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(rapidxml_FRAMEWORKS_FOUND_DEBUG "${rapidxml_FRAMEWORKS_DEBUG}" "${rapidxml_FRAMEWORK_DIRS_DEBUG}")

set(rapidxml_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET rapidxml_DEPS_TARGET)
    add_library(rapidxml_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET rapidxml_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${rapidxml_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${rapidxml_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### rapidxml_DEPS_TARGET to all of them
conan_package_library_targets("${rapidxml_LIBS_DEBUG}"    # libraries
                              "${rapidxml_LIB_DIRS_DEBUG}" # package_libdir
                              "${rapidxml_BIN_DIRS_DEBUG}" # package_bindir
                              "${rapidxml_LIBRARY_TYPE_DEBUG}"
                              "${rapidxml_IS_HOST_WINDOWS_DEBUG}"
                              rapidxml_DEPS_TARGET
                              rapidxml_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "rapidxml"    # package_name
                              "${rapidxml_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${rapidxml_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET rapidxml::rapidxml
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${rapidxml_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${rapidxml_LIBRARIES_TARGETS}>
                 APPEND)

    if("${rapidxml_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET rapidxml::rapidxml
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     rapidxml_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET rapidxml::rapidxml
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${rapidxml_LINKER_FLAGS_DEBUG}> APPEND)
    set_property(TARGET rapidxml::rapidxml
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${rapidxml_INCLUDE_DIRS_DEBUG}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET rapidxml::rapidxml
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${rapidxml_LIB_DIRS_DEBUG}> APPEND)
    set_property(TARGET rapidxml::rapidxml
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${rapidxml_COMPILE_DEFINITIONS_DEBUG}> APPEND)
    set_property(TARGET rapidxml::rapidxml
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${rapidxml_COMPILE_OPTIONS_DEBUG}> APPEND)

########## For the modules (FindXXX)
set(rapidxml_LIBRARIES_DEBUG rapidxml::rapidxml)
