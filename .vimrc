" Boris Petrov's vimrc file

if has('win32')
	let $VIMRUNTIME='C:\Program Files (x86)\Vim\vim73'
endif

set nocompatible

filetype off " required by Vundle

set runtimepath+=~/.vim/bundle/vundle/,~/.vim,$VIMRUNTIME
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'bkad/CamelCaseMotion'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/nerdtree'
Bundle 'tomtom/tcomment_vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-surround'
Bundle 'sickill/vim-pasta'
Bundle 'kien/ctrlp.vim'
Bundle 'AndrewRadev/coffee_tools.vim'
Bundle 'sjl/gundo.vim'
Bundle 'godlygeek/tabular'
Bundle 'majutsushi/tagbar'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'tpope/vim-rails.git'

" vim-scripts repos
Bundle 'PreciseJump'
Bundle 'smartword'
Bundle 'L9'

" non github repos
" Bundle 'git://git.wincent.com/command-t.git'

" filetype on
filetype indent on
filetype plugin on

syntax on

set hidden

set splitbelow
set splitright

set mousehide " hide my mouse when typing!

set nobackup " don't need these
set nowritebackup
set noswapfile

set noexpandtab " no spaces, please!
set tabstop=4 " be reasonable!
set shiftwidth=4
set softtabstop=4

set timeoutlen=500 " half a second to wait if there are "colliding" mappings

" set list
" set listchars=trail:-

set matchpairs+=<:>
set noshowmatch

set autoindent " indents a line as the previous one
set cindent
set shiftround " indenting to tabs-width

set incsearch
set hlsearch
set ignorecase
set nosmartcase
" set infercase
set wrapscan
set magic " why the hell can't I set verymagic?!

set number " line numbers
set numberwidth=1 " Make line number column as narrow as possible

set guioptions=c

set showtabline=0 " Never show tabline

set showcmd " shows incomplete commands
set showmode " shows current mode
set selectmode= " Select mode? Go away!

set autoread " auto reloads file when changes detected

set cursorline " highligths the current line
set nocursorcolumn " don't do that horrible thing

set scrolloff=7
set scrolljump=7
" set sidescrolloff=15

set wildmenu
set wildchar=<Tab>
set wildmode=longest,list
set wildignore=*.o,*.hi,*.dll,*.obj,*.lib,*.swp,*.zip,*.exe,*.so,*.zip

set wrap " line wrapping
set linebreak " does not wrap in the middle of the word

set errorbells " I like the bell
set novisualbell " but not the visuals!

" set virtualedit=onemore

set noautochdir " do not change the current dir to the one the file being edited is in

set lazyredraw " faster macros
set ttyfast " nicer redraw

set nojoinspaces " do not put 2 spaces after dot when joining lines

set notildeop

set more " I like the more prompt
" set shortmess=a " all abbreviations, but I like the other things

set nostartofline " keeps my cursor where it is

set gdefault " replacing is global by default
set noedcompatible

" set iskeyword+=_,$,@,%,# " none of these are word dividers

" sets these numbers in the bottom right
set ruler
set rulerformat=%l/%L,%v%=%P

