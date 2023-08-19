# Set minimum required version of CMake
cmake_minimum_required(  VERSION ${PROJ_GLOBAL_CMAKE_VERSION} ) 

# Set CMake project name
project( "${SUBPROJ_NAME_TEST}" )

# Print informations
message( "Project name: ${PROJECT_NAME}" )

# Add custom target
add_custom_target( "${PROJECT_NAME}" )
