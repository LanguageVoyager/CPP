# Set minimum CMake version value
set( PROJ_GLOBAL_CMAKE_VERSION 3.22.1 )

# Set minimum required version of CMake
cmake_minimum_required(  VERSION ${PROJ_GLOBAL_CMAKE_VERSION} ) 

# Set project base name
if( NOT "$ENV{VAR_PROJECT_NAME}" STREQUAL "" )
    set( PROJ_GLOBAL_BASE_NAME "$ENV{VAR_PROJECT_NAME}" )
elseif( DEFINED VAR_PROJECT_NAME )
    set( PROJ_GLOBAL_BASE_NAME "${VAR_PROJECT_NAME}" )
else()
    set( PROJ_GLOBAL_BASE_NAME "CPPExploration" )
endif()

# Set CMake project name
project( "${PROJ_GLOBAL_BASE_NAME}Main" )

# Set compiler flags
set( PROJ_GLOBAL_CXX_FLAGS "-Wall -Werror" )
if( CMAKE_BUILD_TYPE STREQUAL "Release" )
    set( PROJ_GLOBAL_CXX_FLAGS "${PROJ_GLOBAL_CXX_FLAGS} -O3" )
elseif( CMAKE_BUILD_TYPE STREQUAL "Debug" )
    set( PROJ_GLOBAL_CXX_FLAGS "${PROJ_GLOBAL_CXX_FLAGS} -ggdb3 -O0" )
else()
    message( FATAL_ERROR "Build configuration type '${CMAKE_BUILD_TYPE}' is invalid. CMAke will exit." )
endif()

# Find required programm and libraries path
find_library( PROJ_GLOBAL_LIB_PTHREAD pthread REQUIRED )

# Set project paths
set( CMAKE_BINARY_DIR "${PROJECT_BINARY_DIR}" )
set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/libs/static" )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/libs/shared" )
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin" )

# Print informations
message( "Project name: ${PROJECT_NAME}" )
message( "Binary directory: ${CMAKE_BINARY_DIR}" )
message( "Static libraries path: ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}" )
message( "Shared libraries path: ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}" )
message( "Executables path: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}" )

# Set sub-projects name
set( SUBPROJ_NAME_SOURCE "${PROJ_GLOBAL_BASE_NAME}Source" )
set( SUBPROJ_NAME_TEST "${PROJ_GLOBAL_BASE_NAME}Test" )

# Add sub-directories
add_subdirectory( src )
add_subdirectory( test )

# Add custom target and dependencies to build everything
add_custom_target( "${PROJECT_NAME}" )
add_dependencies( "${PROJECT_NAME}"
    "${SUBPROJ_NAME_SOURCE}"
    "${SUBPROJ_NAME_TEST}"
)
