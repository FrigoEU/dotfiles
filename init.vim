call plug#begin('~/.nvim/plugged')

function! UpdateRPlugin(info)
  if has('nvim')
    silent UpdateRemotePlugins
    echomsg 'rplugin updated: ' . a:info['name'] . ', restart vim for changes'
  endif
endfunction

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'bling/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'mattn/emmet-vim'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'frigoeu/psc-ide-vim'
Plug 'raichoo/purescript-vim'
Plug 'Shougo/deoplete.nvim', { 'do': function('UpdateRPlugin') }
Plug 'leafgarland/typescript-vim'
Plug 'clausreinke/typescript-tools.vim'
Plug 'frigoeu/neomake', {'branch': 'master'}

"Semicolon insertion
Plug 'lfilho/cosco.vim'

"hide status line
set laststatus=0

colorscheme base16-default
set background=dark

"open NERDTree
noremap <silent> <F2> :NERDTreeFind<CR>

call plug#end()

syntax on
filetype plugin indent on
filetype plugin on

let mapleader=" "
nnoremap <Space> <nop>

"search all lowercase --> case insensitive, 
"search with uppercases --> case sensitive
set ignorecase
set smartcase
set infercase

"highlight search result
set hlsearch

"stay 10 lines away from top and bottom when scrolling
set scrolloff=10

"indents
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set bs=2
set tabstop=2
set shiftwidth=2
set expandtab

"navigate between splits
nmap <C-H> <C-W><C-H>
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nnoremap <silent> <leader>c :bp<CR> 
nnoremap <silent> <leader>n :bnext<CR>
nnoremap <silent> <leader>p :bprevious<CR>

"new split directions
:set splitbelow
:set splitright

"auto indent between brackets
inoremap {<CR> {<CR>}<C-o>O

"Wait for enter before starting search in buffer
set noincsearch

"semicolon insertion
autocmd FileType c,cpp,css,java,javascript,perl,php,jade,typescript nmap <silent> <leader>; :call cosco#commaOrSemiColon()<CR>
autocmd FileType c,cpp,css,java,javascript,perl,php,jade,typescript inoremap <silent> <leader>; <ESC>:call cosco#commaOrSemiColon()"<CR>a

"CtrlP mappings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"Open ctrlp in filename mode (as opposed to full path) by default)
let g:ctrlp_by_filename = 0
let g:ctrlp_regexp = 1
"Open file in vertical split with ctrl+c
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("v")': ['<c-c>'],
    \ }

"CtrlP grep ignores
set wildignore+=*/node_modules/*
set wildignore+=*/bower_components/*
set wildignore+=*/dist*
set wildignore+=*/devdoctor/*
set wildignore+=*/devnurse/*
set wildignore+=*/devura/*
set wildignore+=*/distdoctor/*
set wildignore+=*/distnurse/*
set wildignore+=*/output/*
"set wildignore+=*/devnurse/*
"set wildignore+=*/distnurse/*
"set wildignore+=*/out/*
"set wildignore+=*/node_modules/*
"set wildignore+=*/bower_components/*
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"Emmet trigger with ctrl-e
let g:user_emmet_expandabbr_key = '<c-e>'

"Easymotion keybind
nmap ; <Plug>(easymotion-s)
vmap ; <Plug>(easymotion-s)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

"Pipe cursor in insert mode
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

au FileType purescript nmap tt :PSCIDEtype<CR>

"typescript
au FileType typescript nmap tt :TSStype<CR>
au BufEnter *.ts silent! :TSSupdate<CR>
"au VimEnter * :TSSstart<CR>
"au VimLeave * :TSSend<CR>

"Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#_omni_patterns = {}
"TODO
let g:deoplete#_omni_patterns.purescript = '[^.]'
let g:deoplete#_omni_patterns.typescript =
		\ ['[^. *\t]\.\w*', '\h\w*::']
set completeopt=longest,menuone
"Amount of entries in completion popup
set pumheight=5

"Neomake
"Autorun Neomake on save
autocmd! BufWritePost * Neomake
let g:neomake_verbose=0

nnoremap <leader>n :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>lfirst<bar>endtry<cr>
nnoremap <leader>p :try<bar>lprevious<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>llast<bar>endtry<cr>
