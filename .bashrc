# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	  . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# User specific aliases and functions
export PS1="\w \\$ "
export TERM=xterm-256color

export LOCALE_ARCHIVE_2_27="/nix/store/rdzldh4fiisgjy2hfvs1bf48gprbqlkh-glibc-locales-2.27/lib/locale/locale-archive"
export LOCALE_ARCHIVE_2_11="/etc/default/locale"

eval "$(direnv hook bash)"

echo -e -n "\x1b[\x36 q" # cursor as line
