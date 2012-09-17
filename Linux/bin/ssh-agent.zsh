# Based on code from Joseph M. Reagle
# http://www.cygwin.com/ml/cygwin/2001-06/msg00537.html

local SSH_ENV=$HOME/.ssh/environment

function start_agent {
  /usr/bin/env ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
  ssh-add
  chmod 600 ${SSH_ENV}
  . ${SSH_ENV} > /dev/null
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
  . ${SSH_ENV} > /dev/null
  echo '1'
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
  echo '2'
    start_agent;
  }
else
  start_agent;
fi