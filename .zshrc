source ~/.zl_profile
source ~/.zl_others

fpath=(/home/xyassraist/.config/lf/zsh $fpath)

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# zsh exclusive

# plugins setup

export ZSHPLUG=~/.config/zsh

if [ ! -d "$ZSHPLUG" ]; then
	mkdir ~/.config/zsh
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting 
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.config/zsh/zsh-autosuggestions 
  git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.config/zsh/zsh-history-substring-search 
  git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ~/.config/zsh/zsh-you-should-use 
  git clone https://github.com/Aloxaf/fzf-tab ~/.config/zsh/fzf-tab
fi

source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/zsh-you-should-use/you-should-use.plugin.zsh
source ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh

bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# end of zsh exclusive 

# init
eval "$(fzf --zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/zsh.toml)"
eval "$(zoxide init --cmd cd zsh)"

