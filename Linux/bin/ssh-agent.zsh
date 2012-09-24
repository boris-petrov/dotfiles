# Based on code from Joseph M. Reagle
# http://www.cygwin.com/ml/cygwin/2001-06/msg00537.html

SSH_ENV=$HOME/.ssh/environment

function start_agent {
  /usr/bin/env ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
  chmod 600 ${SSH_ENV}
  . ${SSH_ENV} > /dev/null
  ssh-add
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
  . ${SSH_ENV} > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi
