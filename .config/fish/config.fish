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


alias code=codium

if command -v go-wek &> /dev/null 
	alias wrk=go-wrk
end

if command -v go-task &> /dev/null
	alias task=go-task
end

if test -f ~/.zl_profile.fish
 	source ~/.zl_profile.fish
end

if command -v bat &> /dev/null
	# additionally, you might want to edit /etc/pacman.conf if you use Arch (btw) to enable paru color support
	alias cat="bat --paging never"
end

if command -v trash &> /dev/null
	alias rm=trash
	alias rml=trash-list
	alias rmrf=trash-empty
	alias rmres=trash-restore
	alias rmr=trash-rm
end

if command -v yazi &> /dev/null
	alias lf=yazi
end

if command -v eza &> /dev/null 
	set ex eza
	set icon_flag '--icons'
else if command -v lsd &> /dev/null
	set ex lsd 
	set icon_flag '--icon'
end

if ! test -z $ex
	if string match $ex eza &> /dev/null 
		set -l extra " modified"
	end

	alias ls="$ex $icon_flag always --group-directories-first"
	alias lsa="ls -al"
	alias lst="ls -al -t$extra"
	alias lss="ls -alS"
end

if command -v fd &> /dev/null 
	alias find=fd
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


# export FZF_DEFAULT_OPTS='--bind "ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)"'
set -gx FZF_DEFAULT_OPT "
	--bind 'ctrl-e:become(echo {+} | xargs -o $EDITOR)'
	--bind 'ctrl-o:become(xdg-open {})'
	--bind 'ctrl-l:become(readlink -f {} | wl-copy && echo item\ copied\ to\ clipboard)'	
	--bind 'ctrl-y:execute(readlink -f {} | wl-copy && echo item\ copied\ to\ clipboard)'	
	--bind '?:toggle-preview'
"

alias stow="stow --no-folding"


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
		set -l goname cmd
	else
		set -l goname $argv[1]
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
	sleep $argv[2] && kill $(pgrep $argv[1])
end

function man_vim
	$argv | vim +MANPAGER -
end

function rename
	if test $(count $argv) -lt 1 
		echo "you must specify the filename"
		return 1
	end

	if ! test -f $argv[1]
		echo "no file like that"
		return 1
	end

	echo "renaming file $argv[1]"

	set -l splitted $(string split '.' $argv[1])
	set -l sp_length $(count $splitted)
	set -l ext $splitted[$sp_length]

	echo "extension is .$ext"

	set -l new_name $(randstring).$ext
	mv $argv[1] $new_name

	echo "file renamed to $new_name"
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
abbr rn rename
abbr manv man_vim

# kitty-specific
abbr icat "kitty +kitten icat"


#### BINDINGS ####


bind --mode insert ctrl-r history-pager
bind --mode insert ctrl-p 'private_mode; echo "Press enter to continue"; commandline -r ""'
