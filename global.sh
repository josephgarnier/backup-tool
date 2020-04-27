# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#!/bin/bash

readonly PROJECT_DIR=$(pwd)
readonly PROJECT_TEMP_DIR="${PROJECT_DIR}/temp"
readonly PROJECT_LOG_DIR="${PROJECT_DIR}/log"

readonly PROJECT_LSYNCD_LOG_PID_FILE="${PROJECT_LOG_DIR}/lsyncd-pid.log"
readonly PROJECT_LSYNCD_LOG_STATUS_FILE="${PROJECT_LOG_DIR}/lsyncd-status.log"
readonly PROJECT_LSYNCD_CONFIG_FILE="${PROJECT_DIR}/lsyncd.conf.in"
readonly PROJECT_LSYNCD_TMP_CONFIG_FILE="${PROJECT_TEMP_DIR}/lsyncd.conf"