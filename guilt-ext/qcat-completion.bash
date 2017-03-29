
_qcat() {
    COMPREPLY=()
    _get_comp_words_by_ref cur prev words cword
    COMPREPLY=($(compgen -W '$(guilt path |xargs ls -1 |sed "s,.*/,," |egrep -v "^(series|status)$")' -- "$cur"))
    true
}

complete -F _qcat qcat
