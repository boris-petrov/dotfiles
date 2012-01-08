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
setopt CORRECT # Try to correct the spelling of commands.
setopt COMPLETE_ALIASES
setopt GLOB_DOTS # Do not require a leading . in a filename to be matched explicitly.
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE # Do not enter command lines into the history list if they begin with a blank.
unsetopt HUP # Send the HUP signal to running jobs when the shell exits.
setopt NOTIFY # Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
bindkey -v # vi-mode

PROMPT="%{$fg[green]%}%n@%m %{$fg[yellow]%}%~
%{$reset_color%}%(?..%{${fg[red]}%})%B%#%{$reset_color%} "
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
alias du='du -h'

alias grep='grep --color'

alias ls='ls -AhF --color=auto --group-directories-first'
alias ll='ls -l'
alias gcc=colorgcc

alias vim=gvim

alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'

export CC=colorgcc
export EDITOR=gvim

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

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search

export PATH="/usr/lib/colorgcc/bin:$PATH"

compdef -d git

if [ `uname -s` = "Linux" ]; then
	# the next ones work with urxvt
	
	# Ctrl+Left/Right to move by whole words
	bindkey '^[Oc' forward-word
	bindkey '^[Od' backward-word

	# Ctrl+Backspace/Delete to delete whole words
	bindkey '^[[3^' kill-word
	bindkey '^H' backward-kill-word

	# for Home and End
	bindkey "^[[7~" beginning-of-line
	bindkey "^[[8~" end-of-line

	# for Delete key
	bindkey "^[[3~" delete-char

	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

	# To have paths colored instead of underlined
	ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

elif [ `uname -o` = "Cygwin" ]; then

	# the next ones work with mintty
	
	# Ctrl+Left/Right to move by whole words
	bindkey '\e[1;5C' forward-word
	bindkey '\e[1;5D' backward-word

	# Ctrl+Backspace/Delete to delete whole words
	bindkey '\e[3;5~' kill-word
	bindkey '\C-_' backward-kill-word

	# for Home and End
	bindkey "\e[H" beginning-of-line
	bindkey "\e[F" end-of-line

	export VBOX_USER_HOME='C:\Users\Boris\.VirtualBox\'

	# change title of MinTTY to current dir
	function settitle() {
		echo -ne "\033]2;"$1"\007"
	}
	function chpwd() {
		settitle $(pwd)
	}
	settitle $(pwd)
fi

