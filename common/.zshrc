autoload -U compinit colors select-word-style
compinit
colors
select-word-style bash

setopt ALWAYS_TO_END # If a completion with the cursor in the word was started and it results in only one match, the cursor is placed at the end of the word.
setopt AUTO_LIST
unsetopt LIST_AMBIGUOUS # If this option is set completions are shown only if the completions don't have an unambiguous prefix or suffix that could be inserted in the command line.
setopt AUTO_MENU
setopt APPEND_HISTORY
unsetopt AUTO_CD # If a command is not in the hash table, and there exists an executable directory by that name, perform the cd command to that directory.
setopt AUTO_PUSHD # Make cd push the old directory onto the directory stack.
unsetopt AUTO_REMOVE_SLASH
unsetopt BEEP
unsetopt BG_NICE # Run all background jobs at a lower priority. This option is set by default.
setopt CHASE_LINKS # Resolve symbolic links to their true values.
setopt CLOBBER # Allows > redirection to truncate existing files, and >> to create files.
unsetopt CORRECT # Do NOT try to correct the spelling of commands.
setopt COMPLETE_ALIASES
setopt GLOB_DOTS # Do not require a leading . in a filename to be matched explicitly.
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE # Do not enter command lines into the history list if they begin with a blank.
setopt HUP # Send the HUP signal to running jobs when the shell exits.
setopt NOTIFY # Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt PROMPT_SUBST # Enable substitutions of functions in prompt

bindkey -v # vi-mode

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

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

eval $(dircolors)

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

alias df='df -h'
alias du='du -ch'

alias grep='grep -I --color --exclude-dir=node_modules --exclude-dir=.git --exclude=tags'

alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

alias ls='ls -hF --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -A'
alias gcc=colorgcc

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit -v'
alias gl='git log'

alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'

alias be='bundle exec'

alias mplayer='mplayer -softvol -softvol-max 400'
alias smplayer='smplayer -softvol -softvol-max 400'

export CC=colorgcc
export EDITOR=vim

# Extract Stuff
extract () {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2) tar xvjf $1 ;;
      *.tar.gz) tar xvzf $1 ;;
      *.bz2) bunzip2 $1 ;;
      *.rar) unrar e $1 ;;
      *.gz) gunzip $1 ;;
      *.tar) tar xvf $1 ;;
      *.tbz2) tar xvjf $1 ;;
      *.tgz) tar xvzf $1 ;;
      *.zip) unzip $1 ;;
      *.Z) uncompress $1 ;;
      *.7z) 7z x $1 ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
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

  source ssh-agent.zsh

  alias vi=vim

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

  alias vi='/cygdrive/c/Program\ Files\ \(x86\)/Vim/vim73/gvim.exe'
  alias vim=vi
  alias gvim=vim
fi

export LD_LIBRARY_PATH=.:/usr/local/lib:$LD_LIBRARY_PATH

ulimit -c unlimited

##############################
# nodejs and ruby specific stuff
##############################

export PATH=./node_modules/.bin:$HOME/.gem/ruby/1.9.1/bin:$PATH
export NODE_PATH=/usr/lib/node_modules:/usr/lib:.

[ -x "$HOME/nvm/nvm.sh" ] && . "$HOME/nvm/nvm.sh"

if [ -x "$HOME/.rbenv/bin/rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
