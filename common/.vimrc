" Boris Petrov's vimrc file

if has('win32')
	let $VIMRUNTIME='C:\Program Files (x86)\Vim\vim73'
	set runtimepath+=~/.vim
endif

set nocompatible

filetype on

runtime bundle/vim-pathogen.git/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on

set hidden

set splitbelow
set splitright

set nobackup " don't need these
set nowritebackup
set noswapfile

set expandtab " spaces, please!
set tabstop=4 " be reasonable!
set shiftwidth=4
set softtabstop=4

set timeoutlen=500 " half a second to wait if there are 'colliding' mappings

" set list
" set listchars=trail:-

set matchpairs+=<:>

set autoindent " indents a line as the previous one
set cindent
set shiftround " indenting to tabs-width

set incsearch
set hlsearch
set ignorecase
" set infercase
set magic " why the hell can't I set verymagic?!

set number " line numbers
set numberwidth=1 " Make line number column as narrow as possible

set guioptions=ci

set showtabline=0 " Never show tabline

set showcmd " shows incomplete commands

set autoread " auto reloads file when changes detected

set cursorline " highligths the current line

set scrolloff=7
set scrolljump=7
" set sidescrolloff=15

set wildmenu
set wildchar=<Tab>
set wildmode=longest,list
set wildignore=*.o,*.hi,*.dll,*.obj,*.lib,*.swp,*.zip,*.exe,*.so

set linebreak " does not wrap in the middle of the word
set showbreak=+>

" set virtualedit=onemore

set lazyredraw " faster macros
set ttyfast " nicer redraw

set nojoinspaces " do not put 2 spaces after dot when joining lines

" set shortmess=a " all abbreviations, but I like the other things

set nostartofline " keeps my cursor where it is

set gdefault " replacing is global by default

" set iskeyword+=_,$,@,%,# " none of these are word dividers

" sets these numbers in the bottom right
set ruler
set rulerformat=%l/%L,%v%=%P

set laststatus=2 " Always show statusline

set history=200
set viminfo='20,\"50 " read/write a .viminfo file, don't store more than 50 lines of registers

set backspace=2 " backspacing over everything!

set shellslash " unix-like slashes

" nice simple title
set title
set titlestring=%m%rgVim:\ %F

set completeopt=menu

" Persistent undo
set undofile
set undodir=~/.vim/undodir
set undolevels=1000  " Because I make a lot of mistakes... for a long time
set undoreload=10000 " maximum number lines to save for undo on a buffer reload

set report=0 " Always report the number of lines changed

set display=lastline " Show as much of the last line as possible and not these crazy @'s

set formatoptions-=o " Stop continuing the comments on pressing o and O

set grepprg=grep\ -I\ -n\ -s\ --color\ --exclude-dir=node_modules\ --exclude-dir=.git\ --exclude=tags

set spell
set spelllang=en,bg

colorscheme rdark " cannot live without it

set fileencodings=utf-8,utf-16,utf-32,cp-1251,unicode

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

command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" --------------------------------------------------------------------------------------------------
" Highlight extra whitespace
" --------------------------------------------------------------------------------------------------

highlight ExtraWhitespace guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" --------------------------------------------------------------------------------------------------
" SuperTab settings
" --------------------------------------------------------------------------------------------------

autocmd FileType *   let g:SuperTabDefaultCompletionType = '<C-p>'
autocmd FileType cpp let g:SuperTabDefaultCompletionType = 'context'

" --------------------------------------------------------------------------------------------------
" AutoComplPop settings
" --------------------------------------------------------------------------------------------------

let g:acp_behaviorKeywordLength = -1

" --------------------------------------------------------------------------------------------------
" OmniCppComplete settings
" --------------------------------------------------------------------------------------------------

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std"]

" --------------------------------------------------------------------------------------------------
" syntastic settings
" --------------------------------------------------------------------------------------------------

let g:syntastic_enable_balloons = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['cpp', 'java'] }
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_auto_jump = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1

" --------------------------------------------------------------------------------------------------
" commentary mappings
" --------------------------------------------------------------------------------------------------

nmap gcc <Plug>CommentaryLine
nmap gc  <Plug>Commentary
xmap gc  <Plug>Commentary

