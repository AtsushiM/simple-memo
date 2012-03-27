"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/simple-memo.vim
"VERSION:  0.9
"LICENSE:  MIT

let g:simple_memo_PluginDir = expand('<sfile>:p:h:h').'/'
let g:simple_memo_TemplateDir = g:simple_memo_PluginDir.'template/'
let g:simple_memo_SubDir = g:simple_memo_PluginDir.'sub/'

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

command! SMemo call smemo#Memo()
exec 'au BufRead '.g:simple_memo_DefaultMemo.' call smemo#SetBufMapMemo()'
exec 'au BufRead '.g:simple_memo_DefaultMemo.' set filetype=smemo'
exec 'au BufWinLeave '.g:simple_memo_DefaultMemo.' call smemo#MemoClose()'
