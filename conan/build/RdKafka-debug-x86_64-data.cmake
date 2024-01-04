########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND librdkafka_COMPONENT_NAMES RdKafka::rdkafka RdKafka::rdkafka++)
list(REMOVE_DUPLICATES librdkafka_COMPONENT_NAMES)
list(APPEND librdkafka_FIND_DEPENDENCY_NAMES lz4)
list(REMOVE_DUPLICATES librdkafka_FIND_DEPENDENCY_NAMES)
set(lz4_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(librdkafka_PACKAGE_FOLDER_DEBUG "/home/lining/.conan2/p/b/librd88e00d826265d/p")
set(librdkafka_BUILD_MODULES_PATHS_DEBUG )


set(librdkafka_INCLUDE_DIRS_DEBUG "${librdkafka_PACKAGE_FOLDER_DEBUG}/include")
set(librdkafka_RES_DIRS_DEBUG )
set(librdkafka_DEFINITIONS_DEBUG "-DLIBRDKAFKA_STATICLIB")
set(librdkafka_SHARED_LINK_FLAGS_DEBUG )
set(librdkafka_EXE_LINK_FLAGS_DEBUG )
set(librdkafka_OBJECTS_DEBUG )
set(librdkafka_COMPILE_DEFINITIONS_DEBUG "LIBRDKAFKA_STATICLIB")
set(librdkafka_COMPILE_OPTIONS_C_DEBUG )
set(librdkafka_COMPILE_OPTIONS_CXX_DEBUG )
set(librdkafka_LIB_DIRS_DEBUG "${librdkafka_PACKAGE_FOLDER_DEBUG}/lib")
set(librdkafka_BIN_DIRS_DEBUG )
set(librdkafka_LIBRARY_TYPE_DEBUG STATIC)
set(librdkafka_IS_HOST_WINDOWS_DEBUG 0)
set(librdkafka_LIBS_DEBUG rdkafka++ rdkafka)
set(librdkafka_SYSTEM_LIBS_DEBUG pthread rt dl m)
set(librdkafka_FRAMEWORK_DIRS_DEBUG )
set(librdkafka_FRAMEWORKS_DEBUG )
set(librdkafka_BUILD_DIRS_DEBUG )
set(librdkafka_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(librdkafka_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${librdkafka_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${librdkafka_COMPILE_OPTIONS_C_DEBUG}>")
set(librdkafka_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${librdkafka_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${librdkafka_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${librdkafka_EXE_LINK_FLAGS_DEBUG}>")


set(librdkafka_COMPONENTS_DEBUG RdKafka::rdkafka RdKafka::rdkafka++)
########### COMPONENT RdKafka::rdkafka++ VARIABLES ############################################

set(librdkafka_RdKafka_rdkafka++_INCLUDE_DIRS_DEBUG "${librdkafka_PACKAGE_FOLDER_DEBUG}/include")
set(librdkafka_RdKafka_rdkafka++_LIB_DIRS_DEBUG "${librdkafka_PACKAGE_FOLDER_DEBUG}/lib")
set(librdkafka_RdKafka_rdkafka++_BIN_DIRS_DEBUG )
set(librdkafka_RdKafka_rdkafka++_LIBRARY_TYPE_DEBUG STATIC)
set(librdkafka_RdKafka_rdkafka++_IS_HOST_WINDOWS_DEBUG 0)
set(librdkafka_RdKafka_rdkafka++_RES_DIRS_DEBUG )
set(librdkafka_RdKafka_rdkafka++_DEFINITIONS_DEBUG )
set(librdkafka_RdKafka_rdkafka++_OBJECTS_DEBUG )
set(librdkafka_RdKafka_rdkafka++_COMPILE_DEFINITIONS_DEBUG )
set(librdkafka_RdKafka_rdkafka++_COMPILE_OPTIONS_C_DEBUG "")
set(librdkafka_RdKafka_rdkafka++_COMPILE_OPTIONS_CXX_DEBUG "")
set(librdkafka_RdKafka_rdkafka++_LIBS_DEBUG rdkafka++)
set(librdkafka_RdKafka_rdkafka++_SYSTEM_LIBS_DEBUG )
set(librdkafka_RdKafka_rdkafka++_FRAMEWORK_DIRS_DEBUG )
set(librdkafka_RdKafka_rdkafka++_FRAMEWORKS_DEBUG )
set(librdkafka_RdKafka_rdkafka++_DEPENDENCIES_DEBUG RdKafka::rdkafka)
set(librdkafka_RdKafka_rdkafka++_SHARED_LINK_FLAGS_DEBUG )
set(librdkafka_RdKafka_rdkafka++_EXE_LINK_FLAGS_DEBUG )
set(librdkafka_RdKafka_rdkafka++_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(librdkafka_RdKafka_rdkafka++_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${librdkafka_RdKafka_rdkafka++_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${librdkafka_RdKafka_rdkafka++_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${librdkafka_RdKafka_rdkafka++_EXE_LINK_FLAGS_DEBUG}>
)
set(librdkafka_RdKafka_rdkafka++_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${librdkafka_RdKafka_rdkafka++_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${librdkafka_RdKafka_rdkafka++_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT RdKafka::rdkafka VARIABLES ############################################

set(librdkafka_RdKafka_rdkafka_INCLUDE_DIRS_DEBUG "${librdkafka_PACKAGE_FOLDER_DEBUG}/include")
set(librdkafka_RdKafka_rdkafka_LIB_DIRS_DEBUG "${librdkafka_PACKAGE_FOLDER_DEBUG}/lib")
set(librdkafka_RdKafka_rdkafka_BIN_DIRS_DEBUG )
set(librdkafka_RdKafka_rdkafka_LIBRARY_TYPE_DEBUG STATIC)
set(librdkafka_RdKafka_rdkafka_IS_HOST_WINDOWS_DEBUG 0)
set(librdkafka_RdKafka_rdkafka_RES_DIRS_DEBUG )
set(librdkafka_RdKafka_rdkafka_DEFINITIONS_DEBUG "-DLIBRDKAFKA_STATICLIB")
set(librdkafka_RdKafka_rdkafka_OBJECTS_DEBUG )
set(librdkafka_RdKafka_rdkafka_COMPILE_DEFINITIONS_DEBUG "LIBRDKAFKA_STATICLIB")
set(librdkafka_RdKafka_rdkafka_COMPILE_OPTIONS_C_DEBUG "")
set(librdkafka_RdKafka_rdkafka_COMPILE_OPTIONS_CXX_DEBUG "")
set(librdkafka_RdKafka_rdkafka_LIBS_DEBUG rdkafka)
set(librdkafka_RdKafka_rdkafka_SYSTEM_LIBS_DEBUG pthread rt dl m)
set(librdkafka_RdKafka_rdkafka_FRAMEWORK_DIRS_DEBUG )
set(librdkafka_RdKafka_rdkafka_FRAMEWORKS_DEBUG )
set(librdkafka_RdKafka_rdkafka_DEPENDENCIES_DEBUG LZ4::lz4_static)
set(librdkafka_RdKafka_rdkafka_SHARED_LINK_FLAGS_DEBUG )
set(librdkafka_RdKafka_rdkafka_EXE_LINK_FLAGS_DEBUG )
set(librdkafka_RdKafka_rdkafka_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(librdkafka_RdKafka_rdkafka_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${librdkafka_RdKafka_rdkafka_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${librdkafka_RdKafka_rdkafka_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${librdkafka_RdKafka_rdkafka_EXE_LINK_FLAGS_DEBUG}>
)
set(librdkafka_RdKafka_rdkafka_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${librdkafka_RdKafka_rdkafka_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${librdkafka_RdKafka_rdkafka_COMPILE_OPTIONS_C_DEBUG}>")