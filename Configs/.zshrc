alias l="ls -la"
alias le="eza --icons --hyperlink --sort type"
alias la="eza --icons --hyperlink --sort type -ga"
alias lt="eza --icons --hyperlink --sort type -1T"
alias lta="eza --icons --hyperlink --sort type -1Ta"
alias bat="batcat --color=always "
alias batd="batcat -d --color=always "
alias cd="z"
alias cdh="cd ~"

# source /path/to/zsh-autocomplete/zsh-autocomplete.plugin.zsh
skip_global_compinit=1

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
export PATH="$HOME/.local/bin:$PATH"
export ZSH_AUTOCOMPLETE_ADD_SEMICOLON=false

plugins=(
    git
    zsh-autosuggestions
    zsh-history-substring-search
    web-search 
    z
    sudo
    history
    F-Sy-H
    you-should-use
    auto-notify
    command-not-found
    dirhistory 
    # zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

export LANG=pt_BR.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='code'
else
  export EDITOR='nvim'
fi

export PATH="$PATH:/home/moises/.lmstudio/bin"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval $(thefuck --alias)
source $ZSH/oh-my-zsh.sh
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
# source <(fzf --zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_CTRL_T_OPTS="
  --style full
  --walker-skip node_modules,target
  --preview 'batcat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
