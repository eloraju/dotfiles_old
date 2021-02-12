" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        if expl_win_num != -1
            let cur_win_nr = winnr()
            exec expl_win_num . 'wincmd w'
            close
            exec cur_win_nr . 'wincmd w'
            unlet t:expl_buf_num
        else
            unlet t:expl_buf_num
        endif
    else
        exec '1wincmd w'
        Vexplore
        " Set the explorer width
        vertical resize 50
        let t:expl_buf_num = bufnr("%")
    endif
endfunction
map <silent> <C-t> :call ToggleVExplorer()<CR>

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of browser
let g:netrow_altv = 1

" Default to tree mode
let g:netrw_liststyle = 3

" Hide banner
let g:netrw_banner = 0


