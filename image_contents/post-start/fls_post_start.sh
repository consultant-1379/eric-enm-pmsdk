#!/bin/bash
###########################################################################
# COPYRIGHT Ericsson 2023
#
# The copyright to the computer program(s) herein is the property of
# Ericsson Inc. The programs may be used and/or copied only with written
# permission from Ericsson Inc. or in accordance with the terms and
# conditions stipulated in the agreement/contract under which the
# program(s) have been supplied.
# This script requires bash 4 or above

#
# This script verifies the lock file that is created by fls_maintenance.sh
# exists and updates the stopAllOperationOnFlsDB property. The lock file
# is created during fls database backup and restore.
###########################################################################

check_fls_lck_file()
{
    local jvmIdentifier=$(/bin/hostname -s)
    if [ -f /ericsson/tor/no_rollback/fls/lock/fls.lck ]; then
        /opt/ericsson/PlatformIntegrationBridge/etc/config.py update --app_server_address="$jvmIdentifier":8080 --name=stopAllOperationOnFlsDB --value=true --app_server_identifier="$jvmIdentifier" --scope=GLOBAL
    fi
}

check_fls_lck_file
exit 0