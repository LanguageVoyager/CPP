# Set minimum required version of CMake
cmake_minimum_required(  VERSION ${PROJ_GLOBAL_CMAKE_VERSION} ) 

# Set CMake project name
project( "${SUBPROJ_NAME_TEST_GTEST}" )

# Print informations
message( "Project name: ${PROJECT_NAME}" )

# Find required programm and libraries path
set( PROJ_LOCAL_LIB_GTEST_PATH "${PROJ_GLOBAL_THIRD_PARTY_LIBS_DIR}/googletest" )
find_library( PROJ_LOCAL_LIB_GTEST gtest
    PATHS "${PROJ_LOCAL_LIB_GTEST_PATH}"
    REQUIRED NO_DEFAULT_PATH
)

find_library( PROJ_LOCAL_LIB_GMOCK gmock
    PATHS "${PROJ_LOCAL_LIB_GTEST_PATH}"
    REQUIRED NO_DEFAULT_PATH
)

find_library( PROJ_LOCAL_LIB_GMOCKMAIN gtest_main
    PATHS "${PROJ_LOCAL_LIB_GTEST_PATH}"
    REQUIRED NO_DEFAULT_PATH
)

# Add Catch2 header path to include directory
include_directories( "${PROJ_GLOBAL_THIRD_PARTY_INCLUDE_DIR}/googletest" )

# Set sub-projects name
# Now, GTest don't support minimum C++14
set( SUBPROJ_NAME_TEST_CPP14 "${PROJECT_NAME}CPP14" )
set( SUBPROJ_NAME_TEST_CPP17 "${PROJECT_NAME}CPP17" )
set( SUBPROJ_NAME_TEST_CPP20 "${PROJECT_NAME}CPP20" )
set( SUBPROJ_NAME_TEST_CPP23 "${PROJECT_NAME}CPP23" )

# Add sub-directories
add_subdirectory( cpp14 )
add_subdirectory( cpp17 )
add_subdirectory( cpp20 )
add_subdirectory( cpp23 )

# Add custom target and dependencies to build everything
add_custom_target( "${PROJECT_NAME}" )
add_dependencies( "${PROJECT_NAME}"
    "${SUBPROJ_NAME_TEST_CPP14}"
    "${SUBPROJ_NAME_TEST_CPP17}"
    "${SUBPROJ_NAME_TEST_CPP20}"
    "${SUBPROJ_NAME_TEST_CPP23}"
)
