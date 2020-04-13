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
	echo "---------------------------------------------"
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
	echo ""
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
	echo ""
	echo "=== Specific app menu selection ==="
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
				echo "Invalid option ${REPLY}. Try another one."
				continue
				;;
		esac
	done
}

main() {
	echo "============================================="
	echo "               Backup Tool                   "
	echo "============================================="

	# Global variables declaration.
	echo "Initialize global variables."

	readonly WORKSPACE_PATH=$(pwd)
	readonly -A PROJECT_PATHS=(
		[TEMP]="${WORKSPACE_PATH}/temp"
	)

	# Check project structure.
	echo "Check project structure."

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
	echo ""
	echo "=== Backup-Tool menu selection ==="
	local -r -a MENU_OPTIONS=("Incremental save to remote disk" "Backup all apps" "Backup specific apps" "Quit")
	local -r PS3="Select a task: "
	select opt in "${MENU_OPTIONS[@]}"; do
		case "${opt}" in
			"Incremental save to remote disk")
				incremental_save_to_remote_disk
				;;
			"Backup all apps")
				pre_task
				echo "Summary of backup steps:"
				echo " 1. PPA source list"
				echo " 2. GitKraken"
				echo " 3. TeXstudio"
				echo " 4. Mendeley"
				echo " 5. Recoll"
				echo " 6. Visual Studio Code"
				echo " 7. Linux Settings"
				echo ""
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
				echo "Clean \"/temp\" directory."
				rm -f -r "${PROJECT_PATHS[TEMP]}/"*
				echo "Goodbye!"
				break
				;;
			*)
				echo "Invalid option ${REPLY}. Try another one."
				continue
				;;
		esac
	done
}

main "$@"
exit "${?}"
