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


" ensure we're in visual mode if context was selected
function! ChatGPT_visual() range
  normal gv
  call ChatGPT()
endfunction

function! ChatGPT() range

  " make sure chatgpt-cli is installed
  if !IsChatGPTCliInstalled()
    throw 'Requires chatgpt-cli to be installed. https://github.com/kardolus/chatgpt-cli'
    return
  endif

  let ChatGPTResponseIndex = stridx(bufname('%'), "ChatGPT Response :: ")

  " decide what, if anything, we're going to pipe and default to nothing
  let selectionCommand = ""
  let userAction = "[Piped Nothing]"

  " but if we're in visual mode then pipe the selection
  if mode() ==# 'v' || mode() ==# 'V'
    let selected_text = join(getline(line("'<"), line("'>")), "\n")
    let selectionCommand = printf('echo %s', shellescape(selected_text))
    let userAction = "[Piped Snippet]"
  " but if not, and as long as we're not in a chatgpt buffer, pipe the whole file
  elseif ChatGPTResponseIndex == -1
    let selectionCommand = printf('cat %s', shellescape(expand('%')))
    let userAction = printf("[Piped %s]",expand('%:t'))
  endif

  " get the query, question, etc.
  let prompt = shellescape(input("ChatGPT>> "))

  let setup = ''
  " if buffer isn't a ChatGPT buffer identify a unique project name
  if ChatGPTResponseIndex == -1
    let gitSearchCommand = printf('git -C %s rev-parse --show-toplevel', expand('%:h'))
    let projectPath = system(gitSearchCommand)

    " if file is part of a git project, use a thread for the entire repo
    if strlen(projectPath) > 0
      let projectName = fnamemodify(projectPath, ':t')
    " otherwise just use the buffer name for the individual file
    else
      let projectName = bufname('%')
    endif
  " but if it is a ChatGPT buffer just extract the project name
  else
    let projectName = split(bufname('%'),'ChatGPT Response :: ')[0]
  endif

  " make the name file friendly for the history file
  let projectName = substitute(projectName,'\n','','g')
  let formattedProjectName = substitute(projectName, '[^a-zA-Z0-9_]', '_', 'g')
  let setup = printf('export OPENAI_THREAD="%s";', formattedProjectName)

  " run the query and parse the response
  if strlen(selectionCommand) > 0
    let command = printf('(%s) | chatgpt %s;', selectionCommand, prompt)
  else
    let command = printf('chatgpt %s;', prompt)
  endif

  let response = system(setup . command)
  let response = split(response, '\n')

  " combine with user actions
  let userInput = FormatUserInput(prompt, userAction)
  let interaction = extend(userInput, response)

  " output to buffer
  call LoadChatGPTBuffer(interaction, projectName)
endfunction

" launch a buffer to display the output
function! LoadChatGPTBuffer(response, projectName) abort
  let buffer_name = 'ChatGPT Response :: ' . a:projectName
  let buffer = bufnr(buffer_name)

  " if there's no pre-existing buffer create one
  if buffer == -1
    let buffer = bufadd(buffer_name)
    call bufload(buffer)
    call setbufvar(buffer, '&buftype', 'nofile')
  endif

  " if there's no window then create one
  if bufwinnr(buffer_name) == -1
    execute 'sp ' . buffer_name
  " but if there is then bring it into focus
  else
    execute bufwinnr(buffer_name) . ' wincmd w'
  endif

  " add to end of buffer
  call setbufvar(buffer, '&modifiable', 1)
  call setbufline(buffer, '$', a:response)

  " make it look sexy
  call StyleChatGPT(buffer)
  call setbufvar(buffer, '&modifiable', 0)
endfunction

" define ChatGPT buffer styling
function! StyleChatGPT(buffer) abort
  " lets not accidently restyle a working buffer style
  if a:buffer != bufnr('%')
    execute 'buffer ' . a:buffer
  endif

  " keep colors inbetween the lines
  setlocal textwidth=84
  setlocal linebreak
  setlocal wrap

  " paint the screen
  syntax clear
  syntax sync minlines=10000

  syntax match ChatGPTCodeSnippet /`[^`]\{-}`/ 
  highlight link ChatGPTCodeSnippet Question

  syntax match ChatGPTCodeBlock /```\_.\{-}```/ 
  highlight link ChatGPTCodeBlock Question

  syntax match ChatGPTUserAction /\[\_.\{-}\]/ 
  highlight link ChatGPTUserAction EndOfBuffer

  syntax match ChatGPTUser /^-.*-$/ contains=@NoSpell 
  highlight link ChatGPTUser Constant

  execute '%global/\%>84v/normal! gqq'

endfunction

" keep partial (promopt and context created) awareness in the buffer
function! FormatUserInput(prompt, piped) abort
  let separator = repeat('-',84)
  let space = ''

  " make it look good
  return ['','',separator,'',a:piped,'',a:prompt,'',separator,'','']
endfunction

" parse the history into lines
function! ParseChatGPTHistory() abort
  let path = '$HOME/.chatgpt-cli/history/_dotfiles_.json'
  let contents = readfile(glob(path))
  let result = []

  for line in contents
    let parsed = json_decode(line)

    if empty(parsed) || type(parsed) != 3
      continue
    endif

    for item in parsed

      if type(item) != 4 || !has_key(item, 'role') || !has_key(item, 'content')
        continue
      endif

      let role = item['role']
      let message = item['content']

      let parsed_item_str = '\n[' . role . ']\n' . string(message) . "\n"
      let parsed_item_list = split(parsed_item_str, "\n")

      call extend(result, parsed_item_list)

    endfor
  endfor

  return result
endfunction


" Define a function that breaks long lines while leaving shorter lines unchanged
function! BreakLongLines() abort
    " Get the current buffer
    let buffer = bufnr('%')

    " Move to the beginning of the buffer
    normal! gg

    " Loop through each line in the buffer
    while line('.') <= line('$')
        " Get the length of the current line
        let line_length = len(getline('.'))

        " Break line if it is longer than 80 characters
        if line_length > 80
            " Break the line
            normal! gq$

            " Update the length of the current line
            let line_length = len(getline('.'))
        endif

        " Move to the next line
        normal! j
    endwhile

    " Return to the original position
    normal! gg

    " Update the display
    redraw
endfunction

" make sure chatgpt-cli is installed
function! IsChatGPTCliInstalled()
    let command_output = system('command -v chatgpt')
    return empty(command_output) ? 0 : 1
endfunction
