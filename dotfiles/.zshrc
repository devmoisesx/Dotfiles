alias l="ls -la"
#alias ls ="eza --icons --hyperlink --sort type" 
alias le="eza --icons --hyperlink --sort type -a"
alias la="eza --icons --hyperlink --sort type -ga"
alias lt="eza --icons --hyperlink --sort type -1T"
alias lta="eza --icons --hyperlink --sort type -1Ta"
alias bat="bat --color=always "
alias batd="bat -d --color=always "
alias cd="cd"
alias cdh="cd ~"
# alias tmux="tmux a || tmux"
alias gs="git status"
alias gp="git push"
alias ga="git add "
alias gc="git commit -m "

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
export PATH="$HOME/.local/bin:$PATH"

# source /path/to/zsh-autocomplete/zsh-autocomplete.plugin.zsh
skip_global_compinit=1

plugins=(
    git
    zsh-autosuggestions
    zsh-history-substring-search
    web-search 
    z
    sudo
    history
    # F-Sy-H
    you-should-use
    auto-notify
    command-not-found
    dirhistory 
    # zsh-autocomplete
)

export LANG=pt_BR.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='code'
else
  export EDITOR='nvim'
fi

source $ZSH/oh-my-zsh.sh
eval "$(zoxide init zsh)"
# eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
# source <(fzf --zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_CTRL_T_OPTS="
  --style full
  --walker-skip node_modules,target
  --preview 'batcat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export DOTNET_ROOT=/usr/share/dotnet

