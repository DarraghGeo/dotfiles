"
"
" Much/most of this has been blatently stolen from
"
" - @rtomayko (tomayko.com)
" - @jkreeftmeijer (jeffkreeftmeijer.com)
" - Nathan LeClaire (nathanleclaire.com)
" -  The Vim Wikia (vim.wikia.com)
" - Thoughtbot (https://thoughtbot.com/)
"   
"
filetype off
"
" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

set nocompatible                        " essential
set noswapfile                          " no .swp files
set history=1000                        " lots of command line history
set cf                                  " error files / jumping
set ffs=unix,dos,mac                    " support these files
set isk+=_,$,@,%,#,-                    " none word dividers
set viminfo='1000,f1,:100,@100,/20
set modeline                            " make sure modeline support is enabled
set autoread                            " reload files (no local changes only)
set tabpagemax=50                       " open 50 tabs max
set omnifunc=syntaxcomplete#Complete
set splitright splitbelow               " position new windows below and right
set timeoutlen=250                      " wait 250ms to receive second input


" ---------------------------------------------------------------------------
" Colors / Theme
" ---------------------------------------------------------------------------
syntax on
"colorscheme nightfox

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

function! NumberToggle()                " switch between relative and absolute numbers
    if(&relativenumber == 1)            " relative in normal mode for jumping, absolute
        set norelativenumber            " in insert mode for debugging.
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
set colorcolumn=88                      " highlight the 88th column

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
set softtabstop=2                       " yep, two (nope, four!)
set shiftwidth=2
set tabstop=2
set expandtab                           " expand tabs to spaces
set nosmarttab                          " fuck tabs
set formatoptions+=n                    " support for numbered/bullet lists
set virtualedit=block                   " allow virtual edit in visual block
set fileformat=unix
set encoding=utf-8

au BufRead,BufNewFile *.md,*.json setlocal textwidth=80 "Wrap text if md/json
autocmd BufEnter term://* setlocal syntax=no            "disable highlightin in terminal

" enable line numbers in NERDTree
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber

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
nnoremap <S-Tab> gT

nnoremap j jzz
nnoremap k kzz

nnoremap jj <C-d>zz
nnoremap kk <C-u>zz
nnoremap hh ^
nnoremap ll $

nnoremap <Space>h <C-w>h
nnoremap <Space>l <C-w>l
nnoremap <Space>k <C-w>k
nnoremap <Space>j <C-w>j

nnoremap <Space>w :resize -10<CR>
nnoremap <Space>s :resize +10<CR>
nnoremap <Space>a :vertical resize +10<CR>
nnoremap <Space>d :vertical resize -10<CR>

nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

nnoremap Q :q<CR>
nnoremap W :w<CR>

nmap <Space>t :NERDTreeToggle<CR>
nmap <Space><Space> :w<CR>
imap <Space><Space> <Esc>:w<CR>

" fold and open lines
vnoremap <Space>o zo
noremap <Space>r zf

" get a full width or height terminal
nnoremap T :bo term<CR>
nnoremap TT :vert term<CR>

" yanking selected lines, or all document, to OS clipboard
nnoremap <Space>y :%w !pbcopy<CR><CR>
vnoremap <Space>y "+y


autocmd TerminalWinOpen * tnoremap <buffer> <Space><Space> <C-w>N
au TerminalWinOpen * setlocal syntax=off

" ---------------------------------------------------------------------------
" fzf
" ---------------------------------------------------------------------------
nnoremap <Space>f :FZF<CR>
nnoremap <Space>ff :RG<CR>
" ---------------------------------------------------------------------------
" Emmet
" ---------------------------------------------------------------------------
let g:user_emmet_install_global = 0
nmap <Space><Space><Space> <C-y>,
imap <Space><Space><Space> <Esc><C-y>,

" ---------------------------------------------------------------------------
" Python Development
" ---------------------------------------------------------------------------
" run python tests
command PT execute ':w | bo term python3 -B -m unittest'
command PR execute ':w | bo term python3 -B %'
command Black silent execute ':w | !black ./'

" ----------------------------------------------------------------------------
" Airline & ALE
" ----------------------------------------------------------------------------

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:airline#extensions#ale#enabled = 1              " Enable syntax errors in airline

" ----------------------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------------------

" auto-start NERDTree
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
"
" ----------------------------------------------------------------------------
" ProjectRoot
" ----------------------------------------------------------------------------
function! <SID>AutoProjectRootCD()
  try
    if &ft != 'help'
      ProjectRootCD
    endif
  catch
    " Silently ignore invalid buffers
  endtry
endfunction

autocmd BufEnter * call <SID>AutoProjectRootCD()

packloadall
silent! helptags ALL


" ----------------------------------------------------------------------------
" ChatGPT
" ----------------------------------------------------------------------------
nnoremap <Space>g :call ChatGPT()<CR>
vnoremap <Space>g :call ChatGPT_visual()<CR>

function! ChatGPT() range
  let selectionCommand = printf('cat %s', shellescape(expand('%')))

  if mode() ==# 'v' || mode() ==# 'V'
    let selected_text = join(getline(line("'<"), line("'>")), "\n")
    let selectionCommand = printf('echo %s', shellescape(selected_text))
  endif

  let prompt = shellescape(input("What's your question? "))

  if strlen(prompt) < 3
    echo "Error: Prompt required."
    return
  endif

  let setup = ''

  let gitSearchCommand = printf('git -C %s rev-parse --show-toplevel', expand('%:h'))
  let projectPath = system(gitSearchCommand)

  if strlen(projectPath) > 0
    let projectName = fnamemodify(projectPath, ':t')
    let formattedProjectName = substitute(projectName, '[^a-zA-Z0-9_]', '_', 'g')
    let formattedProjectName = substitute(formattedProjectName,'\n','','g')

    let setup = printf('export OPENAI_THREAD="%s";', formattedProjectName)
  endif

  let command = printf('(%s) | chatgpt %s;', selectionCommand, prompt)

  let response = "Hello world"

  let response_buffer = bufadd('ChatGPT Response')
  call setbufvar(response_buffer, '&modifiable', 0)

  call setbufline(response_buffer, 1, response)

  echo response
  "execute 'split ChatGPT Response'

endfunction

function! ChatGPT_visual() range
  normal gv
  call ChatGPT()
endfunction
