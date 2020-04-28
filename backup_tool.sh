# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#!/bin/bash

source tasks.sh

#######################################
# Pre processing of a task.
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
pre_task() {
	if [[ -n "$(ls -A ${PROJECT_TEMP_DIR})" ]]; then
		echo -error "ERROR: \"/temp\" directory is not empty!"
		exit -1
	fi
	echo -e "---------------------------------------------"
}

#######################################
# Post processing of a task.
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
post_task() {
	if [[ -n "$(ls -A ${PROJECT_TEMP_DIR})" ]]; then
		echo -error "ERROR: \"/temp\" directory is not empty!"
		exit -1
	fi
	echo -e ""
}

#######################################
# Submenu to selection application to backup.
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
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
		"Linux Settings" \
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
			"Linux Settings")
				pre_task
				linux_settings
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

main() {
	echo -e "============================================="
	echo -e "               Backup Tool                   "
	echo -e "============================================="

	# Global variables declaration.
	echo -e "Initialize global variables."
	readonly -a PROJECT_DIRS=( \
		"${PROJECT_CONFIG_DIR}" \
		"${PROJECT_LOG_DIR}" \
		"${PROJECT_SRC_DIR}" \
		"${PROJECT_TEMP_DIR}" \
	)

	# Check project structure.
	echo -e "Check project structure."

	for directory in "${PROJECT_DIRS[@]}"; do
		if [[ ! -d "${directory}" ]]; then
			echo -error "ERROR: missing folder \"$(basename ${directory})/\"!"
			exit -1
		fi
	done
	if [[ $(find "${PROJECT_DIR}" -mindepth 1 -maxdepth 1 -type d -not -path "*/\.*" | wc -l) != "${#PROJECT_DIRS[@]}" ]]; then
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
					echo -e " 7. Linux Settings"
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
					linux_settings
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
exit "${?}"
