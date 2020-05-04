# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#!/bin/bash

if [[ ! -v BACKUP_TOOL_GLOBAL ]]; then
	readonly BACKUP_TOOL_GLOBAL=true

	# see https://stackoverflow.com/questions/59895/how-to-get-the-source-directory-of-a-bash-script-from-within-the-script-itself.
	readonly PROJECT_DIR="$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")"
	readonly PROJECT_CONFIG_DIR="${PROJECT_DIR}/config"
	readonly PROJECT_LOG_DIR="${PROJECT_DIR}/log"
	readonly PROJECT_SRC_DIR="${PROJECT_DIR}/src"
	readonly PROJECT_TEMP_DIR="${PROJECT_DIR}/temp"
	readonly PROJECT_VAR_DIR="${PROJECT_DIR}/var"

	readonly PROJECT_LOG_FILE="${PROJECT_LOG_DIR}/backup_tool.log"
	readonly PROJECT_LSYNCD_PROCESS_DATASTREAM_FILE="${PROJECT_VAR_DIR}/process_executing.data"
	readonly PROJECT_LSYNCD_PID_FILE="${PROJECT_VAR_DIR}/lsyncd.pid"
	readonly PROJECT_LSYNCD_STATUS_FILE="${PROJECT_LOG_DIR}/lsyncd.status"
	readonly PROJECT_LSYNCD_CONFIG_FILE="${PROJECT_CONFIG_DIR}/lsyncd.conf.in"
	readonly PROJECT_LSYNCD_TEMPLATE_CONFIG_FILE="${PROJECT_CONFIG_DIR}/lsyncd.conf"
fi