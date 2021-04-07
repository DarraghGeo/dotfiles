# Vi mode for line editing
set -o vi

# Custom prompt
if [ $(id -u) -eq 0 ];
    then
        export PS1="\[\e[00;31m\]\u\[\e[0m\]\[\e[00;37m\] >\[\e[0m\]"
    else
        export PS1="\[\e[00;33m\]\t\[\e[0m\]\[\e[00;37m\] > \[\e[0m\]"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda2/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda2/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda2/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda2/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

