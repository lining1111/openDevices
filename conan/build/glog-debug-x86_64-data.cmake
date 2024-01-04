########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(glog_COMPONENT_NAMES "")
list(APPEND glog_FIND_DEPENDENCY_NAMES gflags libunwind)
list(REMOVE_DUPLICATES glog_FIND_DEPENDENCY_NAMES)
set(gflags_FIND_MODE "NO_MODULE")
set(libunwind_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(glog_PACKAGE_FOLDER_DEBUG "/home/lining/.conan2/p/b/glogbb4d9d46bcdb7/p")
set(glog_BUILD_MODULES_PATHS_DEBUG )


set(glog_INCLUDE_DIRS_DEBUG "${glog_PACKAGE_FOLDER_DEBUG}/include")
set(glog_RES_DIRS_DEBUG )
set(glog_DEFINITIONS_DEBUG "-DGFLAGS_DLL_DECLARE_FLAG="
			"-DGFLAGS_DLL_DEFINE_FLAG=")
set(glog_SHARED_LINK_FLAGS_DEBUG )
set(glog_EXE_LINK_FLAGS_DEBUG )
set(glog_OBJECTS_DEBUG )
set(glog_COMPILE_DEFINITIONS_DEBUG "GFLAGS_DLL_DECLARE_FLAG="
			"GFLAGS_DLL_DEFINE_FLAG=")
set(glog_COMPILE_OPTIONS_C_DEBUG )
set(glog_COMPILE_OPTIONS_CXX_DEBUG )
set(glog_LIB_DIRS_DEBUG "${glog_PACKAGE_FOLDER_DEBUG}/lib")
set(glog_BIN_DIRS_DEBUG )
set(glog_LIBRARY_TYPE_DEBUG STATIC)
set(glog_IS_HOST_WINDOWS_DEBUG 0)
set(glog_LIBS_DEBUG glogd)
set(glog_SYSTEM_LIBS_DEBUG pthread)
set(glog_FRAMEWORK_DIRS_DEBUG )
set(glog_FRAMEWORKS_DEBUG )
set(glog_BUILD_DIRS_DEBUG )
set(glog_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(glog_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${glog_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${glog_COMPILE_OPTIONS_C_DEBUG}>")
set(glog_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${glog_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${glog_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${glog_EXE_LINK_FLAGS_DEBUG}>")


set(glog_COMPONENTS_DEBUG )