########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(libuuid_COMPONENT_NAMES "")
set(libuuid_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(libuuid_PACKAGE_FOLDER_DEBUG "/home/lining/.conan2/p/b/libuu33ba972c462ae/p")
set(libuuid_BUILD_MODULES_PATHS_DEBUG )


set(libuuid_INCLUDE_DIRS_DEBUG "${libuuid_PACKAGE_FOLDER_DEBUG}/include"
			"${libuuid_PACKAGE_FOLDER_DEBUG}/include/uuid")
set(libuuid_RES_DIRS_DEBUG )
set(libuuid_DEFINITIONS_DEBUG )
set(libuuid_SHARED_LINK_FLAGS_DEBUG )
set(libuuid_EXE_LINK_FLAGS_DEBUG )
set(libuuid_OBJECTS_DEBUG )
set(libuuid_COMPILE_DEFINITIONS_DEBUG )
set(libuuid_COMPILE_OPTIONS_C_DEBUG )
set(libuuid_COMPILE_OPTIONS_CXX_DEBUG )
set(libuuid_LIB_DIRS_DEBUG "${libuuid_PACKAGE_FOLDER_DEBUG}/lib")
set(libuuid_BIN_DIRS_DEBUG )
set(libuuid_LIBRARY_TYPE_DEBUG STATIC)
set(libuuid_IS_HOST_WINDOWS_DEBUG 0)
set(libuuid_LIBS_DEBUG uuid)
set(libuuid_SYSTEM_LIBS_DEBUG )
set(libuuid_FRAMEWORK_DIRS_DEBUG )
set(libuuid_FRAMEWORKS_DEBUG )
set(libuuid_BUILD_DIRS_DEBUG )
set(libuuid_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(libuuid_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${libuuid_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${libuuid_COMPILE_OPTIONS_C_DEBUG}>")
set(libuuid_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libuuid_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libuuid_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libuuid_EXE_LINK_FLAGS_DEBUG}>")


set(libuuid_COMPONENTS_DEBUG )