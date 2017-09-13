#!/bin/bash

# get name of the environment by current folder
env_name=${PWD##*/}

# try to activate environment
source activate $env_name > /dev/null 2>&1
# get return code of activation
OUT=$?
# Add R channel
conda config --add channels r > /dev/null 2>&1

# check which os we're on
case "$OSTYPE" in
darwin*)  environment=".environment.osx.yml" ;;
linux*)   environment=".environment.linux.yml"  ;;
esac

# create environment if it does not exist or create is supplied
# this install packages as well
if [[ ($OUT -eq 1)  || ($1 == "create") || ($1 == "install") ]]; then
    conda env create -n $env_name -f $environment
    # if [ $? -ne 0 ]; then return; fi
    shift
fi

# update packages
if [[ $1 == "update" ]]; then
    conda env update --name=$env_name --file=$environment
    shift
fi

# check the return code of operations
OUT=$?

if [[ ! ($OUT -eq 1) ]]; then
    source activate $env_name
fi
