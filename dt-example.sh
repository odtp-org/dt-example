#!/bin/bash
ODTP_USER_EMAIL=maxm@gmail.com
DT_PATH=$(pwd)

DIGITAL_TWIN_NAME=dt-example-1
EXECUTION_NAME=dt-example-execution-3

# Removing gitkeep
rm ${DT_PATH}/dt-example/execution/.gitkeep

# Pulling all the components and versions
odtp new odtp-component-entry \
--component-version v0.1.8 \
--repository https://github.com/odtp-org/odtp-component-example

odtp new odtp-component-entry \
--component-version v0.1.6a \
--repository https://github.com/odtp-org/odtp-pygwalker

# Creating new digital twin
odtp new digital-twin-entry \
--user-email ${ODTP_USER_EMAIL} \
--name ${DIGITAL_TWIN_NAME}

# Creating new workflow
odtp new workflow-entry \
--dt-name ${DIGITAL_TWIN_NAME} \
--name ${WORKFLOW_NAME} \
--component-tags odtp-component-example:v0.1.8,odtp-pygwalker:v0.1.6a

# Creating new execution
odtp new execution-entry \
--name ${EXECUTION_NAME} \
--component-tags odtp-component-example:v0.1.8,odtp-pygwalker:v0.1.6a \
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
