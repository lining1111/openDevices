# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(poco_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(poco_FRAMEWORKS_FOUND_DEBUG "${poco_FRAMEWORKS_DEBUG}" "${poco_FRAMEWORK_DIRS_DEBUG}")

set(poco_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET poco_DEPS_TARGET)
    add_library(poco_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET poco_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${poco_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${poco_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:Poco::Foundation;openssl::openssl;Poco::Data;PostgreSQL::PostgreSQL;SQLite::SQLite3;pcre2::pcre2;ZLIB::ZLIB;Poco::JSON;Poco::Crypto;Poco::Net;Poco::Util;Poco::XML;expat::expat>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### poco_DEPS_TARGET to all of them
conan_package_library_targets("${poco_LIBS_DEBUG}"    # libraries
                              "${poco_LIB_DIRS_DEBUG}" # package_libdir
                              "${poco_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_LIBRARY_TYPE_DEBUG}"
                              "${poco_IS_HOST_WINDOWS_DEBUG}"
                              poco_DEPS_TARGET
                              poco_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "poco"    # package_name
                              "${poco_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${poco_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Debug ########################################

    ########## COMPONENT Poco::NetSSL #############

        set(poco_Poco_NetSSL_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_NetSSL_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_NetSSL_FRAMEWORKS_DEBUG}" "${poco_Poco_NetSSL_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_NetSSL_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_NetSSL_DEPS_TARGET)
            add_library(poco_Poco_NetSSL_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_NetSSL_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_NetSSL_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_NetSSL_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_NetSSL_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_NetSSL_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_NetSSL_LIBS_DEBUG}"
                              "${poco_Poco_NetSSL_LIB_DIRS_DEBUG}"
                              "${poco_Poco_NetSSL_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_NetSSL_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_NetSSL_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_NetSSL_DEPS_TARGET
                              poco_Poco_NetSSL_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_NetSSL"
                              "${poco_Poco_NetSSL_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::NetSSL
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_NetSSL_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_NetSSL_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_NetSSL_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::NetSSL
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_NetSSL_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::NetSSL PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_NetSSL_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::NetSSL PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_NetSSL_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::NetSSL PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_NetSSL_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::NetSSL PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_NetSSL_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::NetSSL PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_NetSSL_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::ActiveRecord #############

        set(poco_Poco_ActiveRecord_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_ActiveRecord_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_ActiveRecord_FRAMEWORKS_DEBUG}" "${poco_Poco_ActiveRecord_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_ActiveRecord_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_ActiveRecord_DEPS_TARGET)
            add_library(poco_Poco_ActiveRecord_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_ActiveRecord_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_ActiveRecord_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_ActiveRecord_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_ActiveRecord_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_ActiveRecord_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_ActiveRecord_LIBS_DEBUG}"
                              "${poco_Poco_ActiveRecord_LIB_DIRS_DEBUG}"
                              "${poco_Poco_ActiveRecord_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_ActiveRecord_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_ActiveRecord_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_ActiveRecord_DEPS_TARGET
                              poco_Poco_ActiveRecord_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_ActiveRecord"
                              "${poco_Poco_ActiveRecord_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::ActiveRecord
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_ActiveRecord_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_ActiveRecord_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_ActiveRecord_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::ActiveRecord
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_ActiveRecord_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::ActiveRecord PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_ActiveRecord_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::ActiveRecord PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_ActiveRecord_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::ActiveRecord PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_ActiveRecord_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::ActiveRecord PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_ActiveRecord_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::ActiveRecord PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_ActiveRecord_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::Zip #############

        set(poco_Poco_Zip_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_Zip_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_Zip_FRAMEWORKS_DEBUG}" "${poco_Poco_Zip_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_Zip_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_Zip_DEPS_TARGET)
            add_library(poco_Poco_Zip_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_Zip_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Zip_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Zip_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Zip_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_Zip_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_Zip_LIBS_DEBUG}"
                              "${poco_Poco_Zip_LIB_DIRS_DEBUG}"
                              "${poco_Poco_Zip_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_Zip_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_Zip_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_Zip_DEPS_TARGET
                              poco_Poco_Zip_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_Zip"
                              "${poco_Poco_Zip_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::Zip
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Zip_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Zip_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_Zip_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::Zip
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_Zip_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::Zip PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Zip_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::Zip PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Zip_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Zip PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Zip_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Zip PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Zip_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::Zip PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Zip_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::Util #############

        set(poco_Poco_Util_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_Util_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_Util_FRAMEWORKS_DEBUG}" "${poco_Poco_Util_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_Util_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_Util_DEPS_TARGET)
            add_library(poco_Poco_Util_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_Util_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Util_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Util_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Util_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_Util_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_Util_LIBS_DEBUG}"
                              "${poco_Poco_Util_LIB_DIRS_DEBUG}"
                              "${poco_Poco_Util_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_Util_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_Util_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_Util_DEPS_TARGET
                              poco_Poco_Util_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_Util"
                              "${poco_Poco_Util_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::Util
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Util_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Util_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_Util_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::Util
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_Util_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::Util PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Util_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::Util PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Util_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Util PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Util_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Util PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Util_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::Util PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Util_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::MongoDB #############

        set(poco_Poco_MongoDB_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_MongoDB_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_MongoDB_FRAMEWORKS_DEBUG}" "${poco_Poco_MongoDB_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_MongoDB_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_MongoDB_DEPS_TARGET)
            add_library(poco_Poco_MongoDB_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_MongoDB_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_MongoDB_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_MongoDB_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_MongoDB_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_MongoDB_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_MongoDB_LIBS_DEBUG}"
                              "${poco_Poco_MongoDB_LIB_DIRS_DEBUG}"
                              "${poco_Poco_MongoDB_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_MongoDB_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_MongoDB_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_MongoDB_DEPS_TARGET
                              poco_Poco_MongoDB_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_MongoDB"
                              "${poco_Poco_MongoDB_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::MongoDB
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_MongoDB_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_MongoDB_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_MongoDB_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::MongoDB
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_MongoDB_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::MongoDB PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_MongoDB_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::MongoDB PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_MongoDB_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::MongoDB PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_MongoDB_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::MongoDB PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_MongoDB_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::MongoDB PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_MongoDB_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::JWT #############

        set(poco_Poco_JWT_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_JWT_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_JWT_FRAMEWORKS_DEBUG}" "${poco_Poco_JWT_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_JWT_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_JWT_DEPS_TARGET)
            add_library(poco_Poco_JWT_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_JWT_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_JWT_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_JWT_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_JWT_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_JWT_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_JWT_LIBS_DEBUG}"
                              "${poco_Poco_JWT_LIB_DIRS_DEBUG}"
                              "${poco_Poco_JWT_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_JWT_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_JWT_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_JWT_DEPS_TARGET
                              poco_Poco_JWT_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_JWT"
                              "${poco_Poco_JWT_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::JWT
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_JWT_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_JWT_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_JWT_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::JWT
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_JWT_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::JWT PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_JWT_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::JWT PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_JWT_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::JWT PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_JWT_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::JWT PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_JWT_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::JWT PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_JWT_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::Encodings #############

        set(poco_Poco_Encodings_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_Encodings_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_Encodings_FRAMEWORKS_DEBUG}" "${poco_Poco_Encodings_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_Encodings_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_Encodings_DEPS_TARGET)
            add_library(poco_Poco_Encodings_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_Encodings_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Encodings_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Encodings_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Encodings_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_Encodings_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_Encodings_LIBS_DEBUG}"
                              "${poco_Poco_Encodings_LIB_DIRS_DEBUG}"
                              "${poco_Poco_Encodings_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_Encodings_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_Encodings_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_Encodings_DEPS_TARGET
                              poco_Poco_Encodings_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_Encodings"
                              "${poco_Poco_Encodings_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::Encodings
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Encodings_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Encodings_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_Encodings_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::Encodings
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_Encodings_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::Encodings PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Encodings_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::Encodings PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Encodings_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Encodings PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Encodings_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Encodings PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Encodings_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::Encodings PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Encodings_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::DataSQLite #############

        set(poco_Poco_DataSQLite_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_DataSQLite_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_DataSQLite_FRAMEWORKS_DEBUG}" "${poco_Poco_DataSQLite_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_DataSQLite_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_DataSQLite_DEPS_TARGET)
            add_library(poco_Poco_DataSQLite_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_DataSQLite_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_DataSQLite_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_DataSQLite_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_DataSQLite_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_DataSQLite_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_DataSQLite_LIBS_DEBUG}"
                              "${poco_Poco_DataSQLite_LIB_DIRS_DEBUG}"
                              "${poco_Poco_DataSQLite_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_DataSQLite_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_DataSQLite_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_DataSQLite_DEPS_TARGET
                              poco_Poco_DataSQLite_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_DataSQLite"
                              "${poco_Poco_DataSQLite_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::DataSQLite
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_DataSQLite_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_DataSQLite_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_DataSQLite_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::DataSQLite
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_DataSQLite_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::DataSQLite PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_DataSQLite_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::DataSQLite PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_DataSQLite_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::DataSQLite PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_DataSQLite_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::DataSQLite PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_DataSQLite_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::DataSQLite PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_DataSQLite_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::DataPostgreSQL #############

        set(poco_Poco_DataPostgreSQL_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_DataPostgreSQL_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_DataPostgreSQL_FRAMEWORKS_DEBUG}" "${poco_Poco_DataPostgreSQL_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_DataPostgreSQL_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_DataPostgreSQL_DEPS_TARGET)
            add_library(poco_Poco_DataPostgreSQL_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_DataPostgreSQL_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_DataPostgreSQL_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_DataPostgreSQL_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_DataPostgreSQL_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_DataPostgreSQL_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_DataPostgreSQL_LIBS_DEBUG}"
                              "${poco_Poco_DataPostgreSQL_LIB_DIRS_DEBUG}"
                              "${poco_Poco_DataPostgreSQL_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_DataPostgreSQL_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_DataPostgreSQL_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_DataPostgreSQL_DEPS_TARGET
                              poco_Poco_DataPostgreSQL_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_DataPostgreSQL"
                              "${poco_Poco_DataPostgreSQL_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::DataPostgreSQL
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_DataPostgreSQL_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_DataPostgreSQL_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_DataPostgreSQL_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::DataPostgreSQL
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_DataPostgreSQL_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::DataPostgreSQL PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_DataPostgreSQL_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::DataPostgreSQL PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_DataPostgreSQL_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::DataPostgreSQL PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_DataPostgreSQL_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::DataPostgreSQL PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_DataPostgreSQL_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::DataPostgreSQL PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_DataPostgreSQL_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::Data #############

        set(poco_Poco_Data_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_Data_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_Data_FRAMEWORKS_DEBUG}" "${poco_Poco_Data_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_Data_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_Data_DEPS_TARGET)
            add_library(poco_Poco_Data_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_Data_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Data_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Data_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Data_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_Data_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_Data_LIBS_DEBUG}"
                              "${poco_Poco_Data_LIB_DIRS_DEBUG}"
                              "${poco_Poco_Data_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_Data_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_Data_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_Data_DEPS_TARGET
                              poco_Poco_Data_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_Data"
                              "${poco_Poco_Data_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::Data
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Data_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Data_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_Data_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::Data
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_Data_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::Data PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Data_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::Data PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Data_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Data PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Data_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Data PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Data_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::Data PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Data_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::Crypto #############

        set(poco_Poco_Crypto_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_Crypto_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_Crypto_FRAMEWORKS_DEBUG}" "${poco_Poco_Crypto_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_Crypto_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_Crypto_DEPS_TARGET)
            add_library(poco_Poco_Crypto_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_Crypto_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Crypto_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Crypto_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Crypto_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_Crypto_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_Crypto_LIBS_DEBUG}"
                              "${poco_Poco_Crypto_LIB_DIRS_DEBUG}"
                              "${poco_Poco_Crypto_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_Crypto_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_Crypto_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_Crypto_DEPS_TARGET
                              poco_Poco_Crypto_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_Crypto"
                              "${poco_Poco_Crypto_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::Crypto
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Crypto_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Crypto_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_Crypto_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::Crypto
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_Crypto_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::Crypto PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Crypto_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::Crypto PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Crypto_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Crypto PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Crypto_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Crypto PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Crypto_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::Crypto PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Crypto_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::XML #############

        set(poco_Poco_XML_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_XML_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_XML_FRAMEWORKS_DEBUG}" "${poco_Poco_XML_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_XML_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_XML_DEPS_TARGET)
            add_library(poco_Poco_XML_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_XML_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_XML_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_XML_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_XML_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_XML_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_XML_LIBS_DEBUG}"
                              "${poco_Poco_XML_LIB_DIRS_DEBUG}"
                              "${poco_Poco_XML_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_XML_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_XML_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_XML_DEPS_TARGET
                              poco_Poco_XML_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_XML"
                              "${poco_Poco_XML_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::XML
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_XML_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_XML_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_XML_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::XML
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_XML_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::XML PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_XML_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::XML PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_XML_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::XML PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_XML_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::XML PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_XML_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::XML PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_XML_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::Redis #############

        set(poco_Poco_Redis_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_Redis_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_Redis_FRAMEWORKS_DEBUG}" "${poco_Poco_Redis_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_Redis_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_Redis_DEPS_TARGET)
            add_library(poco_Poco_Redis_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_Redis_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Redis_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Redis_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Redis_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_Redis_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_Redis_LIBS_DEBUG}"
                              "${poco_Poco_Redis_LIB_DIRS_DEBUG}"
                              "${poco_Poco_Redis_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_Redis_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_Redis_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_Redis_DEPS_TARGET
                              poco_Poco_Redis_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_Redis"
                              "${poco_Poco_Redis_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::Redis
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Redis_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Redis_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_Redis_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::Redis
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_Redis_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::Redis PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Redis_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::Redis PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Redis_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Redis PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Redis_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Redis PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Redis_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::Redis PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Redis_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::Net #############

        set(poco_Poco_Net_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_Net_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_Net_FRAMEWORKS_DEBUG}" "${poco_Poco_Net_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_Net_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_Net_DEPS_TARGET)
            add_library(poco_Poco_Net_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_Net_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Net_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Net_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Net_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_Net_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_Net_LIBS_DEBUG}"
                              "${poco_Poco_Net_LIB_DIRS_DEBUG}"
                              "${poco_Poco_Net_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_Net_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_Net_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_Net_DEPS_TARGET
                              poco_Poco_Net_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_Net"
                              "${poco_Poco_Net_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::Net
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Net_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Net_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_Net_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::Net
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_Net_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::Net PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Net_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::Net PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Net_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Net PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Net_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Net PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Net_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::Net PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Net_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::JSON #############

        set(poco_Poco_JSON_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_JSON_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_JSON_FRAMEWORKS_DEBUG}" "${poco_Poco_JSON_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_JSON_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_JSON_DEPS_TARGET)
            add_library(poco_Poco_JSON_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_JSON_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_JSON_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_JSON_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_JSON_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_JSON_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_JSON_LIBS_DEBUG}"
                              "${poco_Poco_JSON_LIB_DIRS_DEBUG}"
                              "${poco_Poco_JSON_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_JSON_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_JSON_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_JSON_DEPS_TARGET
                              poco_Poco_JSON_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_JSON"
                              "${poco_Poco_JSON_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::JSON
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_JSON_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_JSON_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_JSON_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::JSON
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_JSON_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::JSON PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_JSON_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::JSON PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_JSON_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::JSON PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_JSON_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::JSON PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_JSON_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::JSON PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_JSON_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## COMPONENT Poco::Foundation #############

        set(poco_Poco_Foundation_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(poco_Poco_Foundation_FRAMEWORKS_FOUND_DEBUG "${poco_Poco_Foundation_FRAMEWORKS_DEBUG}" "${poco_Poco_Foundation_FRAMEWORK_DIRS_DEBUG}")

        set(poco_Poco_Foundation_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poco_Poco_Foundation_DEPS_TARGET)
            add_library(poco_Poco_Foundation_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poco_Poco_Foundation_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Foundation_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Foundation_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Foundation_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poco_Poco_Foundation_DEPS_TARGET' to all of them
        conan_package_library_targets("${poco_Poco_Foundation_LIBS_DEBUG}"
                              "${poco_Poco_Foundation_LIB_DIRS_DEBUG}"
                              "${poco_Poco_Foundation_BIN_DIRS_DEBUG}" # package_bindir
                              "${poco_Poco_Foundation_LIBRARY_TYPE_DEBUG}"
                              "${poco_Poco_Foundation_IS_HOST_WINDOWS_DEBUG}"
                              poco_Poco_Foundation_DEPS_TARGET
                              poco_Poco_Foundation_LIBRARIES_TARGETS
                              "_DEBUG"
                              "poco_Poco_Foundation"
                              "${poco_Poco_Foundation_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET Poco::Foundation
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${poco_Poco_Foundation_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${poco_Poco_Foundation_LIBRARIES_TARGETS}>
                     APPEND)

        if("${poco_Poco_Foundation_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET Poco::Foundation
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         poco_Poco_Foundation_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET Poco::Foundation PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Foundation_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET Poco::Foundation PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Foundation_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Foundation PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${poco_Poco_Foundation_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET Poco::Foundation PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Foundation_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET Poco::Foundation PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${poco_Poco_Foundation_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::NetSSL APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::ActiveRecord APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::Zip APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::Util APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::MongoDB APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::JWT APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::Encodings APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::DataSQLite APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::DataPostgreSQL APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::Data APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::Crypto APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::XML APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::Redis APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::Net APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::JSON APPEND)
    set_property(TARGET Poco::Poco PROPERTY INTERFACE_LINK_LIBRARIES Poco::Foundation APPEND)

########## For the modules (FindXXX)
set(poco_LIBRARIES_DEBUG Poco::Poco)
