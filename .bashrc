# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	  . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# User specific aliases and functions
triangle=$'\uE0B0'
time_arrow='\e[44m\e[30m\t \e[34m\e[100m$triangle'
cwd_arrow='\e[1m\e[44m\e[30m \w \e[90m\e[49m$triangle'
start_arrow='\e[49m\e[34m$triangle'
cwd='\e[34m[\w]'
reset='\e[0m\e[39m'
lambda='\e[95mλ'
export PS1="$start_arrow $cwd $lambda $reset"

# export TERM=xterm-256color

export LOCALE_ARCHIVE_2_27="/nix/store/rdzldh4fiisgjy2hfvs1bf48gprbqlkh-glibc-locales-2.27/lib/locale/locale-archive"
export LOCALE_ARCHIVE_2_11="/etc/default/locale"

eval "$(direnv hook bash)"

# echo -e -n "\x1b[\x36 q" # cursor as line
