" Boris Petrov's vimrc file

if has('win32')
	let $VIMRUNTIME='C:\Program Files (x86)\Vim\vim73'
	set runtimepath+=~/.vim
endif

set nocompatible
filetype off

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'AndrewRadev/deleft.vim'
Plugin 'AndrewRadev/sideways.vim'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'AndrewRadev/switch.vim'
Plugin 'AndrewRadev/tagalong.vim'
Plugin 'AndrewRadev/vim-eco'
Plugin 'AndrewRadev/whitespaste.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Raimondi/delimitMate'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'bkad/CamelCaseMotion'
Plugin 'bling/vim-airline'
Plugin 'luochen1990/rainbow'
Plugin 'junegunn/fzf.vim'
Plugin 'dietsche/vim-lastplace'
Plugin 'easymotion/vim-easymotion'
Plugin 'ervandew/supertab'
Plugin 'garbas/vim-snipmate'
Plugin 'godlygeek/csapprox'
Plugin 'godlygeek/tabular'
Plugin 'gregsexton/gitv'
Plugin 'honza/vim-snippets'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kana/vim-smartword'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'mechatroner/rainbow_csv'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'scrooloose/nerdtree'
Plugin 'w0rp/ale'
Plugin 'sheerun/vim-polyglot'
Plugin 'sickill/vim-pasta'
Plugin 'simnalamburt/vim-mundo'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'wellle/targets.vim'
Plugin 'yssl/QFEnter'
Plugin 'AutoComplPop'
Plugin 'OmniCppComplete'
Plugin 'taglist.vim'

call vundle#end()
filetype plugin indent on

syntax on

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

" fix problems in terminal Vim
set t_RV= ttymouse=xterm2 t_Co=256

