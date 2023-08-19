#!/bin/bash
set -e

###############################################################################
###############################################################################
########################    Functions    ######################################
###############################################################################
###############################################################################

###############################################################################
# Print help
#------------------------------------------------------------------------------
fnHelp()
{
    echo "Use syntex:"
    echo -e "\t ${0} [Build configuration type] "
    exit 0;
}

###############################################################################
# Evaluate variables for script
#------------------------------------------------------------------------------
fnEvaluateVariables()
{
    echo "Start: Evaluate variables for script"
    varConfigTypeBuildPath="${varCMakeBuildDirPath}/${varBuildConfig}"
    varCMakeCommonBuildParams="--build ${varConfigTypeBuildPath} -j${varParallelBuildJobCount}"
    echo "End: Evaluate variables for script"
}

###############################################################################
# Print variables for script
#------------------------------------------------------------------------------
fnPrintVariables()
{
    echo "Start: Print variables for script"
    echo "Working directory         : ${varWorkingDir}"
    echo "Project name              : ${varProjectName}"
    echo "CMake build path          : ${varCMakeBuildDir}"
    echo "Build configuration type  : ${varBuildConfig}"
    echo "Common CMake parameters   : ${varCMakeCommonBuildParams}"
    echo "Arguments to process      : ${varArgs}"
    echo "End: Print variables for script"
}

###############################################################################
# Configure CMake if not configured already
#------------------------------------------------------------------------------
fnConfigureIfRequired()
{
    if [ ! -d "${varConfigTypeBuildPath}" ]; then
        fnConfigure
    fi
}

###############################################################################
# Configure CMake
#------------------------------------------------------------------------------
fnConfigure()
{
    echo "Start: Configure CMake"
    cmake   -B"${varConfigTypeBuildPath}" \
            -S"${varWorkingDir}" \
            -DCMAKE_BUILD_TYPE="${varBuildConfig}" \
            -DCMAKE_UNITY_BUILD=1 \
            -DVAR_PROJECT_NAME="${varProjectName}"

    echo "End: Configure CMake"
}

###############################################################################
# Build using CMake
#------------------------------------------------------------------------------
fnBuild()
{
    echo "Start: Build using CMake"
    fnConfigureIfRequired
    cmake ${varCMakeCommonBuildParams} --target "${varProjectName}Main"
    echo "End: Build using CMake"
}

###############################################################################
# Build specific CMake target
#------------------------------------------------------------------------------
fnBuildTarget()
{
    echo "Start: Build specific CMake target"
    fnConfigureIfRequired
    cmake ${varCMakeCommonBuildParams} --target "${1}"
    echo "End: Build specific CMake target"
}

###############################################################################
# Delete build artifects of specific build configuration
#------------------------------------------------------------------------------
fnDelete()
{
    echo "Start: Delete build artifects of specific build configuration"
    if [ -d "${varConfigTypeBuildPath}" ]; then
        rm -r "${varConfigTypeBuildPath}"
    fi
    echo "End: Delete build artifects of specific build configuration"
}

###############################################################################
# Delete build artifects of all build configurations
#------------------------------------------------------------------------------
fnDeleteAll()
{
    echo "Start: Delete build artifects of all build configurations"
    if [ -d "${varCMakeBuildDir}" ]; then
        rm -r "${varCMakeBuildDir}"
    fi
    echo "End: Delete build artifects of all build configurations"
}

###############################################################################
###############################################################################
########################    Script Variables    ###############################
###############################################################################
###############################################################################
varWorkingDir="$(pwd)"
varProjectName=CPPExploration
varCMakeBuildDir=Build
varCMakeBuildDirPath="${varWorkingDir}/${varCMakeBuildDir}"
varParallelBuildJobCount=8

varConfigTypeBuildPath=
varCMakeCommonBuildParams=


###############################################################################
###############################################################################
########################    Script normal logic    ############################
###############################################################################
###############################################################################
varBuildConfig=Release
varArgs=${*:1}

if [[ "$1" == --* ]]; then
    if [ "$1" == "--release" ]; then
        varBuildConfig=Release
    elif [ "$1" == "--debug" ]; then
        varBuildConfig=Debug
    else
        fnHelp
    fi

    varArgs=${*:2}
fi

if [[ -z "${varArgs}" ]]; then
    fnHelp
fi

# Evaluate variables for script
fnEvaluateVariables

# Print variables for script
fnPrintVariables

while getopts ":cbt:dDh" varOption ${varArgs}; do
    case $varOption in
        c) # Configure
            fnConfigure
        ;;

        b) # Build using CMake
            fnBuild
        ;;

        t) # Build specific CMake target
            fnBuildTarget "${OPTARG}"
        ;;

        d) # Delete build artifects of specific build configuration
            fnDelete
        ;;

        D) # Delete build artifects of all build configurations
            fnDeleteAll
        ;;

        \?) # Invalid option
            echo -e "Invalid option received.\n"
            ;&
        h) # Print help
            fnHelp
        ;;
    esac
done

echo "------------------- ## Script end ## -------------------"
