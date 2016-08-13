call plug#begin('~/.nvim/plugged')

function! UpdateRPlugin(info)
  if has('nvim')
    silent UpdateRemotePlugins
    echomsg 'rplugin updated: ' . a:info['name'] . ', restart vim for changes'
  endif
endfunction

"General stuff
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'bling/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', { 'do': function('UpdateRPlugin') }
Plug 'tpope/vim-commentary'
Plug 'scrooloose/syntastic'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-repeat'
"Plug 'https://github.com/FrigoEU/neomake.git'
Plug 'chriskempson/base16-vim'
Plug 'Konfekt/FastFold'
Plug 'mileszs/ack.vim'

"Javascript
Plug 'pangloss/vim-javascript'

"HTML
Plug 'mattn/emmet-vim'

"Haskell
"Vimproc is needed for ghcmod-vim
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'neovimhaskell/haskell-vim'
" Plug 'parsonsmatt/intero-neovim'

"Purescript
Plug 'https://github.com/FrigoEU/psc-ide-vim.git'
Plug 'raichoo/purescript-vim'

"Typescript
Plug 'leafgarland/typescript-vim'
Plug 'clausreinke/typescript-tools.vim'
"Plug 'Quramy/tsuquyomi'

"Idris
Plug 'idris-hackers/idris-vim'


"Semicolon insertion
Plug 'lfilho/cosco.vim'

"hide status line
set laststatus=0

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

colorscheme base16-default
set background=dark

" colorscheme base16-summerfruit
" set background=light

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

"Force operators to be shown like keywords... TBD
highlight! link Operator Keyword

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

command! RELOAD exe "so $MYVIMRC"

"new split directions
:set splitbelow
:set splitright

"move lines
"nnoremap mj :m .+1<CR>
nnoremap mj :m .+1<CR>:call repeat#set("mj", v:count)<CR>
nnoremap mk :m .-2<CR>:call repeat#set("mk", v:count)<CR>
vnoremap mj :m '>+1<CR>gv
vnoremap mk :m '<-2<CR>gv
" vnoremap mj :m '>+1<CR>:call repeat#set("mj", -1)<CR>gv
" vnoremap mk :m '<-2<CR>:call repeat#set("mk", -1)<CR>gv

"auto indent between brackets
inoremap {<CR> {<CR>}<C-o>O

"Wait for enter before starting search in buffer
set noincsearch

"semicolon insertion
autocmd FileType c,cpp,css,java,javascript,perl,php,jade,typescript nmap <silent> ,; :call cosco#commaOrSemiColon()<CR>

" Easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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

"JavaScript / Angular
let g:syntastic_html_tidy_ignore_errors=['proprietary attribute "ng-']

"Purescript
" let g:psc_ide_log_level = 3
au FileType purescript map <leader>t :PSCIDEtype<CR>
au FileType purescript nmap <leader>s :PSCIDEapplySuggestion<CR>
au FileType purescript nmap <leader>p :PSCIDEpursuit<CR>
au FileType purescript nmap <leader>c :PSCIDEcaseSplit<CR>
au FileType purescript nmap <leader>a :PSCIDEaddTypeAnnotation<CR>
au FileType purescript nmap <leader>i :PSCIDEimportIdentifier<CR>
au FileType purescript nmap <leader>r :PSCIDEload<CR>
au FileType purescript nmap <leader>qd :PSCIDEremoveImportQualifications<CR>
au FileType purescript nmap <leader>qa :PSCIDEaddImportQualifications<CR>
nmap <leader>g <C-]>
au FileType purescript nmap <leader>g :PSCIDEgoToDefinition<CR>

" au FileType purescript set foldmethod=expr
au FileType purescript nmap <leader>fm :set foldmethod=manual<CR>zE<CR>
au FileType purescript nmap <leader>fe :set foldmethod=expr<CR>
au FileType purescript setlocal foldexpr=PureScriptFoldLevel(v:lnum)

"au FileType purescript set conceallevel=1
"au FileType purescript set concealcursor=nvc
"au FileType purescript syn keyword purescriptForall forall conceal cchar=∀ 
"let g:psc_ide_syntastic_mode = 1

function! PureScriptFoldLevel(l)
  return getline(a:l) =~ "^\d*import"
endfunction

"Haskell
au FileType haskell nmap <leader>t :GhcModType<CR>
au FileType haskell nmap <silent> <leader>r :GhcModTypeClear<CR>
au FileType haskell nmap <leader>c :GhcModSplitFunCase<CR>
au FileType haskell nmap <leader>i :GhcModInfo<CR>
au BufWritePost *.hs GhcModCheckAndLintAsync

" au FileType haskell nnoremap <Leader>t :InteroType<CR>
" au FileType haskell nnoremap <Leader>i :InteroInfo<CR>
" au FileType haskell nnoremap <Leader>g :InteroGoToDef<CR>
" autocmd! BufWritePost *.hs InteroReload


"typescript
au FileType typescript nmap <leader>t :TSStype<CR>
au BufEnter *.ts silent! :TSSupdate<CR>
"au VimEnter * :TSSstart<CR>
"au VimLeave * :TSSend<CR>
let g:syntastic_typescript_tsc_fname = ''

"Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.purescript = '[^. *\t]'
let g:deoplete#omni#input_patterns.haskell = '[^. *\t]'
set completeopt=longest,menuone
"Amount of entries in completion popup
set pumheight=5
let g:deoplete#max_menu_width = 60


"Neomake
"Autorun Neomake on save
"autocmd! BufWritePost * Neomake
let g:neomake_verbose=0

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tsc', 'tslint']

highlight SyntasticWarningSign guifg=black guibg=yellow
highlight SyntasticStyleWarningSign guifg=black guibg=yellow

nnoremap <leader>n :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>lfirst<bar>endtry<cr>
nnoremap <leader>p :try<bar>lprevious<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>llast<bar>endtry<cr>

" Ack
nnoremap <leader>a :Ack! <CR>
" Setting ack shortcuts to open in splits same as CtrlP
let g:ack_mappings = { "<C-x>": "<C-W><CR><C-W>J<C-W>p<C-W>c<C-W>j",
                     \ "<C-c>": "<C-W><CR><C-W>L<C-W>p<C-W>c<C-W>b"}
