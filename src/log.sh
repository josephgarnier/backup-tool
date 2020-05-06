# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#!/bin/bash

declare DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${DIR}" ]]; then DIR="${PWD}"; fi
source "${DIR}/global.sh"

#######################################
# PRIVATE
#######################################
_log_header() {
	local -n ref_header=${1}
	ref_header="$(date +"%Y/%m/%d %H:%M:%S") [$$]"
}

_log() {
	local -r text="${1}"
	local header=""
	_log_header header
	echo -e "${header} ${text}" |& tee -a "${PROJECT_LOG_FILE}"
}

#######################################
# PUBLIC
#######################################

#######################################
# Log text with info status. Inspired from https://github.com/fredpalmer/log4bash/blob/master/log4bash.sh.
# Globals:
#   PROJECT_LOG_FILE.
# Arguments:
#   <message>: text to log.
# Outputs:
#   None.
# Returns:
#   None.
# Exits:
#   99: if arguments are missing.
#######################################
log_info() {
	local -r -i PARAM_FAILED=99
	if (( $# < 1 )); then
		echo -e "usage: log_info <message>" 1>&2
		exit ${PARAM_FAILED}
	fi

	_log "${1}"
}

#######################################
# Log text with info error. Inspired from https://github.com/fredpalmer/log4bash/blob/master/log4bash.sh.
# Globals:
#   PROJECT_LOG_FILE.
# Arguments:
#   <message>: text to log.
# Outputs:
#   None.
# Returns:
#   None.
# Exits:
#   99: if arguments are missing.
#######################################
log_error() {
	local -r -i PARAM_FAILED=99
	if (( $# < 1 )); then
		echo -e "usage: log_info <message>" 1>&2
		exit ${PARAM_FAILED}
	fi

	_log "${1}"
}