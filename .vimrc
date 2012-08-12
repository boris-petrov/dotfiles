" Boris Petrov's vimrc file

if has('win32')
	let $VIMRUNTIME='C:\Program Files (x86)\Vim\vim73'
	set runtimepath=$VIM/vimfiles,$VIMRUNTIME
elseif has('unix')
	set runtimepath=~/.vim,$VIMRUNTIME
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
Bundle 'tpope/vim-repeat'
Bundle 'sickill/vim-pasta'
Bundle 'kien/ctrlp.vim'
Bundle 'AndrewRadev/coffee_tools.vim'
Bundle 'sjl/gundo.vim'
Bundle 'godlygeek/tabular'
Bundle 'majutsushi/tagbar'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'tpope/vim-unimpaired'
Bundle 'Raimondi/delimitMate'
Bundle 'msanders/snipmate.vim'
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
set wildignore=*.o,*.hi,*.dll,*.obj,*.lib,*.swp,*.zip,*.exe,*.so

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

" Persistent undo
set undofile
set undodir=~/.vim/undodir
set undolevels=1000  " Because I make a lot of mistakes... for a long time
set undoreload=10000 " maximum number lines to save for undo on a buffer reload

set report=0 " Always report the number of lines changed

set display=lastline " Show as much of the last line as possible and not these crazy @'s

set formatoptions-=o " Stop continuing the comments on pressing o and O

set grepprg=grep\ -n\ --color\ --exclude-dir=node_modules\ --exclude-dir=.git\ --exclude-dir=tmp\ --exclude-dir=log\ --exclude-dir=vendor " Use cygwin grep

set spell
setlocal spell spelllang=en

colorscheme rdark " cannot live without it

set fileencodings=utf-8,utf-16,utf-32,cp-1251,unicode
set fileformat=unix

" should do this for when Vim is started from a Cygwin shell
if has('win32')
	set shell=C:\Windows\system32\cmd.exe
	set shellcmdflag=/c
	set shellxquote=
endif

if has('win32')
	let g:haddock_browser = "C:/Program Files (x86)/Mozilla Firefox/firefox.exe"
elseif has('unix')
	let g:haddock_browser = "firefox"
endif

smapclear

" --------------------------------------------------------------------------------------------------
" Highlight extra whitespace
" --------------------------------------------------------------------------------------------------

highlight ExtraWhitespace guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+\%#\@<!$/

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
	set guifont=DejaVu\ LGC\ Sans\ Mono\ Book\ 14
endif

" --------------------------------------------------------------------------------------------------
" Autocommands
" --------------------------------------------------------------------------------------------------

autocmd FileType help setlocal nonumber " no line numbers when viewing help
autocmd FileType help nmap <buffer> <CR> <C-]>
autocmd FileType help nmap <buffer> <BACKSPACE> <C-t>

autocmd FileType coffee,ruby,eruby,html      setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
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

nmap sa= :Tabularize /=<CR>
vmap sa= :Tabularize /=<CR>
nmap sa: :Tabularize /^[^:]*:\s*\zs\s/l0<CR>
vmap sa: :Tabularize /^[^:]*:\s*\zs\s/l0<CR>
nmap sa, :Tabularize /,\s*\zs\s/l0<CR>
vmap sa, :Tabularize /,\s*\zs\s/l0<CR>
nmap sa> :Tabularize /^[^=>]*\zs=>/<CR>
vmap sa> :Tabularize /^[^=>]*\zs=>/<CR>

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
autocmd FileType coffee xmap <buffer> x  <Plug>CoffeeToolsDeleteAndDedent

let g:coffee_tools_function_text_object = 1

let g:pasta_enabled_filetypes = ['coffee']

" --------------------------------------------------------------------------------------------------
" Session Options and Mappings
" --------------------------------------------------------------------------------------------------

set sessionoptions=buffers,curdir,globals,localoptions,tabpages
map <F9> :source Session.vim<CR>
map <F6> :mksession!<CR>

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
xmap <silent> * :call VisualSearch('f')<CR>n
xmap <silent> # :call VisualSearch('b')<CR>n

" --------------------------------------------------------------------------------------------------
" Grep
" --------------------------------------------------------------------------------------------------

" Can be called in several ways:
"
" :Grep <something> " -> Grep for the given search query
" :Grep " -> Grep for the word under the cursor
" :'<,'>Grep " -> Grep in visual mode

autocmd FileType qf nnoremap <buffer> q :q<CR>
autocmd FileType qf nnoremap <buffer> l <CR>
autocmd FileType qf nnoremap <buffer> j j
autocmd FileType qf nnoremap <buffer> k k

function! GetBufferList()
	redir =>buflist
	silent! ls
	redir END
	return buflist
endfunction

function! ToggleList(bufname, pfx)
	let buflist = GetBufferList()
	for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
		if bufwinnr(bufnum) != -1
			exec(a:pfx.'close')
			return
		endif
	endfor
	if a:pfx == 'l' && len(getloclist(0)) == 0
		echohl ErrorMsg
		echo "Location List is Empty."
		return
	endif
	let winnr = winnr()
	exec(a:pfx.'open')
