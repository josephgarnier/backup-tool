#!/bin/bash
# Author Joseph Garnier

source utility.sh
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
	if [[ -n "$(ls -A ${PROJECT_PATHS[TEMP]})" ]]; then
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
	if [[ -n "$(ls -A ${PROJECT_PATHS[TEMP]})" ]]; then
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
	local -r -a MENU_OPTIONS=("PPA source list" "GitKraken" "TeXstudio" "Mendeley" "Recoll" "Visual Studio Code" "Linux Settings" "Quit")
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

	readonly WORKSPACE_PATH=$(pwd)
	readonly -A PROJECT_PATHS=(
		[TEMP]="${WORKSPACE_PATH}/temp"
	)

	readonly PROJECT_LOG_FILE="${WORKSPACE_PATH}/backup_tool.log"
	readonly PROJECT_LSYNCD_CONFIG_FILE="${WORKSPACE_PATH}/lsyncd.conf.in"
	readonly PROJECT_LSYNCD_TMP_CONFIG_FILE="${PROJECT_PATHS[TEMP]}/lsyncd.conf"

	# Check project structure.
	echo -e "Check project structure."

	for key in "${!PROJECT_PATHS[@]}"; do
		if [[ ! -d "${PROJECT_PATHS[$key]}" ]]; then
			echo -error "ERROR: missing folder \"/$(basename ${PROJECT_PATHS[$key]})\"!"
			exit -1
		fi
	done

	if [[ $(find "${WORKSPACE_PATH}" -mindepth 1 -maxdepth 1 -type d -not -path "*/\.*" | wc -l) != "${#PROJECT_PATHS[@]}" ]]; then
		echo -error "ERROR: too many folders in this project!"
		exit -1
	fi

	# Menu.
	echo -e ""
	echo -e "=== Backup-Tool menu selection ==="
	local -r -a MENU_OPTIONS=("Incremental save to remote disk" "Incremental save to Dropbox" "Backup all apps" "Backup specific apps" "Quit")
	local -r PS3="Select a task: "
	select opt in "${MENU_OPTIONS[@]}"; do
		case "${opt}" in
			"Incremental save to remote disk")
				pre_task
				incremental_save_to_remote_disk
				post_task
				;;
			"Incremental save to Dropbox")
				# pre_task
				incremental_save_to_dropbox
				# post_task
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
				;;
			"Backup specific apps")
				submenu_application_selection
				;;
			"Quit")
				# Clean workspace.
				echo -e "Clean \"/temp\" directory."
				rm -f -r "${PROJECT_PATHS[TEMP]}/"*
				echo -e "Goodbye!"
				break
				;;
			*)
				echo -e "Invalid option ${REPLY}. Try another one."
				continue
				;;
		esac
	done
}

main "$@"
exit "${?}"
