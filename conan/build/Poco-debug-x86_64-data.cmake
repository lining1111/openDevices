########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND poco_COMPONENT_NAMES Poco::Foundation Poco::JSON Poco::Net Poco::Redis Poco::XML Poco::Crypto Poco::Data Poco::DataPostgreSQL Poco::DataSQLite Poco::Encodings Poco::JWT Poco::MongoDB Poco::Util Poco::Zip Poco::ActiveRecord Poco::NetSSL)
list(REMOVE_DUPLICATES poco_COMPONENT_NAMES)
list(APPEND poco_FIND_DEPENDENCY_NAMES PCRE2 SQLite3 OpenSSL ZLIB PostgreSQL expat)
list(REMOVE_DUPLICATES poco_FIND_DEPENDENCY_NAMES)
set(PCRE2_FIND_MODE "NO_MODULE")
set(SQLite3_FIND_MODE "NO_MODULE")
set(OpenSSL_FIND_MODE "NO_MODULE")
set(ZLIB_FIND_MODE "NO_MODULE")
set(PostgreSQL_FIND_MODE "NO_MODULE")
set(expat_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(poco_PACKAGE_FOLDER_DEBUG "/home/lining/.conan2/p/b/poco960aa36358246/p")
set(poco_BUILD_MODULES_PATHS_DEBUG )


set(poco_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_RES_DIRS_DEBUG )
set(poco_DEFINITIONS_DEBUG "-DPOCO_STATIC=ON"
			"-DPOCO_UNBUNDLED")
set(poco_SHARED_LINK_FLAGS_DEBUG )
set(poco_EXE_LINK_FLAGS_DEBUG )
set(poco_OBJECTS_DEBUG )
set(poco_COMPILE_DEFINITIONS_DEBUG "POCO_STATIC=ON"
			"POCO_UNBUNDLED")
set(poco_COMPILE_OPTIONS_C_DEBUG )
set(poco_COMPILE_OPTIONS_CXX_DEBUG )
set(poco_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_BIN_DIRS_DEBUG )
set(poco_LIBRARY_TYPE_DEBUG STATIC)
set(poco_IS_HOST_WINDOWS_DEBUG 0)
set(poco_LIBS_DEBUG PocoNetSSLd PocoActiveRecordd PocoZipd PocoUtild PocoMongoDBd PocoJWTd PocoEncodingsd PocoDataSQLited PocoDataPostgreSQLd PocoDatad PocoCryptod PocoXMLd PocoRedisd PocoNetd PocoJSONd PocoFoundationd)
set(poco_SYSTEM_LIBS_DEBUG pthread dl rt)
set(poco_FRAMEWORK_DIRS_DEBUG )
set(poco_FRAMEWORKS_DEBUG )
set(poco_BUILD_DIRS_DEBUG )
set(poco_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(poco_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_COMPILE_OPTIONS_C_DEBUG}>")
set(poco_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_EXE_LINK_FLAGS_DEBUG}>")


set(poco_COMPONENTS_DEBUG Poco::Foundation Poco::JSON Poco::Net Poco::Redis Poco::XML Poco::Crypto Poco::Data Poco::DataPostgreSQL Poco::DataSQLite Poco::Encodings Poco::JWT Poco::MongoDB Poco::Util Poco::Zip Poco::ActiveRecord Poco::NetSSL)
########### COMPONENT Poco::NetSSL VARIABLES ############################################

set(poco_Poco_NetSSL_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_NetSSL_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_NetSSL_BIN_DIRS_DEBUG )
set(poco_Poco_NetSSL_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_NetSSL_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_NetSSL_RES_DIRS_DEBUG )
set(poco_Poco_NetSSL_DEFINITIONS_DEBUG )
set(poco_Poco_NetSSL_OBJECTS_DEBUG )
set(poco_Poco_NetSSL_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_NetSSL_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_NetSSL_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_NetSSL_LIBS_DEBUG PocoNetSSLd)
set(poco_Poco_NetSSL_SYSTEM_LIBS_DEBUG )
set(poco_Poco_NetSSL_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_NetSSL_FRAMEWORKS_DEBUG )
set(poco_Poco_NetSSL_DEPENDENCIES_DEBUG Poco::Crypto Poco::Util Poco::Net)
set(poco_Poco_NetSSL_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_NetSSL_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_NetSSL_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_NetSSL_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_NetSSL_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_NetSSL_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_NetSSL_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_NetSSL_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_NetSSL_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_NetSSL_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::ActiveRecord VARIABLES ############################################

set(poco_Poco_ActiveRecord_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_ActiveRecord_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_ActiveRecord_BIN_DIRS_DEBUG )
set(poco_Poco_ActiveRecord_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_ActiveRecord_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_ActiveRecord_RES_DIRS_DEBUG )
set(poco_Poco_ActiveRecord_DEFINITIONS_DEBUG )
set(poco_Poco_ActiveRecord_OBJECTS_DEBUG )
set(poco_Poco_ActiveRecord_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_ActiveRecord_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_ActiveRecord_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_ActiveRecord_LIBS_DEBUG PocoActiveRecordd)
set(poco_Poco_ActiveRecord_SYSTEM_LIBS_DEBUG )
set(poco_Poco_ActiveRecord_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_ActiveRecord_FRAMEWORKS_DEBUG )
set(poco_Poco_ActiveRecord_DEPENDENCIES_DEBUG Poco::Foundation Poco::Data)
set(poco_Poco_ActiveRecord_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_ActiveRecord_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_ActiveRecord_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_ActiveRecord_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_ActiveRecord_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_ActiveRecord_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_ActiveRecord_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_ActiveRecord_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_ActiveRecord_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_ActiveRecord_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::Zip VARIABLES ############################################

set(poco_Poco_Zip_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_Zip_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_Zip_BIN_DIRS_DEBUG )
set(poco_Poco_Zip_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_Zip_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_Zip_RES_DIRS_DEBUG )
set(poco_Poco_Zip_DEFINITIONS_DEBUG )
set(poco_Poco_Zip_OBJECTS_DEBUG )
set(poco_Poco_Zip_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_Zip_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_Zip_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_Zip_LIBS_DEBUG PocoZipd)
set(poco_Poco_Zip_SYSTEM_LIBS_DEBUG )
set(poco_Poco_Zip_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_Zip_FRAMEWORKS_DEBUG )
set(poco_Poco_Zip_DEPENDENCIES_DEBUG Poco::Util Poco::XML)
set(poco_Poco_Zip_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_Zip_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_Zip_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_Zip_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_Zip_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_Zip_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_Zip_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_Zip_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_Zip_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_Zip_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::Util VARIABLES ############################################

set(poco_Poco_Util_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_Util_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_Util_BIN_DIRS_DEBUG )
set(poco_Poco_Util_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_Util_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_Util_RES_DIRS_DEBUG )
set(poco_Poco_Util_DEFINITIONS_DEBUG )
set(poco_Poco_Util_OBJECTS_DEBUG )
set(poco_Poco_Util_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_Util_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_Util_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_Util_LIBS_DEBUG PocoUtild)
set(poco_Poco_Util_SYSTEM_LIBS_DEBUG )
set(poco_Poco_Util_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_Util_FRAMEWORKS_DEBUG )
set(poco_Poco_Util_DEPENDENCIES_DEBUG Poco::Foundation Poco::XML Poco::JSON)
set(poco_Poco_Util_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_Util_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_Util_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_Util_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_Util_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_Util_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_Util_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_Util_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_Util_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_Util_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::MongoDB VARIABLES ############################################

set(poco_Poco_MongoDB_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_MongoDB_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_MongoDB_BIN_DIRS_DEBUG )
set(poco_Poco_MongoDB_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_MongoDB_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_MongoDB_RES_DIRS_DEBUG )
set(poco_Poco_MongoDB_DEFINITIONS_DEBUG )
set(poco_Poco_MongoDB_OBJECTS_DEBUG )
set(poco_Poco_MongoDB_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_MongoDB_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_MongoDB_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_MongoDB_LIBS_DEBUG PocoMongoDBd)
set(poco_Poco_MongoDB_SYSTEM_LIBS_DEBUG )
set(poco_Poco_MongoDB_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_MongoDB_FRAMEWORKS_DEBUG )
set(poco_Poco_MongoDB_DEPENDENCIES_DEBUG Poco::Net)
set(poco_Poco_MongoDB_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_MongoDB_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_MongoDB_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_MongoDB_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_MongoDB_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_MongoDB_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_MongoDB_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_MongoDB_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_MongoDB_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_MongoDB_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::JWT VARIABLES ############################################

set(poco_Poco_JWT_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_JWT_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_JWT_BIN_DIRS_DEBUG )
set(poco_Poco_JWT_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_JWT_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_JWT_RES_DIRS_DEBUG )
set(poco_Poco_JWT_DEFINITIONS_DEBUG )
set(poco_Poco_JWT_OBJECTS_DEBUG )
set(poco_Poco_JWT_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_JWT_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_JWT_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_JWT_LIBS_DEBUG PocoJWTd)
set(poco_Poco_JWT_SYSTEM_LIBS_DEBUG )
set(poco_Poco_JWT_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_JWT_FRAMEWORKS_DEBUG )
set(poco_Poco_JWT_DEPENDENCIES_DEBUG Poco::JSON Poco::Crypto)
set(poco_Poco_JWT_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_JWT_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_JWT_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_JWT_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_JWT_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_JWT_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_JWT_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_JWT_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_JWT_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_JWT_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::Encodings VARIABLES ############################################

set(poco_Poco_Encodings_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_Encodings_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_Encodings_BIN_DIRS_DEBUG )
set(poco_Poco_Encodings_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_Encodings_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_Encodings_RES_DIRS_DEBUG )
set(poco_Poco_Encodings_DEFINITIONS_DEBUG )
set(poco_Poco_Encodings_OBJECTS_DEBUG )
set(poco_Poco_Encodings_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_Encodings_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_Encodings_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_Encodings_LIBS_DEBUG PocoEncodingsd)
set(poco_Poco_Encodings_SYSTEM_LIBS_DEBUG )
set(poco_Poco_Encodings_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_Encodings_FRAMEWORKS_DEBUG )
set(poco_Poco_Encodings_DEPENDENCIES_DEBUG Poco::Foundation)
set(poco_Poco_Encodings_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_Encodings_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_Encodings_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_Encodings_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_Encodings_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_Encodings_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_Encodings_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_Encodings_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_Encodings_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_Encodings_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::DataSQLite VARIABLES ############################################

set(poco_Poco_DataSQLite_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_DataSQLite_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_DataSQLite_BIN_DIRS_DEBUG )
set(poco_Poco_DataSQLite_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_DataSQLite_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_DataSQLite_RES_DIRS_DEBUG )
set(poco_Poco_DataSQLite_DEFINITIONS_DEBUG )
set(poco_Poco_DataSQLite_OBJECTS_DEBUG )
set(poco_Poco_DataSQLite_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_DataSQLite_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_DataSQLite_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_DataSQLite_LIBS_DEBUG PocoDataSQLited)
set(poco_Poco_DataSQLite_SYSTEM_LIBS_DEBUG )
set(poco_Poco_DataSQLite_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_DataSQLite_FRAMEWORKS_DEBUG )
set(poco_Poco_DataSQLite_DEPENDENCIES_DEBUG Poco::Data SQLite::SQLite3)
set(poco_Poco_DataSQLite_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_DataSQLite_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_DataSQLite_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_DataSQLite_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_DataSQLite_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_DataSQLite_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_DataSQLite_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_DataSQLite_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_DataSQLite_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_DataSQLite_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::DataPostgreSQL VARIABLES ############################################

set(poco_Poco_DataPostgreSQL_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_DataPostgreSQL_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_DataPostgreSQL_BIN_DIRS_DEBUG )
set(poco_Poco_DataPostgreSQL_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_DataPostgreSQL_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_DataPostgreSQL_RES_DIRS_DEBUG )
set(poco_Poco_DataPostgreSQL_DEFINITIONS_DEBUG )
set(poco_Poco_DataPostgreSQL_OBJECTS_DEBUG )
set(poco_Poco_DataPostgreSQL_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_DataPostgreSQL_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_DataPostgreSQL_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_DataPostgreSQL_LIBS_DEBUG PocoDataPostgreSQLd)
set(poco_Poco_DataPostgreSQL_SYSTEM_LIBS_DEBUG )
set(poco_Poco_DataPostgreSQL_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_DataPostgreSQL_FRAMEWORKS_DEBUG )
set(poco_Poco_DataPostgreSQL_DEPENDENCIES_DEBUG Poco::Data PostgreSQL::PostgreSQL)
set(poco_Poco_DataPostgreSQL_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_DataPostgreSQL_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_DataPostgreSQL_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_DataPostgreSQL_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_DataPostgreSQL_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_DataPostgreSQL_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_DataPostgreSQL_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_DataPostgreSQL_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_DataPostgreSQL_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_DataPostgreSQL_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::Data VARIABLES ############################################

set(poco_Poco_Data_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_Data_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_Data_BIN_DIRS_DEBUG )
set(poco_Poco_Data_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_Data_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_Data_RES_DIRS_DEBUG )
set(poco_Poco_Data_DEFINITIONS_DEBUG )
set(poco_Poco_Data_OBJECTS_DEBUG )
set(poco_Poco_Data_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_Data_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_Data_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_Data_LIBS_DEBUG PocoDatad)
set(poco_Poco_Data_SYSTEM_LIBS_DEBUG )
set(poco_Poco_Data_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_Data_FRAMEWORKS_DEBUG )
set(poco_Poco_Data_DEPENDENCIES_DEBUG Poco::Foundation)
set(poco_Poco_Data_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_Data_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_Data_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_Data_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_Data_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_Data_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_Data_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_Data_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_Data_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_Data_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::Crypto VARIABLES ############################################

set(poco_Poco_Crypto_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_Crypto_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_Crypto_BIN_DIRS_DEBUG )
set(poco_Poco_Crypto_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_Crypto_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_Crypto_RES_DIRS_DEBUG )
set(poco_Poco_Crypto_DEFINITIONS_DEBUG )
set(poco_Poco_Crypto_OBJECTS_DEBUG )
set(poco_Poco_Crypto_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_Crypto_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_Crypto_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_Crypto_LIBS_DEBUG PocoCryptod)
set(poco_Poco_Crypto_SYSTEM_LIBS_DEBUG )
set(poco_Poco_Crypto_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_Crypto_FRAMEWORKS_DEBUG )
set(poco_Poco_Crypto_DEPENDENCIES_DEBUG Poco::Foundation openssl::openssl)
set(poco_Poco_Crypto_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_Crypto_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_Crypto_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_Crypto_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_Crypto_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_Crypto_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_Crypto_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_Crypto_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_Crypto_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_Crypto_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::XML VARIABLES ############################################

set(poco_Poco_XML_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_XML_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_XML_BIN_DIRS_DEBUG )
set(poco_Poco_XML_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_XML_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_XML_RES_DIRS_DEBUG )
set(poco_Poco_XML_DEFINITIONS_DEBUG )
set(poco_Poco_XML_OBJECTS_DEBUG )
set(poco_Poco_XML_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_XML_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_XML_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_XML_LIBS_DEBUG PocoXMLd)
set(poco_Poco_XML_SYSTEM_LIBS_DEBUG )
set(poco_Poco_XML_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_XML_FRAMEWORKS_DEBUG )
set(poco_Poco_XML_DEPENDENCIES_DEBUG Poco::Foundation expat::expat)
set(poco_Poco_XML_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_XML_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_XML_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_XML_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_XML_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_XML_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_XML_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_XML_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_XML_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_XML_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::Redis VARIABLES ############################################

set(poco_Poco_Redis_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_Redis_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_Redis_BIN_DIRS_DEBUG )
set(poco_Poco_Redis_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_Redis_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_Redis_RES_DIRS_DEBUG )
set(poco_Poco_Redis_DEFINITIONS_DEBUG )
set(poco_Poco_Redis_OBJECTS_DEBUG )
set(poco_Poco_Redis_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_Redis_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_Redis_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_Redis_LIBS_DEBUG PocoRedisd)
set(poco_Poco_Redis_SYSTEM_LIBS_DEBUG )
set(poco_Poco_Redis_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_Redis_FRAMEWORKS_DEBUG )
set(poco_Poco_Redis_DEPENDENCIES_DEBUG Poco::Net)
set(poco_Poco_Redis_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_Redis_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_Redis_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_Redis_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_Redis_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_Redis_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_Redis_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_Redis_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_Redis_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_Redis_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::Net VARIABLES ############################################

set(poco_Poco_Net_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_Net_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_Net_BIN_DIRS_DEBUG )
set(poco_Poco_Net_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_Net_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_Net_RES_DIRS_DEBUG )
set(poco_Poco_Net_DEFINITIONS_DEBUG )
set(poco_Poco_Net_OBJECTS_DEBUG )
set(poco_Poco_Net_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_Net_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_Net_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_Net_LIBS_DEBUG PocoNetd)
set(poco_Poco_Net_SYSTEM_LIBS_DEBUG )
set(poco_Poco_Net_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_Net_FRAMEWORKS_DEBUG )
set(poco_Poco_Net_DEPENDENCIES_DEBUG Poco::Foundation)
set(poco_Poco_Net_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_Net_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_Net_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_Net_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_Net_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_Net_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_Net_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_Net_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_Net_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_Net_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::JSON VARIABLES ############################################

set(poco_Poco_JSON_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_JSON_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_JSON_BIN_DIRS_DEBUG )
set(poco_Poco_JSON_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_JSON_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_JSON_RES_DIRS_DEBUG )
set(poco_Poco_JSON_DEFINITIONS_DEBUG )
set(poco_Poco_JSON_OBJECTS_DEBUG )
set(poco_Poco_JSON_COMPILE_DEFINITIONS_DEBUG )
set(poco_Poco_JSON_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_JSON_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_JSON_LIBS_DEBUG PocoJSONd)
set(poco_Poco_JSON_SYSTEM_LIBS_DEBUG )
set(poco_Poco_JSON_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_JSON_FRAMEWORKS_DEBUG )
set(poco_Poco_JSON_DEPENDENCIES_DEBUG Poco::Foundation)
set(poco_Poco_JSON_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_JSON_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_JSON_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_JSON_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_JSON_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_JSON_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_JSON_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_JSON_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_JSON_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_JSON_COMPILE_OPTIONS_C_DEBUG}>")
########### COMPONENT Poco::Foundation VARIABLES ############################################

set(poco_Poco_Foundation_INCLUDE_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/include")
set(poco_Poco_Foundation_LIB_DIRS_DEBUG "${poco_PACKAGE_FOLDER_DEBUG}/lib")
set(poco_Poco_Foundation_BIN_DIRS_DEBUG )
set(poco_Poco_Foundation_LIBRARY_TYPE_DEBUG STATIC)
set(poco_Poco_Foundation_IS_HOST_WINDOWS_DEBUG 0)
set(poco_Poco_Foundation_RES_DIRS_DEBUG )
set(poco_Poco_Foundation_DEFINITIONS_DEBUG "-DPOCO_STATIC=ON"
			"-DPOCO_UNBUNDLED")
set(poco_Poco_Foundation_OBJECTS_DEBUG )
set(poco_Poco_Foundation_COMPILE_DEFINITIONS_DEBUG "POCO_STATIC=ON"
			"POCO_UNBUNDLED")
set(poco_Poco_Foundation_COMPILE_OPTIONS_C_DEBUG "")
set(poco_Poco_Foundation_COMPILE_OPTIONS_CXX_DEBUG "")
set(poco_Poco_Foundation_LIBS_DEBUG PocoFoundationd)
set(poco_Poco_Foundation_SYSTEM_LIBS_DEBUG pthread dl rt)
set(poco_Poco_Foundation_FRAMEWORK_DIRS_DEBUG )
set(poco_Poco_Foundation_FRAMEWORKS_DEBUG )
set(poco_Poco_Foundation_DEPENDENCIES_DEBUG pcre2::pcre2 ZLIB::ZLIB)
set(poco_Poco_Foundation_SHARED_LINK_FLAGS_DEBUG )
set(poco_Poco_Foundation_EXE_LINK_FLAGS_DEBUG )
set(poco_Poco_Foundation_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(poco_Poco_Foundation_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poco_Poco_Foundation_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poco_Poco_Foundation_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poco_Poco_Foundation_EXE_LINK_FLAGS_DEBUG}>
)
set(poco_Poco_Foundation_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${poco_Poco_Foundation_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${poco_Poco_Foundation_COMPILE_OPTIONS_C_DEBUG}>")