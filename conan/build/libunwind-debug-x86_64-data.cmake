########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND libunwind_COMPONENT_NAMES libunwind::unwind libunwind::generic libunwind::ptrace libunwind::setjmp libunwind::coredump)
list(REMOVE_DUPLICATES libunwind_COMPONENT_NAMES)
list(APPEND libunwind_FIND_DEPENDENCY_NAMES LibLZMA ZLIB)
list(REMOVE_DUPLICATES libunwind_FIND_DEPENDENCY_NAMES)
set(LibLZMA_FIND_MODE "NO_MODULE")
set(ZLIB_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(libunwind_PACKAGE_FOLDER_DEBUG "/home/lining/.conan2/p/b/libun546427a05ba33/p")
set(libunwind_BUILD_MODULES_PATHS_DEBUG )


set(libunwind_INCLUDE_DIRS_DEBUG )
set(libunwind_RES_DIRS_DEBUG )
set(libunwind_DEFINITIONS_DEBUG )
set(libunwind_SHARED_LINK_FLAGS_DEBUG )
set(libunwind_EXE_LINK_FLAGS_DEBUG )
set(libunwind_OBJECTS_DEBUG )
set(libunwind_COMPILE_DEFINITIONS_DEBUG )
set(libunwind_COMPILE_OPTIONS_C_DEBUG )
set(libunwind_COMPILE_OPTIONS_CXX_DEBUG )
set(libunwind_LIB_DIRS_DEBUG "${libunwind_PACKAGE_FOLDER_DEBUG}/lib")
set(libunwind_BIN_DIRS_DEBUG )
set(libunwind_LIBRARY_TYPE_DEBUG STATIC)
set(libunwind_IS_HOST_WINDOWS_DEBUG 0)
set(libunwind_LIBS_DEBUG unwind-coredump unwind-setjmp unwind-ptrace unwind-generic unwind)
set(libunwind_SYSTEM_LIBS_DEBUG pthread)
set(libunwind_FRAMEWORK_DIRS_DEBUG )
set(libunwind_FRAMEWORKS_DEBUG )
set(libunwind_BUILD_DIRS_DEBUG )
set(libunwind_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(libunwind_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${libunwind_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${libunwind_COMPILE_OPTIONS_C_DEBUG}>")
set(libunwind_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libunwind_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libunwind_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libunwind_EXE_LINK_FLAGS_DEBUG}>")


set(libunwind_COMPONENTS_DEBUG libunwind::unwind libunwind::generic libunwind::ptrace libunwind::setjmp libunwind::coredump)
########### COMPONENT libunwind::coredump VARIABLES ############################################

set(libunwind_libunwind_coredump_INCLUDE_DIRS_DEBUG )
set(libunwind_libunwind_coredump_LIB_DIRS_DEBUG "${libunwind_PACKAGE_FOLDER_DEBUG}/lib")
set(libunwind_libunwind_coredump_BIN_DIRS_DEBUG )
set(libunwind_libunwind_coredump_LIBRARY_TYPE_DEBUG STATIC)
set(libunwind_libunwind_coredump_IS_HOST_WINDOWS_DEBUG 0)
set(libunwind_libunwind_coredump_RES_DIRS_DEBUG )
set(libunwind_libunwind_coredump_DEFINITIONS_DEBUG )
set(libunwind_libunwind_coredump_OBJECTS_DEBUG )
set(libunwind_libunwind_coredump_COMPILE_DEFINITIONS_DEBUG )
set(libunwind_libunwind_coredump_COMPILE_OPTIONS_C_DEBUG "")
set(libunwind_libunwind_coredump_COMPILE_OPTIONS_CXX_DEBUG "")
set(libunwind_libunwind_coredump_LIBS_DEBUG unwind-coredump)
set(libunwind_libunwind_coredump_SYSTEM_LIBS_DEBUG )
set(libunwind_libunwind_coredump_FRAMEWORK_DIRS_DEBUG )
set(libunwind_libunwind_coredump_FRAMEWORKS_DEBUG )
set(libunwind_libunwind_coredump_DEPENDENCIES_DEBUG libunwind::generic libunwind::unwind)
set(libunwind_libunwind_coredump_SHARED_LINK_FLAGS_DEBUG )
set(libunwind_libunwind_coredump_EXE_LINK_FLAGS_DEBUG )
set(libunwind_libunwind_coredump_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(libunwind_libunwind_coredump_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libunwind_libunwind_coredump_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libunwind_libunwind_coredump_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libunwind_libunwind_coredump_EXE_LINK_FLAGS_DEBUG}>
)
set(libunwind_libunwind_coredump_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${libunwind_libunwind_coredump_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${libunwind_libunwind_coredump_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT libunwind::setjmp VARIABLES ############################################

set(libunwind_libunwind_setjmp_INCLUDE_DIRS_DEBUG )
set(libunwind_libunwind_setjmp_LIB_DIRS_DEBUG "${libunwind_PACKAGE_FOLDER_DEBUG}/lib")
set(libunwind_libunwind_setjmp_BIN_DIRS_DEBUG )
set(libunwind_libunwind_setjmp_LIBRARY_TYPE_DEBUG STATIC)
set(libunwind_libunwind_setjmp_IS_HOST_WINDOWS_DEBUG 0)
set(libunwind_libunwind_setjmp_RES_DIRS_DEBUG )
set(libunwind_libunwind_setjmp_DEFINITIONS_DEBUG )
set(libunwind_libunwind_setjmp_OBJECTS_DEBUG )
set(libunwind_libunwind_setjmp_COMPILE_DEFINITIONS_DEBUG )
set(libunwind_libunwind_setjmp_COMPILE_OPTIONS_C_DEBUG "")
set(libunwind_libunwind_setjmp_COMPILE_OPTIONS_CXX_DEBUG "")
set(libunwind_libunwind_setjmp_LIBS_DEBUG unwind-setjmp)
set(libunwind_libunwind_setjmp_SYSTEM_LIBS_DEBUG )
set(libunwind_libunwind_setjmp_FRAMEWORK_DIRS_DEBUG )
set(libunwind_libunwind_setjmp_FRAMEWORKS_DEBUG )
set(libunwind_libunwind_setjmp_DEPENDENCIES_DEBUG libunwind::unwind)
set(libunwind_libunwind_setjmp_SHARED_LINK_FLAGS_DEBUG )
set(libunwind_libunwind_setjmp_EXE_LINK_FLAGS_DEBUG )
set(libunwind_libunwind_setjmp_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(libunwind_libunwind_setjmp_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libunwind_libunwind_setjmp_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libunwind_libunwind_setjmp_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libunwind_libunwind_setjmp_EXE_LINK_FLAGS_DEBUG}>
)
set(libunwind_libunwind_setjmp_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${libunwind_libunwind_setjmp_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${libunwind_libunwind_setjmp_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT libunwind::ptrace VARIABLES ############################################

set(libunwind_libunwind_ptrace_INCLUDE_DIRS_DEBUG )
set(libunwind_libunwind_ptrace_LIB_DIRS_DEBUG "${libunwind_PACKAGE_FOLDER_DEBUG}/lib")
set(libunwind_libunwind_ptrace_BIN_DIRS_DEBUG )
set(libunwind_libunwind_ptrace_LIBRARY_TYPE_DEBUG STATIC)
set(libunwind_libunwind_ptrace_IS_HOST_WINDOWS_DEBUG 0)
set(libunwind_libunwind_ptrace_RES_DIRS_DEBUG )
set(libunwind_libunwind_ptrace_DEFINITIONS_DEBUG )
set(libunwind_libunwind_ptrace_OBJECTS_DEBUG )
set(libunwind_libunwind_ptrace_COMPILE_DEFINITIONS_DEBUG )
set(libunwind_libunwind_ptrace_COMPILE_OPTIONS_C_DEBUG "")
set(libunwind_libunwind_ptrace_COMPILE_OPTIONS_CXX_DEBUG "")
set(libunwind_libunwind_ptrace_LIBS_DEBUG unwind-ptrace)
set(libunwind_libunwind_ptrace_SYSTEM_LIBS_DEBUG )
set(libunwind_libunwind_ptrace_FRAMEWORK_DIRS_DEBUG )
set(libunwind_libunwind_ptrace_FRAMEWORKS_DEBUG )
set(libunwind_libunwind_ptrace_DEPENDENCIES_DEBUG libunwind::generic libunwind::unwind)
set(libunwind_libunwind_ptrace_SHARED_LINK_FLAGS_DEBUG )
set(libunwind_libunwind_ptrace_EXE_LINK_FLAGS_DEBUG )
set(libunwind_libunwind_ptrace_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(libunwind_libunwind_ptrace_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libunwind_libunwind_ptrace_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libunwind_libunwind_ptrace_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libunwind_libunwind_ptrace_EXE_LINK_FLAGS_DEBUG}>
)
set(libunwind_libunwind_ptrace_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${libunwind_libunwind_ptrace_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${libunwind_libunwind_ptrace_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT libunwind::generic VARIABLES ############################################

set(libunwind_libunwind_generic_INCLUDE_DIRS_DEBUG )
set(libunwind_libunwind_generic_LIB_DIRS_DEBUG "${libunwind_PACKAGE_FOLDER_DEBUG}/lib")
set(libunwind_libunwind_generic_BIN_DIRS_DEBUG )
set(libunwind_libunwind_generic_LIBRARY_TYPE_DEBUG STATIC)
set(libunwind_libunwind_generic_IS_HOST_WINDOWS_DEBUG 0)
set(libunwind_libunwind_generic_RES_DIRS_DEBUG )
set(libunwind_libunwind_generic_DEFINITIONS_DEBUG )
set(libunwind_libunwind_generic_OBJECTS_DEBUG )
set(libunwind_libunwind_generic_COMPILE_DEFINITIONS_DEBUG )
set(libunwind_libunwind_generic_COMPILE_OPTIONS_C_DEBUG "")
set(libunwind_libunwind_generic_COMPILE_OPTIONS_CXX_DEBUG "")
set(libunwind_libunwind_generic_LIBS_DEBUG unwind-generic)
set(libunwind_libunwind_generic_SYSTEM_LIBS_DEBUG )
set(libunwind_libunwind_generic_FRAMEWORK_DIRS_DEBUG )
set(libunwind_libunwind_generic_FRAMEWORKS_DEBUG )
set(libunwind_libunwind_generic_DEPENDENCIES_DEBUG libunwind::unwind)
set(libunwind_libunwind_generic_SHARED_LINK_FLAGS_DEBUG )
set(libunwind_libunwind_generic_EXE_LINK_FLAGS_DEBUG )
set(libunwind_libunwind_generic_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(libunwind_libunwind_generic_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libunwind_libunwind_generic_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libunwind_libunwind_generic_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libunwind_libunwind_generic_EXE_LINK_FLAGS_DEBUG}>
)
set(libunwind_libunwind_generic_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${libunwind_libunwind_generic_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${libunwind_libunwind_generic_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT libunwind::unwind VARIABLES ############################################

set(libunwind_libunwind_unwind_INCLUDE_DIRS_DEBUG )
set(libunwind_libunwind_unwind_LIB_DIRS_DEBUG "${libunwind_PACKAGE_FOLDER_DEBUG}/lib")
set(libunwind_libunwind_unwind_BIN_DIRS_DEBUG )
set(libunwind_libunwind_unwind_LIBRARY_TYPE_DEBUG STATIC)
set(libunwind_libunwind_unwind_IS_HOST_WINDOWS_DEBUG 0)
set(libunwind_libunwind_unwind_RES_DIRS_DEBUG )
set(libunwind_libunwind_unwind_DEFINITIONS_DEBUG )
set(libunwind_libunwind_unwind_OBJECTS_DEBUG )
set(libunwind_libunwind_unwind_COMPILE_DEFINITIONS_DEBUG )
set(libunwind_libunwind_unwind_COMPILE_OPTIONS_C_DEBUG "")
set(libunwind_libunwind_unwind_COMPILE_OPTIONS_CXX_DEBUG "")
set(libunwind_libunwind_unwind_LIBS_DEBUG unwind)
set(libunwind_libunwind_unwind_SYSTEM_LIBS_DEBUG pthread)
set(libunwind_libunwind_unwind_FRAMEWORK_DIRS_DEBUG )
set(libunwind_libunwind_unwind_FRAMEWORKS_DEBUG )
set(libunwind_libunwind_unwind_DEPENDENCIES_DEBUG LibLZMA::LibLZMA ZLIB::ZLIB)
set(libunwind_libunwind_unwind_SHARED_LINK_FLAGS_DEBUG )
set(libunwind_libunwind_unwind_EXE_LINK_FLAGS_DEBUG )
set(libunwind_libunwind_unwind_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(libunwind_libunwind_unwind_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libunwind_libunwind_unwind_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libunwind_libunwind_unwind_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libunwind_libunwind_unwind_EXE_LINK_FLAGS_DEBUG}>
)
set(libunwind_libunwind_unwind_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${libunwind_libunwind_unwind_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${libunwind_libunwind_unwind_COMPILE_OPTIONS_C_DEBUG}>")