########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(gflags_COMPONENT_NAMES "")
set(gflags_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(gflags_PACKAGE_FOLDER_DEBUG "/home/lining/.conan2/p/b/gflagfa02e95bc8609/p")
set(gflags_BUILD_MODULES_PATHS_DEBUG )


set(gflags_INCLUDE_DIRS_DEBUG "${gflags_PACKAGE_FOLDER_DEBUG}/include")
set(gflags_RES_DIRS_DEBUG )
set(gflags_DEFINITIONS_DEBUG )
set(gflags_SHARED_LINK_FLAGS_DEBUG )
set(gflags_EXE_LINK_FLAGS_DEBUG )
set(gflags_OBJECTS_DEBUG )
set(gflags_COMPILE_DEFINITIONS_DEBUG )
set(gflags_COMPILE_OPTIONS_C_DEBUG )
set(gflags_COMPILE_OPTIONS_CXX_DEBUG )
set(gflags_LIB_DIRS_DEBUG "${gflags_PACKAGE_FOLDER_DEBUG}/lib")
set(gflags_BIN_DIRS_DEBUG )
set(gflags_LIBRARY_TYPE_DEBUG STATIC)
set(gflags_IS_HOST_WINDOWS_DEBUG 0)
set(gflags_LIBS_DEBUG gflags_nothreads_debug)
set(gflags_SYSTEM_LIBS_DEBUG pthread m)
set(gflags_FRAMEWORK_DIRS_DEBUG )
set(gflags_FRAMEWORKS_DEBUG )
set(gflags_BUILD_DIRS_DEBUG )
set(gflags_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(gflags_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${gflags_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${gflags_COMPILE_OPTIONS_C_DEBUG}>")
set(gflags_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${gflags_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${gflags_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${gflags_EXE_LINK_FLAGS_DEBUG}>")


set(gflags_COMPONENTS_DEBUG )