set laststatus=2 " Always show statusline
set statusline=%<%f%m%r\ %k%1*%y%2*\ %{fugitive#statusline()}%*%=%-([%l/%L],%v\ (%P)%)

set history=200
set viminfo='20,\"50 " read/write a .viminfo file, don't store more than 50 lines of registers

set backspace=2 " backspacing over everything!

set shellslash " unix-like slashes

" nice simple title
set title
set titlestring=%m%rgVim:\ %F

set completeopt=menu,preview

set diffopt+=iwhite " ignore whitespace in diff mode

set undolevels=1000 " Because I make a lot of mistakes... for a long time

set report=0 " Always report the number of lines changed

set display=lastline " Show as much of the last line as possible and not these crazy @'s

set formatoptions-=o " Stop continuing the comments on pressing o and O

colorscheme rdark " cannot live without it

set fileencodings=utf-8,utf-16,utf-32,cp-1251,unicode
set fileformat=unix

" if has('win32')
"	  set shell=C:/Users/Boris/cygwin/Cygwin.bat
"	  set shellcmdflag=--login\ -c
"	  set shellxquote=\"
" endif

if has('win32')
	let g:haddock_browser = "C:/Program Files (x86)/Mozilla Firefox/firefox.exe"
elseif has('unix')
	let g:haddock_browser = "firefox"
endif

" --------------------------------------------------------------------------------------------------
" Highlight extra whitespace
" --------------------------------------------------------------------------------------------------

highlight ExtraWhitespace guibg=red
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /^\s* \s*\|\s\+$/

" --------------------------------------------------------------------------------------------------
" Leader Variables
" --------------------------------------------------------------------------------------------------

let mapleader = ","
let g:mapleader = ","

" --------------------------------------------------------------------------------------------------
" Fonts
" --------------------------------------------------------------------------------------------------

" best fonts in the world
if has('win32')
	set guifont=Inconsolata:h15:cDEFAULT
	" set guifont=Consolas:h14:cDEFAULT
	" set guifont=DejaVu_LGC_Sans_Mono:h13:cDEFAULT

	command! Inconsolata set guifont=Inconsolata:h15:cDEFAULT
	command! Consolas set guifont=Consolas:h14:cDEFAULT
	command! DejaVu set guifont=DejaVu_LGC_Sans_Mono:h13:cDEFAULT
elseif has('unix')
	set guifont=DejaVu\ LGC\ Sans\ Mono\ Book\ 13
endif

" --------------------------------------------------------------------------------------------------
" Autocommands
" --------------------------------------------------------------------------------------------------

autocmd FileType helpfile setlocal nonumber " no line numbers when viewing help
" These do not work?!
autocmd FileType helpfile nmap <buffer> <RETURN> <C-]>
autocmd FileType helpfile nmap <buffer> <BACKSPACE> <C-t>

autocmd FileType coffee,ruby                 setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd BufNewFile,BufReadPost coffee,python setlocal foldmethod=indent nofoldenable

runtime macros/matchit.vim " smarter matching with % (ifs, elses...)

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
			\ if line("'\"") > 0 && line ("'\"") <= line("$") |
			\	exe "normal! g'\"" |
			\ endif

" When .vimrc is edited, reload it
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

autocmd FileType haskell compiler ghc

" Saves txt and hs files after leaving insert mode if there were any changes
" autocmd InsertLeave *.{txt,hs} :up

" autocmd BufLeave *.hs execute "mksession!"
" autocmd BufEnter *.hs execute "so Session.vim"

" --------------------------------------------------------------------------------------------------
" Tabularize
" --------------------------------------------------------------------------------------------------

nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" --------------------------------------------------------------------------------------------------
" Tagbar
" --------------------------------------------------------------------------------------------------

nnoremap <silent> gd :TagbarToggle<CR>
autocmd FileType tagbar nmap <buffer> l <CR>
let g:tagbar_autofocus             = 1
let g:tagbar_updateonsave_maxlines = 0
let g:tagbar_autoclose             = 1

if executable('coffeetags')
	let g:tagbar_type_coffee = {
				\ 'ctagsbin' : 'coffeetags',
				\ 'ctagsargs' : '',
				\ 'kinds' : [
				\ 'f:functions',
				\ 'o:object',
				\ ],
				\ 'sro' : ".",
				\ 'kind2scope' : {
				\ 'f' : 'object',
				\ 'o' : 'object',
				\ }
				\ }
endif

" --------------------------------------------------------------------------------------------------
" Gundo
" --------------------------------------------------------------------------------------------------

nnoremap <F4> :GundoToggle<CR>

" --------------------------------------------------------------------------------------------------
" CoffeeScript related stuff
" --------------------------------------------------------------------------------------------------

let coffee_compiler     = 'iced'
let coffee_compile_vert = 1

autocmd FileType coffee nmap <buffer> dd <Plug>CoffeeToolsDeleteAndDedent
autocmd FileType coffee xmap <buffer> d  <Plug>CoffeeToolsDeleteAndDedent

