#!/bin/bash
##-------------------------------------------------------------------
## File: check_service_status.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2015-02-24>
## Updated: Time-stamp: <2017-11-13 11:08:59>
##-------------------------------------------------------------------
# TODO: move to common library
service_name=${1?}

sudo "/etc/init.d/$service_name" status
exit_code=$?
if [ $exit_code = 0 ]; then
    echo "OK: service $service_name is running | status=0"
else
    echo "CRITICAL: service $service_name has stopped | status=2"
    exit 2
fi
## File: check_service_status.sh ends
