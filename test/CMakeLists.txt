list(TRANSFORM SRC_FILES PREPEND ../)
##测试客户端
add_executable(testClient testClient.cpp ${SRC_FILES})
target_link_libraries(testClient ${LIBS})
redefine_file_macro(testClient)