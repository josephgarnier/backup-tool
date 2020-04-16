#!/bin/bash
# Author Joseph Garnier

#######################################
# Backup the PPA source list
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
ppa_source_list() {
	echo "Backup the PPA source list."

	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Linux_Mint"
	local -r OUTPUT_ZIP_NAME="ppa_source_list.zip"
	local -r OUTPUT_ZIP_PATH="${PROJECT_PATHS[TEMP]}/${OUTPUT_ZIP_NAME}"
	local -r DEST_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_ZIP_NAME}"

	echo -ne "  copy source list to temp directory... "
	error=$(cp --parents -a "/etc/apt/sources.list.d" "${PROJECT_PATHS[TEMP]}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  save all trusted keys in sources.keys file of temp directory... "
	error=$(script -e -c "apt-key exportall > \"${PROJECT_PATHS[TEMP]}/sources.keys\"" /dev/null 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with output directory content... "
	error=$((cd "${PROJECT_PATHS[TEMP]}" && zip -r -m "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"... "
	error=$(mv -f "${OUTPUT_ZIP_PATH}" "${DEST_ZIP_PATH}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo "Done!"
}

#######################################
# Backup GitKraken
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
gitkraken() {
	echo "Backup GitKraken."

	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/GitKraken"
	local -r OUTPUT_ZIP_NAME="GitKraken.zip"
	local -r OUTPUT_ZIP_PATH="${PROJECT_PATHS[TEMP]}/${OUTPUT_ZIP_NAME}"
	local -r DEST_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_ZIP_NAME}"

	echo -ne "  copy config files to temp directory... "
	error=$(cp --parents -a "/home/joseph/.gitkraken" "${PROJECT_PATHS[TEMP]}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it... "
	error=$((cd "${PROJECT_PATHS[TEMP]}" && zip -r -m "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"... "
	error=$(mv -f "${OUTPUT_ZIP_PATH}" "${DEST_ZIP_PATH}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo "Done!"
}

#######################################
# Backup TeXstudio
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
texstudio() {
	echo "Backup TeXstudio."

	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Latex"
	local -r OUTPUT_FILE_NAME="texstudio.txsprofile"
	local -r OUTPUT_FILE_PATH="${PROJECT_PATHS[TEMP]}/${OUTPUT_FILE_NAME}"
	local -r DEST_FILE_PATH="${DEST_DIR_PATH}/${OUTPUT_FILE_NAME}"

	echo -ne "  copy profile file to temp directory... "
	error=$(cp -T --preserve=all "/home/joseph/.config/texstudio/texstudio.ini" "${OUTPUT_FILE_PATH}" 2>&1 1>/dev/null) #It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  move profile file \"${OUTPUT_FILE_NAME}\" to final destination \"${DEST_DIR_PATH}\"... "
	error=$(mv -f "${OUTPUT_FILE_PATH}" "${DEST_FILE_PATH}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo "Done!"
}

#######################################
# Backup Mendeley
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
mendeley() {
	echo "Backup Mendeley."
	
	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Latex/Mendeley"
	local -r OUTPUT_CONFIG_ZIP_NAME="Mendeley_Desktop.conf.zip"
	local -r OUTPUT_DATA_ZIP_NAME="Mendeley_Ltd.zip"
	local -r OUTPUT_CONFIG_ZIP_PATH="${PROJECT_PATHS[TEMP]}/${OUTPUT_CONFIG_ZIP_NAME}"
	local -r OUTPUT_DATA_ZIP_PATH="${PROJECT_PATHS[TEMP]}/${OUTPUT_DATA_ZIP_NAME}"
	local -r DEST_CONFIG_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_CONFIG_ZIP_NAME}"
	local -r DEST_DATA_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_DATA_ZIP_NAME}"

	# Config files
	echo -ne "  copy config files to temp directory... "
	error=$(cp --parents -a "/home/joseph/.config/Mendeley Ltd." "${PROJECT_PATHS[TEMP]}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it... "
	error=$((cd "${PROJECT_PATHS[TEMP]}" && zip -r -m "${OUTPUT_CONFIG_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_CONFIG_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"... "
	error=$(mv -f ${OUTPUT_CONFIG_ZIP_PATH} ${DEST_CONFIG_ZIP_PATH} 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	assert_eq "$(ls -A ${PROJECT_PATHS[TEMP]})" "" "\"/temp\" directory is not empty!"
	
	# Data files
	echo -ne "  copy data files to temp directory... "
	error=$(cp --parents -a "/home/joseph/.local/share/data/Mendeley Ltd./Mendeley Desktop" "${PROJECT_PATHS[TEMP]}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it... "
	error=$((cd "${PROJECT_PATHS[TEMP]}" && zip -r -m "${OUTPUT_DATA_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_DATA_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"... "
	error=$(mv -f ${OUTPUT_DATA_ZIP_PATH} ${DEST_DATA_ZIP_PATH} 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo "Done!"
}

#######################################
# Backup Recoll
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
recoll() {
	echo "Backup Recoll."

	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Recoll"
	local -r OUTPUT_ZIP_NAME="Recoll.zip"
	local -r OUTPUT_ZIP_PATH="${PROJECT_PATHS[TEMP]}/${OUTPUT_ZIP_NAME}"
	local -r DEST_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_ZIP_NAME}"

	echo -ne "  copy data files to temp directory... "
	error=$(cp --parents -a "/home/joseph/.recoll" "${PROJECT_PATHS[TEMP]}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it... "
	error=$((cd "${PROJECT_PATHS[TEMP]}" && zip -r -m "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"... "
	error=$(mv -f "${OUTPUT_ZIP_PATH}" "${DEST_ZIP_PATH}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo "Done!"
}

#######################################
# Backup Visual Studio Code
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
visual_studio_code() {
	echo "Backup Visual Studio Code."

	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Visual_Studio_Code"
	local -r OUTPUT_EXTENSIONS_ZIP_NAME="Extensions.zip"
	local -r OUTPUT_USER_ZIP_NAME="User.zip"
	local -r OUTPUT_EXTENSIONS_ZIP_PATH="${PROJECT_PATHS[TEMP]}/${OUTPUT_EXTENSIONS_ZIP_NAME}"
	local -r OUTPUT_USER_ZIP_PATH="${PROJECT_PATHS[TEMP]}/${OUTPUT_USER_ZIP_NAME}"
	local -r DEST_EXTENSIONS_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_EXTENSIONS_ZIP_NAME}"
	local -r DEST_USER_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_USER_ZIP_NAME}"

	# Extensions files
	echo -ne "  copy extensions files to temp directory... "
	error=$(cp --parents -a "/home/joseph/.vscode/extensions" "${PROJECT_PATHS[TEMP]}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it... "
	error=$((cd "${PROJECT_PATHS[TEMP]}" && zip -r -m "${OUTPUT_EXTENSIONS_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_EXTENSIONS_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"... "
	error=$(mv -f ${OUTPUT_EXTENSIONS_ZIP_PATH} ${DEST_EXTENSIONS_ZIP_PATH} 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	assert_eq "$(ls -A ${PROJECT_PATHS[TEMP]})" "" "\"/temp\" directory is not empty!"
	
	# User files
	echo -ne "  copy user files to temp directory... "
	error=$(cp --parents -a "/home/joseph/.config/Code/User" "${PROJECT_PATHS[TEMP]}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it... "
	error=$((cd "${PROJECT_PATHS[TEMP]}" && zip -r -m "${OUTPUT_USER_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_USER_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"... "
	error=$(mv -f ${OUTPUT_USER_ZIP_PATH} ${DEST_USER_ZIP_PATH} 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo "Done!"
}

#######################################
# Backup Linux Settings
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
linux_settings() {
	echo "Backup Linux Settings."

	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Linux_Mint"
	local -r OUTPUT_FILE_NAME="linux_settings.txt"
	local -r OUTPUT_FILE_PATH="${PROJECT_PATHS[TEMP]}/${OUTPUT_FILE_NAME}"
	local -r DEST_FILE_PATH="${DEST_DIR_PATH}/${OUTPUT_FILE_NAME}"

	echo -ne "  save all linux settings in \"${OUTPUT_FILE_NAME}\" in temp directory... "
	error=$(script -e -c "dconf dump / > \"${OUTPUT_FILE_PATH}\"" /dev/null 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move setting file \"${OUTPUT_FILE_NAME}\" to final destination \"${DEST_DIR_PATH}\"... "
	error=$(mv -f "${OUTPUT_FILE_PATH}" "${DEST_FILE_PATH}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo "Done!"
}

#######################################
# Incremental save to remote disk
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
incremental_save_to_remote_disk() {
	echo "Incremental save to remote disk."
	
	#Looking for rsync
	which rsync > /dev/null
	if [[ "${?}" -ne 0 ]]; then
		echo -e "rsync command not found!"
		exit -1
	fi

	local -r -a SRC_DIR_PATH=(
		"/home/joseph/Documents/Documents_Administratifs"
		"/home/joseph/Documents/Graphisme_et_Modelisation"
		"/home/joseph/Documents/Livres"
		"/home/joseph/Documents/Reserve_Cyberdefense"
		"/home/joseph/Documents/Scolarite"
		"/home/joseph/Documents/Sport"
		"/home/joseph/Documents/Travail"
	)
	local -r DEST_DIR_PATH="admin@192.168.0.253:/shares/Documents/Joseph"
	local -r OPTIONS="-r -t -p -v --progress --delete -c -l -H -i -s --log-file=${PROJECT_LOG_FILE}"
	
	echo -e "=============================" |& tee -a "${PROJECT_LOG_FILE}"
	for path in "${!SRC_DIR_PATH[@]}"; do
		echo -e "  save content of \"${SRC_DIR_PATH[$path]}\" to \"${DEST_DIR_PATH}\" directory..."
		rsync ${OPTIONS} "${SRC_DIR_PATH[$path]}" "${DEST_DIR_PATH}"
		echo -status "${?}" "${?}"
		echo -e "-----------------------------" |& tee -a "${PROJECT_LOG_FILE}"
	done

	echo "Done!"
}

#######################################
# Incremental save to Dropbox
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
incremental_save_to_dropbox() {
	echo "Incremental save to Dropbox."
	
	#Looking for rsync
	which rsync > /dev/null
	if [[ "${?}" -ne 0 ]]; then
		echo -e "rsync command not found!"
		exit -1
	fi
	#Looking for rsync
	which lsyncd > /dev/null
	if [[ "${?}" -ne 0 ]]; then
		echo -e "lsyncd command not found!"
		exit -1
	fi

	local -r SRC_DIR_PATH="/home/joseph/Documents/Test"
	local -r DROPBOX_DEST_DIR_PATH="/home/joseph/Dropbox"
	
	echo -ne "  copy lsyncd config file template to temp directory and fill it..."
	error=$((cp -T --preserve=all "${PROJECT_LSYNCD_CONFIG_FILE}" "${PROJECT_LSYNCD_TMP_CONFIG_FILE}" && 
		sed -i 's,${WORKSPACE_PATH},'"${WORKSPACE_PATH}"',' "${PROJECT_LSYNCD_TMP_CONFIG_FILE}") 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	lsyncd -log all -log Exec "${PROJECT_LSYNCD_TMP_CONFIG_FILE}"
	
	echo -ne "  remove the config file from temp directory..."
	error=$(rm -f "${PROJECT_LSYNCD_TMP_CONFIG_FILE}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo -e "Done!"
}

# todo : push, renomer var project, replace  " en fin d'écho, ajouter -e aux echo, renomer  backup to backup_tool