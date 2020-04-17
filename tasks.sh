# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#!/bin/bash

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
	echo -e "Backup the PPA source list."

	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Linux_Mint"
	local -r OUTPUT_ZIP_NAME="ppa_source_list.zip"
	local -r OUTPUT_ZIP_PATH="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"
	local -r DEST_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_ZIP_NAME}"

	echo -ne "  copy source list to temp directory..."
	error=$(cp --parents -a "/etc/apt/sources.list.d" "${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  save all trusted keys in sources.keys file of temp directory..."
	error=$(script -e -c "apt-key exportall > \"${PROJECT_TEMP_DIR}/sources.keys\"" /dev/null 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with output directory content..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip -r -m "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"..."
	error=$(mv -f "${OUTPUT_ZIP_PATH}" "${DEST_ZIP_PATH}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo -e "Done!"
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
	echo -e "Backup GitKraken."

	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/GitKraken"
	local -r OUTPUT_ZIP_NAME="GitKraken.zip"
	local -r OUTPUT_ZIP_PATH="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"
	local -r DEST_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_ZIP_NAME}"

	echo -ne "  copy config files to temp directory..."
	error=$(cp --parents -a "/home/joseph/.gitkraken" "${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip -r -m "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"..."
	error=$(mv -f "${OUTPUT_ZIP_PATH}" "${DEST_ZIP_PATH}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo -e "Done!"
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
	echo -e "Backup TeXstudio."

	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Latex"
	local -r OUTPUT_FILE_NAME="texstudio.txsprofile"
	local -r OUTPUT_FILE_PATH="${PROJECT_TEMP_DIR}/${OUTPUT_FILE_NAME}"
	local -r DEST_FILE_PATH="${DEST_DIR_PATH}/${OUTPUT_FILE_NAME}"

	echo -ne "  copy profile file to temp directory..."
	error=$(cp -T --preserve=all "/home/joseph/.config/texstudio/texstudio.ini" "${OUTPUT_FILE_PATH}" 2>&1 1>/dev/null) #It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  move profile file \"${OUTPUT_FILE_NAME}\" to final destination \"${DEST_DIR_PATH}\"..."
	error=$(mv -f "${OUTPUT_FILE_PATH}" "${DEST_FILE_PATH}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo -e "Done!"
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
	echo -e "Backup Mendeley."
	
	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Latex/Mendeley"
	local -r OUTPUT_CONFIG_ZIP_NAME="Mendeley_Desktop.conf.zip"
	local -r OUTPUT_DATA_ZIP_NAME="Mendeley_Ltd.zip"
	local -r OUTPUT_CONFIG_ZIP_PATH="${PROJECT_TEMP_DIR}/${OUTPUT_CONFIG_ZIP_NAME}"
	local -r OUTPUT_DATA_ZIP_PATH="${PROJECT_TEMP_DIR}/${OUTPUT_DATA_ZIP_NAME}"
	local -r DEST_CONFIG_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_CONFIG_ZIP_NAME}"
	local -r DEST_DATA_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_DATA_ZIP_NAME}"

	# Config files
	echo -ne "  copy config files to temp directory..."
	error=$(cp --parents -a "/home/joseph/.config/Mendeley Ltd." "${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip -r -m "${OUTPUT_CONFIG_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_CONFIG_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"..."
	error=$(mv -f ${OUTPUT_CONFIG_ZIP_PATH} ${DEST_CONFIG_ZIP_PATH} 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	assert_eq "$(ls -A ${PROJECT_TEMP_DIR})" "" "\"/temp\" directory is not empty!"
	
	# Data files
	echo -ne "  copy data files to temp directory..."
	error=$(cp --parents -a "/home/joseph/.local/share/data/Mendeley Ltd./Mendeley Desktop" "${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip -r -m "${OUTPUT_DATA_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_DATA_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"..."
	error=$(mv -f ${OUTPUT_DATA_ZIP_PATH} ${DEST_DATA_ZIP_PATH} 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo -e "Done!"
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
	echo -e "Backup Recoll."

	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Recoll"
	local -r OUTPUT_ZIP_NAME="Recoll.zip"
	local -r OUTPUT_ZIP_PATH="${PROJECT_TEMP_DIR}/${OUTPUT_ZIP_NAME}"
	local -r DEST_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_ZIP_NAME}"

	echo -ne "  copy data files to temp directory..."
	error=$(cp --parents -a "/home/joseph/.recoll" "${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip -r -m "${OUTPUT_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"..."
	error=$(mv -f "${OUTPUT_ZIP_PATH}" "${DEST_ZIP_PATH}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo -e "Done!"
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
	echo -e "Backup Visual Studio Code."

	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Visual_Studio_Code"
	local -r OUTPUT_EXTENSIONS_ZIP_NAME="Extensions.zip"
	local -r OUTPUT_USER_ZIP_NAME="User.zip"
	local -r OUTPUT_EXTENSIONS_ZIP_PATH="${PROJECT_TEMP_DIR}/${OUTPUT_EXTENSIONS_ZIP_NAME}"
	local -r OUTPUT_USER_ZIP_PATH="${PROJECT_TEMP_DIR}/${OUTPUT_USER_ZIP_NAME}"
	local -r DEST_EXTENSIONS_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_EXTENSIONS_ZIP_NAME}"
	local -r DEST_USER_ZIP_PATH="${DEST_DIR_PATH}/${OUTPUT_USER_ZIP_NAME}"

	# Extensions files
	echo -ne "  copy extensions files to temp directory..."
	error=$(cp --parents -a "/home/joseph/.vscode/extensions" "${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip -r -m "${OUTPUT_EXTENSIONS_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_EXTENSIONS_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"..."
	error=$(mv -f ${OUTPUT_EXTENSIONS_ZIP_PATH} ${DEST_EXTENSIONS_ZIP_PATH} 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	assert_eq "$(ls -A ${PROJECT_TEMP_DIR})" "" "\"/temp\" directory is not empty!"
	
	# User files
	echo -ne "  copy user files to temp directory..."
	error=$(cp --parents -a "/home/joseph/.config/Code/User" "${PROJECT_TEMP_DIR}" 2>&1 1>/dev/null) #-a is same as -dR --preserve=all. It preserve mode, ownership and timestamps.
	echo -status "${?}" "${error}"

	echo -ne "  create a zip file with content of temp directory and clean it..."
	error=$((cd "${PROJECT_TEMP_DIR}" && zip -r -m "${OUTPUT_USER_ZIP_NAME}" *) 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move the generate \"${OUTPUT_USER_ZIP_NAME}\" file to final destination \"${DEST_DIR_PATH}\"..."
	error=$(mv -f ${OUTPUT_USER_ZIP_PATH} ${DEST_USER_ZIP_PATH} 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo -e "Done!"
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
	echo -e "Backup Linux Settings."

	local -r DEST_DIR_PATH="/home/joseph/Documents/Travail/Logiciels_Outils_et_Configurations/Linux_Mint"
	local -r OUTPUT_FILE_NAME="linux_settings.txt"
	local -r OUTPUT_FILE_PATH="${PROJECT_TEMP_DIR}/${OUTPUT_FILE_NAME}"
	local -r DEST_FILE_PATH="${DEST_DIR_PATH}/${OUTPUT_FILE_NAME}"

	echo -ne "  save all linux settings in \"${OUTPUT_FILE_NAME}\" in temp directory..."
	error=$(script -e -c "dconf dump / > \"${OUTPUT_FILE_PATH}\"" /dev/null 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -ne "  move setting file \"${OUTPUT_FILE_NAME}\" to final destination \"${DEST_DIR_PATH}\"..."
	error=$(mv -f "${OUTPUT_FILE_PATH}" "${DEST_FILE_PATH}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"

	echo -e "Done!"
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
	echo -e "Incremental save to remote disk."
	
	#Looking for rsync
	which rsync > /dev/null
	if [[ "${?}" -ne 0 ]]; then
		echo -e "rsync command not found!"
		exit -1
	fi

	local -r -a SRC_DIR_PATH=( \
		"/home/joseph/Documents/Documents_Administratifs" \
		"/home/joseph/Documents/Graphisme_et_Modelisation" \
		"/home/joseph/Documents/Livres" \
		"/home/joseph/Documents/Reserve_Cyberdefense" \
		"/home/joseph/Documents/Scolarite" \
		"/home/joseph/Documents/Sport" \
		"/home/joseph/Documents/Travail" \
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

	echo -e "Done!"
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
	echo -e "Incremental save to Dropbox."
	
	# Looking for rsync
	which rsync > /dev/null
	if [[ "${?}" -ne 0 ]]; then
		echo -e "rsync command not found!"
		exit -1
	fi
	# Looking for Dropbox
	which dropbox > /dev/null
	if [[ "${?}" -ne 0 ]]; then
		echo -e "dropbox command not found!"
		exit -1
	fi

	# Start Dropbox if not started
	if [[ "$(dropbox status)" != "Up to date" ]]; then
		echo -e "  start Dropbox..."
		dropbox start
		while [[ "$(dropbox status)" != "Up to date" ]]; do
			sleep 1
		done
		echo -status "${?}" "${?}"
		sleep 1
	fi
	
	local -r -a SRC_DIRS=( \
		"/home/joseph/Documents/Documents_Administratifs" \
		"/home/joseph/Documents/Graphisme_et_Modelisation" \
		"/home/joseph/Documents/Livres" \
		"/home/joseph/Documents/Reserve_Cyberdefense" \
		"/home/joseph/Documents/Scolarite" \
		"/home/joseph/Documents/Sport" \
		"/home/joseph/Documents/Travail" \
	)
	local -r DROPBOX_DEST_DIR="/home/joseph/Dropbox/Backup"
	local -r OPTIONS="--archive --hard-links --acls --xattrs --verbose --progress --delete --checksum --itemize-changes --protect-args --log-file=${PROJECT_LOG_FILE}"
	
	echo -e "=============================" |& tee -a "${PROJECT_LOG_FILE}"
	for path in "${!SRC_DIRS[@]}"; do
		echo -e "  save content of \"${SRC_DIRS[$path]}\" to \"${DROPBOX_DEST_DIR}\" directory..."
		rsync ${OPTIONS} "${SRC_DIRS[$path]}" "${DROPBOX_DEST_DIR}"
		echo -status "${?}" "${?}"
		echo -e "-----------------------------" |& tee -a "${PROJECT_LOG_FILE}"
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
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
start_dropbox_synchronizer_daemon() {
	echo -e "Start Dropbox synchronizer daemon."
	
	#Looking for rsync
	which rsync > /dev/null
	if [[ "${?}" -ne 0 ]]; then
		echo -e "rsync command not found!"
		exit -1
	fi
	#Looking for lsyncd
	which lsyncd > /dev/null
	if [[ "${?}" -ne 0 ]]; then
		echo -e "lsyncd command not found!"
		exit -1
	fi

	local -r SRC_DIR_PATH="/home/joseph/Documents/Test"
	local -r DROPBOX_DEST_DIR_PATH="/home/joseph/Dropbox"

	echo -ne "  copy lsyncd config file template to temp directory and fill it..."
	error=$((cp -T --preserve=all "${PROJECT_LSYNCD_CONFIG_FILE}" "${PROJECT_LSYNCD_TMP_CONFIG_FILE}" && \
		sed -i 's,${PROJECT_LSYNCD_LOG_FILE},'"${PROJECT_LSYNCD_LOG_FILE}"',' "${PROJECT_LSYNCD_TMP_CONFIG_FILE}" && \
		sed -i 's,${PROJECT_LSYNCD_LOG_RSYNC_FILE},'"${PROJECT_LSYNCD_LOG_RSYNC_FILE}"',' "${PROJECT_LSYNCD_TMP_CONFIG_FILE}" && \
		sed -i 's,${PROJECT_LSYNCD_LOG_PID_FILE},'"${PROJECT_LSYNCD_LOG_PID_FILE}"',' "${PROJECT_LSYNCD_TMP_CONFIG_FILE}" && \
		sed -i 's,${PROJECT_LSYNCD_LOG_STATUS_FILE},'"${PROJECT_LSYNCD_LOG_STATUS_FILE}"',' "${PROJECT_LSYNCD_TMP_CONFIG_FILE}") \
		2>&1 1>/dev/null \
	)
	echo -status "${?}" "${error}"
	
	echo -ne "  erase the existing log files of the task..."
	error=$((truncate -s 0 "${PROJECT_LSYNCD_LOG_FILE}" && \
		truncate -s 0 "${PROJECT_LSYNCD_LOG_RSYNC_FILE}" && \
		truncate -s 0 "${PROJECT_LSYNCD_LOG_PID_FILE}" && \
		truncate -s 0 "${PROJECT_LSYNCD_LOG_STATUS_FILE}") \
		2>&1 1>/dev/null \
	)
	echo -status "${?}" "${error}"
	
	echo -e "  start the lsyncd process."
	lsyncd -log all -log Exec "${PROJECT_LSYNCD_TMP_CONFIG_FILE}"
	echo -e "  the lsyncd process is stopped."

	echo -ne "  remove the config file from \"temp/\" directory..."
	error=$(rm -f "${PROJECT_LSYNCD_TMP_CONFIG_FILE}" 2>&1 1>/dev/null)
	echo -status "${?}" "${error}"
	
	echo -e "Done!"
}

#######################################
# Stop Dropbox synchronizer daemon
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   None.
#######################################
stop_dropbox_synchronizer_daemon() {
	echo -e "Stop Dropbox synchronizer daemon."
	
	echo -e "Done!"
}