autocmd FileType cpp setlocal commentstring=//\ %s

" --------------------------------------------------------------------------------------------------
" leader variables
" --------------------------------------------------------------------------------------------------

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
	command! Consolas    set guifont=Consolas:h14:cDEFAULT
	command! DejaVu      set guifont=DejaVu_LGC_Sans_Mono:h13:cDEFAULT
elseif has('unix')
	" set guifont=DejaVu\ LGC\ Sans\ Mono\ Book\ 14
	set guifont=Inconsolata\ 15

	command! Inconsolata set guifont=Inconsolata\ 17
	command! DejaVu      set guifont=DejaVu\ LGC\ Sans\ Mono\ Book\ 14
endif

" --------------------------------------------------------------------------------------------------
" autocommands
" --------------------------------------------------------------------------------------------------

autocmd FileType help setlocal nonumber " no line numbers when viewing help
autocmd FileType help nmap <buffer> <CR> <C-]>
autocmd FileType help nmap <buffer> <BACKSPACE> <C-t>
autocmd FileType help nmap <buffer> q :q<CR>

autocmd FileType coffee,ruby,eruby,html,zsh,sh,yaml,scss setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType cpp,java,vim,go                         setlocal noexpandtab
autocmd FileType coffee,python,slim                      setlocal foldmethod=indent nofoldenable
autocmd FileType coffee,ruby,eruby,html,slim,eco,scss    setlocal grepprg+=\ --exclude-dir=coverage\ --exclude-dir=tmp\ --exclude-dir=log\ --exclude-dir=vendor\ --exclude-dir=public

augroup RainbowParentheses
	autocmd!
	autocmd VimEnter * RainbowParenthesesToggle
	autocmd Syntax * RainbowParenthesesLoadRound
	autocmd Syntax * RainbowParenthesesLoadSquare
	autocmd Syntax * RainbowParenthesesLoadBraces
	autocmd FileType cpp RainbowParenthesesLoadChevrons
augroup END

runtime! macros/matchit.vim " smarter matching with % (ifs, elses...)

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
			\ if line("'\"") > 0 && line ("'\"") <= line("$") |
			\	exe "keepjumps normal! g'\"" |
			\ endif

" When .vimrc is edited, reload it
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

autocmd FileType haskell compiler ghc

" Saves txt and hs files after leaving insert mode if there were any changes
" autocmd InsertLeave *.{txt,hs} :up

" --------------------------------------------------------------------------------------------------
" Tabularize
" --------------------------------------------------------------------------------------------------

nnoremap sa :call <SID>Tabularize(0)<cr>
xnoremap sa :<c-u>call <SID>Tabularize(1)<cr>

function! s:Tabularize(visual)
	let saved_cursor = getpos('.')

	echohl ModeMsg | echo "-- ALIGN -- " | echohl None
	let char = nr2char(getchar())

	if     char == '=' | let alignment = 'equals'
	elseif char == '>' | let alignment = 'ruby_hash'
	elseif char == ',' | let alignment = 'commas'
	elseif char == ':' | let alignment = 'colons'
	elseif char == ' ' | let alignment = 'space'
	else
		" just try aligning by the character
		let alignment = '/'.char
	endif

	if a:visual
		exe "'<,'>Tabularize ".alignment
	else
		exe 'Tabularize '.alignment
	endif

	echo
	call setpos('.', saved_cursor)
endfunction

" --------------------------------------------------------------------------------------------------
" BufExplorer
" --------------------------------------------------------------------------------------------------

nnoremap <silent> ga :BufExplorer<CR>

" --------------------------------------------------------------------------------------------------
" Tags
" --------------------------------------------------------------------------------------------------

" Tagbar
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

autocmd FileType coffee hi! link Keyword   Statement
autocmd FileType coffee hi! link Structure Type
autocmd FileType coffee hi! def link coffeeObjAssign Special

let g:coffee_tools_function_text_object = 1

let g:syntastic_coffee_checkers  = ['iced']
let g:syntastic_coffee_iced_args = '-cp'

" --------------------------------------------------------------------------------------------------
" Session Options and Mappings
" --------------------------------------------------------------------------------------------------

set sessionoptions=buffers,curdir,globals,localoptions,tabpages
map <F9> :source Session.vim<CR>
map <F6> :mksession!<CR>

