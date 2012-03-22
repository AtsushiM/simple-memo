"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/FastProject.vim
"VERSION:  0.9
"LICENSE:  MIT

let g:simple_memo_PluginDir = expand('<sfile>:p:h:h').'/'
let g:simple_memo_TemplateDir = g:simple_memo_PluginDir.'template/'
let g:simple_memo_SubDir = g:simple_memo_PluginDir.'sub/'
let s:simple_memo_MemoNo = 0
let s:simple_memo_MemoOpen = 0

if !exists("g:simple_memo_DefaultConfigDir")
    let g:simple_memo_DefaultConfigDir = $HOME.'/.simple-memo/'
endif
if !exists("g:simple_memo_DefaultMemo")
    let g:simple_memo_DefaultMemo = '~MEMO~'
endif
if !exists("g:simple_memo_MemoWindowSize")
    let g:simple_memo_MemoWindowSize = 'topleft 50vs'
endif

" config
if !isdirectory(g:simple_memo_DefaultConfigDir)
    call mkdir(g:simple_memo_DefaultConfigDir)
endif
let s:simple_memo_DefaultMemo = g:simple_memo_DefaultConfigDir.g:simple_memo_DefaultMemo
if !filereadable(s:simple_memo_DefaultMemo)
    call system('cp '.g:simple_memo_TemplateDir.g:simple_memo_DefaultMemo.' '.s:simple_memo_DefaultMemo)
endif

function! s:MemoOpen()
    exec g:simple_memo_MemoWindowSize." ".g:simple_memo_DefaultConfigDir.g:simple_memo_DefaultMemo
    let s:simple_memo_MemoOpen = 1
    let s:simple_memo_MemoNo = bufnr('%')
endfunction
function! s:MemoClose()
    let s:simple_memo_MemoOpen = 0
    exec 'bw '.s:simple_memo_MemoNo
    winc p
endfunction

function! s:Memo()
    if s:simple_memo_MemoOpen == 0
        call s:MemoOpen()
    else
        call s:MemoClose()
    endif
endfunction

command! SMemo call s:Memo()

function! s:URICheck(uri)
  return escape(matchstr(a:uri, '[a-z]*:\/\/[^ >,;:]*'), '#')
endfunction

function! s:BrowseURI()
  let uri = prutility#URICheck(getline("."))
  if uri != ""
    call system("! open " . uri)
  else
    echo "No URI found in line."
  endif
endfunction

function! s:SetBufMapMemo()
    nnoremap <buffer><silent> b :call <SID>BrowseURI()<CR>
    nnoremap <buffer><silent> q :bw %<CR>:winc p<CR>
endfunction
exec 'au BufRead '.g:simple_memo_DefaultMemo.' call <SID>SetBufMapMemo()'
exec 'au BufWinLeave '.g:simple_memo_DefaultMemo.' call <SID>MemoClose()'