set mouse=a

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
set wildignore=*/tmp/*,*.obj,*.o,*.hi,*.dll,*.so,*.lib,*.a,*.swp,*.zip,*.tar*,*.exe,*.out,*.sqlite*,*.gif,*.jpg,*.bmp,*.png,*.jar,*.class,*.pyc

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

if executable('rg')
	set grepprg=rg\ --vimgrep\ --color\ never\ --ignore-case\ --sort-files
elseif executable('ag')
	set grepprg=ag\ --nocolor
else
	set grepprg=grep\ -I\ -n\ -s\ --exclude-dir=node_modules\ --exclude-dir=.git\ --exclude-dir=.svn\ --exclude=.tags
endif

set tags+=./.tags,.tags

set spell
set spelllang=en_us,bg

set synmaxcol=500 " do not syntax-highlight lines after the 500th symbols

colorscheme rdark " cannot live without it

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

command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" --------------------------------------------------------------------------------------------------
" Highlight extra whitespace
" --------------------------------------------------------------------------------------------------

highlight ExtraWhitespace guibg=red

" --------------------------------------------------------------------------------------------------
" SuperTab settings
" --------------------------------------------------------------------------------------------------

let g:SuperTabContextDefaultCompletionType = '<c-x><c-u>'

" --------------------------------------------------------------------------------------------------
" SnipMate settings
" --------------------------------------------------------------------------------------------------
"
let g:snipMate = { 'snippet_version' : 1 }

" --------------------------------------------------------------------------------------------------
" AutoComplPop settings
" --------------------------------------------------------------------------------------------------

let g:acp_behaviorKeywordLength = -1

" --------------------------------------------------------------------------------------------------
" targets settings
" --------------------------------------------------------------------------------------------------

autocmd User targets#mappings#user call targets#mappings#extend({
    \ 'b': {'pair': [{'o':'(', 'c':')'}]}
    \ })

" --------------------------------------------------------------------------------------------------
" OmniCppComplete settings
" --------------------------------------------------------------------------------------------------

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std"]

" --------------------------------------------------------------------------------------------------
" ale settings
" --------------------------------------------------------------------------------------------------

let g:ale_linters = {
\   'python': ['flake8'],
\}

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_python_flake8_options = '--max-line-length 119'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_linters_explicit = 1

" --------------------------------------------------------------------------------------------------
" commentary mappings
" --------------------------------------------------------------------------------------------------

nmap gcc <Plug>CommentaryLine
nmap gc  <Plug>Commentary
xmap gc  <Plug>Commentary

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
	set guifont=Inconsolata\ LGC\ Nerd\ Font\ 12

	command! Inconsolata set guifont=Inconsolata\ LGC\ Nerd\ Font\ 12
	command! DejaVu      set guifont=DejaVu\ LGC\ Sans\ Mono\ Book\ 11
endif

" --------------------------------------------------------------------------------------------------
" Autocommands
" --------------------------------------------------------------------------------------------------

augroup MyAutocmds
	autocmd!

	" match end of line whitespace
	function! s:MatchWhitespacePattern(pattern)
		if &filetype != 'gitcommit' && &filetype != 'git' && &filetype != 'qf'
			exe 'match ExtraWhitespace /'.escape(a:pattern, '/').'/'
		else
			match ExtraWhitespace ''
		endif
	endfunction

	" the last character in the following is a NBSP
	autocmd InsertEnter * call s:MatchWhitespacePattern('\s\+\%#\@<!$\|\t\+\ze \| \+\ze\t\|[^\t]\zs\t\+\| ')
	autocmd InsertLeave * call s:MatchWhitespacePattern('\s\+$\|\t\+\ze \| \+\ze\t\|[^\t]\zs\t\+\| ')
	" match space before tab; tabs not at the start of the line
	autocmd FileType * call s:MatchWhitespacePattern('\s\+$\|\t\+\ze \| \+\ze\t\|[^\t]\zs\t\+\| ')
	autocmd BufWinLeave * call clearmatches()

	autocmd BufEnter * let b:SuperTabDefaultCompletionType = '<C-p>'
	autocmd BufEnter *.cpp,*.java let b:SuperTabDefaultCompletionType = 'context'

	autocmd FileType cpp,c,cs,groovy setlocal commentstring=//\ %s

	autocmd FileType help setlocal nonumber " no line numbers when viewing help
	autocmd FileType help nmap <buffer> <CR> <C-]>
	autocmd FileType help nmap <buffer> <BACKSPACE> <C-t>
	autocmd FileType help nmap <buffer> q :q<CR>

	autocmd FileType coffee,javascript,typescript,ruby,eruby,html,htmldjango,zsh,sh,yaml,scss,html.handlebars setlocal tabstop=2 shiftwidth=2 softtabstop=2
	autocmd FileType html.handlebars setlocal nofixendofline
	autocmd FileType cs,java,vim,go,groovy setlocal noexpandtab
	autocmd FileType coffee,python,slim setlocal foldmethod=indent nofoldenable
	if !executable('ag')
		autocmd FileType coffee,ruby,eruby,html,slim,eco,scss setlocal grepprg+=\ --exclude-dir=coverage\ --exclude-dir=tmp\ --exclude-dir=log\ --exclude-dir=vendor\ --exclude-dir=public\ --exclude-dir=env
	endif

	autocmd BufWritePost $MYVIMRC source $MYVIMRC

	autocmd FileType haskell compiler ghc

	autocmd FileType taglist nmap <buffer> l <CR>

	autocmd FileType coffee hi! link Keyword   Statement
	autocmd FileType coffee hi! link Structure Type
	autocmd FileType coffee hi! def link coffeeObjAssign Special

	autocmd FileType qf nnoremap <buffer> q :cclose \| :lclose<CR>
	autocmd FileType qf nnoremap <buffer> j j
	autocmd FileType qf nnoremap <buffer> k k

	autocmd FileType nerdtree nmap <buffer> l o
	autocmd FileType nerdtree nmap <buffer> h x
	autocmd FileType nerdtree nmap <buffer> c ma
	autocmd FileType nerdtree nmap <buffer> d md

	autocmd FileType gitv nmap <buffer> l <CR>
	autocmd FileType git setlocal foldlevel=99

	autocmd BufEnter *.git/COMMIT_EDITMSG exe 'normal! gg' | if getline('.') =~ '^\s*$' | startinsert | endif
	autocmd FileType gitcommit nmap <buffer> q :q<CR>
	autocmd FileType fugitive nmap <buffer> d <CR>:Gdiff<CR><C-w>hgg
	autocmd FileType fugitive nmap <buffer> C cc
	autocmd FileType fugitive nmap <buffer> ca cva
	autocmd FileType fugitive nmap <buffer> j )
	autocmd FileType fugitive nmap <buffer> k (
	autocmd FileType fugitive nmap <buffer> l <CR>
	autocmd FileType fugitive nmap <buffer> q gq
	autocmd FileType fugitiveblame nnoremap <buffer> j  <C-w>lj<C-w>h
	autocmd FileType fugitiveblame nnoremap <buffer> J  <C-w>l4j<C-w>h
	autocmd FileType fugitiveblame nnoremap <buffer> k  <C-w>lk<C-w>h
	autocmd FileType fugitiveblame nnoremap <buffer> K  <C-w>l4k<C-w>h
	autocmd FileType fugitiveblame nnoremap <buffer> gg <C-w>lgg<C-w>h
	autocmd FileType fugitiveblame nnoremap <buffer> G  <C-w>lG<C-w>h
	autocmd FileType fugitiveblame nmap <buffer> q gq
augroup END

runtime! macros/matchit.vim " smarter matching with % (ifs, elses...)

" When .vimrc is edited, reload it

" Saves txt and hs files after leaving insert mode if there were any changes
" autocmd InsertLeave *.{txt,hs} :up

" --------------------------------------------------------------------------------------------------
" Rainbow Parentheses
" --------------------------------------------------------------------------------------------------

let g:rainbow_active = 1
let g:rainbow_conf = {
\   'parentheses_options': 'contains=@Spell',
\}

" --------------------------------------------------------------------------------------------------
" Tabularize
" --------------------------------------------------------------------------------------------------

nnoremap sa :call <SID>Tabularize(0)<CR>
xnoremap sa :<c-u>call <SID>Tabularize(1)<CR>

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

" Taglist
nnoremap <silent> gd :TlistToggle<CR>

let g:Tlist_Use_Right_Window=1
let g:Tlist_Close_On_Select=1
let g:Tlist_Exit_OnlyWindow=1

let g:tlist_coffee_settings = 'coffee;c:class;m:method;f:function'

" Gutentags
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0

" --------------------------------------------------------------------------------------------------
" Mundo
" --------------------------------------------------------------------------------------------------

nnoremap <F4> :MundoToggle<CR>

" --------------------------------------------------------------------------------------------------
" CoffeeScript related stuff
" --------------------------------------------------------------------------------------------------

let coffee_compile_vert = 1

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
	let l:pattern = substitute(l:pattern, "\n", "\\\\n", "g")
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
" Sideways
" --------------------------------------------------------------------------------------------------

nnoremap s< :SidewaysLeft<CR>
nnoremap s> :SidewaysRight<CR>
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

" --------------------------------------------------------------------------------------------------
" QuickFix list
" --------------------------------------------------------------------------------------------------

let g:qfenter_keymap = {}
let g:qfenter_keymap.open  = ['l', '<CR>']
let g:qfenter_keymap.vopen = []
let g:qfenter_keymap.hopen = ['s']
let g:qfenter_keymap.topen = ['t']

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

" --------------------------------------------------------------------------------------------------
" Ag
" --------------------------------------------------------------------------------------------------

command! -range -nargs=* Grep call s:Grep(<count>, <q-args>)

" Can be called in several ways:
"
" :Grep <something> -> Grep for the given search query
" :Grep -> Grep for the word under the cursor
" :'<,'>Grep -> Grep in visual mode

function! s:Grep(count, args)
	let options = ''
	if a:count >= 0
		" then we've selected something in visual mode
		if executable('rg')
			let options = '--fixed-strings '
		elseif executable('ag')
			let options = '--literal '
		endif
		let query = s:LastSelectedText()
	elseif empty(a:args)
		" If no pattern is provided, search for the word under the cursor
		let query = expand("<cword>")
		if executable('rg')
			let options = '--word-regexp --fixed-strings '
		elseif executable('ag')
			let options = '--word-regexp --literal '
		endif
	else
		let query = a:args
	end

	let escaped_query = substitute(substitute(shellescape(query, '#'), '\\!', '!', 'g'), '|', '\\|', 'g')
	exe 'grep '.options.escaped_query.' .'
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
" pasta config
" --------------------------------------------------------------------------------------------------

let g:pasta_disabled_filetypes = []

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

let delimitMate_expand_space = 1
imap <expr> <CR> delimitMate#ShouldJump() ? "\<C-g>g" : "\<CR>\<Plug>DiscretionaryEnd"

" --------------------------------------------------------------------------------------------------
" vim-airline config
" --------------------------------------------------------------------------------------------------

let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#hunks#enabled = 0
let g:airline_detect_spell=0
let g:airline_section_z='%v %P'

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

map f ,,s

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
" terminal mappings
" --------------------------------------------------------------------------------------------------

tnoremap <S-INSERT> <C-w>"+

" --------------------------------------------------------------------------------------------------
" Windows-like mappings
" --------------------------------------------------------------------------------------------------

inoremap <C-v> <C-r><C-o>+
xnoremap <C-v> x<ESC>i<C-r><C-o>+<ESC>
nnoremap <C-v> i<C-r><C-o>+<ESC>
xnoremap <silent> <C-c> "+y
xnoremap <silent> <C-x> "+x
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
nmap d` ds`
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
xmap ` S`
xmap > S>
xmap < >
xmap " S"
xmap ' S'

" --------------------------------------------------------------------------------------------------
" Keymap
" --------------------------------------------------------------------------------------------------

nmap <silent> <Leader>k :call <SID>ToggleKeymap()<CR>

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

nmap <silent> <Leader>w :call <SID>ToggleHorizontalScrollbar()<CR>:<C-U>setlocal wrap! wrap?<CR>

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

nnoremap <silent> gn :NERDTreeMirrorToggle<CR>

let NERDTreeMapJumpFirstChild = ""
let NERDTreeMapJumpLastChild = ""
let NERDTreeRespectWildIgnore = 1
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore=['__pycache__']
let nerdtree_tabs_open_on_new_tab = 0
let nerdtree_tabs_open_on_console_startup = 1

" --------------------------------------------------------------------------------------------------
" Gitv mappings
" --------------------------------------------------------------------------------------------------

highlight diffAdded guifg=Green
highlight diffRemoved guifg=Red
highlight diffFile guifg=Yellow

" --------------------------------------------------------------------------------------------------
" fugitive mappings
" --------------------------------------------------------------------------------------------------

cab Gs Git
cab Gc Gcommit
cab Gd Gdiff

nmap gs :Git<CR>

command! -nargs=0 -range Glogr tabnew | set ft=diff buftype=nofile | 0r!git -C "#:h" log -L "<line1>,<line2>:#:t"
command! -nargs=0 Glogf tabnew | set ft=diff buftype=nofile | 0r!git -C "#:h" log -p --follow "#:t"

" --------------------------------------------------------------------------------------------------
" vim-gutter Settings
" --------------------------------------------------------------------------------------------------

let g:gitgutter_map_keys = 0

" --------------------------------------------------------------------------------------------------
" fzf Mappings
" --------------------------------------------------------------------------------------------------

nnoremap gz :Files<CR>
let g:fzf_layout = { 'up': '~40%' }

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

" Rescan the buffer from start and fix highlighting
nnoremap <Leader>s <Esc>:syntax sync fromstart<CR>

" Map F1 to ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
cnoremap <F1> <ESC>

nmap <Leader>cl :let @+=expand("%:p")<CR>:let @*=expand("%:p")<CR>
nmap <Leader>2 :%s;^\(\s\+\);\=repeat(' ', len(submatch(0))/2);g<CR>
nmap <Leader>4 :%s;^\(\s\+\);\=repeat(' ', len(submatch(0))*2);g<CR>
xmap <Leader>2 :s;^\(\s\+\);\=repeat(' ', len(submatch(0))/2);g<CR>
xmap <Leader>4 :s;^\(\s\+\);\=repeat(' ', len(submatch(0))*2);g<CR>

" Saving read-only files
cnoremap sudow w !sudo tee % >/dev/null

let g:switch_mapping = '-'

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

function! FixWhitespace()
	silent! %s/\%u00a0/ / " Replace nbsp by spaces
	silent! %s/\s\+$//    " Remove trailing whitespace
endfunction

" Map <F5> to fix whitespace issues
nnoremap <silent> <F5> :let _s=@/<CR>:call FixWhitespace()<CR>:let @/=_s<CR>:nohl<CR>:set ff=unix<CR>:w<CR>

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

imap <C-SPACE> <Tab>
if has("gui_running")
	nmap <ESC> :noh<CR>
endif
nnoremap vv V
nnoremap V v$h
nnoremap Y y$

" Open new tab easily
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>T :tabedit %<CR>

nnoremap <Leader>r :e %<CR>

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
