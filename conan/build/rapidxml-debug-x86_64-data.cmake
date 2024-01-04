########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(rapidxml_COMPONENT_NAMES "")
set(rapidxml_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(rapidxml_PACKAGE_FOLDER_DEBUG "/home/lining/.conan2/p/rapidbbf32a96281c9/p")
set(rapidxml_BUILD_MODULES_PATHS_DEBUG )


set(rapidxml_INCLUDE_DIRS_DEBUG "${rapidxml_PACKAGE_FOLDER_DEBUG}/include"
			"${rapidxml_PACKAGE_FOLDER_DEBUG}/include/rapidxml")
set(rapidxml_RES_DIRS_DEBUG )
set(rapidxml_DEFINITIONS_DEBUG )
set(rapidxml_SHARED_LINK_FLAGS_DEBUG )
set(rapidxml_EXE_LINK_FLAGS_DEBUG )
set(rapidxml_OBJECTS_DEBUG )
set(rapidxml_COMPILE_DEFINITIONS_DEBUG )
set(rapidxml_COMPILE_OPTIONS_C_DEBUG )
set(rapidxml_COMPILE_OPTIONS_CXX_DEBUG )
set(rapidxml_LIB_DIRS_DEBUG )
set(rapidxml_BIN_DIRS_DEBUG )
set(rapidxml_LIBRARY_TYPE_DEBUG UNKNOWN)
set(rapidxml_IS_HOST_WINDOWS_DEBUG 0)
set(rapidxml_LIBS_DEBUG )
set(rapidxml_SYSTEM_LIBS_DEBUG )
set(rapidxml_FRAMEWORK_DIRS_DEBUG )
set(rapidxml_FRAMEWORKS_DEBUG )
set(rapidxml_BUILD_DIRS_DEBUG )
set(rapidxml_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(rapidxml_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${rapidxml_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${rapidxml_COMPILE_OPTIONS_C_DEBUG}>")
set(rapidxml_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${rapidxml_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${rapidxml_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${rapidxml_EXE_LINK_FLAGS_DEBUG}>")


set(rapidxml_COMPONENTS_DEBUG )