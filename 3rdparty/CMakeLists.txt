# Set minimum required version of CMake
cmake_minimum_required(  VERSION ${PROJ_GLOBAL_CMAKE_VERSION} ) 

# Set CMake project name
project( "${SUBPROJ_NAME_THIRD_PARTY}" )

# Print informations
message( "Project name: ${PROJECT_NAME}" )

# Set unit-test framework versions/tags
set( SUBPROJ_GTEST_BRANCH_TAG "v1.14.0" )
set( SUBPROJ_CATCH2_BRANCH_TAG "v3.4.0" )

# Add custom target for google-test unit-testing framework
add_custom_target( "${PROJECT_NAME}CloneGTest"
    COMMAND ls src/googletest >/dev/null || git clone --recursive -b "${SUBPROJ_GTEST_BRANCH_TAG}" https://github.com/google/googletest.git src/googletest
)

add_custom_target( "${PROJECT_NAME}CleanGTest"
    COMMAND rm -rf "${PROJECT_SOURCE_DIR}/libs/googletest"
    COMMAND rm -rf "${PROJECT_SOURCE_DIR}/include/googletest"
)

add_custom_target( "${PROJECT_NAME}GTest"
    DEPENDS "${PROJECT_NAME}CloneGTest"
    DEPENDS "${PROJECT_NAME}CleanGTest"
    COMMAND cmake -B googletest -S src/googletest
    COMMAND cmake --build googletest --target all
    COMMAND ls "${PROJECT_SOURCE_DIR}/libs/googletest" >/dev/null || mkdir -p "${PROJECT_SOURCE_DIR}/libs/googletest"
    COMMAND ls "${PROJECT_SOURCE_DIR}/include/googletest" >/dev/null || mkdir -p "${PROJECT_SOURCE_DIR}/include/googletest"
    COMMAND mv -f googletest/lib/* "${PROJECT_SOURCE_DIR}/libs/googletest/"
    COMMAND cp -rf src/googletest/googlemock/include/* "${PROJECT_SOURCE_DIR}/include/googletest/"
    COMMAND cp -rf src/googletest/googletest/include/* "${PROJECT_SOURCE_DIR}/include/googletest/"
)

# Add custom target for Catch2 unit-testing framework
add_custom_target( "${PROJECT_NAME}CloneCatch2"
    COMMAND ls src/Catch2 >/dev/null || git clone --recursive -b "${SUBPROJ_CATCH2_BRANCH_TAG}" https://github.com/catchorg/Catch2.git src/Catch2
)

add_custom_target( "${PROJECT_NAME}CleanCatch2"
    COMMAND rm -rf "${PROJECT_SOURCE_DIR}/libs/Catch2"
    COMMAND rm -rf "${PROJECT_SOURCE_DIR}/include/Catch2"
)

add_custom_target( "${PROJECT_NAME}Catch2"
    DEPENDS "${PROJECT_NAME}CloneCatch2"
    DEPENDS "${PROJECT_NAME}CleanCatch2"
    COMMAND cmake -B Catch2 -S src/Catch2
    COMMAND cmake --build Catch2 --target all
    COMMAND ls "${PROJECT_SOURCE_DIR}/libs/Catch2" >/dev/null || mkdir -p "${PROJECT_SOURCE_DIR}/libs/Catch2"
    COMMAND ls "${PROJECT_SOURCE_DIR}/include/Catch2/catch2" >/dev/null || mkdir -p "${PROJECT_SOURCE_DIR}/include/Catch2/catch2"
    COMMAND mv -f Catch2/src/libCatch2*.a "${PROJECT_SOURCE_DIR}/libs/Catch2/"
    COMMAND cp -rf src/Catch2/src/catch2/* "${PROJECT_SOURCE_DIR}/include/Catch2/catch2/"
    COMMAND cp -rf Catch2/generated-includes/catch2/* "${PROJECT_SOURCE_DIR}/include/Catch2/catch2/"
)

# Add custom target and dependencies to build everything
add_custom_target( "${PROJECT_NAME}" )
add_dependencies( "${PROJECT_NAME}"
    "${PROJECT_NAME}GTest"
    "${PROJECT_NAME}Catch2"
)
