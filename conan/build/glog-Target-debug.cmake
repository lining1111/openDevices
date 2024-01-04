# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(glog_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(glog_FRAMEWORKS_FOUND_DEBUG "${glog_FRAMEWORKS_DEBUG}" "${glog_FRAMEWORK_DIRS_DEBUG}")

set(glog_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET glog_DEPS_TARGET)
    add_library(glog_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET glog_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${glog_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${glog_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:gflags::gflags;libunwind::libunwind>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### glog_DEPS_TARGET to all of them
conan_package_library_targets("${glog_LIBS_DEBUG}"    # libraries
                              "${glog_LIB_DIRS_DEBUG}" # package_libdir
                              "${glog_BIN_DIRS_DEBUG}" # package_bindir
                              "${glog_LIBRARY_TYPE_DEBUG}"
                              "${glog_IS_HOST_WINDOWS_DEBUG}"
                              glog_DEPS_TARGET
                              glog_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "glog"    # package_name
                              "${glog_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${glog_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET glog::glog
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${glog_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${glog_LIBRARIES_TARGETS}>
                 APPEND)

    if("${glog_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET glog::glog
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     glog_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET glog::glog
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${glog_LINKER_FLAGS_DEBUG}> APPEND)
    set_property(TARGET glog::glog
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${glog_INCLUDE_DIRS_DEBUG}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET glog::glog
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${glog_LIB_DIRS_DEBUG}> APPEND)
    set_property(TARGET glog::glog
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${glog_COMPILE_DEFINITIONS_DEBUG}> APPEND)
    set_property(TARGET glog::glog
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${glog_COMPILE_OPTIONS_DEBUG}> APPEND)

########## For the modules (FindXXX)
set(glog_LIBRARIES_DEBUG glog::glog)
