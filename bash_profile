# Vi mode for line editing
set -o vi

# Custom prompt
if [ $(id -u) -eq 0 ];
    then
        export PS1="\[\e[00;31m\]\u\[\e[0m\]\[\e[00;37m\] >\[\e[0m\]"
    else
        export PS1="\[\e[00;33m\]\t\[\e[0m\]\[\e[00;37m\] > \[\e[0m\]"
fi
