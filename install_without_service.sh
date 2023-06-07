# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#!/bin/bash

readonly INSTALL_DIR="/opt/backup_tool"
readonly MENU_ENTRY_FILE="/home/joseph/.local/share/applications/backup_tool_service.desktop"

#######################################
# The Main function.
# Globals:
#   None.
# Arguments:
#   None.
# Outputs:
#   None.
# Returns:
#   None.
# Exits:
#   None.
#######################################
main() {
	echo -e "============================================="
	echo -e "    Backup Tool Without Service Installer    "
	echo -e "============================================="

	echo -e ""
	echo -e "Clean dirctory \"${INSTALL_DIR}\" from old installation and remove the menu entry \"${MENU_ENTRY_FILE}\"..."
	local error=$((rm -f -r "${INSTALL_DIR}/"* && \
			rm -f "${MENU_ENTRY_FILE}" \
		) \
		2>&1 1>/dev/null \
	)
	if (( ${?} != 0 )); then
		echo -e "ERROR: ${error}" 1>&2
		exit -1
	fi
	echo -e "Install directory is clear."
	
	echo -e ""
	echo -e "Copy all source files in \"${INSTALL_DIR}\" and the menu entry file in \"${MENU_ENTRY_FILE}\"..."
	local error=$((cp --parents -a "config/lsyncd.conf.in" "${INSTALL_DIR}" && \
			mkdir --parents "${INSTALL_DIR}/log" && \
			cp --parents -a "src/" "${INSTALL_DIR}" && \
			mkdir --parents "${INSTALL_DIR}/temp" && \
			mkdir --parents "${INSTALL_DIR}/var" && \
			cp -T --preserve=all "src/backup_tool_service.desktop" "${MENU_ENTRY_FILE}" \
		) \
		2>&1 1>/dev/null \
	)
	if (( ${?} != 0 )); then
		echo -e "ERROR: ${error}" 1>&2
		exit -1
	fi
	echo -e "Files copied."

	echo ""
	echo -e "Installation is over with success."
}

main "$@"
exit ${?}