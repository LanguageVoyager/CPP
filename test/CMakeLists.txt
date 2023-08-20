# Set minimum required version of CMake
cmake_minimum_required(  VERSION ${PROJ_GLOBAL_CMAKE_VERSION} ) 

# Set CMake project name
project( "${SUBPROJ_NAME_TEST}" )

# Print informations
message( "Project name: ${PROJECT_NAME}" )

# Set sub-projects name
set( SUBPROJ_NAME_TEST_CATCH2 "${PROJECT_NAME}Catch2" )
set( SUBPROJ_NAME_TEST_GTEST "${PROJECT_NAME}GTest" )

# Add sub-directories
add_subdirectory( Catch2Tests )
add_subdirectory( GTests )

# Add custom target and dependencies to build everything
add_custom_target( "${PROJECT_NAME}" )
add_dependencies( "${PROJECT_NAME}"
    "${SUBPROJ_NAME_TEST_CATCH2}"
    "${SUBPROJ_NAME_TEST_GTEST}"
)
