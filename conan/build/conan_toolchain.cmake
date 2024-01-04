

# Conan automatically generated toolchain file
# DO NOT EDIT MANUALLY, it will be overwritten

# Avoid including toolchain file several times (bad if appending to variables like
#   CMAKE_CXX_FLAGS. See https://github.com/android/ndk/issues/323
include_guard()

message(STATUS "Using Conan toolchain: ${CMAKE_CURRENT_LIST_FILE}")

if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeToolchain' generator only works with CMake >= 3.15")
endif()










string(APPEND CONAN_CXX_FLAGS " -m64")
string(APPEND CONAN_C_FLAGS " -m64")
string(APPEND CONAN_SHARED_LINKER_FLAGS " -m64")
string(APPEND CONAN_EXE_LINKER_FLAGS " -m64")



message(STATUS "Conan toolchain: C++ Standard 17 with extensions ON")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Extra c, cxx, linkflags and defines


if(DEFINED CONAN_CXX_FLAGS)
  string(APPEND CMAKE_CXX_FLAGS_INIT " ${CONAN_CXX_FLAGS}")
endif()
if(DEFINED CONAN_C_FLAGS)
  string(APPEND CMAKE_C_FLAGS_INIT " ${CONAN_C_FLAGS}")
endif()
if(DEFINED CONAN_SHARED_LINKER_FLAGS)
  string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT " ${CONAN_SHARED_LINKER_FLAGS}")
endif()
if(DEFINED CONAN_EXE_LINKER_FLAGS)
  string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " ${CONAN_EXE_LINKER_FLAGS}")
endif()

get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if(_CMAKE_IN_TRY_COMPILE)
    message(STATUS "Running toolchain IN_TRY_COMPILE")
    return()
endif()

set(CMAKE_FIND_PACKAGE_PREFER_CONFIG ON)

# Definition of CMAKE_MODULE_PATH
list(PREPEND CMAKE_MODULE_PATH "/home/lining/.conan2/p/b/proto1d37e88829c1c/p/lib/cmake/protobuf" "/home/lining/.conan2/p/b/opens79c593763dfb3/p/lib/cmake")
# the generators folder (where conan generates files, like this toolchain)
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

# Definition of CMAKE_PREFIX_PATH, CMAKE_XXXXX_PATH
# The explicitly defined "builddirs" of "host" context dependencies must be in PREFIX_PATH
list(PREPEND CMAKE_PREFIX_PATH "/home/lining/.conan2/p/b/proto1d37e88829c1c/p/lib/cmake/protobuf" "/home/lining/.conan2/p/b/opens79c593763dfb3/p/lib/cmake")
# The Conan local "generators" folder, where this toolchain is saved.
list(PREPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_LIST_DIR} )
list(PREPEND CMAKE_LIBRARY_PATH "/home/lining/.conan2/p/b/libcu585c922363e85/p/lib" "/home/lining/.conan2/p/b/libuu33ba972c462ae/p/lib" "/home/lining/.conan2/p/b/glogbb4d9d46bcdb7/p/lib" "/home/lining/.conan2/p/b/gflagfa02e95bc8609/p/lib" "/home/lining/.conan2/p/b/libun546427a05ba33/p/lib" "/home/lining/.conan2/p/b/xz_utbfbb964550c24/p/lib" "/home/lining/.conan2/p/b/proto1d37e88829c1c/p/lib" "/home/lining/.conan2/p/b/fmt0815b54485efb/p/lib" "/home/lining/.conan2/p/b/poco960aa36358246/p/lib" "/home/lining/.conan2/p/b/pcre2edd38ff993f07/p/lib" "/home/lining/.conan2/p/b/bzip29aac29ffcf0d5/p/lib" "/home/lining/.conan2/p/b/sqlit6c8fda915d2d8/p/lib" "/home/lining/.conan2/p/b/opens79c593763dfb3/p/lib" "/home/lining/.conan2/p/b/zlibc063c70624fc7/p/lib" "/home/lining/.conan2/p/b/libpq9542adee4ba80/p/lib" "/home/lining/.conan2/p/b/expat316657f227866/p/lib" "/home/lining/.conan2/p/rapid4cabb31a09329/p/lib" "/home/lining/.conan2/p/b/librd88e00d826265d/p/lib" "/home/lining/.conan2/p/b/lz4f30fe6ae9e773/p/lib")
list(PREPEND CMAKE_INCLUDE_PATH "/home/lining/.conan2/p/b/libcu585c922363e85/p/include" "/home/lining/.conan2/p/b/libuu33ba972c462ae/p/include" "/home/lining/.conan2/p/b/libuu33ba972c462ae/p/include/uuid" "/home/lining/.conan2/p/b/glogbb4d9d46bcdb7/p/include" "/home/lining/.conan2/p/b/gflagfa02e95bc8609/p/include" "/home/lining/.conan2/p/b/libun546427a05ba33/p/include" "/home/lining/.conan2/p/b/xz_utbfbb964550c24/p/include" "/home/lining/.conan2/p/b/proto1d37e88829c1c/p/include" "/home/lining/.conan2/p/b/fmt0815b54485efb/p/include" "/home/lining/.conan2/p/b/poco960aa36358246/p/include" "/home/lining/.conan2/p/b/pcre2edd38ff993f07/p/include" "/home/lining/.conan2/p/b/bzip29aac29ffcf0d5/p/include" "/home/lining/.conan2/p/b/sqlit6c8fda915d2d8/p/include" "/home/lining/.conan2/p/b/opens79c593763dfb3/p/include" "/home/lining/.conan2/p/b/zlibc063c70624fc7/p/include" "/home/lining/.conan2/p/b/libpq9542adee4ba80/p/include" "/home/lining/.conan2/p/b/expat316657f227866/p/include" "/home/lining/.conan2/p/b/xpackec19ea598cb2b/p/include" "/home/lining/.conan2/p/rapid4cabb31a09329/p/include" "/home/lining/.conan2/p/rapidbbf32a96281c9/p/include" "/home/lining/.conan2/p/rapidbbf32a96281c9/p/include/rapidxml" "/home/lining/.conan2/p/b/librd88e00d826265d/p/include" "/home/lining/.conan2/p/b/lz4f30fe6ae9e773/p/include")



if (DEFINED ENV{PKG_CONFIG_PATH})
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:$ENV{PKG_CONFIG_PATH}")
else()
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:")
endif()




# Variables
# Variables  per configuration


# Preprocessor definitions
# Preprocessor definitions per configuration
