# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#!/bin/bash

declare DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${DIR}" ]]; then DIR="${PWD}"; fi
source "${DIR}/log.sh"
source "${DIR}/utility.sh"

#######################################
# Backup AppImageLauncher
# Globals:
#   PROJECT_TEMP_DIR.
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
appimagelauncher() {
	echo -e "Backup AppImageLauncher."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="appimagelauncher_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy config file to temp backup directory..."
	error=$(cp --preserve=all "/home/joseph/.config/appimagelauncher.cfg" "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null) # It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup Bitwarden
# Globals:
#   PROJECT_TEMP_DIR.
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
bitwarden() {
	echo -e "Backup Bitwarden."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="bitwarden_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy user config files and folders to temp backup directory..."
	error=$((cp --preserve=all \
			"/home/joseph/.config/Bitwarden/data.json" \
			"${OUTPUT_BACKUP_DIR}" \
		) \
		2>&1 1>/dev/null \
	)
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup Diagrams.net
# Globals:
#   PROJECT_TEMP_DIR.
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
diagrams_net() {
	echo -e "Backup Diagrams.net."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="diagrams_net_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy user config files and folders to temp backup directory..."
	error=$((cp --archive \
			"/home/joseph/.config/draw.io/IndexedDB" \
			"/home/joseph/.config/draw.io/Local Storage" \
			"/home/joseph/.config/draw.io/Session Storage" \
			"/home/joseph/.config/draw.io/WebStorage" \
			"${OUTPUT_BACKUP_DIR}" && \
			cp --preserve=all \
			"/home/joseph/.config/draw.io/Preferences" \
			"/home/joseph/.config/draw.io/config.json" \
			"${OUTPUT_BACKUP_DIR}" \
		) \
		2>&1 1>/dev/null \
	)
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup Double Commander
# Globals:
#   PROJECT_TEMP_DIR.
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
double_commander() {
	echo -e "Backup Double Commander."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="double_commander_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy config folder to temp directory..."
	error=$(cp --archive "/home/joseph/.config/doublecmd" "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup FreeFileSync
# Globals:
#   PROJECT_TEMP_DIR.
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
freefilesync() {
	echo -e "Backup FreeFileSync."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="freefilesync_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy config folder to temp directory..."
	error=$(cp --archive "/home/joseph/.config/FreeFileSync" "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup GitKraken
# Globals:
#   PROJECT_TEMP_DIR.
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
gitkraken() {
	echo -e "Backup GitKraken."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="gitkraken_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy config folder to temp directory..."
	error=$(cp --archive "/home/joseph/.gitkraken" "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup Kopia
# Globals:
#   PROJECT_TEMP_DIR.
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
kopia() {
	echo -e "Backup Kopia."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="kopia_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy config folder to temp directory..."
	error=$(cp --archive "/home/joseph/.config/kopia" "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup Leviia
# Globals:
#   PROJECT_TEMP_DIR.
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
leviia() {
	echo -e "Backup Leviia."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="leviia_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy user config files and folders to temp backup directory..."
	error=$((cp --preserve=all \
			"/home/joseph/.config/Leviia/leviia.cfg" \
			"/home/joseph/.config/Leviia/sync-exclude.lst" \
			"${OUTPUT_BACKUP_DIR}" \
		) \
		2>&1 1>/dev/null \
	)
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup Linux home settings
# Globals:
#   PROJECT_TEMP_DIR.
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
linux_home_settings() {
	echo -e "Backup Linux home settings."

	local -r DEST_DIR="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Linux_Mint"
	local -r OUTPUT_ZIP_NAME="home_settings.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  copy Linux home settings files to temp directory..."
	local error=$(cp --parents --preserve=all \
		"/home/joseph/.profile" \
		"/home/joseph/.bashrc" \
		"${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) # It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo -e "Done!"
}

#######################################
# Backup Linux Mint
# Globals:
#   PROJECT_TEMP_DIR.
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
linux_mint() {
		echo -e "Backup Linux Mint."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="linux_mint_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy Linux home settings files and folders to temp backup directory..."
	error=$(cp --preserve=all \
		"/home/joseph/.profile" \
		"/home/joseph/.bashrc" \
		"/home/joseph/.nvidia-settings-rc" \
		"${OUTPUT_BACKUP_DIR}" \
		2>&1 1>/dev/null \
	) # It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  copy source list to temp backup directory..."
	error=$(cp --archive "/etc/apt/sources.list.d" "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  save all linux settings in temp backup directory..."
	error=$(script --return --command "dconf dump / > \""${OUTPUT_BACKUP_DIR}"/linux_settings.txt\"" /dev/null 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  save all trusted keys in sources.keys file of temp backup directory..."
	error=$(script --return --command "apt-key exportall > \""${OUTPUT_BACKUP_DIR}"/sources.keys\"" /dev/null 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup Linux settings
# Globals:
#   PROJECT_TEMP_DIR.
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
linux_settings() {
	echo -e "Backup Linux settings."

	local -r DEST_DIR="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Linux_Mint"
	local -r OUTPUT_FILE_NAME="linux_settings.txt"
	local -r OUTPUT_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_FILE_NAME}"

	echo -ne "  save all linux settings in \"${OUTPUT_FILE_NAME}\" in temp directory..."
	local error=$(script --return --command "dconf dump / > \""${OUTPUT_FILE}"\"" /dev/null 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move setting file \"${OUTPUT_FILE_NAME}\" to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup Mark Text
# Globals:
#   PROJECT_TEMP_DIR.
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
mark_text() {
	echo -e "Backup Mark Text."
	
	local -r DEST_DIR="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Mark_Text"
	local -r OUTPUT_ZIP_NAME="Mark_Text.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  copy each file to temp directory..."
	local error=$(cp --parents --preserve=all \
		"/home/joseph/.config/marktext/dataCenter.json" \
		"/home/joseph/.config/marktext/preferences.json" \
		"${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) # It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with output directory content..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo -e "Done!"
}

#######################################
# Backup Mendeley
# Globals:
#   PROJECT_TEMP_DIR.
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
mendeley() {
	echo -e "Backup Mendeley."
	
	local -r DEST_DIR="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Latex/Mendeley"
	local -r OUTPUT_CONFIG_ZIP_NAME="Mendeley_Desktop.conf.zip"
	local -r OUTPUT_DATA_ZIP_NAME="Mendeley_Ltd.zip"
	local -r OUTPUT_CONFIG_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_CONFIG_ZIP_NAME}"
	local -r OUTPUT_DATA_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_DATA_ZIP_NAME}"

	# Config files
	echo -ne "  copy config files to temp directory..."
	local error=$(cp --parents --archive "/home/joseph/.config/Mendeley Ltd." "${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_CONFIG_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_CONFIG_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_CONFIG_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	assert_eq "$(ls -A "${PROJECT_TEMP_DIR}")" "" "\"/temp\" directory is not empty!"
	
	# Data files
	echo -ne "  copy data files to temp directory..."
	error=$(cp --parents --archive "/home/joseph/.local/share/data/Mendeley Ltd./Mendeley Desktop" "${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_DATA_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_DATA_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_DATA_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo -e "Done!"
}

#######################################
# Backup the PPA source list
# Globals:
#   PROJECT_TEMP_DIR.
#   DEST_DIR.
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
ppa_source_list() {
	echo -e "Backup the PPA source list."

	local -r DEST_DIR="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Linux_Mint"
	local -r OUTPUT_ZIP_NAME="ppa_source_list.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  copy source list to temp directory..."
	local error=$(cp --parents --archive "/etc/apt/sources.list.d" "${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  save all trusted keys in sources.keys file of temp directory..."
	error=$(script --return --command "apt-key exportall > \""${PROJECT_TEMP_DIR}"/sources.keys\"" /dev/null 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with output directory content..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo -e "Done!"
}

#######################################
# Backup Qt Creator
# Globals:
#   PROJECT_TEMP_DIR.
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
qt_creator() {
	echo -e "Backup Qt Creator."

	local -r DEST_DIR="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Qt_Creator"
	local -r OUTPUT_ZIP_NAME="QtProject.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  copy data files to temp directory..."
	local error=$(cp --parents --archive "/home/joseph/.config/QtProject" "${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup Recoll
# Globals:
#   PROJECT_TEMP_DIR.
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
recoll() {
	echo -e "Backup Recoll."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="recoll_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy config file to temp backup directory..."
	error=$(cp --preserve=all "/home/joseph/.recoll/recoll.conf" "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null) # It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup TeXstudio
# Globals:
#   PROJECT_TEMP_DIR.
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
texstudio() {
	echo -e "Backup TeXstudio."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="texstudio_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy config folder to temp directory..."
	error=$(cp --archive "/home/joseph/.config/texstudio" "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup Visual Studio Code
# Globals:
#   PROJECT_TEMP_DIR.
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
visual_studio_code() {
	echo -e "Backup Visual Studio Code."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="visual_studio_code_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy user folder to temp directory..."
	error=$(cp --archive "/home/joseph/.config/Code/User" "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup Zettlr
# Globals:
#   PROJECT_TEMP_DIR.
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
zettlr() {
	echo -e "Backup Zettlr."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="zettlr_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy user config files and folders to temp backup directory..."
	error=$((cp --archive \
			"/home/joseph/.config/Zettlr/defaults" \
			"/home/joseph/.config/Zettlr/snippets" \
			"${OUTPUT_BACKUP_DIR}" && \
			cp --preserve=all \
			"/home/joseph/.config/Zettlr/config.json" \
			"/home/joseph/.config/Zettlr/custom.css" \
			"/home/joseph/.config/Zettlr/stats.json" \
			"/home/joseph/.config/Zettlr/tags.json" \
			"/home/joseph/.config/Zettlr/targets.json" \
			"/home/joseph/.config/Zettlr/user.dic" \
			"${OUTPUT_BACKUP_DIR}" \
		) \
		2>&1 1>/dev/null \
	)
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Backup Zotero
# Globals:
#   PROJECT_TEMP_DIR.
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
zotero() {
	echo -e "Backup Zotero."

	local -r DEST_DIR="/home/joseph/6_Sauvegardes"
	local -r OUTPUT_BACKUP_DIR_NAME="zotero_linux_$(date +%F)"
	local -r OUTPUT_BACKUP_DIR="${PROJECT_TEMP_DIR}/${OUTPUT_BACKUP_DIR_NAME}"
	local -r OUTPUT_ZIP_NAME="${OUTPUT_BACKUP_DIR_NAME}.zip"
	local -r OUTPUT_ZIP_FILE="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create the temp backup directory \"${OUTPUT_BACKUP_DIR_NAME}\"."
	local error=$(mkdir "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy data folder to temp directory..."
	error=$(cp --archive "/home/joseph/.zotero" "${OUTPUT_BACKUP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create the final zip file and clean temp directory..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip --recurse-paths --move "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR}\"..."
	error=$(mv --force "${OUTPUT_ZIP_FILE}" "${DEST_DIR}/" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
}

#######################################
# Incremental save to remote disk
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
#   -1: if rsync command is not found.
#######################################
incremental_save_to_remote_disk() {
	echo -e "Incremental save to remote disk."
	
	# Looking for rsync
	which rsync 1>/dev/null
	if (( ${?} != 0 )); then
		echo -error "ERROR: rsync command not found!"
		exit -1
	fi

	local -r SRC_BASE_DIR="/home/joseph/Documents"
	local -r DEST_DIR="admin@192.168.0.253:/shares/Documents/Joseph"
	local -r OPTIONS="--checksum --delete --hard-links --human-readable --itemize-changes --links --perms --progress --protect-args --recursive --times --verbose"
	
	local -a src_dirs=()
	shopt -s globstar
	for file in "${SRC_BASE_DIR}"/*; do
		src_dirs+=("${file}")
	done
	shopt -u globstar

	echo -e "============================="
	for path in "${src_dirs[@]}"; do
		echo -e "  save content of \"${path}\" to \"${DEST_DIR}\" directory..."
		rsync ${OPTIONS} "${path}" "${DEST_DIR}"
		echo -status "${?}" "${?}"
		echo -e "-----------------------------"
	done

	echo -e "Done!"
}

#######################################
# Incremental save to Dropbox
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
#   -1: if rsync or dropbox commands are not found.
#######################################
incremental_save_to_dropbox() {
	echo -e "Incremental save to Dropbox."
	
	# Looking for rsync
	which rsync 1>/dev/null
	if (( ${?} != 0 )); then
		echo -error "ERROR: rsync command not found!"
		exit -1
	fi
	# Looking for Dropbox
	which dropbox 1>/dev/null
	if (( ${?} != 0 )); then
		echo -error "ERROR: dropbox command not found!"
		exit -1
	fi

	# Start Dropbox if not started
	if [[ "$(dropbox status)" == "Dropbox isn't running!" ]]; then
		echo -e "  start Dropbox..."
		dropbox start
		while [[ "$(dropbox status)" != "Up to date" ]]; do
			sleep 1
		done
		echo -status "${?}" "${?}"
		sleep 1
	fi
	
	# Save with rsync command
	local -r -a SRC_DIRS=( \
		"/home/joseph/Documents/1_Projects/Digital_Garden" \
		"/home/joseph/Documents/Travail/Recherche/Projets/BeInG" \
	)
	local -r DROPBOX_DEST_DIR="/home/joseph/Dropbox/Backup"
	local -r OPTIONS="--acls --archive --checksum --executability --delete --hard-links --human-readable --itemize-changes --progress --protect-args --verbose --whole-file --xattrs"
	
	echo -e "============================="
	for path in "${SRC_DIRS[@]}"; do
		echo -e "  save content of \"${path}\" to \"${DROPBOX_DEST_DIR}\" directory..."
		rsync ${OPTIONS} "${path}" "${DROPBOX_DEST_DIR}"
		echo -status "${?}" "${?}"
		echo -e "-----------------------------"
	done
	
	# Wait for Dropbox finish synchronization
	echo -ne "  wait for Dropbox finish synchronization before shutdown it..."
	while [[ "$(dropbox status)" != "Up to date" ]]; do
		sleep 1
	done
	echo -status "${?}" "${?}"
	
	# Stop Dropbox
	echo -e "  stop Dropbox..."
	dropbox stop
	while [[ "$(dropbox status)" != "Dropbox isn't running!" ]]; do
		sleep 1
	done
	echo -status "${?}" "${?}"
	
	echo -e "Done!"
}

#######################################
# Start Dropbox synchronizer daemon
# Globals:
#   PROJECT_LSYNCD_CONFIG_FILE.
#   PROJECT_LSYNCD_TEMPLATE_CONFIG_FILE.
#   PROJECT_LOG_FILE.
#   PROJECT_LSYNCD_PID_FILE.
#   PROJECT_LSYNCD_STATUS_FILE.
#   PROJECT_SRC_DIR.
#   PROJECT_LSYNCD_PROCESS_DATASTREAM_FILE.
# Arguments:
#   None.
# Outputs:
#   Write messages to STDOUT.
#   Write errors to STDERR.
# Returns:
#   None.
# Exits:
#   -1: if rsync, lsyncd or dropbox commands are not found. Also when config files cannot be created or log files cannot be erased and var files reseted
#######################################
start_dropbox_synchronizer_daemon() {
	log_info "Start Dropbox synchronizer daemon."
	
	#Looking for rsync
	which rsync 1>/dev/null
	if (( ${?} != 0 )); then
		log_error "ERROR: rsync command not found!"
		exit -1
	fi
	#Looking for lsyncd
	which lsyncd 1>/dev/null
	if (( ${?} != 0 )); then
		log_error "ERROR: lsyncd command not found!"
		exit -1
	fi
	# Looking for Dropbox
	which dropbox 1>/dev/null
	if (( ${?} != 0 )); then
		log_error "ERROR: dropbox command not found!"
		exit -1
	fi
	# Test if lsyncd deamon is already running
	pgrep -x lsyncd 1>/dev/null
	if (( ${?} == 0 )); then
		log_error "ERROR: lsyncd deamon is already running!"
		exit -1
	fi

	log_info "  copy lsyncd config file template to \"config/\" directory and fill it..."
	local error=$((cp -T --preserve=all "${PROJECT_LSYNCD_TEMPLATE_CONFIG_FILE}" "${PROJECT_LSYNCD_CONFIG_FILE}" && \
			sed -i 's,${PROJECT_LOG_FILE},'"${PROJECT_LOG_FILE}"',' "${PROJECT_LSYNCD_CONFIG_FILE}" && \
			sed -i 's,${PROJECT_LSYNCD_PID_FILE},'"${PROJECT_LSYNCD_PID_FILE}"',' "${PROJECT_LSYNCD_CONFIG_FILE}" && \
			sed -i 's,${PROJECT_LSYNCD_STATUS_FILE},'"${PROJECT_LSYNCD_STATUS_FILE}"',' "${PROJECT_LSYNCD_CONFIG_FILE}" && \
			sed -i 's,${PROJECT_SRC_DIR},'"${PROJECT_SRC_DIR}"',' "${PROJECT_LSYNCD_CONFIG_FILE}" \
		) \
		2>&1 1>/dev/null \
	)
	if (( ${?} == 0 )); then
		log_info "  config files are ready."
	else
		log_error "ERROR: error with config files: ${error}"
		exit -1
	fi
	
	log_info "  erase the existing log files of the task and var files to default value..."
	error=$((truncate -s 0 "${PROJECT_LOG_FILE}" && \
		truncate -s 0 "${PROJECT_LSYNCD_PROCESS_DATASTREAM_FILE}" && \
		truncate -s 0 "${PROJECT_LSYNCD_PID_FILE}" && \
		truncate -s 0 "${PROJECT_LSYNCD_STATUS_FILE}" && \
		echo -ne "0" >"${PROJECT_LSYNCD_PROCESS_DATASTREAM_FILE}" \
		) \
		2>&1 1>/dev/null \
	)
	if (( ${?} == 0 )); then
		log_info "  log files are erased and var files reseted."
	else
		log_error "ERROR: error with log or var files: ${error}"
		exit -1
	fi

	log_info "  start the lsyncd process..."
	lsyncd -log all "${PROJECT_LSYNCD_CONFIG_FILE}"
	log_info "  the lsyncd process is started."

	log_info "Done!"
}

#######################################
# Stop Dropbox synchronizer daemon
# Globals:
#   PROJECT_LSYNCD_PROCESS_DATASTREAM_FILE
#   PROJECT_LSYNCD_PID_FILE.
#   PROJECT_LSYNCD_CONFIG_FILE.
# Arguments:
#   None.
# Outputs:
#   Write messages to STDOUT.
#   Write errors to STDERR.
# Returns:
#   None.
# Exits:
#   -1: if lsyncd deamon is not running. Also when config file or var files cannot be removed.
#######################################
stop_dropbox_synchronizer_daemon() {
	log_info "Stop Dropbox synchronizer daemon."
	
	# Test if lsyncd deamon is running
	pgrep -x lsyncd 1>/dev/null
	if (( ${?} != 0 )); then
		log_error "ERROR: lsyncd deamon is not running!"
		exit -1
	fi

	declare -r -i lsyncd_pid="$(cat ${PROJECT_LSYNCD_PID_FILE})"
	log_info "  stop the lsyncd process ${lsyncd_pid}..."
	local error=$(start-stop-daemon --verbose --stop --pidfile "${PROJECT_LSYNCD_PID_FILE}" 2>&1 1>/dev/null)
	if (( ${?} == 0 )); then
		log_info "  lsyncd is stopped."
	else
		log_error "ERROR: lsyncd process cannot be stopped.: ${error}"
		exit -1
	fi
	
	log_info "  remove the config file from \"config/\" directory and all var files from \"var/\" directory..."
	error=$((rm -f "${PROJECT_LSYNCD_CONFIG_FILE}" && \
			rm -f "${PROJECT_LSYNCD_PROCESS_DATASTREAM_FILE}" && \
			rm -f "${PROJECT_LSYNCD_PID_FILE}" \
		) \
		2>&1 1>/dev/null \
	)
	if (( ${?} == 0 )); then
		log_info "  the config file is removed."
	else
		log_error "ERROR: the config file cannot be removed: ${error}"
		exit -1
	fi
	
	log_info "Done!"
}
