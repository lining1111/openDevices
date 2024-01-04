########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(xpack_COMPONENT_NAMES "")
list(APPEND xpack_FIND_DEPENDENCY_NAMES RapidJSON rapidxml)
list(REMOVE_DUPLICATES xpack_FIND_DEPENDENCY_NAMES)
set(RapidJSON_FIND_MODE "NO_MODULE")
set(rapidxml_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(xpack_PACKAGE_FOLDER_DEBUG "/home/lining/.conan2/p/b/xpackec19ea598cb2b/p")
set(xpack_BUILD_MODULES_PATHS_DEBUG )


set(xpack_INCLUDE_DIRS_DEBUG "${xpack_PACKAGE_FOLDER_DEBUG}/include")
set(xpack_RES_DIRS_DEBUG )
set(xpack_DEFINITIONS_DEBUG )
set(xpack_SHARED_LINK_FLAGS_DEBUG )
set(xpack_EXE_LINK_FLAGS_DEBUG )
set(xpack_OBJECTS_DEBUG )
set(xpack_COMPILE_DEFINITIONS_DEBUG )
set(xpack_COMPILE_OPTIONS_C_DEBUG )
set(xpack_COMPILE_OPTIONS_CXX_DEBUG )
set(xpack_LIB_DIRS_DEBUG )
set(xpack_BIN_DIRS_DEBUG )
set(xpack_LIBRARY_TYPE_DEBUG UNKNOWN)
set(xpack_IS_HOST_WINDOWS_DEBUG 0)
set(xpack_LIBS_DEBUG )
set(xpack_SYSTEM_LIBS_DEBUG )
set(xpack_FRAMEWORK_DIRS_DEBUG )
set(xpack_FRAMEWORKS_DEBUG )
set(xpack_BUILD_DIRS_DEBUG )
set(xpack_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(xpack_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${xpack_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${xpack_COMPILE_OPTIONS_C_DEBUG}>")
set(xpack_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${xpack_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${xpack_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${xpack_EXE_LINK_FLAGS_DEBUG}>")


set(xpack_COMPONENTS_DEBUG )