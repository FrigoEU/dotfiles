call plug#begin('~/.nvim/plugged')

function! UpdateRPlugin(info)
  if has('nvim')
    silent UpdateRemotePlugins
    echomsg 'rplugin updated: ' . a:info['name'] . ', restart vim for changes'
  endif
endfunction

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
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

"CtrlP mappings
" let g:ctrlp_map = '<Space>pf'
" let g:ctrlp_cmd = 'CtrlP'
"Open ctrlp in filename mode (as opposed to full path) by default)
" let g:ctrlp_by_filename = 0
" let g:ctrlp_regexp = 1
"Open file in vertical split with ctrl+c
" let g:ctrlp_prompt_mappings = {
"     \ 'AcceptSelection("v")': ['<c-c>'],
    " \ }

"CtrlP grep ignores
" set wildignore+=*/node_modules/*
" set wildignore+=*/bower_components/*
" set wildignore+=*/dist*
" set wildignore+=*/devdoctor/*
" set wildignore+=*/devnurse/*
" set wildignore+=*/devura/*
" set wildignore+=*/distdoctor/*
" set wildignore+=*/distnurse/*
" set wildignore+=*/output/*
"set wildignore+=*/devnurse/*
"set wildignore+=*/distnurse/*
"set wildignore+=*/out/*
"set wildignore+=*/node_modules/*
"set wildignore+=*/bower_components/*
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

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
let g:psc_ide_log_level = 0
let g:psc_ide_syntastic_mode = 1

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

"Deoplete
" let g:deoplete#complete_method = "omnifunc"
" let g:deoplete#enable_smart_case= 1
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#omni#input_patterns = {}
" let g:deoplete#omni#input_patterns.purescript = '[^. *\t]'
" let g:deoplete#omni#input_patterns.haskell = '[^. *\t]'
" let g:deoplete#omni#input_patterns.purescript = '[.\w]+'
" let g:deoplete#omni#input_patterns.haskell = '[.\w]+'
set completeopt=longest,menuone
" set completeopt=longest,menuone,preview
"Amount of entries in completion popup
set pumheight=8
" let g:deoplete#max_menu_width = 60

" let g:deoplete#enable_ignore_case = 1
" let g:deoplete#enable_refresh_always = 1
" let g:deoplete#enable_debug = 1
" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', '/tmp/deoplete.log')


let g:ycm_semantic_triggers = {
      \ 'purescript': ['re!\w+']
      \ }

"Neomake
"Autorun Neomake on save
autocmd! BufWritePost * Neomake
let g:neomake_verbose=0
let g:neomake_purescript_enabled_makers = [] " We use syntastic for it so we can capture suggestions, maybe we can do this with neomake also... cause it's super fast!
                                             " https://github.com/neomake/neomake/commit/972cc885d39c6c36084220cf628692ac2053284e

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
let g:fzf_buffers_jump = 1 " jump to existing buffer if possible
command! -bang -nargs=? GFiles                    
  \ call fzf#vim#gitfiles(<q-args>, {"options": "--tiebreak=end,length"}, <bang>0)
command! -bang Commits
  \ call fzf#vim#commits({'right': '50%'})
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, 
  \                 ' --color-path "33;10" ', 
  \                 fzf#vim#with_preview('right:50%'),
  \                 <bang>0 )
nnoremap <leader>pf :GFiles<CR>
" nnoremap <leader>gs :Commits<CR>
" nnoremap <leader>gt :BCommits<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bf :BLines<CR>
nnoremap <leader>/ :Ag<Space>
nnoremap <leader>* :call SearchUnderCursor()<CR>
fun! SearchUnderCursor()
  let w = expand("<cword>")
  exe ("Ag " . w)
endfun
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }
"

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gt :Gblame<CR>


" Setting ack shortcuts to open in splits same as CtrlP
" let g:ack_mappings = { "<C-x>": "<C-W><CR><C-W>J<C-W>p<C-W>c<C-W>j",
"                      \ "<C-c>": "<C-W><CR><C-W>L<C-W>p<C-W>c<C-W>b"}
