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
Plug 'Shougo/deoplete.nvim', { 'do': function('UpdateRPlugin') }
Plug 'tpope/vim-commentary'


"Haskell
"Vimproc is needed for ghcmod-vim
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'neovimhaskell/haskell-vim'

Plug 'scrooloose/syntastic'
"Plug 'https://github.com/FrigoEU/neomake.git'

Plug 'https://github.com/FrigoEU/psc-ide-vim.git'
Plug 'raichoo/purescript-vim'

Plug 'leafgarland/typescript-vim'
Plug 'clausreinke/typescript-tools.vim'


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

let mapleader=","

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

"new split directions
:set splitbelow
:set splitright

"auto indent between brackets
inoremap {<CR> {<CR>}<C-o>O

"Wait for enter before starting search in buffer
set noincsearch

"semicolon insertion
autocmd FileType c,cpp,css,java,javascript,perl,php,jade,typescript nmap <silent> ,; :call cosco#commaOrSemiColon()<CR>

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

"Purescript
au FileType purescript nmap <leader>t :PSCIDEtype<CR>
au FileType purescript nmap <leader>s :PSCIDEapplySuggestion<CR>
au FileType purescript nmap <leader>p :PSCIDEpursuit<CR>
nmap <leader>g <C-]>

"Haskell
au FileType haskell nmap <leader>t :GhcModType<CR>
au FileType haskell nmap <silent> <leader>r :GhcModTypeClear<CR>
au FileType haskell nmap <leader>c :GhcModSplitFunCase<CR>
au BufWritePost *.hs GhcModCheckAndLintAsync


"typescript
au FileType typescript nmap <leader>t :TSStype<CR>
au BufEnter *.ts silent! :TSSupdate<CR>
"au VimEnter * :TSSstart<CR>
"au VimLeave * :TSSend<CR>

"Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#_omni_patterns = {}
"TODO
let g:deoplete#_omni_patterns.purescript = '[^.]'
let g:deoplete#_omni_patterns.haskell = '[^.]'
let g:deoplete#_omni_patterns.typescript =
		\ ['[^. *\t]\.\w*', '\h\w*::']
set completeopt=longest,menuone
"Amount of entries in completion popup
set pumheight=5

"Neomake
"Autorun Neomake on save
"autocmd! BufWritePost * Neomake
let g:neomake_verbose=0

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

nnoremap <Space>n :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>lfirst<bar>endtry<cr>
nnoremap <Space>p :try<bar>lprevious<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>llast<bar>endtry<cr>
