set nocompatible                " Disable vi compatibility
set encoding=utf-8 nobomb       " 
set termencoding=utf-8          " 
set fileencoding=utf-8          " 

set number                      " enable line numbers.
set numberwidth=5               " width of numbers line
set ttyfast                     " 
set modelines=0                 " not using mode lines - disabled
set noerrorbells                " remove sounds effects
set visualbell                  " -//-
set showmode                    " Show the current mode
set showcmd                     " show partial command on last line of screen.
set showmatch                   " show matching parenthesis
set title                       " Show the filename in the window title bar
set ar                          " reload files if changed externally
set noex                        " no read conf. file from the current dir.   
syntax on                       " enable syntax highlight
set backspace=indent,eol,start  " allow backspacing over everything
set esckeys                     " Allow cursor keys in insert mode.


"------------------------------------------------------------------------------
" Editing
set expandtab                   " Expand tabs to spaces
set autoindent smartindent      " auto/smart indent
set copyindent                  " copy previous indentation on auto indent
set softtabstop=4               " Tab key results in # spaces
set tabstop=4                   " Tab is # spaces
set shiftwidth=4                " The # of spaces for indenting.
set smarttab                    " At start of line, <Tab> inserts shift width
                                "   spaces, <Bs> deletes shift width spaces.
set textwidth=79                " 
set nowrap                      " do not automatically wrap on load
set formatoptions-=t            " do not automatically wrap text when typing
set colorcolumn=+1              " Show large lines

set scrolloff=10                " always see 10 lines when scroll
set pastetoggle=<leader>p       " paste mode: avoid auto indent, treat chars
                                "   as literal.


"------------------------------------------------------------------------------
" Backup and Swap files
set nobackup
set nowritebackup
set noswapfile


"------------------------------------------------------------------------------
" Security settings
"set cm=blowfish2

"------------------------------------------------------------------------------
" Search / Replace
nnoremap / /\v
vnoremap / /\v
nnoremap <silent> <cr> :nohlsearch<cr><cr>  " disable higlighting on Enter key
set hlsearch                    " highlight searche result
set ignorecase smartcase        " make searches case-insensitive, unless they
                                "   contain upper-case letters


"------------------------------------------------------------------------------
" Folding
set foldmethod=manual           " manual fold
set foldnestmax=3               " deepest fold is 3 levels
set nofoldenable                " don't fold by default


"------------------------------------------------------------------------------
" show special characters settings
set listchars=eol:?,tab:>-,trail:_,nbsp:_
highlight NonText guifg=#00ff00
highlight SpecialKey guifg=#00ff00


"------------------------------------------------------------------------------
" Interface
set t_Co=256                    " 256 colors terminal
color dracula

set tpm=10                      "maximum number of open tabs
set wak=yes                     "use ALT as usual, and not to call the menu item

set laststatus=2
set statusline=%m%r%<%F%=%y\[%{&ff}\|%{&enc}\]\ [%lx%v\,%p%%\,%L\]
" [modified flag/readonly flag][file name] [file type]
" [file format (win/unix)][file encoding][position][percentage][total lines]


if has('gui_running')
    "set transp=0
    set guioptions-=T           " remove toolbar
    set guifont=Monaco:h14
    autocmd! GUIEnter * set vb t_vb=
    " Maximize gvim window.
    set lines=45 columns=120
endif



"------------------------------------------------------------------------------
" vimdiff settings
set diffopt=filler              " Add vertical spaces to keep right
                                "   and left aligned.
set diffopt+=iwhite             " Ignore whitespace changes.
if &diff
    "set wrap                    " if doesn't work - bug
    map <gn> ]c
    map <gp> [c
    map <C-Left> dp
    map <C-Right> do
    " au FilterWritePre * if &diff | set wrap | endif
endif



"------------------------------------------------------------------------------
" Keys and Input

" Avoid mistyping commands
command! W w
command! Wq wq

" [Ctrl+A / Ctr+E] - Begin/End of the line
nmap <C-A> 0
nmap <C-E> $
imap <C-A> <ESC>0i
imap <C-E> <ESC>$i<Right>

" [Esc-Esc]-close
map <Esc><Esc> :qa<CR>
imap <Esc><Esc> <Esc>:qa<CR>

" [Ctrl+X+T] - new tab
imap <C-X>t <Esc>:tabnew<CR>i
nmap <C-X>t :tabnew<CR>
" [Ctrl+X+H] / [Ctrl+X+V] - split horizontal / vertical
map <C-X>h :split<CR>
map <C-X>v :vsplit<CR>
imap <C-X>v <Esc>:split<CR>
imap <C-X>h <Esc>:vsplit<CR>i

" F7 - Tabs
map <F7> :tabnext<CR>
map <C-F7> :tabprevious<CR>
imap <F7> <Esc>:tabnext<CR>i
imap <C-F7> <Esc>:tabprevious<CR>i

"[Ctrl+X+S]-hide/show special characters
map <C-X>s :set<Space>list!<CR>
map <C-X>S :set<Space>list!<CR>

"[Ctrl+X+N]-hide/show line number
map <C-X>n :set<Space>number!<CR>
map <C-X>N :set<Space>number!<CR>

"[Ctrl+X+W]-disable/enable wrap text
map <C-X>w :set<Space>wrap!<CR>
map <C-X>W :set<Space>wrap!<CR>

"[Ctrl+O]-Explore
map <C-O> :Explore<CR>

"[F6]-next window
map <F6> :wincmd p<CR>
imap <F6> <Esc>:wincmd p<CR>i

" Use Shift Up/Down for select lines in visual mode
nmap <S-Up> V
nmap <S-Down> V
imap <S-Up> <ESC>V
imap <S-Down> <ESC>V

" these are mapped in visual mode
vmap <S-Up> k
vmap <S-Down> j


"-[Integrating with GPG]-------------------------------------------------------
" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
  au!

  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  " We don't want a swap file, as it writes unencrypted data to disk
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile

  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null

  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

  " Convert all text to encrypted text before writing
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost *.gpg u
augroup END

"-[Plugins]--------------------------------------------------------------------
let g:GPGPossibleRecipients=["Example User <example@example.com>"]


