call plug#begin('~/.nvim/plugged')

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --omnisharp-completer
  endif
endfunction

"General stuff
Plug 'scrooloose/nerdtree' " Files explorer
" Plug 'ctrlpvim/ctrlp.vim'
"Plug 'bling/vim-airline'
Plug 'easymotion/vim-easymotion' " jump movements
Plug 'Raimondi/delimitMate' " Automatisch quotes enzo sluiten
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'lifepillar/vim-mucomplete'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/syntastic'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-repeat'
Plug 'chriskempson/base16-vim'
" Plug 'dracula/vim'
" Plug 'Konfekt/FastFold'
" Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'neomake/neomake'
" Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Javascript
Plug 'pangloss/vim-javascript'

"HTML
Plug 'mattn/emmet-vim'

"Haskell
"Vimproc is needed for ghcmod-vim
" Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Plug 'eagletmt/ghcmod-vim'
" Plug 'eagletmt/neco-ghc'
" Plug 'neovimhaskell/haskell-vim'
" Plug 'parsonsmatt/intero-neovim'

"Purescript
Plug 'raichoo/purescript-vim'
Plug 'https://github.com/FrigoEU/psc-ide-vim.git'

"Typescript
Plug 'leafgarland/typescript-vim'
" Plug 'clausreinke/typescript-tools.vim', { 'do': 'npm install' }
" Plug 'mhartington/nvim-typescript'
" Plug 'Shougo/vimproc.vim', {'do' : 'make'} " for tsuquyomi
" Plug 'Quramy/tsuquyomi'
Plug 'runoshun/tscompletejob' " for type info, completions, goToDef...

"Idris
Plug 'idris-hackers/idris-vim'

"Semicolon insertion
Plug 'lfilho/cosco.vim'

call plug#end()

let g:python_host_prog = "/Library/Frameworks/Python.framework/Versions/2.7/bin/python2"
let g:python3_host_prog = "/Library/Frameworks/Python.framework/Versions/3.5/bin/python3"

"hide status line
set laststatus=0

set termguicolors

set incsearch

let mapleader="\<Space>"

"Surround - like Spacemacs
xmap s <Plug>VSurround
xnoremap S s

nnoremap <silent> <leader>pt :NERDTreeFind<CR>
nnoremap <silent> <leader>wV :vsplit<CR>
nnoremap <silent> <leader>wS :split<CR>
nnoremap <silent> <leader>bp :bp<CR>
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <silent> <leader>en :lnext<CR>
nnoremap <silent> <leader>ep :lprevious<CR>

color base16-default-dark
" color base16-dracula
" colorscheme base16-solarflare
" set background=dark

syntax on
filetype plugin indent on
filetype plugin on

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

inoremap <expr> <C-j>      pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k>      pumvisible() ? "\<C-p>" : "\<Up>"

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

"Emmet trigger with ctrl-e
let g:user_emmet_install_global = 0
autocmd FileType html EmmetInstall
autocmd FileType html imap <buffer> <C-e> <Plug>(emmet-expand-abbr)

"Easymotion keybind
nmap ; <Plug>(easymotion-s)
vmap ; <Plug>(easymotion-s)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" Just to get rid of easymotion keybinds, I only use the above keys to
" interact with easymotion
map ù <Plug>(easymotion-prefix)

"Pipe cursor in insert mode
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

"JavaScript / Angular
let g:syntastic_html_tidy_ignore_errors=['proprietary attribute "ng-']

"Purescript
let g:psc_ide_log_level = 0
let g:psc_ide_syntastic_mode = 1
let g:psc_ide_auto_imports = 1
let g:psc_ide_import_on_completion = 0

au FileType purescript map <leader>t :PSCIDEtype<CR>
au FileType purescript nmap <leader>s :PSCIDEapplySuggestion<CR>
" au FileType purescript nmap <leader>p :PSCIDEpursuit<CR>
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
" let g:psc_ide_server_port = 3030

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
au FileType typescript nmap <leader>t :TsCompleteJobQuickInfo<CR>

" autocomplete
set completeopt=longest,menuone
set pumheight=8
let g:ycm_auto_start_csharp_server = 1
let g:ycm_python_binary_path="~/tensorflow/bin/python3.5"
let g:ycm_semantic_triggers = {
      \ 'purescript': ['re!\w+']
      \ }
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#omni#input_patterns = {}
" let g:deoplete#omni#input_patterns.typescript =
"       \ ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::']

" let g:deoplete#omni_patterns = {}
" let g:deoplete#omni_patterns.purescript = 
"       \ ['\w*']

"Neomake
"Autorun Neomake on save
autocmd! BufWritePost * Neomake
let g:neomake_verbose=0
let g:neomake_purescript_enabled_makers = [] 
" We use syntastic for purescript so we can capture suggestions, maybe we can do this with neomake also... cause it's super fast!
" https://github.com/neomake/neomake/commit/972cc885d39c6c36084220cf628692ac2053284e

"UltiSnips Snippets
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsJumpForwardTrigger = "<C-e>"
let g:UltiSnipsJumpBackwardTrigger = "<C-b>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.nvim/snippets']
let g:UltiSnipsSnippetsDir=$HOME.'/.nvim/snippets'

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = [] " neomake

highlight SyntasticWarningSign guifg=black guibg=yellow
highlight SyntasticStyleWarningSign guifg=black guibg=yellow

" nnoremap <leader>n :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>lfirst<bar>endtry<cr>
" nnoremap <leader>p :try<bar>lprevious<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>llast<bar>endtry<cr>

" FZF
let $FZF_DEFAULT_COMMAND='ag -g ""' "ag takes gitignore into account
let g:fzf_buffers_jump = 1 " jump to existing buffer if possible
command! -bang Commits
  \ call fzf#vim#commits({'right': '50%'})
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, 
  \                 ' --color-path "33;10" ', 
  \                 fzf#vim#with_preview('right:50%'),
  \                 <bang>0 )
nnoremap <leader>pf :Files<CR>
" nnoremap <leader>gs :Commits<CR>
" nnoremap <leader>gt :BCommits<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bf :BLines<CR>
nnoremap <leader><leader> :Commands<CR>
nnoremap <leader>/ :Ag<Space>
nnoremap <leader>* :call SearchUnderCursor()<CR>
fun! SearchUnderCursor()
  let w = expand("<cword>")
  exe ("Ag " . w)
endfun

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gt :Gblame<CR>
