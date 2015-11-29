
"******************************************************************************
" Common configuration
"******************************************************************************
set number
set hlsearch
set clipboard=unnamed
set backspace=indent,eol,start
set autoindent
set autowrite
set shiftwidth=4
set incsearch
set textwidth=80
set wildignore+=*/obj/*,*/export/*,*/inst.images/*,*/rc_files/*,*/simics/*,*/tools/*
set formatoptions=ql
"set switchbuf=usetab,usetab

"******************************************************************************
" Abbreviation
"******************************************************************************
ab #d #define
ab #i #include
ab #b /****************************************
ab #e <Space>****************************************/
ab #l /*-------------------------------------------- */


"******************************************************************************
" autocmd
"******************************************************************************
"The following list identifies the formatting flags.
"  t Automatically wrap text.
"  c Automatically wrap comments. Insert the comment leader automatically.
"  r Insert comment leader in a comment when a new line is inserted.
"  o Insert comment leader in a comment when a new line is created using the
"  O and o command.
"  q Allow gq to format comments.
"  2 Format based on the indent of the second line, not the first.
"  v Do old-style Vi text wrapping.Wrap only on blanks that you enter.
"  b Wrap only on blanks you type, but only if they occur before textwidth.
"  l Do not break line in insert mode. Only let gq break the lines.
"
":autocmd FileType *     set formatoptions=tcql nocindent comments&
":autocmd FileType c,cpp set formatoptions=croql  cindent comments=sr:/*,mb:*,ex:*/,://
":autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

"******************************************************************************
" Function keys
"******************************************************************************
" toggle highlight
let hlstate=0
nnoremap <silent> <F2> :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr>

" Build tags
nnoremap <silent> <F9> <Esc>:!ctags -R *<CR>

" Serch symbols in multiple files
map <F3> :execute "grep -r " . expand("<cword>") . " *" <CR> <CR> :copen <CR>

function! ToggleQuickFix()
  if exists("g:qwindow")
    cclose
    unlet g:qwindow
  else
    try
      copen 10
      let g:qwindow = 1
    catch
      echo "No Errors found!"
    endtry
  endif
endfunction

nmap <script> <silent> <F7> :call ToggleQuickFix()<CR>
nnoremap * *``

"******************************************************************************
" Window Control
"******************************************************************************
map <C-h>     <C-w>h
map <C-j>     <C-w>j
map <C-k>     <C-w>k
map <C-l>     <C-w>l
map <C-UP>    <C-w>+
map <C-DOWN>  <C-w>-
map <C-RIGHT> <C-w><
map <C-LEFT>  <C-w>>

"******************************************************************************
" Search for selected text, forwards or backwards in visual mode
"******************************************************************************
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


"******************************************************************************
" taglist plugin
"******************************************************************************
nnoremap <silent> <F6> :TlistToggle<CR>
let Tlist_Use_Right_Window=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_Menu=1
let Tlist_Auto_Open=2


"******************************************************************************
" NERDTreeTabs plugin
"******************************************************************************
nnoremap <silent> <F5> :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup=1


"******************************************************************************
" winManager plugin
"******************************************************************************
"let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
"let g:winManagerWindowLayout = "TagList|FileExplorer,BufExplorer"
"map <F5> : WMToggle<cr>


"******************************************************************************
" CtrlP plugin
"******************************************************************************
let g:ctrlp_regexp=1
let g:ctrlp_max_height=50
let g:ctrlp_working_path_mode = 'rw'
