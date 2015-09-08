" Delete surrounding function call
" Relies on surround.vim
"
" function_call(cursor_here) => dsf => cursor_here
"
" Try `dsf` with more complicated structures:
"
"   nested(function_call(cursor_here))
"   nested(cursor_here(chewy_center))
"   One::Two.new([cursor_here])
"   One::Two.new(Hash[cursor_here])
"
nnoremap <silent> dsf :call <SID>DeleteSurroundingFunctionCall()<cr>
function! s:DeleteSurroundingFunctionCall()
  if search('\k\+\zs[([]', 'b', line('.')) <= 0
    return
  endif

  " what's the opening bracket?
  let opener = getline('.')[col('.') - 1]

  " go back one word to get to the beginning of the function call
  normal! b

  " now we're on the function's name, see if we should move back some more
  " e.g. Foo.bar(baz), Bar::Baz.new(qux)
  let prefix = strpart(getline('.'), 0, col('.') - 1)
  while prefix =~ '\(\.\|::\)$'
    if search('\k\+', 'b', line('.')) <= 0
      break
    endif
    let prefix = strpart(getline('.'), 0, col('.') - 1)
  endwhile

  exe 'normal! dt'.opener
  exe 'normal ds'.opener
endfunction