" autocmd BufLeave *.hs execute "mksession!"
" autocmd BufEnter *.hs execute "so Session.vim"

" --------------------------------------------------------------------------------------------------
" Visual Search
" --------------------------------------------------------------------------------------------------

" From an idea by Michael Naumann
function! s:VisualSearch(direction) range
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
xmap <silent> * :call <SID>VisualSearch('f')<CR>n
xmap <silent> # :call <SID>VisualSearch('b')<CR>n

" --------------------------------------------------------------------------------------------------
" Grep
" --------------------------------------------------------------------------------------------------

" Can be called in several ways:
"
" :Grep <something> -> Grep for the given search query
" :Grep -> Grep for the word under the cursor
" :'<,'>Grep -> Grep in visual mode

autocmd FileType qf nnoremap <buffer> q :cclose \| :lclose<CR>
autocmd FileType qf nnoremap <buffer> l <CR>
autocmd FileType qf nnoremap <buffer> j j
autocmd FileType qf nnoremap <buffer> k k

function! s:GetBufferList()
	redir =>buflist
	silent! ls
	redir END
	return buflist
endfunction

function! s:ToggleList(bufname, pfx)
	let buflist = <SID>GetBufferList()
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
nmap <silent> gr :call <SID>ToggleList("Quickfix List", 'c')<CR>

command! -count=0 -nargs=* Grep call s:Grep(<count>, <q-args>)

function! s:Grep(count, args)
	try
		let l:original_grepprg = &grepprg
		if a:count > 0
			" then we've selected something in visual mode
			let query = s:LastSelectedText()
			let &grepprg = l:original_grepprg . " -F"
		elseif empty(a:args)
			" If no pattern is provided, search for the word under the cursor
			let &grepprg = l:original_grepprg . " -w -F"
			let query = expand("<cword>")
		else
			let query = a:args
		end

		exe 'grep -r '.shellescape(query).' .'

	finally
		let &grepprg = l:original_grepprg
	endtry
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

" Disable vim-pasta and use it through whitespaste
let g:pasta_enabled_filetypes = []

let g:whitespaste_paste_before_command = "normal \<Plug>BeforePasta"
let g:whitespaste_paste_after_command  = "normal \<Plug>AfterPasta"
let g:whitespaste_paste_visual_command = "normal gv\<Plug>VisualPasta"

" --------------------------------------------------------------------------------------------------
" delimitMate Mappings
" --------------------------------------------------------------------------------------------------

imap <expr> <CR> delimitMate#ShouldJump() ? "\<C-g>g" : "\<CR>\<Plug>DiscretionaryEnd"

" --------------------------------------------------------------------------------------------------
" anzu Mappings
" --------------------------------------------------------------------------------------------------

nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

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
" EasyMotion Plugin Mappings
" --------------------------------------------------------------------------------------------------

map f ,,f
map F ,,F

" --------------------------------------------------------------------------------------------------
" Splitjoin
" --------------------------------------------------------------------------------------------------

let g:splitjoin_normalize_whitespace = 1
let g:splitjoin_align                = 1

" --------------------------------------------------------------------------------------------------
" Unimpaired Mappings
" --------------------------------------------------------------------------------------------------

" quickfix window
nmap sh [q
nmap sl ]q

" tags
nmap sk [t
nmap sj ]t

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

inoremap <C-v> <C-r><C-o>+
xnoremap <C-v> x<ESC>i<C-r><C-o>+<ESC>
nnoremap <C-v> i<C-r><C-o>+<ESC>
xnoremap <silent> <C-c> "zy:call system('loliclip -ci', @z)<CR>:call system('loliclip -pi', @z)<CR>
xnoremap <silent> <C-x> "zx:call system('loliclip -ci', @z)<CR>:call system('loliclip -pi', @z)<CR>
inoremap <C-a> <ESC>ggVG
xnoremap <C-a> <ESC>ggVG
nnoremap <C-a> ggVG

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

nmap <silent> ,k :call <SID>ToggleKeymap()<CR>

function! s:ToggleKeymap()
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

nmap <silent> gw :call <SID>ToggleHorizontalScrollbar()<CR>:<C-U>setlocal wrap! wrap?<CR>

