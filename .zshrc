# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ekstdolaptop1/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

eval "$(navi widget zsh)"
eval "$(zoxide init zsh)"

GOPATH=$HOME/.gocode

#if [[ $(ps --no-header -p $PPID -o comm) =~ '^yakuake|kitty$' ]]; then
#        for wid in $(xdotool search --pid $PPID); do
#            xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
#fi


zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' 
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#777777"

export NPM_PACKAGES="$HOME/.npm-packages"
export NDOE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin/:$HOME/.local/bin:$HOME/.local/bin/*/:$HOME/.cargo/bin:$HOME/.npm/bin:$NODE_PATH:$HOME/.cabal/bin"

rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	local page
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}




alias his="cat ~/.zsh_history | fzf | zsh"
alias icat="kitty +kitten icat"
alias nvimtest="cd ~/Dokumente/test/ && nvim"
alias quickpython='echo "import sympy\\nfrom sympy.abc import x, y, z\\nimport numpy as np\\nimport matplotlib.pyplot as plt\\nimport matplotlib as mat\\n\\n\\n" > /tmp/quickpython.py && export TMPPATH="$(pwd)" && cd /tmp && nvim /tmp/quickpython.py +"bo split" +term +"winc t" +start && cd "$TMPPATH"'
alias nvimconfig='export TMPPATH="$(pwd)" && cd $HOME/.config/nvim && nvim init.lua +NvimTreeOpen && cd "$TMPPATH"'

# eval $(thefuck --alias)
#
# stuff
alias steamid="grep -n name ~/.steam/steam/steamapps/*.acf | sed -e 's/^.*_//;s/\.acf:.:/ /;s/name//;s/\"//g;s/\t//g;s/ /-/' | awk -F'-' '{printf \"%-40s %s\n\", \$2, \$1}' | fzy | grep -oE '[^ ]+$'"
alias s="kitty +kitten ssh"
function fzopen() {
	output=$(fd | fzy) && xdg-open $output
}
function mvhere() {
	output=$(fd . ${1:=~/Downloads/} | fzy) && mv $output .
}


alias nixswitch="sudo nixos-rebuild switch --flake '$HOME/nikstdo/.#nikstdoConfig'"
alias nixhomeswitch="home-manager switch --flake '$HOME/nikstdo/.#nikstdoConfig'"



if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ ! -d  ~/.zsh/zsh-autosuggestions ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ ! -d ~/.zsh/powerlevel10k ]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
fi
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



function battery_level {                                                                                                                            
 charge_current="$(cat /sys/class/power_supply/BAT0/charge_now)"                                                                                    
 charge_full="$(cat /sys/class/power_supply/BAT0/charge_full)"                                                                                      
 let "current=100*$charge_current/$charge_full"                                                                                                     
 echo "$current%"                                                                                                                                   
}


alias split_by_size='i=0;
for f in `ls -S`;
do
    d=dir_$(printf %03d $((i/100+1)));
    mkdir -p $d;
    mv "$f" $d;
    let i++;
done'


alias bssh="s -L localhost:8888:localhost:8888 -L localhost:6006:localhost:6006 -L localhost:8080:localhost:8080 mmc-user@gimpel.informatik.uni-augsburg.de -p 6104"
alias bsshfs="sshfs mmc-user@gimpel.informatik.uni-augsburg.de:/home/mmc-user ./mountpoint -p 6104"




extract_all_pdfimages() {
	for file in ${~1:=./**/*.pdf}
	do mkdir "${file%.*}/"
		pdfimages "$file" "${file%.*}/"
		fclones group "${file%.*}/" | fclones remove
	done
}



convert_all_img() {
	for file in ${~1}; do magick "$file" "${file%.*}.$2"; done
}

# sets out of memory priority, negative to make it less likely to be killed
# requires root 
set_oom() {
	if [ -e /proc/$1 ]
	then sudo echo $2 > /proc/$1/oom_adj
	else sudo echo $2 > /proc/$(pidof $1)/oom_adj
	fi
}

setopt allexport ; . $HOME/.env ; unsetopt allexport
