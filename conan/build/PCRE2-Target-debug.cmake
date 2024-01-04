# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(pcre2_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(pcre2_FRAMEWORKS_FOUND_DEBUG "${pcre2_FRAMEWORKS_DEBUG}" "${pcre2_FRAMEWORK_DIRS_DEBUG}")

set(pcre2_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET pcre2_DEPS_TARGET)
    add_library(pcre2_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET pcre2_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${pcre2_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${pcre2_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:ZLIB::ZLIB;BZip2::BZip2;PCRE2::8BIT>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### pcre2_DEPS_TARGET to all of them
conan_package_library_targets("${pcre2_LIBS_DEBUG}"    # libraries
                              "${pcre2_LIB_DIRS_DEBUG}" # package_libdir
                              "${pcre2_BIN_DIRS_DEBUG}" # package_bindir
                              "${pcre2_LIBRARY_TYPE_DEBUG}"
                              "${pcre2_IS_HOST_WINDOWS_DEBUG}"
                              pcre2_DEPS_TARGET
                              pcre2_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "pcre2"    # package_name
                              "${pcre2_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${pcre2_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Debug ########################################

    ########## COMPONENT PCRE2::32BIT #############

        set(pcre2_PCRE2_32BIT_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(pcre2_PCRE2_32BIT_FRAMEWORKS_FOUND_DEBUG "${pcre2_PCRE2_32BIT_FRAMEWORKS_DEBUG}" "${pcre2_PCRE2_32BIT_FRAMEWORK_DIRS_DEBUG}")

        set(pcre2_PCRE2_32BIT_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET pcre2_PCRE2_32BIT_DEPS_TARGET)
            add_library(pcre2_PCRE2_32BIT_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET pcre2_PCRE2_32BIT_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_32BIT_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_32BIT_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_32BIT_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'pcre2_PCRE2_32BIT_DEPS_TARGET' to all of them
        conan_package_library_targets("${pcre2_PCRE2_32BIT_LIBS_DEBUG}"
                              "${pcre2_PCRE2_32BIT_LIB_DIRS_DEBUG}"
                              "${pcre2_PCRE2_32BIT_BIN_DIRS_DEBUG}" # package_bindir
                              "${pcre2_PCRE2_32BIT_LIBRARY_TYPE_DEBUG}"
                              "${pcre2_PCRE2_32BIT_IS_HOST_WINDOWS_DEBUG}"
                              pcre2_PCRE2_32BIT_DEPS_TARGET
                              pcre2_PCRE2_32BIT_LIBRARIES_TARGETS
                              "_DEBUG"
                              "pcre2_PCRE2_32BIT"
                              "${pcre2_PCRE2_32BIT_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET PCRE2::32BIT
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_32BIT_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_32BIT_LIBRARIES_TARGETS}>
                     APPEND)

        if("${pcre2_PCRE2_32BIT_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET PCRE2::32BIT
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         pcre2_PCRE2_32BIT_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET PCRE2::32BIT PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_32BIT_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::32BIT PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_32BIT_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::32BIT PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_32BIT_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::32BIT PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_32BIT_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::32BIT PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_32BIT_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT PCRE2::16BIT #############

        set(pcre2_PCRE2_16BIT_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(pcre2_PCRE2_16BIT_FRAMEWORKS_FOUND_DEBUG "${pcre2_PCRE2_16BIT_FRAMEWORKS_DEBUG}" "${pcre2_PCRE2_16BIT_FRAMEWORK_DIRS_DEBUG}")

        set(pcre2_PCRE2_16BIT_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET pcre2_PCRE2_16BIT_DEPS_TARGET)
            add_library(pcre2_PCRE2_16BIT_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET pcre2_PCRE2_16BIT_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_16BIT_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_16BIT_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_16BIT_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'pcre2_PCRE2_16BIT_DEPS_TARGET' to all of them
        conan_package_library_targets("${pcre2_PCRE2_16BIT_LIBS_DEBUG}"
                              "${pcre2_PCRE2_16BIT_LIB_DIRS_DEBUG}"
                              "${pcre2_PCRE2_16BIT_BIN_DIRS_DEBUG}" # package_bindir
                              "${pcre2_PCRE2_16BIT_LIBRARY_TYPE_DEBUG}"
                              "${pcre2_PCRE2_16BIT_IS_HOST_WINDOWS_DEBUG}"
                              pcre2_PCRE2_16BIT_DEPS_TARGET
                              pcre2_PCRE2_16BIT_LIBRARIES_TARGETS
                              "_DEBUG"
                              "pcre2_PCRE2_16BIT"
                              "${pcre2_PCRE2_16BIT_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET PCRE2::16BIT
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_16BIT_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_16BIT_LIBRARIES_TARGETS}>
                     APPEND)

        if("${pcre2_PCRE2_16BIT_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET PCRE2::16BIT
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         pcre2_PCRE2_16BIT_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET PCRE2::16BIT PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_16BIT_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::16BIT PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_16BIT_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::16BIT PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_16BIT_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::16BIT PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_16BIT_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::16BIT PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_16BIT_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT PCRE2::POSIX #############

        set(pcre2_PCRE2_POSIX_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(pcre2_PCRE2_POSIX_FRAMEWORKS_FOUND_DEBUG "${pcre2_PCRE2_POSIX_FRAMEWORKS_DEBUG}" "${pcre2_PCRE2_POSIX_FRAMEWORK_DIRS_DEBUG}")

        set(pcre2_PCRE2_POSIX_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET pcre2_PCRE2_POSIX_DEPS_TARGET)
            add_library(pcre2_PCRE2_POSIX_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET pcre2_PCRE2_POSIX_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_POSIX_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_POSIX_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_POSIX_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'pcre2_PCRE2_POSIX_DEPS_TARGET' to all of them
        conan_package_library_targets("${pcre2_PCRE2_POSIX_LIBS_DEBUG}"
                              "${pcre2_PCRE2_POSIX_LIB_DIRS_DEBUG}"
                              "${pcre2_PCRE2_POSIX_BIN_DIRS_DEBUG}" # package_bindir
                              "${pcre2_PCRE2_POSIX_LIBRARY_TYPE_DEBUG}"
                              "${pcre2_PCRE2_POSIX_IS_HOST_WINDOWS_DEBUG}"
                              pcre2_PCRE2_POSIX_DEPS_TARGET
                              pcre2_PCRE2_POSIX_LIBRARIES_TARGETS
                              "_DEBUG"
                              "pcre2_PCRE2_POSIX"
                              "${pcre2_PCRE2_POSIX_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET PCRE2::POSIX
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_POSIX_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_POSIX_LIBRARIES_TARGETS}>
                     APPEND)

        if("${pcre2_PCRE2_POSIX_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET PCRE2::POSIX
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         pcre2_PCRE2_POSIX_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET PCRE2::POSIX PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_POSIX_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::POSIX PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_POSIX_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::POSIX PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_POSIX_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::POSIX PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_POSIX_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::POSIX PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_POSIX_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT PCRE2::8BIT #############

        set(pcre2_PCRE2_8BIT_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(pcre2_PCRE2_8BIT_FRAMEWORKS_FOUND_DEBUG "${pcre2_PCRE2_8BIT_FRAMEWORKS_DEBUG}" "${pcre2_PCRE2_8BIT_FRAMEWORK_DIRS_DEBUG}")

        set(pcre2_PCRE2_8BIT_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET pcre2_PCRE2_8BIT_DEPS_TARGET)
            add_library(pcre2_PCRE2_8BIT_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET pcre2_PCRE2_8BIT_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_8BIT_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_8BIT_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_8BIT_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'pcre2_PCRE2_8BIT_DEPS_TARGET' to all of them
        conan_package_library_targets("${pcre2_PCRE2_8BIT_LIBS_DEBUG}"
                              "${pcre2_PCRE2_8BIT_LIB_DIRS_DEBUG}"
                              "${pcre2_PCRE2_8BIT_BIN_DIRS_DEBUG}" # package_bindir
                              "${pcre2_PCRE2_8BIT_LIBRARY_TYPE_DEBUG}"
                              "${pcre2_PCRE2_8BIT_IS_HOST_WINDOWS_DEBUG}"
                              pcre2_PCRE2_8BIT_DEPS_TARGET
                              pcre2_PCRE2_8BIT_LIBRARIES_TARGETS
                              "_DEBUG"
                              "pcre2_PCRE2_8BIT"
                              "${pcre2_PCRE2_8BIT_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET PCRE2::8BIT
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_8BIT_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_8BIT_LIBRARIES_TARGETS}>
                     APPEND)

        if("${pcre2_PCRE2_8BIT_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET PCRE2::8BIT
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         pcre2_PCRE2_8BIT_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET PCRE2::8BIT PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_8BIT_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::8BIT PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_8BIT_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::8BIT PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_8BIT_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::8BIT PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_8BIT_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET PCRE2::8BIT PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${pcre2_PCRE2_8BIT_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET pcre2::pcre2 PROPERTY INTERFACE_LINK_LIBRARIES PCRE2::32BIT APPEND)
    set_property(TARGET pcre2::pcre2 PROPERTY INTERFACE_LINK_LIBRARIES PCRE2::16BIT APPEND)
    set_property(TARGET pcre2::pcre2 PROPERTY INTERFACE_LINK_LIBRARIES PCRE2::POSIX APPEND)
    set_property(TARGET pcre2::pcre2 PROPERTY INTERFACE_LINK_LIBRARIES PCRE2::8BIT APPEND)

########## For the modules (FindXXX)
set(pcre2_LIBRARIES_DEBUG pcre2::pcre2)
