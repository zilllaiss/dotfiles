#### INITS ####


set -g fish_key_bindings fish_vi_key_bindings

set -gx EDITOR vim
set -gx CUSTOM_BIN ~/.local/bin
set -gx CUSTOM_PATH ~/go/bin /usr/local/go/bin ~/.bun/bin $CUSTOM_BIN $CUSTOM_BIN/paru ~/bin/nvim/bin ~/zig ~/.local/share/nvim/mason/bin
set -gx PATH "$PATH:$CUSTOM_PATH"
set -gx GO_TASK_PROGNAME go-task
set -gx PAGER "bat"
set -gx WWW_HOME "www.duckduckgo.com"

zoxide init --cmd cd fish | source


#### COMMAND OVERRIDES AND CONFIGS ####


test -f ~/.zl_profile.fish; and source ~/.zl_profile.fish

alias code=codium
alias stow="stow --no-folding"

command -v go-wrk &> /dev/null; and alias wrk=go-wrk
command -v go-task &> /dev/null; and alias task=go-task
command -v yazi &> /dev/null; and alias lf=yazi
command -v fd &> /dev/null; and alias find=fd

# additionally, you might want to edit /etc/pacman.conf if you use Arch (btw) to enable paru color support
command -v bat &> /dev/null; and alias cat="bat --paging never"

command -v trash &> /dev/null; and begin
	alias rm=trash
	alias rml=trash-list
	alias rmrf=trash-empty
	alias rmres=trash-restore
	alias rmr=trash-rm
end

command -v fzf &> /dev/null; and begin
	# Set up fzf key bindings
	fzf --fish | source

	# export FZF_DEFAULT_OPTS='--bind "ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)"'
	set -gx FZF_DEFAULT_OPT "
		--bind 'ctrl-e:become(echo {+} | xargs -o $EDITOR)'
		--bind 'ctrl-o:become(xdg-open {})'
		--bind 'ctrl-l:become(readlink -f {} | wl-copy && echo item\ copied\ to\ clipboard)'	
		--bind 'ctrl-y:execute(readlink -f {} | wl-copy && echo item\ copied\ to\ clipboard)'	
		--bind '?:toggle-preview'
	"
end

if command -v eza &> /dev/null 
	set ex eza
	set icon_flag '--icons'
else if command -v lsd &> /dev/null
	set ex lsd 
	set icon_flag '--icon'
end

test -z $ex; or begin
	if string match $ex eza &> /dev/null 
		set -l extra " modified"
	end

	alias ls="$ex $icon_flag always --group-directories-first"
	alias lsa="ls -al"
	alias lst="ls -al -t$extra"
	alias lss="ls -alS"
end

if command -v rg &> /dev/null
	alias grep=rg
else
	alias grep="grep --color=always"
end

if command -v micro &> /dev/null
	alias nano=micro
else
	alias nano="nano --modernbindings"
end


#### ALIASES ####


function gitcount
	git ls-files | xargs wc -l
end

function cpr 
	rsync --archive -v --chown=$USER:$USER $argv[1] $argv[2] 
end

function yy
	set -l tmp "$(mktemp -t "yazi-cwd.XXXXXX")"

	yazi $argv --cwd-file="$tmp"

	set -l cwd "$(cat -- "$tmp")"

	if $cwd; and test -n "$cwd"; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end

	rm -f -- "$tmp"
end

function gb  
	set -l goname

	if test -z $argv[1]
		set goname cmd
	else
		set goname $argv[1]
	end

	go build -o ./bin/$goname 
end

# fedora
function rpm_list
	rpm -qa | grep -E  $argv[1] | sort
end

# this is just a function which extend fzf bindings so it wouldn't conflict with apps that use the original bindings
function f 
	fzf --bind 'enter:become(readlink -f {} | wl-copy && echo "item copied to the clipboard")'
end

# find inside files
function fif 
	find . -type f -exec grep --color=always -H $argv[1] {} \;
end

function stop 
	sleep $argv[2]; and kill (pgrep $argv[1])
end

function man_vim
	$argv | vim +MANPAGER -
end

function private_mode
	if ! test -z $fish_private_mode
		set -gx fish_private_mode 
		echo Private mode deactivated
	else 
		set -gx fish_private_mode true
		echo Private mode activated
	end
end

# to reduce memory (even when slightly) and to remind what functions available
function act
	source ~/.config/fish/actions.fish
end

abbr pm private_mode
abbr vime "vim -y" # working with (natural) languages with non-ascii characters like JP & AR is a nightmare in vim 
abbr q exit
abbr cl clear
abbr termmode "sudo systemctl isolate multi-user.target"
abbr graphmode "sudo systemctl isolate graphical.target"
abbr lg lazygit
abbr zlf "~/zlf.sh"
abbr frc "$EDITOR ~/.config/fish/config.fish"
abbr brc "$EDITOR ~/.bashrc"
abbr zrc "$EDITOR ~/.zshrc"
abbr zlrc "$EDITOR ~/.zl_profile"
abbr tmuxpi "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
abbr rpml rpm_list
abbr manv man_vim

# kitty-specific
abbr icat "kitty +kitten icat"


#### BINDINGS ####


bind --mode insert ctrl-r history-pager
bind --mode insert ctrl-p 'private_mode; echo "Press enter to continue"; commandline -r ""'
