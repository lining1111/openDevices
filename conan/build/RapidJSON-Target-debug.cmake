# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(rapidjson_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(rapidjson_FRAMEWORKS_FOUND_DEBUG "${rapidjson_FRAMEWORKS_DEBUG}" "${rapidjson_FRAMEWORK_DIRS_DEBUG}")

set(rapidjson_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET rapidjson_DEPS_TARGET)
    add_library(rapidjson_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET rapidjson_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${rapidjson_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${rapidjson_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### rapidjson_DEPS_TARGET to all of them
conan_package_library_targets("${rapidjson_LIBS_DEBUG}"    # libraries
                              "${rapidjson_LIB_DIRS_DEBUG}" # package_libdir
                              "${rapidjson_BIN_DIRS_DEBUG}" # package_bindir
                              "${rapidjson_LIBRARY_TYPE_DEBUG}"
                              "${rapidjson_IS_HOST_WINDOWS_DEBUG}"
                              rapidjson_DEPS_TARGET
                              rapidjson_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "rapidjson"    # package_name
                              "${rapidjson_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${rapidjson_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET rapidjson
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${rapidjson_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${rapidjson_LIBRARIES_TARGETS}>
                 APPEND)

    if("${rapidjson_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET rapidjson
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     rapidjson_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET rapidjson
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${rapidjson_LINKER_FLAGS_DEBUG}> APPEND)
    set_property(TARGET rapidjson
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${rapidjson_INCLUDE_DIRS_DEBUG}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET rapidjson
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${rapidjson_LIB_DIRS_DEBUG}> APPEND)
    set_property(TARGET rapidjson
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${rapidjson_COMPILE_DEFINITIONS_DEBUG}> APPEND)
    set_property(TARGET rapidjson
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${rapidjson_COMPILE_OPTIONS_DEBUG}> APPEND)

########## For the modules (FindXXX)
set(rapidjson_LIBRARIES_DEBUG rapidjson)
