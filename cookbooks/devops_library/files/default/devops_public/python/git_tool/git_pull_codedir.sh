#!/bin/bash -e
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT 
##   https://raw.githubusercontent.com/DennyZhang/devops_public/master/LICENSE
##
## File : git_pull_codedir.sh
## Author : Denny <denny@dennyzhang.com>
## Description :
## Sample: bash git_pull_codedir.sh "/data/code_dir/repo1,/data/code_dir/repo2"
## --
## Created : <2017-06-04>
## Updated: Time-stamp: <2017-06-19 14:25:09>
##-------------------------------------------------------------------
# https://coderwall.com/p/rdi_wq/fix-could-not-open-a-connection-to-your-authentication-agent-when-using-ssh-add

function detect_ssh_auth_sock() {
    ssh_agent_pid=$(pgrep ssh-agent  | head -n 1)
    if [ -z "$ssh_agent_pid" ]; then
        echo "ERROR: no ssh agent is found. Please run eval \$(ssh-agent) and ssh-add \$ssh_keyfile first."
    else
        # Sample output:
        # lsof -p 2341 | grep "/tmp/"
        # ssh-agent 2341 root    3u  unix 0xffff88009057d000      0t0 1092136 /tmp/ssh-CQvj4eoYn5ha/agent.2340 type=STREAM
        ssh_auth_sock=$(lsof -p "$ssh_agent_pid" | grep '/tmp/' | awk -F' ' '{print $9}')
        # Return: /tmp/ssh-CQvj4eoYn5ha/agent.2340
        if [ -S "$ssh_auth_sock" ]; then
            echo "$ssh_auth_sock"
        else
            echo "ERROR: $ssh_auth_sock doesn't exist, or it's not a socket"
            exit 1
        fi
    fi
}

function get_agentid_from_authsock() {
    # Sample: /tmp/ssh-CQvj4eoYn5ha/agent.2340 -> 2340
    ssh_auth_sock=${1?}
    echo "${ssh_auth_sock##*.}"
}

code_dir_list=${1?}
ssh_auth_sock=$(detect_ssh_auth_sock)

if [[ "${ssh_auth_sock}" == ERROR* ]]; then
    echo "ERROR to get existing ssh agent session. ssh_auth_sock: $ssh_auth_sock"
    exit 1
fi

ssh_agent_id=$(get_agentid_from_authsock "$ssh_auth_sock")
export SSH_AUTH_SOCK="$ssh_auth_sock"
export SSH_AGENT_PID="$ssh_agent_id"

echo "export SSH_AUTH_SOCK=$ssh_auth_sock; export SSH_AGENT_PID=$ssh_agent_id"
if [ ! -f /usr/sbin/git_pull_codedir.py ]; then
    echo "ERROR: /usr/sbin/git_pull_codedir.py is not found!"
    echo "Get it from: https://github.com/DennyZhang/devops_public/tree/master/python/git_tool"
    exit 1
fi

echo "python /usr/sbin/git_pull_codedir.py --code_dirs $code_dir_list"
python /usr/sbin/git_pull_codedir.py --code_dirs "$code_dir_list"
## File : git_pull_codedir.sh ends
