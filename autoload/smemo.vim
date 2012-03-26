"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/simple-memo.vim
"VERSION:  0.9
"LICENSE:  MIT

let s:simple_memo_MemoNo = 0
let s:simple_memo_MemoOpen = 0

function! smemo#MemoOpen()
    exec g:simple_memo_MemoWindowSize." ".g:simple_memo_DefaultConfigDir.g:simple_memo_DefaultMemo
    let s:simple_memo_MemoOpen = 1
    let s:simple_memo_MemoNo = bufnr('%')
endfunction
function! smemo#MemoClose()
    let s:simple_memo_MemoOpen = 0
    exec 'bw '.s:simple_memo_MemoNo
    winc p
endfunction

function! smemo#Memo()
    if s:simple_memo_MemoOpen == 0
        call smemo#MemoOpen()
    else
        call smemo#MemoClose()
    endif
endfunction

function! smemo#URICheck(uri)
  return escape(matchstr(a:uri, '[a-z]*:\/\/[^ >,;:]*'), '#')
endfunction

function! smemo#BrowseURI()
  let uri = smemo#URICheck(getline("."))
  if uri != ""
    call system("! open " . uri)
  else
    echo "No URI found in line."
  endif
endfunction

function! smemo#SetBufMapMemo()
    nnoremap <buffer><silent> b :call smemo#BrowseURI()<CR>
    nnoremap <buffer><silent> q :call smemo#MemoClose()<CR>
endfunction
