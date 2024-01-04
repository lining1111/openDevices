# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libpq_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(libpq_FRAMEWORKS_FOUND_DEBUG "${libpq_FRAMEWORKS_DEBUG}" "${libpq_FRAMEWORK_DIRS_DEBUG}")

set(libpq_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libpq_DEPS_TARGET)
    add_library(libpq_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libpq_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${libpq_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${libpq_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:libpq::pgcommon;libpq::pgport>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libpq_DEPS_TARGET to all of them
conan_package_library_targets("${libpq_LIBS_DEBUG}"    # libraries
                              "${libpq_LIB_DIRS_DEBUG}" # package_libdir
                              "${libpq_BIN_DIRS_DEBUG}" # package_bindir
                              "${libpq_LIBRARY_TYPE_DEBUG}"
                              "${libpq_IS_HOST_WINDOWS_DEBUG}"
                              libpq_DEPS_TARGET
                              libpq_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "libpq"    # package_name
                              "${libpq_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libpq_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Debug ########################################

    ########## COMPONENT libpq::pq #############

        set(libpq_libpq_pq_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(libpq_libpq_pq_FRAMEWORKS_FOUND_DEBUG "${libpq_libpq_pq_FRAMEWORKS_DEBUG}" "${libpq_libpq_pq_FRAMEWORK_DIRS_DEBUG}")

        set(libpq_libpq_pq_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET libpq_libpq_pq_DEPS_TARGET)
            add_library(libpq_libpq_pq_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET libpq_libpq_pq_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${libpq_libpq_pq_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${libpq_libpq_pq_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${libpq_libpq_pq_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'libpq_libpq_pq_DEPS_TARGET' to all of them
        conan_package_library_targets("${libpq_libpq_pq_LIBS_DEBUG}"
                              "${libpq_libpq_pq_LIB_DIRS_DEBUG}"
                              "${libpq_libpq_pq_BIN_DIRS_DEBUG}" # package_bindir
                              "${libpq_libpq_pq_LIBRARY_TYPE_DEBUG}"
                              "${libpq_libpq_pq_IS_HOST_WINDOWS_DEBUG}"
                              libpq_libpq_pq_DEPS_TARGET
                              libpq_libpq_pq_LIBRARIES_TARGETS
                              "_DEBUG"
                              "libpq_libpq_pq"
                              "${libpq_libpq_pq_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET libpq::pq
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${libpq_libpq_pq_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${libpq_libpq_pq_LIBRARIES_TARGETS}>
                     APPEND)

        if("${libpq_libpq_pq_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET libpq::pq
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         libpq_libpq_pq_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET libpq::pq PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${libpq_libpq_pq_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET libpq::pq PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${libpq_libpq_pq_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET libpq::pq PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${libpq_libpq_pq_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET libpq::pq PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${libpq_libpq_pq_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET libpq::pq PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${libpq_libpq_pq_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT libpq::pgcommon #############

        set(libpq_libpq_pgcommon_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(libpq_libpq_pgcommon_FRAMEWORKS_FOUND_DEBUG "${libpq_libpq_pgcommon_FRAMEWORKS_DEBUG}" "${libpq_libpq_pgcommon_FRAMEWORK_DIRS_DEBUG}")

        set(libpq_libpq_pgcommon_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET libpq_libpq_pgcommon_DEPS_TARGET)
            add_library(libpq_libpq_pgcommon_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET libpq_libpq_pgcommon_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${libpq_libpq_pgcommon_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${libpq_libpq_pgcommon_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${libpq_libpq_pgcommon_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'libpq_libpq_pgcommon_DEPS_TARGET' to all of them
        conan_package_library_targets("${libpq_libpq_pgcommon_LIBS_DEBUG}"
                              "${libpq_libpq_pgcommon_LIB_DIRS_DEBUG}"
                              "${libpq_libpq_pgcommon_BIN_DIRS_DEBUG}" # package_bindir
                              "${libpq_libpq_pgcommon_LIBRARY_TYPE_DEBUG}"
                              "${libpq_libpq_pgcommon_IS_HOST_WINDOWS_DEBUG}"
                              libpq_libpq_pgcommon_DEPS_TARGET
                              libpq_libpq_pgcommon_LIBRARIES_TARGETS
                              "_DEBUG"
                              "libpq_libpq_pgcommon"
                              "${libpq_libpq_pgcommon_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET libpq::pgcommon
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${libpq_libpq_pgcommon_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${libpq_libpq_pgcommon_LIBRARIES_TARGETS}>
                     APPEND)

        if("${libpq_libpq_pgcommon_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET libpq::pgcommon
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         libpq_libpq_pgcommon_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET libpq::pgcommon PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${libpq_libpq_pgcommon_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET libpq::pgcommon PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${libpq_libpq_pgcommon_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET libpq::pgcommon PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${libpq_libpq_pgcommon_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET libpq::pgcommon PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${libpq_libpq_pgcommon_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET libpq::pgcommon PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${libpq_libpq_pgcommon_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT libpq::pgport #############

        set(libpq_libpq_pgport_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(libpq_libpq_pgport_FRAMEWORKS_FOUND_DEBUG "${libpq_libpq_pgport_FRAMEWORKS_DEBUG}" "${libpq_libpq_pgport_FRAMEWORK_DIRS_DEBUG}")

        set(libpq_libpq_pgport_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET libpq_libpq_pgport_DEPS_TARGET)
            add_library(libpq_libpq_pgport_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET libpq_libpq_pgport_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${libpq_libpq_pgport_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${libpq_libpq_pgport_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${libpq_libpq_pgport_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'libpq_libpq_pgport_DEPS_TARGET' to all of them
        conan_package_library_targets("${libpq_libpq_pgport_LIBS_DEBUG}"
                              "${libpq_libpq_pgport_LIB_DIRS_DEBUG}"
                              "${libpq_libpq_pgport_BIN_DIRS_DEBUG}" # package_bindir
                              "${libpq_libpq_pgport_LIBRARY_TYPE_DEBUG}"
                              "${libpq_libpq_pgport_IS_HOST_WINDOWS_DEBUG}"
                              libpq_libpq_pgport_DEPS_TARGET
                              libpq_libpq_pgport_LIBRARIES_TARGETS
                              "_DEBUG"
                              "libpq_libpq_pgport"
                              "${libpq_libpq_pgport_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET libpq::pgport
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${libpq_libpq_pgport_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${libpq_libpq_pgport_LIBRARIES_TARGETS}>
                     APPEND)

        if("${libpq_libpq_pgport_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET libpq::pgport
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         libpq_libpq_pgport_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET libpq::pgport PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${libpq_libpq_pgport_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET libpq::pgport PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${libpq_libpq_pgport_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET libpq::pgport PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${libpq_libpq_pgport_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET libpq::pgport PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${libpq_libpq_pgport_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET libpq::pgport PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${libpq_libpq_pgport_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET PostgreSQL::PostgreSQL PROPERTY INTERFACE_LINK_LIBRARIES libpq::pq APPEND)
    set_property(TARGET PostgreSQL::PostgreSQL PROPERTY INTERFACE_LINK_LIBRARIES libpq::pgcommon APPEND)
    set_property(TARGET PostgreSQL::PostgreSQL PROPERTY INTERFACE_LINK_LIBRARIES libpq::pgport APPEND)

########## For the modules (FindXXX)
set(libpq_LIBRARIES_DEBUG PostgreSQL::PostgreSQL)