endfunction

" nmap <silent> gr :call ToggleList("Location List", 'l')<CR>
nmap <silent> gr :call ToggleList("Quickfix List", 'c')<CR>

command! -count=0 -nargs=* Grep call s:Grep(<count>, <q-args>)

function! s:Grep(count, args)
	if a:count > 0
		" then we've selected something in visual mode
		let search_text = s:LastSelectedText()
	elseif empty(a:args)
		" If no pattern is provided, search for the word under the cursor
		let search_text = expand("<cword>")
	else
		let search_text = a:args
	end

	if has('unix')
		let search_text = escape(search_text, '"#%')
	else
		" TODO: escape quotes using CMD's stupid style
	end

	if a:count > 0
		let query = '"' . search_text . '"'
	elseif empty(a:args)
		let query = '-w "' . search_text . '"'
	else
		let query = '"' . search_text . '"'
	end

	exe 'grep -r ' . query . ' .'
endfunction

function! s:LastSelectedText()
	let saved_cursor = getpos('.')

	let original_reg = getreg('z')
	let original_reg_type = getregtype('z')

	normal! gv"zy
	let text = @z

	call setreg('z', original_reg, original_reg_type)
	call setpos('.', saved_cursor)

	return text
endfunction

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
	return "\<Plug>VisualPasta@=RestoreRegister()\<CR>"
endfunction

xmap <silent> <expr> p <SID>Repl()

" --------------------------------------------------------------------------------------------------
" delimitMate Mappings
" --------------------------------------------------------------------------------------------------

inoremap <expr> <CR> delimitMate#ShouldJump() ? "\<C-g>g" : "\n"

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
let g:PreciseJump_match_target_hi = "PreciseJumpTarget"

" --------------------------------------------------------------------------------------------------
" Unimpaired Mappings
" --------------------------------------------------------------------------------------------------

nmap sh [q
nmap sl ]q

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
xnoremap <C-v> x<ESC>:set paste<CR>mui<C-R>+<ESC>mv'uV'v=:set nopaste<CR>
nnoremap <C-v> :set paste<CR>mui<C-R>+<ESC>mv'uV'v=:set nopaste<CR>
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

nmap <silent> gk :call ToggleKeymap()<CR>

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

nmap <silent> gw :call ToggleHorizontalScrollbar()<CR>:<C-U>setlocal wrap! wrap?<CR>

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

nnoremap gn :NERDTreeToggle<CR>
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

let g:ctrlp_map                   = 'gz'
let g:ctrlp_working_path_mode     = 2
let g:ctrlp_custom_ignore         = '\.git$\|node_modules$\|tmp$\|vendor$\|\.hg$\|\.svn$'
let g:ctrlp_match_window_bottom   = 0
let g:ctrlp_match_window_reversed = 0

"--------------------------------------------------------
" Abbreviations
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

" Always move through visual lines in normal mode:
nnoremap j gj
nnoremap k gk

" Faster moving:
map J 4j
map K 4k

nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

nnoremap s <Nop>

nmap sj :SplitjoinSplit<CR>
nmap sk :SplitjoinJoin<CR>

" Map <F5> to remove all trailing whitespace
nnoremap <silent> <F5> :let _s=@/<CR>:%s/\s\+$//e<CR>:let @/=_s<CR>:nohl<CR>:set ff=unix<CR>:w<CR>

" free mappings - U, P, S, H, L, M, X, $, ^, &, -, _, +, |, \, ','

inoremap hj <ESC>
inoremap jh <ESC>
inoremap jk <ESC>
inoremap kj <ESC>
inoremap kl <ESC>
inoremap lk <ESC>

inoremap <C-backspace> <C-w>
inoremap <C-delete> <C-o>de

" TODO: fix
nnoremap gj J

nnoremap gm zz
noremap z ^
noremap Z $

" inoremap ( ()<C-o>h
" inoremap [ []<C-o>h
" inoremap { {}<C-o>h

" Remove the Windows' ^M
nnoremap <Leader>m :%s/<C-V><C-M>//ge<CR>
nnoremap <Leader>v :e! $MYVIMRC<CR>

nnoremap gV <C-v>

" Moving through tabs:
nnoremap <C-l> gt
nnoremap <C-h> gT

" Moving through splits:
nnoremap gh <C-w>h
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l

inoremap <C-SPACE> <C-n>
nnoremap <ESC> :noh<CR>
nnoremap vv V
nnoremap V v$h
nnoremap Y y$

" Open new tab easily
nnoremap <Leader>t :tabnew<CR>

nnoremap <CR> o<ESC>
nnoremap <S-CR> O<ESC>

" Do not overwrite my register!
nnoremap x "_x

nnoremap Q @q

nnoremap gb <C-o>

" gh - go to header in C/C++?

noremap <S-SPACE> <PAGEUP>
noremap <SPACE> <PAGEDOWN>

" Quit like in bash
nnoremap <C-d> :q<CR>

" Returns the cursor where it was before the start of the editing
nnoremap . .`[

