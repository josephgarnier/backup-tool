# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#!/bin/bash

readonly INSTALL_DIR="/opt/backup_tool"
readonly SERVICE_FILE="/home/joseph/.config/systemd/user/backup_tool.service"
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
	echo -e "          Backup Tool Installer              "
	echo -e "============================================="
	
	echo -e ""
	echo -e "Check if \"backup_tool.service\" is running to stop and disable it..."
	systemctl is-active --quiet backup_tool.service
	if (( ${?} != 0 )); then
		echo -e "Service is running. Stopping and disabling in progress..."
		local error=$((systemctl --user stop backup_tool.service && \
				systemctl --user disable backup_tool.service \
			) \
			2>&1 1>/dev/null \
		)
		if (( ${?} != 0 )); then
			echo -e "ERROR: ${error}" 1>&2
			exit -1
		fi
		echo -e "Service disabled."
	else
		echo -e "Service is not running."
	fi

	echo -e ""
	echo -e "Clean dirctory \"${INSTALL_DIR}\" from old installation, remove the service file \"${SERVICE_FILE}\" and the menu entry \"${MENU_ENTRY_FILE}\"..."
	local error=$((rm -f -r "${INSTALL_DIR}/"* && \
			rm -f "${SERVICE_FILE}" && \
			rm -f "${MENU_ENTRY_FILE}" \
		) \
		2>&1 1>/dev/null \
	)
	if (( ${?} != 0 )); then
		echo -e "ERROR: ${error}" 1>&2
		exit -1
	fi
	echo -e "Install directory is clear and service file removed."
	
	echo -e ""
	echo -e "Copy all source files in \"${INSTALL_DIR}\", the service file in \"${SERVICE_FILE}\" and the menu entry file in \"${MENU_ENTRY_FILE}\"..."
	local error=$((cp --parents -a "config/lsyncd.conf.in" "${INSTALL_DIR}" && \
			mkdir --parents "${INSTALL_DIR}/log" && \
			cp --parents -a "src/" "${INSTALL_DIR}" && \
			mkdir --parents "${INSTALL_DIR}/temp" && \
			mkdir --parents "${INSTALL_DIR}/var" && \
			cp -T --preserve=all "src/backup_tool.service" "${SERVICE_FILE}" && \
			cp -T --preserve=all "src/backup_tool_service.desktop" "${MENU_ENTRY_FILE}" \
		) \
		2>&1 1>/dev/null \
	)
	if (( ${?} != 0 )); then
		echo -e "ERROR: ${error}" 1>&2
		exit -1
	fi
	echo -e "Files copied."

	echo -e ""
	echo -e "Enable and start the service..."
	local error=$((systemctl --user enable backup_tool.service && \
				systemctl --user start backup_tool.service \
			) \
			2>&1 1>/dev/null \
		)
		if (( ${?} != 0 )); then
			echo -e "ERROR: ${error}" 1>&2
			exit -1
		fi
	echo -e "Service enabled and started."
	
	echo ""
	echo -e "Installation is over with success."
}

main "$@"
exit ${?}