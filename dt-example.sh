#!/bin/bash
ODTP_USER_EMAIL=
DT_PATH=$(pwd)

DIGITAL_TWIN_NAME=dt-example
EXECUTION_NAME=dt-example-execution-1

# Removing gitkeep
rm ${DT_PATH}/dt-example/execution/.gitkeep

# Pulling all the components and versions
odtp new odtp-component-entry \
--name odtp-component-example \
--component-version v0.1.2 \
--repository https://github.com/odtp-org/odtp-component-example

odtp new odtp-component-entry \
--name odtp-pygwalker \
--component-version v0.1.0 \
--repository https://github.com/odtp-org/odtp-pygwalker

# Creating new digital twin
odtp new digital-twin-entry \
--user-email ${ODTP_USER_EMAIL}  \
--name ${DIGITAL_TWIN_NAME}

# Creating new execution
odtp new execution-entry \
--name ${EXECUTION_NAME} \
--digital-twin-name ${DIGITAL_TWIN_NAME} \
--component-tags odtp-component-example:v0.1.1,odtp-pygwalker:v0.1.0 \
--parameter-files ${DT_PATH}/dt-example/001.parameters, \
--ports ,8502:8501

# Preparing execution
odtp execution prepare \
--execution-name ${EXECUTION_NAME} \
--project-path ${DT_PATH}/dt-example/execution

# Running execution
odtp execution run \
--execution-name ${EXECUTION_NAME} \
--project-path ${DT_PATH}/dt-example/execution