let g:coffee_tools_function_text_object = 1

let g:pasta_enabled_filetypes = ['coffee']

" --------------------------------------------------------------------------------------------------
" Session Options and Mappings
" --------------------------------------------------------------------------------------------------

set sessionoptions=buffers,curdir,globals,localoptions,tabpages
map <F9> :source Session.vim<RETURN>
map <F6> :mksession!<RETURN>

" --------------------------------------------------------------------------------------------------
" Visual Search
" --------------------------------------------------------------------------------------------------

" From an idea by Michael Naumann
function! VisualSearch(direction) range
	let l:saved_reg = @"
	execute "normal! vgvy"
	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")
	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	else
		execute "normal /" . l:pattern . "^M"
	endif
	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

" Basically you press * or # to search for the current selection !! Really useful
xmap <silent> * :call VisualSearch('f')<RETURN>n
xmap <silent> # :call VisualSearch('b')<RETURN>n

" --------------------------------------------------------------------------------------------------
" Pasting Options
" --------------------------------------------------------------------------------------------------

nmap p <Plug>AfterPasta
nmap P <Plug>BeforePasta

let s:cpo_save=&cpo
set cpo&vim
"------------------------------------------------------------------------
" I haven't found how to hide this function (yet)
function! RestoreRegister()
	if &clipboard == 'unnamed'
		let @* = s:restore_reg
	elseif &clipboard == 'unnamedplus'
		let @+ = s:restore_reg
	else
		let @" = s:restore_reg
	endif
	return ''
endfunction

function! s:Repl()
	let s:restore_reg = @"
	return "\<Plug>VisualPasta@=RestoreRegister()\<cr>"
endfunction

xmap <silent> <expr> p <sid>Repl()

" --------------------------------------------------------------------------------------------------
" CamelCase Plugin Mappings
" --------------------------------------------------------------------------------------------------

map <silent> W <Plug>CamelCaseMotion_w
map <silent> B <Plug>CamelCaseMotion_b
map <silent> E <Plug>CamelCaseMotion_e

" --------------------------------------------------------------------------------------------------
" SmartWord Plugin Mappings
" --------------------------------------------------------------------------------------------------

map w <Plug>(smartword-w)
map b <Plug>(smartword-b)
map e <Plug>(smartword-e)
map ge <Plug>(smartword-ge)
ounmap w
ounmap b
ounmap e

" --------------------------------------------------------------------------------------------------
" PreciseJump Plugin Mappings
" --------------------------------------------------------------------------------------------------

let g:PreciseJump_target_keys = '123456789abcdefghijklmnopqrstuwxzABCDEFGHIJKLMNOPQRSTUWXZ'
map f _f
map F _F

" --------------------------------------------------------------------------------------------------
" Indenting
" --------------------------------------------------------------------------------------------------

nnoremap <TAB> >>
xnoremap <TAB> >
nnoremap <S-TAB> <<
xnoremap <S-TAB> <

" --------------------------------------------------------------------------------------------------
" Windows-like mappings
" --------------------------------------------------------------------------------------------------

inoremap <C-v> <C-r>"
xnoremap <C-v> x<ESC>:set paste<RETURN>mui<C-R>+<ESC>mv'uV'v=:set nopaste<RETURN>
nnoremap <C-v> :set paste<RETURN>mui<C-R>+<ESC>mv'uV'v=:set nopaste<RETURN>
xnoremap <C-c> "+y
xnoremap <C-x> "+x
inoremap <C-a> <ESC>ggVG
xnoremap <C-a> <ESC>ggVG
nnoremap <C-a> ggVG
inoremap <C-z> <C-o>u

" --------------------------------------------------------------------------------------------------
" Surround Plugin Mappings
" --------------------------------------------------------------------------------------------------

nmap d( ds(
nmap d) d(
nmap d[ ds[
nmap d] d[
nmap d{ ds{
nmap d} d{
nmap d< ds<
nmap d> d<
nmap d" ds"
nmap d' ds'

xmap ) S)
xmap ( )
xmap ] S]
xmap [ ]
xmap } S}
xmap { }
xmap > S>
xmap < >
xmap " S"
xmap ' S'

