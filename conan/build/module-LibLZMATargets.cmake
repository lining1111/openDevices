# Load the debug and release variables
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB DATA_FILES "${_DIR}/module-LibLZMA-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${xz_utils_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${LibLZMA_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET LibLZMA::LibLZMA)
    add_library(LibLZMA::LibLZMA INTERFACE IMPORTED)
    message(${LibLZMA_MESSAGE_MODE} "Conan: Target declared 'LibLZMA::LibLZMA'")
endif()
# Load the debug and release library finders
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB CONFIG_FILES "${_DIR}/module-LibLZMA-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()