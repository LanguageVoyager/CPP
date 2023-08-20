# Set minimum required version of CMake
cmake_minimum_required(  VERSION ${PROJ_GLOBAL_CMAKE_VERSION} ) 

# Set CMake project name
project( "${SUBPROJ_NAME_TEST_CPP14}" )

# Set CMake compiler flags
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14 ${PROJ_GLOBAL_CXX_FLAGS}" )

# Print informations
message( "Project name: ${PROJECT_NAME}" )
message( "CMake compiler flags are: ${CMAKE_CXX_FLAGS}" )

# Create source group
add_executable( "${PROJECT_NAME}"
    TestMain.cpp
)

# Set dependent linking libraries
target_link_libraries( "${PROJECT_NAME}"
    "${PROJ_LOCAL_LIB_GTEST}"
    "${PROJ_LOCAL_LIB_GMOCK}"
    "${PROJ_LOCAL_LIB_GMOCKMAIN}"
    "${PROJ_GLOBAL_LIB_PTHREAD}"
)