" --------------------------------------------------------------------------------------------------
" Keymap
" --------------------------------------------------------------------------------------------------

nmap <silent> gk :call ToggleKeymap()<RETURN>

function! ToggleKeymap()
	if &keymap == ""
		set keymap=bulgarian-phonetic
		if has('win32')
			Consolas
		endif
	else
		set keymap=
		if has('win32')
			Inconsolata
		endif
	endif
endfunction

" --------------------------------------------------------------------------------------------------
" Wrapping
" --------------------------------------------------------------------------------------------------

nmap <silent> gw :call ToggleHorizontalScrollbar()<RETURN>:<C-U>setlocal wrap! wrap?<RETURN>

function! ToggleHorizontalScrollbar()
	if &guioptions =~# "b"
		set guioptions-=b
	else
		set guioptions+=b
	endif
endfunction

" --------------------------------------------------------------------------------------------------
" NERDTree (un)Mappings
" --------------------------------------------------------------------------------------------------

nnoremap gn :NERDTreeToggle<RETURN>
let g:NERDTreeMapPreviewVSplit=""
let g:NERDTreeMapJumpFirstChild=""
let g:NERDTreeMapJumpLastChild=""
autocmd FileType nerdtree nmap <buffer> l o
autocmd FileType nerdtree nmap <buffer> h x
autocmd FileType nerdtree nmap <buffer> c ma
autocmd FileType nerdtree nmap <buffer> d md

" --------------------------------------------------------------------------------------------------
" Ctrl-P Mappings
" --------------------------------------------------------------------------------------------------

let g:ctrlp_map = 'gz'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = '\.git$\|node_modules$\|\.hg$\|\.svn$'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

"--------------------------------------------------------
" Abreviations
" -------------------------------------------------------

cab W w
cab Wq wq
cab wQ wq
cab WQ wq
cab Q q
cab q1 q!

" --------------------------------------------------------------------------------------------------
" Misc Mappings
" --------------------------------------------------------------------------------------------------

" Always move through visual lines:
nnoremap j gj
nnoremap k gk

" Faster moving:
map J 4j
map K 4k

nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

" Map <F5> to remove all trailing whitespace
nnoremap <silent> <F5> :let _s=@/<RETURN>:%s/\s\+$//e<RETURN>:let @/=_s<RETURN>:nohl<RETURN>:set ff=unix<RETURN>:w<RETURN>

" free mappings - U, P, S, H, L, M, X, $, ^, &, -, _, +, |, \, ','

inoremap hj <ESC>
inoremap jh <ESC>
inoremap jk <ESC>
inoremap kj <ESC>
inoremap kl <ESC>
inoremap lk <ESC>

inoremap <C-backspace> <C-w>
inoremap <C-delete> <C-o>de

nnoremap gj J

nnoremap gm zz
noremap z ^
noremap Z $

" inoremap ( ()<C-o>h
" inoremap [ []<C-o>h
" inoremap { {}<C-o>h

" Remove the Windows' ^M
nnoremap <Leader>m :%s/<C-V><C-M>//ge<RETURN>
nnoremap <Leader>v :e! $MYVIMRC<RETURN>

nnoremap gV <C-v>

nnoremap gs <C-w>w
inoremap <C-SPACE> <C-n>
nnoremap <ESC> :noh<RETURN>
nnoremap vv V
nnoremap V v$h
nnoremap Y y$

" Open new tab easily
nnoremap <Leader>t :tabnew<RETURN>

nnoremap <RETURN> o<ESC>
nnoremap <S-RETURN> O<ESC>

" Do not overwrite my register!
nnoremap x "_x
nnoremap s "_s

nnoremap Q @q

nnoremap gb <C-o>

" gh - go to header in C/C++?

noremap <S-SPACE> <PAGEUP>
noremap <SPACE> <PAGEDOWN>

" Quit like in bash
nnoremap <C-d> :q<RETURN>

" Returns the cursor where it was before the start of the editing
nnoremap . .`[

