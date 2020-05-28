# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#!/bin/bash

declare DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${DIR}" ]]; then DIR="${PWD}"; fi
source "${DIR}/tasks.sh"

#######################################
# Pre processing of a task.
# Globals:
#   PROJECT_TEMP_DIR
# Arguments:
#   None.
# Outputs:
#   Write messages to STDOUT.
#   Write errors to STDERR.
# Returns:
#   None.
# Exits:
#   -1: if temp directory in not empty.
#######################################
pre_task() {
	if [[ -n "$(ls -A "${PROJECT_TEMP_DIR}")" ]]; then
		echo -error "ERROR: \"/temp\" directory is not empty!"
		exit -1
	fi
	echo -e "---------------------------------------------"
}

#######################################
# Post processing of a task.
# Globals:
#   PROJECT_TEMP_DIR
# Arguments:
#   None.
# Outputs:
#   Write messages to STDOUT.
#   Write errors to STDERR.
# Returns:
#   None.
# Exits:
#   -1: if temp directory in not empty.
#######################################
post_task() {
	if [[ -n "$(ls -A "${PROJECT_TEMP_DIR}")" ]]; then
		echo -error "ERROR: \"/temp\" directory is not empty!"
		exit -1
	fi
	echo -e ""
}

#######################################
# Submenu to select application to backup.
# Globals:
#   None.
# Arguments:
#   None.
# Outputs:
#   Write messages to STDOUT.
#   Write errors to STDERR.
# Returns:
#   None.
# Exits:
#   None.
#######################################
submenu_application_selection() {
	echo -e ""
	echo -e "=== Specific app menu selection ==="
	local -r -a MENU_OPTIONS=( \
		"PPA source list" \
		"GitKraken" \
		"TeXstudio" \
		"Mendeley" \
		"Recoll" \
		"Visual Studio Code" \
		"Qt Creator" \
		"Linux Settings" \
		"Zotero" \
		"Quit" \
	)
	local -r PS3="Select an application to backup: "
	select opt in "${MENU_OPTIONS[@]}"; do
		case "${opt}" in
			"PPA source list")
				pre_task
				ppa_source_list
				post_task
				;;
			"GitKraken")
				pre_task
				gitkraken
				post_task
				;;
			"TeXstudio")
				pre_task
				texstudio
				post_task
				;;
			"Mendeley")
				pre_task
				mendeley
				post_task
				;;
			"Recoll")
				pre_task
				recoll
				post_task
				;;
			"Visual Studio Code")
				pre_task
				visual_studio_code
				post_task
				;;
			"Qt Creator")
				pre_task
				qt_creator
				post_task
				;;
			"Linux Settings")
				pre_task
				linux_settings
				post_task
				;;
			"Zotero")
				pre_task
				zotero
				post_task
				;;
			"Quit")
				break
				;;
			*)
				echo -e "Invalid option ${REPLY}. Try another one."
				continue
				;;
		esac
	done
}

