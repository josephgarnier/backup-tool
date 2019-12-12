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





#***********************************************#
#                  TeXstudio                    #
#***********************************************#



#***********************************************#
#                  Mendeley                     #
#***********************************************#



#***********************************************#
#                    Recoll                     #
#***********************************************#




#***********************************************#
#              Visual Studio Code               #
#***********************************************#


