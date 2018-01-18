set nocompatible
set relativenumber
set cursorline
set cursorcolumn
set showmatch
set list
set listchars=tab:\|\ ,trail:•,extends:»,precedes:«

filetype plugin indent on
syntax on
set cindent

set mouse=v
set tabstop=4
set shiftwidth=4

call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jiangmiao/auto-pairs'
Plug 'dracula/vim'
Plug 'Shougo/unite.vim'
Plug 'artur-shaik/vim-javacomplete2'
call plug#end()

set t_Co=256
set background=dark
color dracula
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dracula'

nmap <F2> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_path_to_python_interpreter='/usr/bin/python'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_show_diagnostics_ui = 1

let g:indentLine_enabled = 1
let g:indentLine_char='┆'

let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
            \ '-i --line-numbers --nocolor ' .
            \ '--nogroup --hidden --ignore ' .
            \ '''.hg'' --ignore ''.svn'' --ignore' .
            \ ' ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''

autocmd FileType java setlocal omnifunc=javacomplete#Complete
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
nmap <F5> <Plug>(JavaComplete-Imports-Add)
nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
