# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(librdkafka_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(librdkafka_FRAMEWORKS_FOUND_DEBUG "${librdkafka_FRAMEWORKS_DEBUG}" "${librdkafka_FRAMEWORK_DIRS_DEBUG}")

set(librdkafka_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET librdkafka_DEPS_TARGET)
    add_library(librdkafka_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET librdkafka_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${librdkafka_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${librdkafka_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:LZ4::lz4_static;RdKafka::rdkafka>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### librdkafka_DEPS_TARGET to all of them
conan_package_library_targets("${librdkafka_LIBS_DEBUG}"    # libraries
                              "${librdkafka_LIB_DIRS_DEBUG}" # package_libdir
                              "${librdkafka_BIN_DIRS_DEBUG}" # package_bindir
                              "${librdkafka_LIBRARY_TYPE_DEBUG}"
                              "${librdkafka_IS_HOST_WINDOWS_DEBUG}"
                              librdkafka_DEPS_TARGET
                              librdkafka_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "librdkafka"    # package_name
                              "${librdkafka_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${librdkafka_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Debug ########################################

    ########## COMPONENT RdKafka::rdkafka++ #############

        set(librdkafka_RdKafka_rdkafka++_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(librdkafka_RdKafka_rdkafka++_FRAMEWORKS_FOUND_DEBUG "${librdkafka_RdKafka_rdkafka++_FRAMEWORKS_DEBUG}" "${librdkafka_RdKafka_rdkafka++_FRAMEWORK_DIRS_DEBUG}")

        set(librdkafka_RdKafka_rdkafka++_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET librdkafka_RdKafka_rdkafka++_DEPS_TARGET)
            add_library(librdkafka_RdKafka_rdkafka++_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET librdkafka_RdKafka_rdkafka++_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka++_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka++_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka++_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'librdkafka_RdKafka_rdkafka++_DEPS_TARGET' to all of them
        conan_package_library_targets("${librdkafka_RdKafka_rdkafka++_LIBS_DEBUG}"
                              "${librdkafka_RdKafka_rdkafka++_LIB_DIRS_DEBUG}"
                              "${librdkafka_RdKafka_rdkafka++_BIN_DIRS_DEBUG}" # package_bindir
                              "${librdkafka_RdKafka_rdkafka++_LIBRARY_TYPE_DEBUG}"
                              "${librdkafka_RdKafka_rdkafka++_IS_HOST_WINDOWS_DEBUG}"
                              librdkafka_RdKafka_rdkafka++_DEPS_TARGET
                              librdkafka_RdKafka_rdkafka++_LIBRARIES_TARGETS
                              "_DEBUG"
                              "librdkafka_RdKafka_rdkafka++"
                              "${librdkafka_RdKafka_rdkafka++_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET RdKafka::rdkafka++
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka++_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka++_LIBRARIES_TARGETS}>
                     APPEND)

        if("${librdkafka_RdKafka_rdkafka++_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET RdKafka::rdkafka++
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         librdkafka_RdKafka_rdkafka++_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET RdKafka::rdkafka++ PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka++_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET RdKafka::rdkafka++ PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka++_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET RdKafka::rdkafka++ PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka++_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET RdKafka::rdkafka++ PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka++_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET RdKafka::rdkafka++ PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka++_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT RdKafka::rdkafka #############

        set(librdkafka_RdKafka_rdkafka_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(librdkafka_RdKafka_rdkafka_FRAMEWORKS_FOUND_DEBUG "${librdkafka_RdKafka_rdkafka_FRAMEWORKS_DEBUG}" "${librdkafka_RdKafka_rdkafka_FRAMEWORK_DIRS_DEBUG}")

        set(librdkafka_RdKafka_rdkafka_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET librdkafka_RdKafka_rdkafka_DEPS_TARGET)
            add_library(librdkafka_RdKafka_rdkafka_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET librdkafka_RdKafka_rdkafka_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'librdkafka_RdKafka_rdkafka_DEPS_TARGET' to all of them
        conan_package_library_targets("${librdkafka_RdKafka_rdkafka_LIBS_DEBUG}"
                              "${librdkafka_RdKafka_rdkafka_LIB_DIRS_DEBUG}"
                              "${librdkafka_RdKafka_rdkafka_BIN_DIRS_DEBUG}" # package_bindir
                              "${librdkafka_RdKafka_rdkafka_LIBRARY_TYPE_DEBUG}"
                              "${librdkafka_RdKafka_rdkafka_IS_HOST_WINDOWS_DEBUG}"
                              librdkafka_RdKafka_rdkafka_DEPS_TARGET
                              librdkafka_RdKafka_rdkafka_LIBRARIES_TARGETS
                              "_DEBUG"
                              "librdkafka_RdKafka_rdkafka"
                              "${librdkafka_RdKafka_rdkafka_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET RdKafka::rdkafka
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka_LIBRARIES_TARGETS}>
                     APPEND)

        if("${librdkafka_RdKafka_rdkafka_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET RdKafka::rdkafka
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         librdkafka_RdKafka_rdkafka_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET RdKafka::rdkafka PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET RdKafka::rdkafka PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET RdKafka::rdkafka PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET RdKafka::rdkafka PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET RdKafka::rdkafka PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${librdkafka_RdKafka_rdkafka_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET RdKafka::rdkafka++ PROPERTY INTERFACE_LINK_LIBRARIES RdKafka::rdkafka++ APPEND)
    set_property(TARGET RdKafka::rdkafka++ PROPERTY INTERFACE_LINK_LIBRARIES RdKafka::rdkafka APPEND)

########## For the modules (FindXXX)
set(librdkafka_LIBRARIES_DEBUG RdKafka::rdkafka++)