function! s:ToggleHorizontalScrollbar()
	if &guioptions =~# "b"
		set guioptions-=b
	else
		set guioptions+=b
	endif
endfunction

" --------------------------------------------------------------------------------------------------
" NERDTree (un)Mappings
" --------------------------------------------------------------------------------------------------

nnoremap gn :NERDTreeTabsToggle<CR>

let g:NERDTreeMapPreviewVSplit     = ""
let g:NERDTreeMapJumpFirstChild    = ""
let g:NERDTreeMapJumpLastChild     = ""
let g:nerdtree_tabs_focus_on_files = 1

autocmd FileType nerdtree nmap <buffer> l o
autocmd FileType nerdtree nmap <buffer> h x
autocmd FileType nerdtree nmap <buffer> c ma
autocmd FileType nerdtree nmap <buffer> d md

" --------------------------------------------------------------------------------------------------
" Gitv mappings
" --------------------------------------------------------------------------------------------------

autocmd FileType gitv nmap <buffer> l <CR>
autocmd FileType git setlocal foldlevel=99
highlight diffAdded guifg=Green
highlight diffRemoved guifg=Red
highlight diffFile guifg=Yellow

" --------------------------------------------------------------------------------------------------
" fugitive mappings
" --------------------------------------------------------------------------------------------------

cab Gs Gstatus
cab Gc Gcommit
cab Gd Gdiff
autocmd BufEnter *.git/COMMIT_EDITMSG exe 'normal! gg' | if getline('.') =~ '^\s*$' | startinsert | endif
autocmd BufEnter *.git/COMMIT_EDITMSG nmap <buffer> q :q<CR>
autocmd BufEnter *.git/index nmap <buffer> d <CR>:Gdiff<CR><C-w>hgg
autocmd BufEnter *.git/index nmap <buffer> C cvc
autocmd BufEnter *.git/index nmap <buffer> ca cva
autocmd BufEnter *.git/index nmap <buffer> j <C-n>
autocmd BufEnter *.git/index nmap <buffer> k <C-p>
autocmd BufEnter *.git/index nmap <buffer> l <CR>
autocmd FileType fugitiveblame nnoremap <buffer> j j<C-w>lj<C-w>h
autocmd FileType fugitiveblame nnoremap <buffer> J 4j<C-w>l4j<C-w>h
autocmd FileType fugitiveblame nnoremap <buffer> k k<C-w>lk<C-w>h
autocmd FileType fugitiveblame nnoremap <buffer> K 4k<C-w>l4k<C-w>h
autocmd FileType fugitiveblame nnoremap <buffer> gg gg<C-w>lgg<C-w>h
autocmd FileType fugitiveblame nnoremap <buffer> G G<C-w>lG<C-w>h
nmap gs :Gstatus<CR><C-n>

" --------------------------------------------------------------------------------------------------
" Ctrl-P Mappings
" --------------------------------------------------------------------------------------------------

let g:ctrlp_map                   = 'gz'
let g:ctrlp_working_path_mode     = 'ra'
let g:ctrlp_custom_ignore         = {
	\ 'dir': '\v[\/](\.(git|hg|svn)|node_modules|tmp|vendor)$',
	\ }
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

" Map F1 to ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
cnoremap <F1> <ESC>

nnoremap - :Switch<CR>

xmap so <Plug>ExtractVar
nmap si <Plug>InlineVar

nmap U <NOP>

" Always move through visual lines in normal mode:
nnoremap j gj
nnoremap k gk

" Faster moving:
map J 4j
map K 4k

nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

nmap saj :SplitjoinSplit<CR>
nmap sak :SplitjoinJoin<CR>

nmap gt <C-]>
nmap gT <Nop>

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

nnoremap <Leader>j J

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
nnoremap s "_s

nnoremap Q @q

nnoremap gb <C-o>

" gh - go to header in C/C++?

noremap <S-SPACE> <PAGEUP>
noremap <SPACE> <PAGEDOWN>

" Quit like in bash
nnoremap <C-d> :q<CR>

" Returns the cursor where it was before the start of the editing
runtime autoload/repeat.vim
nnoremap . mr:call repeat#run(v:count)<bar>call feedkeys('`r', 'n')<CR>
