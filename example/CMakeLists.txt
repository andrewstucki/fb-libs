cmake_minimum_required(VERSION 2.8)

add_compile_options(-std=c++14)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(Boost_USE_STATIC_LIBS   ON)
set(OPENSSL_USE_STATIC_LIBS   ON)

find_package(Folly REQUIRED)
find_package(Wangle REQUIRED)
find_package(Proxygen REQUIRED)
find_package(Boost REQUIRED COMPONENTS system thread context)
find_package(OpenSSL REQUIRED)
find_package(Glog REQUIRED)
find_package(Gflags REQUIRED)
find_package(Libevent REQUIRED)
find_package(DoubleConversion REQUIRED)
find_package(Threads REQUIRED)
find_package(Libdl)
find_package(Librt)
find_package(Libunwind)
find_package(Libz)

include_directories(
  ${CMAKE_SOURCE_DIR}/..
  ${FOLLY_INCLUDE_DIR}
  ${WANGLE_INCLUDE_DIR}
  ${PROXYGEN_INCLUDE_DIR}
  ${Boost_INCLUDE_DIR}
  ${OPENSSL_INCLUDE_DIR}
  ${GLOG_INCLUDE_DIRS}
  ${GFLAGS_INCLUDE_DIRS}
  ${LIBEVENT_INCLUDE_DIRS}
  ${DOUBLE_CONVERSION_INCLUDE_DIRS}
  ${INCLUDE_DIR}
)

add_executable(StaticServer static/StaticHandler.cpp static/StaticServer.cpp)
target_link_libraries(StaticServer
  ${PROXYGEN_LIBRARIES}
  ${WANGLE_LIBRARIES}
  ${FOLLY_LIBRARIES}
  ${LIBZ_LIBRARIES}
  ${Boost_LIBRARIES}
  ${OPENSSL_LIBRARIES}
  ${GLOG_LIBRARIES}
  ${GFLAGS_LIBRARIES}
  ${LIBEVENT_LIBRARIES}
  ${DOUBLE_CONVERSION_LIBRARIES}
  ${LIBDL_LIBRARIES}
  ${LIBUNWIND_LIBRARIES}
  ${LIBRT_LIBRARIES})
