autoload -U compinit colors select-word-style

compinit -d /tmp/dumpfile
colors
select-word-style bash

##############################
# Options
##############################

unsetopt LIST_AMBIGUOUS # If this option is set completions are shown only if the completions don't have an unambiguous prefix or suffix that could be inserted in the command line.
unsetopt AUTO_REMOVE_SLASH
unsetopt BG_NICE # Run all background jobs at a lower priority. This option is set by default.
setopt HIST_IGNORE_SPACE # Do not enter command lines into the history list if they begin with a blank.
setopt NOTIFY # Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt PROMPT_SUBST # Enable substitutions of functions in prompt

bindkey -v # vi-mode

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

##############################
# Git status in prompt
##############################

autoload -Uz promptinit; promptinit

fpath=($HOME/.zdir/functions $fpath)
autoload -U ~/.zdir/functions/*(:t)

add-zsh-hook chpwd chpwd_update_git_vars
add-zsh-hook preexec preexec_update_git_vars
add-zsh-hook precmd precmd_update_git_vars

##############################
# Prompt
##############################

PROMPT='
%{$fg[green]%}%n@%m$(prompt_git_info) %{$fg[yellow]%}%~
%{$reset_color%}%(?..%{${fg[red]}%})%B%#%{$reset_color%} '
RPROMPT=""

eval $(dircolors)

##############################
# Completion
##############################

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

##############################
# Aliases
##############################

alias diff='colordiff'
alias mkdir='mkdir -p -v'

alias df='df -hPT'
alias du='du -ch'

alias grep='grep -I -n -s --color --exclude-dir=node_modules --exclude-dir=.git --exclude=tags --exclude-dir=coverage --exclude-dir=tmp --exclude-dir=log --exclude-dir=vendor --exclude-dir=public'

alias ls='ls -hF --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -A'
alias gcc=colorgcc

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit -v'
alias gl='git log'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'

alias be='bundle exec'

alias mplayer='mplayer -softvol -softvol-max 400'
alias smplayer='smplayer -softvol -softvol-max 400'

alias feh='feh -.'

alias reboot='sudo systemctl reboot'
alias suspend='systemctl suspend'
alias halt='sudo systemctl poweroff'

alias vi=vim

##############################
# Functions
##############################

# Extract Stuff
extract() {
  local c e i

  (($#)) || return

  for i; do
    c=''
    e=1

    if [[ ! -r $i ]]; then
      echo "$0: file is unreadable: \`$i'" >&2
      continue
    fi

    case $i in
    *.t(gz|lz|xz|b2|bz2|ar.*))
           bsdtar xvf $i;;
    *.7z)  7z x $i;;
    *.Z)   uncompress $i;;
    *.bz2) bunzip2 $i;;
    *.exe) cabextract $i;;
    *.gz)  gunzip $i;;
    *.rar) unrar x $i;;
    *.xz)  unxz $i;;
    *.zip) unzip $i;;
    *)     echo "$0: unrecognized file extension: \`$i'" >&2
           continue;;
    esac

    e=$?
  done

  return $e
}
up-line-or-beginning-search () {
  if [[ $LBUFFER == *$'\n'* ]]; then
    zle .up-line-or-history
    __searching=''
  elif [[ -n $PREBUFFER ]] &&
      zstyle -t ':zle:up-line-or-beginning-search' edit-buffer
  then
    zle .push-line-or-edit
  else
    [[ $LASTWIDGET = $__searching ]] && CURSOR=$__savecursor
    __savecursor=$CURSOR
    __searching=$WIDGET
    zle .history-beginning-search-backward
    zstyle -T ':zle:up-line-or-beginning-search' leave-cursor &&
        zle .end-of-line
  fi
}
down-line-or-beginning-search () {
  if [[ $LBUFFER == *$'\n'* ]]; then
    zle .down-line-or-history
    __searching=''
  elif [[ -n $PREBUFFER ]] &&
      zstyle -t ':zle:down-line-or-beginning-search' edit-buffer
  then
    zle .push-line-or-edit
  else
    [[ $LASTWIDGET = $__searching ]] && CURSOR=$__savecursor
    __savecursor=$CURSOR
    __searching=$WIDGET
    zle .history-beginning-search-forward
    zstyle -T ':zle:down-line-or-beginning-search' leave-cursor &&
        zle .end-of-line
  fi
}

function xterm-bindings () {
  # Ctrl+Left/Right to move by whole words
  bindkey '\e[1;5C' forward-word
  bindkey '\e[1;5D' backward-word

  # Ctrl+Backspace/Delete to delete whole words
  bindkey '\e[3;5~' kill-word
  bindkey '\C-_'    backward-kill-word

  # for Home and End
  bindkey "\e[H" beginning-of-line
  bindkey "\e[F" end-of-line

  # for Delete key
  bindkey "\e[3~" delete-char
}

function urxvt-bindings () {

  bindkey -M viins '^[[A' delete-char

  bindkey -M viins '^[[B' down-line-or-beginning-search
  bindkey -M viins '^k'   up-line-or-beginning-search
  bindkey -M viins '^h'   backward-delete-char
  bindkey -M viins '^l'   delete-char
  bindkey -M viins '^e'   end-of-line
  bindkey -M viins '^a'   beginning-of-line

  bindkey -M viins '\en'  forward-word  # Alt-n
  bindkey -M viins '\eb'  backward-word # Alt-b

  # Ctrl+Left/Right to move by whole words
  # bindkey '^[Oc' forward-word
  # bindkey '^[Od' backward-word

  # Ctrl+Backspace/Delete to delete whole words
  # bindkey '^[[3^' kill-word
  # bindkey '^H' backward-kill-word

  # for Home and End
  # bindkey "^[[7~" beginning-of-line
  # bindkey "^[[8~" end-of-line

  # for Delete key
  # bindkey "^[[3~" delete-char

}

# Color manpages
man() {
  env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

##############################
##############################

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

if [ `uname -s` = "Linux" ]; then
  # the next ones work with urxvt
  urxvt-bindings

  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # To have paths colored instead of underlined
  ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

  # change title of urxvt to current dir
  function settitle() {
    printf "\e]0;$@\a"
  }
  function dir_in_title() {
    settitle $PWD
  }
  chpwd_functions=(dir_in_title)
  settitle $PWD

  hook_function() {
    [[ $3 = git* ]] && source ssh-agent.zsh
    [[ $3 = ssh* ]] && source ssh-agent.zsh
  }

  add-zsh-hook preexec hook_function

elif [ `uname -o` = "Cygwin" ]; then
  xterm-bindings

  export VBOX_USER_HOME='C:\Users\Boris\.VirtualBox\'

  # change title of MinTTY to current dir
  function settitle() {
    echo -ne "\033]2;"$1"\007"
  }
  function chpwd() {
    settitle $(pwd)
  }
  settitle $(pwd)

  alias vim='/cygdrive/c/Program\ Files\ \(x86\)/Vim/vim73/gvim.exe'
  alias gvim=vim
fi

export CC=colorgcc
export EDITOR=vim

export LD_LIBRARY_PATH=.:/usr/local/lib:$LD_LIBRARY_PATH

ulimit -c unlimited

##############################
# nodejs and ruby specific stuff
##############################

export PATH=$HOME/bin:./node_modules/.bin:$HOME/.gem/ruby/1.9.1/bin:$PATH
export NODE_PATH=/usr/lib/node_modules:/usr/lib:.

[ -x "$HOME/nvm/nvm.sh" ] && . "$HOME/nvm/nvm.sh"

if [ -x "$HOME/.rbenv/bin/rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