#######################################
# The Main function.
# Use `backup_tools.sh onstartup` to start the task `start_dropbox_synchronizer_daemon`.
# Use `backup_tools.sh onshutdown` to start the task `stop_dropbox_synchronizer_daemon`.
# Globals:
#   PROJECT_CONFIG_DIR.
#   PROJECT_LOG_DIR.
#   PROJECT_SRC_DIR.
#   PROJECT_TEMP_DIR.
#   PROJECT_VAR_DIR.
# Arguments:
#   onstartup: to start the task `start_dropbox_synchronizer_daemon`.
#   onshutdown: to start the task `stop_dropbox_synchronizer_daemon`.
# Outputs:
#   Write messages to STDOUT.
#   Write errors to STDERR.
# Returns:
#   None.
# Exits:
#   -1: if a project folder is missing or if they are too many folder.
#######################################
main() {
	local -r COMMAND="${*:$OPTIND:1}" # optionnal, inspired from https://github.com/andreafabrizi/Dropbox-Uploader and https://github.com/jmcantrell/bashful/tree/master/bin
	# local -r ARG1="${*:$OPTIND+1:1}" # not used
	# local -r ARG2="${*:$OPTIND+2:1}" # not used
	local -r -i NB_ARGS=${#-$OPTIND}

	#CHECKING PARAMS VALUES
	case $COMMAND in
		"onstartup")
			start_dropbox_synchronizer_daemon
			exit 0
			;;
		"onshutdown")
			stop_dropbox_synchronizer_daemon
			exit 0
			;;
	esac

	echo -e "============================================="
	echo -e "               Backup Tool                   "
	echo -e "============================================="

	# Global variables declaration.
	echo -e "Initialize global variables."
	local -r -a PROJECT_DIRS=( \
		"${PROJECT_CONFIG_DIR}" \
		"${PROJECT_LOG_DIR}" \
		"${PROJECT_SRC_DIR}" \
		"${PROJECT_TEMP_DIR}" \
		"${PROJECT_VAR_DIR}" \
	)

	# Check project structure.
	echo -e "Check project structure."

	for directory in "${PROJECT_DIRS[@]}"; do
		if [[ ! -d "${directory}" ]]; then
			echo -error "ERROR: missing folder \"$(basename "${directory}")/\"!"
			exit -1
		fi
	done

	if [[ "$(find "${PROJECT_DIR}" -mindepth 1 -maxdepth 1 -type d -not -path "*/\.*" | wc -l)" != "${#PROJECT_DIRS[@]}" ]]; then
		echo -error "ERROR: too many folders in this project!"
		exit -1
	fi

	# Menu.
	echo -e ""
	echo -e "=== Backup-Tool menu selection ==="
	local -r -a MENU_OPTIONS=( \
		"Incremental save to Remote Disk" \
		"Incremental save to Dropbox" \
		"Start Dropbox synchronizer daemon" \
		"Stop Dropbox synchronizer daemon" \
		"Backup all apps" \
		"Backup specific apps" \
		"Quit" \
	)
	local -r PS3="Select a task: "
	while true; do
		select opt in "${MENU_OPTIONS[@]}"; do
			case "${opt}" in
				"Incremental save to Remote Disk")
					pre_task
					incremental_save_to_remote_disk
					post_task
					break
					;;
				"Incremental save to Dropbox")
					pre_task
					incremental_save_to_dropbox
					post_task
					break
					;;
				"Start Dropbox synchronizer daemon")
					pre_task
					start_dropbox_synchronizer_daemon
					post_task
					break
					;;
				"Stop Dropbox synchronizer daemon")
					pre_task
					stop_dropbox_synchronizer_daemon
					post_task
					break
					;;
				"Backup all apps")
					pre_task
					echo -e "Summary of backup steps:"
					echo -e " 1. PPA source list"
					echo -e " 2. GitKraken"
					echo -e " 3. TeXstudio"
					echo -e " 4. Mendeley"
					echo -e " 5. Recoll"
					echo -e " 6. Visual Studio Code"
					echo -e " 7. Qt Creator"
					echo -e " 8. Linux Settings"
					echo -e " 8. Zotero"
					echo -e ""
					pre_task
					ppa_source_list
					post_task
					pre_task
					gitkraken
					post_task
					pre_task
					texstudio
					post_task
					pre_task
					mendeley
					post_task
					pre_task
					recoll
					post_task
					pre_task
					visual_studio_code
					post_task
					pre_task
					qt_creator
					post_task
					pre_task
					linux_settings
					post_task
					pre_task
					zotero
					post_task
					break
					;;
				"Backup specific apps")
					submenu_application_selection
					break
					;;
				"Quit")
					echo -e ""
					echo -e "Clean \"temp/\" directory."
					rm -f -r "${PROJECT_TEMP_DIR}/"*
					echo -e "Goodbye!"
					break 2
					;;
				*)
					echo -e "Invalid option ${REPLY}. Try another one."
					continue
					;;
			esac
		done
	done
}

main "$@"
exit ${?}
