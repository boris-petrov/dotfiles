" Delete surrounding function call
" Depends on surround.vim
nnoremap <silent> dsf :call <SID>DeleteSurroundingFunctionCall()<cr>

function! s:DeleteSurroundingFunctionCall()
  let function_call_pattern = '\%(\k\+\.\)*\k\+([^()]\{-}\%#[^()]\{-})'

  if search(function_call_pattern, 'Wb', line('.')) < 0
    return
  endif

  normal! dt(
  normal ds(
  silent! call repeat#set('dsf')
endfunction
