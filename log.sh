# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#!/bin/bash

source global.sh

readonly PROJECT_LOG_FILE="${PROJECT_LOG_DIR}/backup_tool.log"

#######################################
# Log command.
# Globals:
#   log the text passed in parameter.
# Arguments:
#   text to log.
# Returns:
#   None.
#######################################
log() {
	local -r text="${1}"
	echo -e "$(date +"%Y/%m/%d %H:%M:%S") [$$] ${text}" 1>>"${PROJECT_LOG_FILE}" 2>&1
}

#######################################
# Log text with info status.
# Globals:
#   see log command.
# Arguments:
#   text to log.
# Returns:
#   None.
#######################################
log_info() {
	log "${@}"
}