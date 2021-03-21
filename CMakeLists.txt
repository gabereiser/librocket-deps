cmake_minimum_required(VERSION 3.10)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")

### Require out-of-source builds
file(TO_CMAKE_PATH "${PROJECT_BINARY_DIR}/CMakeLists.txt" LOC_PATH)
if(EXISTS "${LOC_PATH}")
    message(FATAL_ERROR "You cannot build in a source directory (or any directory with a CMakeLists.txt file). Please make a build subdirectory. Feel free to remove CMakeCache.txt and CMakeFiles.")
endif()

### Set C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

IF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  SET(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install" CACHE PATH "Install Path" FORCE)
ENDIF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

set(CMAKE_FIND_ROOT_PATH ${CMAKE_SOURCE_DIR})
set(ZLIB_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/zlib")
set(ZLIB_LIBRARY "${CMAKE_BINARY_DIR}/zlib/Release/zlibstatic.lib")
option(BUILD_STATIC "" ON)
option(BUILD_SHARED_LIBS "" OFF)
option(JSON_BuildTests "" OFF)
option(GLFW_BUILD_EXAMPLES "" OFF)
option(GLFW_BUILD_DOCS "" OFF)
project(rocket-deps)

add_subdirectory(glfw)
add_subdirectory(freetype2)
add_subdirectory(json)
add_subdirectory(libzip)
add_subdirectory(zlib)

add_library(rocket-deps STATIC librocket-deps.cpp)

add_library(rocket::deps ALIAS rocket-deps)

#add_dependencies(librocket-deps zip zlib glm json freetype2 SDL2)
target_link_libraries(rocket-deps zip zlibstatic json freetype2 glfw)



include(GNUInstallDirs)

install( TARGETS rocket-deps
         EXPORT rocket-deps-config
         ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}/lib )
install( DIRECTORY ${CMAKE_SOURCE_DIR}/glm/glm DESTINATION ${CMAKE_INSTALL_PREFIX}/include PATTERN "CMakeLists.txt" EXCLUDE)