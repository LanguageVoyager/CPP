# Set minimum required version of CMake
cmake_minimum_required(  VERSION ${PROJ_GLOBAL_CMAKE_VERSION} ) 

# Set CMake project name
project( "${SUBPROJ_NAME_SOURCE}" )

# Print informations
message( "Project name: ${PROJECT_NAME}" )

# Set sub-projects name
set( SUBPROJ_NAME_SOURCE_CPP11 "${PROJ_GLOBAL_BASE_NAME}CPP11" )
set( SUBPROJ_NAME_SOURCE_CPP14 "${PROJ_GLOBAL_BASE_NAME}CPP14" )
set( SUBPROJ_NAME_SOURCE_CPP17 "${PROJ_GLOBAL_BASE_NAME}CPP17" )
set( SUBPROJ_NAME_SOURCE_CPP20 "${PROJ_GLOBAL_BASE_NAME}CPP20" )
set( SUBPROJ_NAME_SOURCE_CPP23 "${PROJ_GLOBAL_BASE_NAME}CPP23" )

# Add sub-directories
#add_subdirectory( cpp11 ) # Disabled for now because of compilation error
add_subdirectory( cpp14 )
add_subdirectory( cpp17 )
add_subdirectory( cpp20 )
add_subdirectory( cpp23 )

# Add custom target and dependencies to build everything
add_custom_target( "${PROJECT_NAME}" )
add_dependencies( "${PROJECT_NAME}"
#    "${SUBPROJ_NAME_SOURCE_CPP11}"
    "${SUBPROJ_NAME_SOURCE_CPP14}"
    "${SUBPROJ_NAME_SOURCE_CPP17}"
    "${SUBPROJ_NAME_SOURCE_CPP20}"
    "${SUBPROJ_NAME_SOURCE_CPP23}"
)
