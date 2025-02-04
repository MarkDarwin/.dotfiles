# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~
# remove duplicate entries from PATH
export PATH=$(echo "$PATH" | awk -v RS=: -v ORS=: '!a[$1]++' | sed 's/:$//')


# Set the directory we want to store pure prompt
PUREPROMPT_HOME="${HOME}/.zsh/pure"

# Download Pure prompt, if it's not there yet
if [ ! -d "$PUREPROMPT_HOME" ]; then
   mkdir -p "$(dirname $PUREPROMPT_HOME)"
   git clone https://github.com/sindresorhus/pure.git "$PUREPROMPT_HOME"
fi


# Set the directory we want to store fzf
FZF_HOME="${HOME}/.fzf"

# Download fzf, if it's not there yet
if [ ! -d "$FZF_HOME" ]; then
   mkdir -p "$(dirname $FZF_HOME)"
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
fi
# might need to manually add ~/.fzf to the path with  export PATH=~/.fzf/bin:$PATH

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE  # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS   # Don't save duplicate lines
setopt SHARE_HISTORY      # Share history between sessions


# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

# editor and browser
export VISUAL=nano
export EDITOR=nano
export TERM=xterm-256color

export BROWSER="edge"

# directories
export REPOS="$HOME/git"


# stop pure prompt from auto pulling when opening a directory
# without, ssh key will need to be unlocked all the time
PURE_GIT_PULL=0

if [[ "$OSTYPE" == darwin* ]]; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
else
  fpath+=($HOME/.zsh/pure)
fi

autoload -U promptinit; promptinit
prompt pure


# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~
if [ -f ~/.shell_aliases ]; then
    . ~/.shell_aliases
fi

# ~~~~~~~~~~~~~~~ Sourcing ~~~~~~~~~~~~~~~~~~~~~~~~


source <(fzf --zsh)
# --zsh is not supported on current OS
#source <(fzf)
# ~~~~~~~~~~~~~~~ Completion ~~~~~~~~~~~~~~~~~~~~~~~~


fpath+=~/.zfunc

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

autoload -Uz compinit
compinit -u

zstyle ':completion:*' menu select

# Example to install completion:
# talosctl completion zsh > ~/.zfunc/_talosctl

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


