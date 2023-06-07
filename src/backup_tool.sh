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
# PRIVATE
#######################################

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
__pre_task() {
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
__post_task() {
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
__submenu_application_selection() {
	echo -e ""
	echo -e "=== Specific app menu selection ==="
	local -r -a MENU_OPTIONS=( \
		"AppImageLauncher" \
		"Diagrams.net" \
		"GitKraken" \
		"Linux Mint" \
		"Mark Text" \
		"Mendeley" \
		"Qt Creator" \
		"Recoll" \
		"TeXstudio" \
		"Visual Studio Code" \
		"Zettlr" \
		"Zotero" \
		"Quit" \
	)
	local -r PS3="Select an application to backup: "
	select opt in "${MENU_OPTIONS[@]}"; do
		case "${opt}" in
			"AppImageLauncher")
				__pre_task
				appimage_launcher
				__post_task
				;;
			"Diagrams.net")
				__pre_task
				diagrams_net
				__post_task
				;;
			"GitKraken")
				__pre_task
				gitkraken
				__post_task
				;;
			"Linux Mint")
				__pre_task
				linux_mint
				__post_task
				;;
			"Mark Text")
				__pre_task
				mark_text
				__post_task
				;;
			"Mendeley")
				__pre_task
				mendeley
				__post_task
				;;
			"Qt Creator")
				__pre_task
				qt_creator
				__post_task
				;;
			"Recoll")
				__pre_task
				recoll
				__post_task
				;;
			"TeXstudio")
				__pre_task
				texstudio
				__post_task
				;;
			"Visual Studio Code")
				__pre_task
				visual_studio_code
				__post_task
				;;
			"Zettlr")
				__pre_task
				zettlr
				__post_task
				;;
			"Zotero")
				__pre_task
				zotero
				__post_task
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
# PUBLIC
#######################################

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

	# Checking params values.
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
					__pre_task
					incremental_save_to_remote_disk
					__post_task
					break
					;;
				"Incremental save to Dropbox")
					__pre_task
					incremental_save_to_dropbox
					__post_task
					break
					;;
				"Start Dropbox synchronizer daemon")
					__pre_task
					start_dropbox_synchronizer_daemon
					__post_task
					break
					;;
				"Stop Dropbox synchronizer daemon")
					__pre_task
					stop_dropbox_synchronizer_daemon
					__post_task
					break
					;;
				"Backup all apps")
					__pre_task
					echo -e "Summary of backup steps:"
					echo -e " 1. AppImageLauncher"
					echo -e " 2. Diagrams.net"
					echo -e " 3. GitKraken"
					echo -e " 4. Linux Mint"
					echo -e " 5. Mark Text"
					echo -e " 6. Mendeley"
					echo -e " 7. Qt Creator"
					echo -e " 8. Recoll"
					echo -e " 9. TeXstudio"
					echo -e " 10. Visual Studio Code"
					echo -e " 11. Zettlr"
					echo -e " 12. Zotero"
					echo -e ""
					__pre_task
					appimage_launcher
					__post_task
					__pre_task
					diagrams_net
					__post_task
					__pre_task
					gitkraken
					__post_task
					__pre_task
					linux_mint
					__post_task
					__pre_task
					mark_text
					__post_task
					__pre_task
					mendeley
					__post_task
					__pre_task
					qt_creator
					__post_task
					__pre_task
					recoll
					__post_task
					__pre_task
					texstudio
					__post_task
					__pre_task
					visual_studio_code
					__post_task
					__pre_task
					zettlr
					__post_task
					__pre_task
					zotero
					__post_task
					break
					;;
				"Backup specific apps")
					__submenu_application_selection
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
