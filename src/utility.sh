# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#!/bin/bash

readonly -A COLORS=( \
	[GREEN]="\e[32m" \
	[RED]="\e[31m" \
	[WHITE]="\e[37m" \
	[RESET]="\e[0m" \
)

#######################################
# Extends echo command.
# Globals:
#   see echo command.
# Arguments:
#   see echo command.
#   -error: display a message with red color.
#   -status <error_code> <error_message>: display a message either with green color if success or red if fail.
# Returns:
#   None.
#######################################
echo() {
	local -r option="${1}" code="${2}" error="${3}"

	case "${option}" in
		"-error")
			echo -e "\e[31m${code}\e[0m"
			;;
		"-status")
			if [[ "${code}" -eq 0 ]]; then
				echo -e " "${COLORS[GREEN]}"[success]"${COLORS[RESET]}""
			else
				echo -e " "${COLORS[RED]}"[fail]: "${error}${COLORS[RESET]}""
			fi
			;;
		*)
			command echo "${@}"
			;;
	esac
}

#######################################
# Takes two strings and checks whether they are the same based on the character strings.
# Inspired from https://github.com/torokmark/assert.sh
# Globals:
#   None.
# Arguments:
#   -expected: expected string.
#   -actual: current string that should be the same as expected.
#   -message (optional): message to display if strings are not equals.
# Returns:
#   -0 if strings are equals or exit with code error 99.
#######################################
assert_eq() {
	local -r ASSERT_FAILED=99
	local -r expected="${1}"
	local -r actual="${2}"
	local msg

	if [[ "$#" -ge 3 ]]; then
		msg="$3"
	fi

	if [[ "${expected}" == "${actual}" ]]; then
		return 0
	else
		# An error occured, retrieved the line and the name of the script where
		# it happend
		set $(caller)
		echo -e "Assertion failed: \""${expected}" == "${actual}"\" :: "${msg}""
		echo -e "File \"${0}\", line ${1}" 2>&1
		exit "${ASSERT_FAILED}"
	fi
}
