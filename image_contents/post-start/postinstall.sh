#!/bin/bash
#
# COPYRIGHT Ericsson 2023
#
# The copyright to the computer program(s) herein is the property of
# Ericsson Inc. The programs may be used and/or copied only with written
# permission from Ericsson Inc. or in accordance with the terms and
# conditions stipulated in the agreement/contract under which the
# program(s) have been supplied.
#

_SWAPOFF=/sbin/swapoff
_LOGGER=/bin/logger
_ECHO=/bin/echo
_SED=/bin/sed

readonly swappiness=/proc/sys/vm/swappiness

# GLOBAL VARIABLES
SCRIPT_NAME="${0}"
LOG_TAG="${Deliverable}"

error()
{
  $_LOGGER -t "${LOG_TAG}" -p user.err "( ${SCRIPT_NAME} ): $1"
}

info()
{
  $_LOGGER -t "${LOG_TAG}" -p user.info "( ${SCRIPT_NAME} ): $1"
}

info "Running postinstall to disable swap"

if $_SED -i '/swap/d' /etc/fstab; then
    error "Failed to remove swap entry from fstab"
fi

if ! $_SWAPOFF -a; then
    error "Failed to disable swapping. Command that failed : '$_SWAPOFF -a'"
fi

if ! $_ECHO 0 > $swappiness; then
    error "Failed to set swappiness to 0."
fi

info "${Deliverable} postinstall completed"

exit 0