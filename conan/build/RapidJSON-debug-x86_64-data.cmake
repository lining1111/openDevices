########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(rapidjson_COMPONENT_NAMES "")
set(rapidjson_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(rapidjson_PACKAGE_FOLDER_DEBUG "/home/lining/.conan2/p/rapid4cabb31a09329/p")
set(rapidjson_BUILD_MODULES_PATHS_DEBUG )


set(rapidjson_INCLUDE_DIRS_DEBUG "${rapidjson_PACKAGE_FOLDER_DEBUG}/include")
set(rapidjson_RES_DIRS_DEBUG )
set(rapidjson_DEFINITIONS_DEBUG )
set(rapidjson_SHARED_LINK_FLAGS_DEBUG )
set(rapidjson_EXE_LINK_FLAGS_DEBUG )
set(rapidjson_OBJECTS_DEBUG )
set(rapidjson_COMPILE_DEFINITIONS_DEBUG )
set(rapidjson_COMPILE_OPTIONS_C_DEBUG )
set(rapidjson_COMPILE_OPTIONS_CXX_DEBUG )
set(rapidjson_LIB_DIRS_DEBUG "${rapidjson_PACKAGE_FOLDER_DEBUG}/lib")
set(rapidjson_BIN_DIRS_DEBUG )
set(rapidjson_LIBRARY_TYPE_DEBUG UNKNOWN)
set(rapidjson_IS_HOST_WINDOWS_DEBUG 0)
set(rapidjson_LIBS_DEBUG )
set(rapidjson_SYSTEM_LIBS_DEBUG )
set(rapidjson_FRAMEWORK_DIRS_DEBUG )
set(rapidjson_FRAMEWORKS_DEBUG )
set(rapidjson_BUILD_DIRS_DEBUG )
set(rapidjson_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(rapidjson_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${rapidjson_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${rapidjson_COMPILE_OPTIONS_C_DEBUG}>")
set(rapidjson_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${rapidjson_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${rapidjson_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${rapidjson_EXE_LINK_FLAGS_DEBUG}>")


set(rapidjson_COMPONENTS_DEBUG )