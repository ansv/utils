
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
    'wipe'
)

_guilt() {
    COMPREPLY=()
    _get_comp_words_by_ref cur prev words cword

    COMPREPLY=($(compgen -W '${_guilt_arglist[@]}' -- "$cur"))

    true
}

complete -F _guilt guilt && complete -F _guilt q
