source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

set encoding=utf-8
set splitbelow
set number "line numbering
set guifont=Fira_Code\ Regular:h11

set lcs+=space:�
let g:indentLine_setColors = 0

set nobackup
set noswapfile
set noundofile
map <C-n> :NERDTreeToggle<CR>
" DISPLAY IDENTATION
map <C-i> :set invlist<CR>
:imap jj <Esc>
imap <C-BS> <C-W>
" Plugins will be downloaded under the specified directory.
call plug#begin('c:\Users\dante\Vim\plugged')

" Declare the list of plugins.
Plug 'sjl/badwolf'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'ycm-core/YouCompleteMe'
Plug 'preservim/nerdcommenter'
syntax on
" colorscheme elflord
colorscheme badwolf

" Make the tab line darker than the background.
let g:badwolf_tabline = 0
let g:badwolf_tabline = 3


" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" Change comment color to MINT :)
hi Comment guifg=#98fb98

autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>

autocmd Filetype python map <buffer> <F5> :w<CR>:ter python "%"<CR>
autocmd Filetype python imap <buffer> <F5> <esc>:w<CR>:ter python "%"<CR>
autocmd Filetype python map <buffer> <F6> :w<CR>:vert ter python "%"<CR>
autocmd Filetype python imap <buffer> <F6> <esc>:w<CR>:vert ter python "%"<CR>


" changing fonts 
if has("unix")
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction
else
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction
endif


if has("gui_running")
    nmap <S-F12> :call FontSizeMinus()<CR>
    nmap <F12> :call FontSizePlus()<CR>
endif

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
