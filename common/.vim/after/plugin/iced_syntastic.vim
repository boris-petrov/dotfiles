"============================================================================
"File: iced_syntastic.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer: Boris Petrov <boris_petrov@live.com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================
"
" Note: this script requires IcedCoffeeScript version 1.6.2 or newer.
"
if exists("g:loaded_syntastic_coffee_iced_checker")
    finish
endif
let g:loaded_syntastic_coffee_iced_checker=1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_coffee_iced_IsAvailable() dict
    if !executable(self.getExec())
        return 0
    endif
    let ver = self.getVersion(self.getExecEscaped() . ' --version 2>' . syntastic#util#DevNull())
    return syntastic#util#versionIsAtLeast(ver, [1, 6, 2])
endfunction

function! SyntaxCheckers_coffee_iced_GetLocList() dict
    let makeprg = self.makeprgBuild({ 'args_after': '-cp' })

    let errorformat =
        \ '%E%f:%l:%c: %trror: %m,' .
        \ 'Syntax%trror: In %f\, %m on line %l,' .
        \ '%EError: In %f\, Parse error on line %l: %m,' .
        \ '%EError: In %f\, %m on line %l,' .
        \ '%W%f(%l): lint warning: %m,' .
        \ '%W%f(%l): warning: %m,' .
        \ '%E%f(%l): SyntaxError: %m,' .
        \ '%-Z%p^,' .
        \ '%-G%.%#'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'coffee',
    \ 'name': 'iced'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
