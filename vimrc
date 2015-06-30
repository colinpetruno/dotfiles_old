set nocompatible              " be iMproved, required
filetype off                  " required

" change leader to spacebar
let mapleader = "\<Space>"


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/syntastic' "syntax highlighting
Plugin 'maksimr/vim-jsbeautify'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'vim-ruby/vim-ruby'
Plugin 'groenewege/vim-less'
Plugin 'vim-scripts/L9'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-rails'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'mileszs/ack.vim'
Plugin 'othree/html5.vim'
Plugin 'avakhov/vim-yaml'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'bling/vim-airline'

" Plugin 'skammer/vim-css-color'


" Settings
set background=dark   " you can use `dark` or `light` as your background
syntax on
color mango

:let g:airline_theme='sol'
:let g:airline#extensions#tabline#enabled = 1
:let g:airline#extensions#tabline#fnamemod = ':t'

set number
set numberwidth=3

set colorcolumn=80
hi ColorColumn ctermbg=23

" TAB SETTINGS
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

" INDENT GUIDE COLORS
hi IndentGuidesOdd  ctermbg=Blue
hi IndentGuidesEven ctermbg=DarkCyan


map <C-n> :NERDTreeToggle<CR>
map <C-f> :call JsBeautify()<cr>

" Fuzzy Finder
" map ,f :FufCoverageFile **/<CR>

" nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
" imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
" nmap <F2> :.w !pbcopy<CR><CR>
" vmap <F2> :w !pbcopy<CR><CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

au BufNewFile,BufRead *.hbs set filetype=mustache
autocmd BufNewFile,BufRead *.less setf less
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" easier tab navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" leader o to open file
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>


" copy paste 
set clipboard=unnamed
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" map <Leader> <Plug>(easymotion-prefix)

nmap <Leader><Leader> V

" Buffers

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" stop annoying window from popping up
map q: :q

function! <SID>StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

autocmd BufWritePre *.scss,*.py,*.js,*.rb,*.erb :call <SID>StripTrailingWhitespaces()

