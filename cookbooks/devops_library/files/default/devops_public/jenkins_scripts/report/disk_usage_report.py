# -*- coding: utf-8 -*-
#!/usr/bin/python
##-------------------------------------------------------------------
## @copyright 2016 DennyZhang.com
## Licensed under MIT 
##   https://raw.githubusercontent.com/DennyZhang/devops_public/master/LICENSE
##
## File : disk_usage_report.py
## Author : Denny <denny@dennyzhang.com>
## Description :
## --
## Created : <2017-01-15>
## Updated: Time-stamp: <2017-06-30 23:19:34>
##-------------------------------------------------------------------
import os, sys, json
import requests
import subprocess

def quit_if_empty(string, err_msg):
    if string is None or string == '':
        print("Error: string is null or empty. %s" % (err_msg))
        sys.exit(-1)

################################################################################
'''
python ./disk_usage_report.py --server_role couchbase --server_list 192.168.1.2,192.168.1.3

# Sample output:
'''

if __name__ == '__main__':
    print("hello")
## File : disk_usage_report.py ends
