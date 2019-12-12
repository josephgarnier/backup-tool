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
	local -r OUTPUT_DIR_NAME="ppa_source_list"
	local -r OUTPUT_ZIP_NAME="ppa_source_list.zip"
	local -r OUTPUT_DIR_PATH="${PROJECT_PATHS[TEMP]}/${OUTPUT_DIR_NAME}"
	local -r OUTPUT_ZIP_PATH="${PROJECT_PATHS[TEMP]}/${OUTPUT_ZIP_NAME}"
	local -r DEST_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_ZIP_NAME}"

	echo -ne "  create output directory \"$(basename ${OUTPUT_DIR_PATH})\" in \"/temp\"... "
	error=$(mkdir "${OUTPUT_DIR_PATH}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  copy source list to output directory... "
	error=$(cp --parents -a "/etc/apt/sources.list*" "${OUTPUT_DIR_PATH}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  save all trusted keys to output directory in sources.keys file... "
	error=$(apt-key exportall > "${OUTPUT_DIR_PATH}/sources.keys" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with output directory content... "
	error=$((cd "${PROJECT_PATHS[TEMP]}" && zip -r -m "${OUTPUT_ZIP_NAME}" "${OUTPUT_DIR_NAME}") 2>&1 1>/dev/null)
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

	echo -ne "  move profile file \"${OUTPUT_FILE_NAME}\" file to final destination \"${DEST_DIR_PATH}\"... "
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



#***********************************************#
#                    Recoll                     #
#***********************************************#




#***********************************************#
#              Visual Studio Code               #
#***********************************************#


