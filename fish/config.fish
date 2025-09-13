if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Source secrets
source ~/.config/fish/secrets.fish

# Python (pyenv)
if command -v pyenv 1>/dev/null 2>&1
    set -gx PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    pyenv init --path | source
    pyenv init - | source
end

# Go
set -gx GOPATH $HOME/go
fish_add_path $GOPATH/bin

# Haskell GHCup
if test -f "$HOME/.ghcup/env"
    source "$HOME/.ghcup/env"
end

# NVM
set -gx NVM_DIR "$HOME/.nvm"

# OpenJDK
fish_add_path /opt/homebrew/opt/openjdk/bin

# FVM (Flutter Version Management)
set -gx FVM_CACHE_PATH "$HOME/fvm"
fish_add_path $FVM_CACHE_PATH/default/bin

# Aliases
alias vimc="/usr/bin/vim"
alias vim="nvim"
alias vimconfig="cd ~/.config/nvim && vim ."
alias claude="~/.claude/local/claude"
alias gco="git checkout"
alias signal="~/.cargo/bin/gurk"
alias mysql-local="docker compose -f ~/.config/mysql_local/docker-compose.yml"

#Cursor
set fish_cursor_default block

# pnpm
set -gx PNPM_HOME /Users/gabrielvincent/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
