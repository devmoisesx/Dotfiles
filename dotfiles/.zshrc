 alias ls="eza --icons --hyperlink --sort type" 
alias le="eza --icons --hyperlink --sort type -a"
alias lt="eza --icons --hyperlink --sort type -1T"
alias lta="eza --icons --hyperlink --sort type -1Ta"
alias bat="bat --color=always "
alias cd="cd"
alias gs="git status"
alias gp="git push"
alias ga="git add "
alias gc="git commit -m "
alias n="nvim"
# alias tmux="tmux -A -s terminal"
# alias lvim="NVIM_APPNAME=lvim nvim"

# alias nvim="/home/moises/.local/bin/lvim"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
export PATH="$HOME/.local/bin:$PATH"
export TERMINAL="kitty"
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
# 	exec tmux new-session -A -s terminal
# fi

skip_global_compinit=1

plugins=(
    git
    zsh-autosuggestions
    zsh-history-substring-search
    web-search 
    z
    sudo
    history
    you-should-use
    auto-notify
    command-not-found
    dirhistory 
)

export LANG=pt_BR.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='code'
else
  export EDITOR='nvim'
fi

source $ZSH/oh-my-zsh.sh
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_CTRL_T_OPTS="
  --style full
  --walker-skip node_modules,target
  --preview 'batcat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export DOTNET_ROOT=/usr/share/dotnet
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
eval "$(starship init zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
