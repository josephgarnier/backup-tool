# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#!/bin/bash

declare DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${DIR}" ]]; then DIR="${PWD}"; fi
source "${DIR}/global.sh"
source "${DIR}/utility.sh"

#######################################
# PRIVATE
#######################################
_trap_add() {
	local -r command="${1}"
	local -r signal="${2}"
	local handler="$(trap -p "${signal}")"
	if [[ -n "${handler}" ]]; then
		handler="${handler/trap -- \'/}"    # strip `trap '...' SIGNAL` -> ...
		handler="${handler%\'*}"            # 
		handler="${handler//\'\\\'\'/\'}"   # <- Unquote quoted quotes ('\'')
		trap "${handler};${command}" "${signal}"
	else
		trap "${command}" "${signal}"
	fi
}

_no_more_locking() {
	local -r lockfile="${1}"
	local -r -i filedescriptor=${2}
	flock --unlock ${filedescriptor}
	flock --exclusive --nonblock ${filedescriptor} && rm -f "${lockfile}"
}

_prepare_mutex() {
	local -r lockfile="${1}"
	local -r -i filedescriptor=${2}
	eval "exec ${filedescriptor}>\"${lockfile}\""
	_trap_add "_no_more_locking ${lockfile} ${filedescriptor}" "EXIT"
}

#######################################
# PUBLIC
#######################################

#######################################
# Create and lock a lock file, like https://linux.die.net/man/1/lockfile.. Inspired from https://stackoverflow.com/questions/1715137/what-is-the-best-way-to-ensure-only-one-instance-of-a-bash-script-is-running/1985512#1985512 and https://gist.github.com/brendan-w/4fde0934fef759ac55b9#file-bashlock-sh.
# Globals:
#   PROJECT_VAR_DIR
# Arguments:
#   <sleeptime>: if lockfile can't create all the specified files (in the specified order), it waits sleeptime seconds and retries the last file that didn't succeed. Infinite waiting if set to -1.
#   <lock_filename>: file name of the lock file.
#   <file_descriptor>: file descriptor of the lock file.
# Outputs:
#   None.
# Returns:
#   0: if success.
#   1: timeout.
# Exits:
#   99: if arguments are missing.
#######################################
lock() {
	local -r -i PARAM_FAILED=99
	local -r -i LOCK_TIMEOUT=1
	if (( $# < 3 )); then
		echo -error "ERROR: usage: lock <sleeptime> <lock_filename> <file_descriptor>" 1>&2
		exit ${PARAM_FAILED}
	fi

	local -r -i sleeptime=${1}
	local -r filename="${2}"
	local -r -i filedescriptor=${3}
	local -r lockfile="${PROJECT_VAR_DIR}/${filename}"
	
	_prepare_mutex "${lockfile}" ${filedescriptor}
	if (( ${sleeptime} == -1 )); then
		flock --exclusive ${filedescriptor}
		return ${?}
	else
		flock --exclusive --wait ${sleeptime} ${filedescriptor}
		return ${?}
	fi
	return 0
}

#######################################
# Unlock a lock file, like https://linux.die.net/man/1/lockfile.. Inspired from https://stackoverflow.com/questions/1715137/what-is-the-best-way-to-ensure-only-one-instance-of-a-bash-script-is-running/1985512#1985512 and https://gist.github.com/brendan-w/4fde0934fef759ac55b9#file-bashlock-sh.
# Globals:
#   PROJECT_VAR_DIR
# Arguments:
#   <lock_filename>: file name of the lock file.
#   <file_descriptor>: file descriptor of the lock file.
# Outputs:
#   None.
# Returns:
#   0: if success.
# Exits:
#   99: if arguments are missing.
#######################################
unlock() {
	local -r -i PARAM_FAILED=99
	if (( $# < 2 )); then
		echo -error "ERROR: usage: unlock <lock_filename> <file_descriptor>" 1>&2
		exit ${PARAM_FAILED}
	fi
	
	local -r filename="${1}"
	local -r -i filedescriptor=${2}
	local -r lockfile="${PROJECT_VAR_DIR}/${filename}"

	flock --unlock ${filedescriptor}
	return ${?}
}