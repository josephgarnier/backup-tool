#!/bin/bash
# Author Joseph Garnier

declare -r -A COLORS=(
	[GREEN]="\e[32m"
	[RED]="\e[31m"
	[WHITE]="\e[37m"
	[RESET]="\e[0m"
)

#######################################
# Extends echo command
# Globals:
#   see echo command.
# Arguments:
#   see echo command.
#   -error : display a message with red color.
#   -status <error_code> <error_message> : display a message either with green color if success or red if fail
# Returns:
#   None
#######################################
echo() {
	local -r option="${1}" code="${2}" error="${3}"
	
	case "${option}" in
		"-error")
			echo -e "\e[31m${code}\e[0m"
		;;
		"-status")
			if [ "${code}" -eq 0 ]; then
				echo -e "${COLORS[GREEN]}[success]${COLORS[RESET]}"
			else
				echo -e " ${COLORS[RED]}[fail]: ${error}${COLORS[RESET]}"
			fi
		;;
		*)
			command echo "${@}"
		;;
	esac
}