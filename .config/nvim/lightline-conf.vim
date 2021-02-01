
" Lightline + CoC
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" Lighline filepath
function! LightlineFilePath()
    let path = expand("%")
    let splitPath = split(path,"/")
    let size = len(splitPath)
    if size > 3
        let newArray = ["..."] + splitPath[-3:]
        return join(newArray, "/")
    endif

    return path
endfunction

let g:lightline = {
            \ 'colorscheme': 'one',
            \ 'active': {
            \   'left': [ ['mode', 'paste'],
            \             ['filepath', 'modified']],
            \  'right': [['lineinfo'],
            \           ['filetype'],
            \           ['lightline_hunks']]
            \ },
            \ 'component_function': {
            \   'currentfunction': 'CocCurrentFunction',
            \   'lightline_hunks': 'lightline#hunks#composer',
            \   'filepath': 'LightlineFilePath'
            \ },
            \ 'mode_map': {
            \ 'n' : 'N',
            \ 'i' : 'I',
            \ 'R' : 'R',
            \ 'v' : 'V',
            \ 'V' : 'VL',
            \ "\<C-v>": 'VB',
            \ 'c' : 'C',
            \ 's' : 'S',
            \ 'S' : 'SL',
            \ "\<C-s>": 'SB',
            \ 't': 'T',
            \ },
            \ }

let g:lightline#hunks#only_branch = 1

