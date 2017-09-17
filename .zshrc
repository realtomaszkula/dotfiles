export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

# Path to your oh-my-zsh installation.
export ZSH=/home/zecik/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)
plugins+=(zsh-nvm zsh-completions)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"
alias xo="xdg-open"
alias c="code"
alias rs="redshift -t 3500:3500"
alias dc="docker-compose"
alias d="docker"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias drmi='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
alias drmae='docker rm $(docker ps -qa --no-trunc --filter "status=exited")'

# npm
alias npmre='rm -rf node_modules && npm install'
alias nt='npm test'
alias ntw='npm run test:watch'
alias ns='npm start'
alias nb='npm run build'
alias nl='npm link'

# for now only
alias rmg='find -L node_modules/@pracujwpl -type d -name graphql | xargs rm -rf'

# allow for Ctrl+R reverse search in node REPL
alias node='env NODE_NO_READLINE=1 rlwrap node'

# Always start in tmux
_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}

ensure_tmux_is_running

# # load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

for var in ~/.zsh/vars/*; do
  source $var
done

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# COMPLETION SETTINGS
# add custom completion scripts
fpath=(~/.zsh/completion $fpath)
source ~/.local/bin/aws_zsh_completer.sh

# compsys initialization
autoload -Uz compinit && compinit -i

# show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2



