# Set minimum required version of CMake
cmake_minimum_required(  VERSION ${PROJ_GLOBAL_CMAKE_VERSION} ) 

# Set CMake project name
project( "${SUBPROJ_NAME_TEST_CATCH2}" )

# Print informations
message( "Project name: ${PROJECT_NAME}" )

# Find required programm and libraries path
set( PROJ_LOCAL_LIB_CATCH2_PATH "${PROJ_GLOBAL_THIRD_PARTY_LIBS_DIR}/Catch2" )
find_library( PROJ_LOCAL_LIB_CATCH2 Catch2
    PATHS "${PROJ_LOCAL_LIB_CATCH2_PATH}"
    REQUIRED NO_DEFAULT_PATH
)

find_library( PROJ_LOCAL_LIB_CATCH2MAIN Catch2Main
    PATHS "${PROJ_LOCAL_LIB_CATCH2_PATH}"
    REQUIRED NO_DEFAULT_PATH
)

# Add Catch2 header path to include directory
include_directories( "${PROJ_GLOBAL_THIRD_PARTY_INCLUDE_DIR}/Catch2" )
add_compile_definitions( CATCH_CONFIG_CPP11_TO_STRING )

# Set sub-projects name
set( SUBPROJ_NAME_TEST_CPP11 "${PROJECT_NAME}CPP11" )
set( SUBPROJ_NAME_TEST_CPP14 "${PROJECT_NAME}CPP14" )
set( SUBPROJ_NAME_TEST_CPP17 "${PROJECT_NAME}CPP17" )
set( SUBPROJ_NAME_TEST_CPP20 "${PROJECT_NAME}CPP20" )
set( SUBPROJ_NAME_TEST_CPP23 "${PROJECT_NAME}CPP23" )

# Add sub-directories
#add_subdirectory( cpp11 ) # Disabled because of compilation issue
add_subdirectory( cpp14 )
add_subdirectory( cpp17 )
add_subdirectory( cpp20 )
add_subdirectory( cpp23 )

# Add custom target and dependencies to build everything
add_custom_target( "${PROJECT_NAME}" )
add_dependencies( "${PROJECT_NAME}"
#    "${SUBPROJ_NAME_TEST_CPP11}"
    "${SUBPROJ_NAME_TEST_CPP14}"
    "${SUBPROJ_NAME_TEST_CPP17}"
    "${SUBPROJ_NAME_TEST_CPP20}"
    "${SUBPROJ_NAME_TEST_CPP23}"
)
