########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(lz4_COMPONENT_NAMES "")
set(lz4_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(lz4_PACKAGE_FOLDER_DEBUG "/home/lining/.conan2/p/b/lz4f30fe6ae9e773/p")
set(lz4_BUILD_MODULES_PATHS_DEBUG )


set(lz4_INCLUDE_DIRS_DEBUG )
set(lz4_RES_DIRS_DEBUG )
set(lz4_DEFINITIONS_DEBUG )
set(lz4_SHARED_LINK_FLAGS_DEBUG )
set(lz4_EXE_LINK_FLAGS_DEBUG )
set(lz4_OBJECTS_DEBUG )
set(lz4_COMPILE_DEFINITIONS_DEBUG )
set(lz4_COMPILE_OPTIONS_C_DEBUG )
set(lz4_COMPILE_OPTIONS_CXX_DEBUG )
set(lz4_LIB_DIRS_DEBUG "${lz4_PACKAGE_FOLDER_DEBUG}/lib")
set(lz4_BIN_DIRS_DEBUG )
set(lz4_LIBRARY_TYPE_DEBUG STATIC)
set(lz4_IS_HOST_WINDOWS_DEBUG 0)
set(lz4_LIBS_DEBUG lz4)
set(lz4_SYSTEM_LIBS_DEBUG )
set(lz4_FRAMEWORK_DIRS_DEBUG )
set(lz4_FRAMEWORKS_DEBUG )
set(lz4_BUILD_DIRS_DEBUG )
set(lz4_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(lz4_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${lz4_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${lz4_COMPILE_OPTIONS_C_DEBUG}>")
set(lz4_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${lz4_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${lz4_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${lz4_EXE_LINK_FLAGS_DEBUG}>")


set(lz4_COMPONENTS_DEBUG )