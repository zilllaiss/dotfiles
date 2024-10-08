source ~/.zl_profile

if [ -f ~/.zl_others ]; then
  source ~/.zl_others
fi

fpath=(/home/xyassraist/.config/lf/zsh $fpath)

export ZSHPLUG=~/.config/zsh

if [ ! -d "$ZSHPLUG" ]; then
  mkdir ~/.config/zsh
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting 
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.config/zsh/zsh-autosuggestions 
  git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.config/zsh/zsh-history-substring-search 
  git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ~/.config/zsh/zsh-you-should-use 
  git clone https://github.com/Aloxaf/fzf-tab.git ~/.config/zsh/fzf-tab
  git clone https://github.com/zsh-users/zsh-completions.git ~/.config/zsh/zsh-completions
fi

source $ZSHPLUG/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSHPLUG/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSHPLUG/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSHPLUG/zsh-you-should-use/you-should-use.plugin.zsh
source $ZSHPLUG/fzf-tab/fzf-tab.plugin.zsh
source $ZSHPLUG/zsh-completions/zsh-completions.plugin.zsh

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

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"


bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# end of zsh exclusive 

# init
if command -v fzf &> /dev/null
then
	eval "$(fzf --zsh)"
fi

if command -v oh-my-posh &> /dev/null
then
	eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/zsh.toml)"
fi

if command -v zoxide &> /dev/null
then
	eval "$(zoxide init --cmd cd zsh)"
fi
