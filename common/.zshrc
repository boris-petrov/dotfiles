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
setopt histignoredups # Ignore duplicate lines in the history.
unsetopt HUP # Send the HUP signal to running jobs when the shell exits.
setopt PROMPT_SUBST # Enable substitutions of functions in prompt
setopt interactivecomments # Enable ability to add comments at the end of a line

bindkey -v # vi-mode

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTORY_IGNORE="(ls|cd|cd ..|pwd|exit|bg|fg)"

##############################
# Git status in prompt
##############################

autoload -Uz promptinit; promptinit

fpath=($HOME/.zdir/functions $fpath)
autoload -U $HOME/.zdir/functions/*(:t)

add-zsh-hook chpwd update_current_git_vars
add-zsh-hook precmd update_current_git_vars

##############################
# Prompt
##############################

PROMPT='
%{$fg[green]%}%n@%m$(prompt_git_info) %{$bg[yellow]$fg[black]%}%~
%{$reset_color%}%(?..%{${fg[red]}%})%B%#%{$reset_color%} '
RPROMPT=""

eval $(dircolors)

##############################
# Completion
##############################

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

##############################
# Aliases
##############################

# grc aliases

alias grc='grc -es --colour=auto'
alias ping='grc ping'
alias make='grc make'
alias mount='grc mount'
alias ps='grc ps'
alias df='grc df -hPT'
alias du='grc du -ch'
alias free='grc free -h'
alias env='grc env'

# other aliases

alias diff='colordiff -bup'
alias mkdir='mkdir -p -v'

alias tmux='tmux -u -2 -q'

alias ctags='ctags -f.tags'

alias ip='grc ip'

LS='ls -hF --color --group-directories-first'
alias ls=$LS
alias ll="grc $LS -l"
alias la='ls -A'
alias mv='mv -i'

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit -v'
alias gl='git log'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

alias cd..='cd ..'
alias cd...='cd ../..'
alias -g ...='../..'
alias cd....='cd ../../..'
alias -g ....='../../..'
alias cd.....='cd ../../../..'
alias -g .....='../../../..'

alias be='bundle exec'

alias tailf='tail -F'

alias mplayer_softvol='mplayer -softvol -softvol-max 400'
alias smplayer_softvol='smplayer -softvol -softvol-max 400'

alias feh='feh -.'

alias reboot='sudo systemctl reboot'
alias suspend='systemctl suspend'
alias halt='sudo systemctl poweroff'

alias vi=vim

alias htop='TERM=screen htop' # fix for tmux redrawing issue

alias sudo='sudo -E '

alias grep='grep --no-messages --color=auto'

alias feh='feh --auto-rotate'

which() {
  (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@
}
export which

file() {
  (/usr/bin/file $@; /usr/bin/file -bi $@) | xargs -0 echo
}
export file

export LESS="-XRi --quit-if-one-screen"
export PAGER=less

export FZF_DEFAULT_COMMAND='
  (git ls-tree -r --name-only HEAD ||
    find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
      sed s/^..//) 2> /dev/null'
export FZF_DEFAULT_OPTS='--reverse --tiebreak=end'

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
    *.t(gz|lz|xz|b2|bz2|ar|ar.*))
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

  bindkey -M viins '^[[A'  delete-char
  bindkey -M viins '^[[3~' delete-char # delete key

  bindkey -M viins '^[[B' down-line-or-beginning-search
  bindkey -M viins '^k'   up-line-or-beginning-search
  bindkey -M viins '^h'   backward-delete-char
  bindkey -M viins '^l'   delete-char
  bindkey -M viins '^e'   end-of-line
  bindkey -M viins '^a'   beginning-of-line

  bindkey -M viins '\en'  forward-word  # Alt-n
  bindkey -M viins '\eb'  backward-word # Alt-b

  bindkey ^R history-incremental-search-backward

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
  \env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
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

  # zsh highlighting
  ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
  ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[path_approx]='fg=red'
  ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta'
  ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta'

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
    [[ $3 = git* || $3 = ssh* || $3 = scp* ]] && source ssh-agent.zsh
  }

  add-zsh-hook preexec hook_function

  export GPG_TTY=$(tty)

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

# replaces `git push --force` with `git push --force-with-lease`
git() {
  if [[ $@ == 'push -f'* || $@ == 'push --force'* ]]; then
    command git push --force-with-lease
  else
    command git "$@"
  fi
}

# great video about `fzf` - https://www.youtube.com/watch?v=qgG5Jhi_Els
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FD_OPTIONS='--follow --exclude .git --exclude node_modules'
export FZF_DEFAULT_COMMAND="git ls-tree -r --name-only HEAD || fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_DEFAULT_OPTIONS='--no-mouse --reverse --multi --inline-info'

ulimit -c unlimited
