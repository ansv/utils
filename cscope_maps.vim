" cscope helpers for vim
"
" Stick this file in your ~/.vim/plugin directory
"

" if (diff mode)
"     "jump between diff changes"
" else if (quickfix mode)
"     "jump between quickfix entries"
" else
"     "jump between paragraphs"
"
function! cscope_maps#Prev()
    if &diff
        execute "normal [c"
    else
        try
            execute "cp"
        catch /^Vim\%((\a\+)\)\=:E42:/
            execute "normal {"
        catch /^Vim\%((\a\+)\)\=:E\(553\|42\):/
        endtry
    endif
endfunction

function! cscope_maps#Next()
    if &diff
        execute "normal ]c"
    else
        try
            execute "cn"
        catch /^Vim\%((\a\+)\)\=:E42:/
            execute "normal }"
        catch /^Vim\%((\a\+)\)\=:E\(553\|42\):/
        endtry
    endif
endfunction

nmap <C-Up> :call cscope_maps#Prev()<CR>
nmap <C-Down> :call cscope_maps#Next()<CR>


if !has("cscope")
    " time to recompile vim with the option '--enable-cscope' ...
    finish
endif


" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetag

" check cscope for definition of a symbol before checking ctags: set to 1
" if you want the reverse search order.
set csto=0

" add any cscope database in current directory
if filereadable("cscope.out")
    cs add cscope.out
" else add the database pointed to by environment variable
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif

" show msg when any other cscope db added
set cscopeverbose


" use <C-g>^ as a "replacement" for the classical <C-g>


" clear and close quickfix
function! cscope_maps#CloseQF()
    call setqflist([])
    execute "cclose"
endfunction

nmap <C-g><C-x> :call cscope_maps#CloseQF()<CR>
nmap <C-g>x :call cscope_maps#CloseQF()<CR>


" rebuild and [R]eload cscope db
function! cscope_maps#ReloadMaps()
    execute "cscope kill -1"
    execute "!cscope -v -R -b -q -k"
    execute "cscope add ."
    call cscope_maps#CloseQF()
endfunction

nmap <C-g><C-r> :call cscope_maps#ReloadMaps()<CR>
nmap <C-g>r :call cscope_maps#ReloadMaps()<CR>


" find [U]sages
function! cscope_maps#FindUsages()
    let str = expand("<cword>")
    call cscope_maps#CloseQF()
    execute "cscope find c " . str
    execute "cw"
    call matchadd('Search', '\<' . str . '\>')
endfunction

nmap <C-g><C-u> :call cscope_maps#FindUsages()<CR>
nmap <C-g>u :call cscope_maps#FindUsages()<CR>


" goto global [D]efinition
function! cscope_maps#GotoDef()
    execute "cscope find g " . expand("<cword>")
    call cscope_maps#CloseQF()
endfunction

nmap <C-g><C-d> :call cscope_maps#GotoDef()<CR>
nmap <C-g>d :call cscope_maps#GotoDef()<CR>
nmap g<C-d> :call cscope_maps#GotoDef()<CR>


" find all refs to the token [G] (Definition + Usages)
function! cscope_maps#FindToken()
    let str = expand("<cword>")
    call cscope_maps#CloseQF()
    execute "cscope find s " . str
    execute "cw"
    call matchadd('Search', '\<' . str . '\>')
endfunction

nmap <C-g><C-g> :call cscope_maps#FindToken()<CR>
nmap <C-g>g :call cscope_maps#FindToken()<CR>


" find all instances of the [T]ext
function! cscope_maps#FindText()
    let str = expand("<cword>")
    call cscope_maps#CloseQF()
    execute "cscope find t " . str
    execute "cw"
    call matchadd('Search', str)
endfunction

nmap <C-g><C-t> :call cscope_maps#FindText()<CR>
nmap <C-g>t :call cscope_maps#FindText()<CR>


" open [F]ile
function! cscope_maps#FindFiles()
    call cscope_maps#CloseQF()
    let str = input("find files: ", "")
    execute "cscope find f " . str
    execute "cw"
    call matchadd('Search', str)
endfunction

nmap <C-g><C-f> :call cscope_maps#FindFiles()<CR>
nmap <C-g>f :call cscope_maps#FindFiles()<CR>
