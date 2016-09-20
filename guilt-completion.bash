
_guilt_arglist=(
    'add'
    'applied'
    'branch'
    'commit'
    'delete'
    'diff'
    'export'
    'files'
    'fold'
    'fork'
    'graph'
    'guard'
    'header'
    'help'
    'import'
    'import-commit'
    'init'
    'new'
    'next'
    'patchbomb'
    'pop'
    'prev'
    'push'
    'rebase'
    'refresh'
    'repair'
    'rm'
    'select'
    'series'
    'status'
    'top'
    'unapplied'
    'cat'
)

_guilt() {
    COMPREPLY=()
    _get_comp_words_by_ref cur prev words cword

    case "${words[1]}" in
    push|fold)
        COMPREPLY=($(compgen -W '$(guilt unapplied)' -- "$cur"))
    	;;
    pop)
        COMPREPLY=($(compgen -W '$(guilt applied)' -- "$cur"))
    	;;
    delete)
        COMPREPLY=($(compgen -W '$(guilt unapplied; guilt g |sed "s,.*/,,")' -- "$cur"))
    	;;
    cat)
        COMPREPLY=($(compgen -W '$(guilt applied; guilt unapplied; guilt g |sed "s,.*/,,")' -- "$cur"))
    	;;
    *)
        COMPREPLY=($(compgen -W '${_guilt_arglist[@]}' -- "$cur"))
    	;;
    esac

    true
}

complete -F _guilt guilt && complete -F _guilt q
