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
	echo "=== Backup task menu selection ==="
	readonly -a MENU_OPTIONS=("All" "PPA source list" "GitKraken" "TeXstudio" "Mendeley" "Recoll" "Visual Studio Code" "Quit")
	readonly PS3="Select a task to backup: "
	select opt in "${MENU_OPTIONS[@]}"; do
		case "${opt}" in
			"All")
				pre_task
				echo "Summary of backup steps:"
				echo " 1. PPA source list"
				echo ""
				ppa_source_list
				post_task
				;;
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
				echo "C"
				;;
			"Mendeley")
				echo "C"
				;;
			"Recoll")
				echo "C"
				;;
			"Visual Studio Code")
				echo "C"
				;;
			"Quit")
				# Clean workspace.
				echo "Clean \"/temp\" directory."
				#rm -R "${PROJECT_PATHS[TEMP]}/*"
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
