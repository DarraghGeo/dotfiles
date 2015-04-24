"
"
" Much/most of this has been blatently stolen from
"
" - @rtomayko (tomayko.com)
" - @jkreeftmeijer (jeffkreeftmeijer.com)
" - Nathan LeClaire (nathanleclaire.com)
"   The Vim Wikia (vim.wikia.com)
" - [More Victims Coming Soon]
"
filetype plugin on
"
" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

set nocompatible                        " essential
set history=1000                        " lots of command line history
set cf                                  " error files / jumping
set ffs=unix,dos,mac                    " support these files
set isk+=_,$,@,%,#,-                    " none word dividers
set viminfo='1000,f1,:100,@100,/20
set modeline                            " make sure modeline support is enabled
set autoread                            " reload files (no local changes only)
set tabpagemax=50                       " open 50 tabs max
set autochdir                           " change working directory
set omnifunc=syntaxcomplete#Complete

" ---------------------------------------------------------------------------
" Colors / Theme
" ---------------------------------------------------------------------------
syntax on
colorscheme torte

" ---------------------------------------------------------------------------
"  Highlight
" ---------------------------------------------------------------------------

highlight Comment         ctermfg=DarkGrey guifg=#444444
highlight StatusLineNC    ctermfg=Black ctermbg=DarkGrey cterm=bold
highlight StatusLine      ctermbg=Black ctermfg=LightGrey
highlight LongLine        cterm=underline,bold

" ----------------------------------------------------------------------------
"   Highlight Trailing Whitespace
" ----------------------------------------------------------------------------

set list listchars=trail:.,tab:>.
highlight SpecialKey ctermfg=DarkGray ctermbg=Black

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set ruler                               " show the cursor position all the time
set noshowcmd                           " don't display incomplete commands
set nolazyredraw                        " turn off lazy redraw
set relativenumber                      " line numbers
set wildmenu                            " turn on wild menu
set wildmode=list:longest,full
set ch=2                                " command line height
set backspace=2                         " allow backspacing over everything in insert mode
set report=0                            " tell us about changes
set nostartofline                       " don't jump to the start of line when scrolling

function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set nonumber
        set relativenumber
    endif
endfunction


autocmd InsertEnter * call NumberToggle()
autocmd InsertLeave * call NumberToggle()

" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch                           " brackets/braces that is
set mat=5                               " duration to show matching brace (1/10 sec)
set incsearch                           " do incremental searching
set laststatus=2                        " always show the status line
set ignorecase                          " ignore case when searching
set nohlsearch                          " don't highlight searches
set visualbell                          " shut the fuck up
set cursorline                          " underline current line
set cursorcolumn                        " highlight current column
match LongLine /\%81v.\+/                  " let us know when we pass 80 chars

function! CursorToggle()
    if(&cursorline == 1)
        set nocursorline
        set nocursorcolumn
    else
        set cursorline
        set cursorcolumn
    endif
endfunction

nnoremap <expr> ; CursorToggle()
" ----------------------------------------------------------------------------
" Text Formatting
" ----------------------------------------------------------------------------

set autoindent                          " automatic indent new lines
set smartindent                         " be smart about it
set nowrap                              " do not wrap lines
set softtabstop=4                       " yep, two (nope, four!)
set shiftwidth=4
set tabstop=4
set expandtab                           " expand tabs to spaces
set nosmarttab                          " fuck tabs
set formatoptions+=n                    " support for numbered/bullet lists
set virtualedit=block                   " allow virtual edit in visual block

" ----------------------------------------------------------------------------
" Key Mapping
" ----------------------------------------------------------------------------
let mapleader = ","
inoremap <S-Tab> <Tab>
inoremap <Tab> <C-X><C-I>
inoremap <expr> h ((pumvisible())?("\<C-E>"):("h"))
inoremap <expr> j ((pumvisible())?("\<C-N>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-P>"):("k"))
inoremap <expr> l ((pumvisible())?("\<C-Y>"):("l"))

nnoremap <Tab> gt

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

nnoremap Q :q<CR>
nnoremap W :w<CR>

" ----------------------------------------------------------------------------
" PHPUnit testing
" http://nathanleclaire.com/blog/2014/01/20/speed-up-your-workflow-by-running-phpunit-tests-inside-of-vim/
" ----------------------------------------------------------------------------
function! RunPHPUnitTest(filter)
    cd %:p:h
    if a:filter
        normal! T yw
        let result = system("phpunit --filter " . @" . " " . bufname("%"))
    else
        let result = system("phpunit " . bufname("%"))
    endif
    split __PHPUnit_Result__
    normal! ggdG
    setlocal buftype=nofile
    call append(0, split(result, '\v\n'))
    cd -
endfunction

nnoremap <leader>u :call RunPHPUnitTest(0)<cr>
nnoremap <leader>f :call RunPHPUnitTest(1)<cr>
