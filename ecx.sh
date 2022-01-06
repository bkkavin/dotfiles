#urxvtd -q -o -f
#urxvtc -hold -name "ecx" -e echo "hi"


emacsclient -a "" -nc -F "(quote (name . \"ecx\"))"
