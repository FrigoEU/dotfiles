# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	  . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# User specific aliases and functions
export PS1="\w [\t] \\$ "
export TERM=xterm-256color

eval "$(direnv hook bash)"
