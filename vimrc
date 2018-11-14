" Basic settings and status line {{{
syntax on
set nowrap
set scrolloff=7
set textwidth=80
set autoindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set number
set cmdheight=2
set colorcolumn=80
set noruler
set laststatus=2
set noswapfile
set clipboard=unnamed
set statusline=%F%m\ %y\ b%n%=line:%4l:%v\ of\ %L\ [%P]
set autochdir
set formatoptions=cq
set fo-=t
set completeopt+=longest
set backspace=2
set updatetime=100
" the default formatoption can be changed in filetype plugins, these can be
" changed in filetype plugins that is loaded after the vimrc. In
" ~/.vim/after/ftplugins the formatoptions is changed for some filetypes.

" gvim specific settings {{{
if has("gui_running")
    set guicursor=n-v-c-i:block-Cursor
    set backspace=2 "fixes backspace problem
    set langmenu=en_US
    let $LANG='en_US'
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set mouse=""
endif
" }}}
" }}}
" imports {{{

source $VIMRUNTIME/macros/matchit.vim
" }}}
" color settings {{{
" example of how these can be is in $VIMRUNTIME/syntax/syncolor.vim
" the color numbers are found at http://www.pixelbeat.org/docs/terminal_colours/
" type ':VXtermColorTable' to check all colors (needs colors.vim file from git)

" Normal     : the background (bg) the normal text (fg)
" Comment    : self explanatory
" Number     : self explanatory
" String     : self explanatory
" Identifier : (py) data types (None float int etc)
" Visual     : The area marked in visual mode
" PreProc    : import, c preprocessor stuff etc
" Special    : special keys in vim <left>, <leader>, <esc> etc.
"              special characters \0, \n etc.
" Type       : (vimrc) StatusLine ctermfg guibg etc. (c,cpp) data types

" gvim specific colors {{{
if has("gui_running")
    colorscheme desert
    " set guifont=Lucida_Console
endif
" }}}

    set t_Co=256 " enables me to use more than 16 colors, needs ncurses

    " color of the different syntax elements
    hi Normal      ctermfg=255  ctermbg=232 guifg=#ffffff guibg=#000000 cterm=italic gui=none gui=none
    hi NonText                  guifg=#4542ae guibg=#000000
    hi Comment     ctermfg=27   guifg=#005fff cterm=none gui=none
    hi Number      ctermfg=130  guifg=#af5f00 cterm=none gui=none
    hi Folded      ctermfg=41   guifg=#000087 ctermbg=19  guibg=#949494 cterm=bold
    hi String      ctermfg=160  guifg=#df0000 cterm=none gui=none
    hi Type        ctermfg=34   guifg=#00af00 cterm=none gui=none
    hi Statement   ctermfg=208  guifg=#df8700 cterm=none gui=none
    hi Identifier  ctermfg=34   guifg=#00af00 cterm=none gui=none
    hi Visual      ctermbg=238  guibg=#444444 ctermfg=none cterm=none gui=none
    hi PreProc     ctermfg=93   guifg=#8700ff cterm=none gui=none
    hi Special     ctermfg=93   guifg=#8700ff cterm=none gui=none
    hi LineNr      ctermfg=130  guifg=#af5f00 cterm=none gui=none
    hi ColorColumn ctermbg=235  guibg=#121212
    hi Error       ctermbg=1    guibg=#FF0000
    hi search      ctermbg=8    guibg=#808080

    hi SpellBad    ctermbg=124
    hi SpellCap    ctermbg=20
    hi SpellRare   ctermbg=196
    " CSV files
    hi CSVColumnEven ctermbg=232
    hi CSVColumnOdd  ctermbg=234
    " color of the statusline || bg = text
    hi StatusLine   ctermfg=232 ctermbg=248 guifg=#080808 guibg=#a8a8a8 gui=bold cterm=bold
    hi StatusLineNc ctermfg=232 ctermbg=240 guifg=#080808 guibg=#585858

    " NERDTREE
    hi Directory    ctermfg=161
    " syntastic

    hi Pmenu ctermbg=238 ctermfg=255
" }}}
" leaders {{{
let mapleader=","
let maplocalleader=";"
" }}}
" variables {{{
let $SYNTAX="$VIMRUNTIME/syntax"

if !exists("g:startdir")
    let g:startdir = expand("%:p:h")
endif

" dont overwrite the variable if resource vimrc
if !exists("b:mycomment")
    let b:mycomment = ""
endif

if !exists("b:leadertl_line")
    let b:leadertl_line = 3
endif
"}}}
" vimrc settings {{{
" open and source the vimrc file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
if findfile("zathurarc",expand($HOME) . "/.config/zathura")
    nnoremap <leader>ez :vsplit $HOME/.config/zathura/zathurarc<cr>
endif
" ^^^ is not working
" }}}
" maps {{{

nnoremap j gj
nnoremap k gk
" removes the arrowkeys in insert mode
inoremap <C-c> <nop>
inoremap jk <esc>

nnoremap <leader>f gg=G
nnoremap L :bn<cr>
nnoremap H :bp<cr>
nnoremap <leader>r <nop>
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-right> <C-w>l
nnoremap <C-left> <C-w>h
nnoremap <C-up> <C-w>k
nnoremap <C-down> <C-w>j

nnoremap <leader>sf :Files<cr>
nnoremap <leader>sg :GFiles<cr>
nnoremap <leader>sc :Commits<cr>

cnoremap w!! w !sudo tee %

nnoremap <down> 2jzz
nnoremap <up> 2kzz
vnoremap <down> 2jzz
vnoremap <up> 2kzz

let NERDTreeChDirMode=2
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>b :NERDTree .<cr>

nnoremap <leader>m :TagbarToggle<cr>
" tmux uses C-a as prefix C-a is normally number increment
nnoremap <C-c> <C-a>

nnoremap <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
nnoremap <leader>c :execute "normal I" . b:mycomment . " "<cr>
nnoremap <leader>d :<C-u>call setline(".", substitute(getline("."),'\V\^\(\s\{-}\)\(' . b:mycomment .  '\s\*\)\(\.\*\)','\1\3',""))<cr>

vnoremap <leader>c :call setline(".", substitute(getline("."),'^\(\s*\)','\1' . b:mycomment . ' ',""))<cr>
vnoremap <leader>d :call setline(".", substitute(getline("."),'\V\^\(\s\{-}\)\(' . b:mycomment .  '\s\*\)\(\.\*\)','\1\3',""))<cr>gv
"vnoremap <leader>c :<c-u>execute "'<,'>" . 's@^\(\s*\)@\1' . b:mycomment<cr>
"vnoremap <leader>x :<c-u>execute "'<,'>" . 's@\v^(\s{-})(' . b:mycomment .  ')+(.*)@\1\3'<cr>

nnoremap <silent> <leader>q :bp\|bd #<cr>
vnoremap <leader>; <c-v>$A;<esc>
nnoremap <leader>; <c-v>$A;<esc>

nnoremap <leader>tcd :call VimuxRunCommand("cd " . expand("%:p:h"))<cr>
nnoremap <leader>tcc :call VimuxSendKeys('C-c')<cr>

let b:leadertrc=""
nnoremap <leader>tl :call VimuxRunCommand(substitute(getline(b:leadertl_line), '^\s*' . b:mycomment . '\s*\(.*\)$', '\1', "")) <cr>
nnoremap <leader>l :execute "normal :!" . substitute(getline(b:leadertl_line), '^\s*' . b:mycomment . '\s*\zs\(.*\)\ze$', '\1', "")
nnoremap <leader>trc :call VimuxRunCommand(b:leadertrc) <cr>

nnoremap <localleader>n :cn<CR>
nnoremap <localleader>p :cp<CR>

" }}}
" C/C++ file settings {{{
augroup FT_cpp
    au!
    autocmd FileType cpp let b:mycomment = "//"
    autocmd FileType c let b:mycomment = "//"

    autocmd FileType cpp nnoremap <buffer> <leader>e :make %<<cr>
    autocmd FileType c nnoremap <buffer> <leader>e :make %<<cr>
    autocmd FileType cpp nnoremap <buffer> <leader>r :!./%<<cr>
    autocmd FileType c nnoremap <buffer> <leader>r :!./%<<cr>
    autocmd FileType c nnoremap <buffer> <leader>a :make all<cr>
    autocmd FileType c nnoremap <buffer> <leader>s :!./<tab><cr>
    " add maps for make and run programs in c/c++
augroup END
" }}}
" python file settings {{{
augroup FT_python
    au!
    autocmd FileType python let b:mycomment = "#"
    autocmd FileType python set fo-=t
    autocmd FIleType python nnoremap <buffer> gd :YcmCompleter GoToDefinition<cr>
    autocmd FIleType python nnoremap <buffer> gD :YcmCompleter GoToDeclaration<cr>
    autocmd FileType python nnoremap <buffer> <leader>tr3 :call VimuxRunCommand("python3 " . expand("%:p"))<cr>
    autocmd FileType python nnoremap <buffer> <leader>tr2 :call VimuxRunCommand("python  " . expand("%:p"))<cr>
    autocmd FileType python nnoremap <buffer> <leader>r3 :!python3 %<cr>
    autocmd FileType python nnoremap <buffer> <leader>r2 :!python %<cr>
    autocmd FileType python nnoremap <buffer> <leader>in :!ipython3 <cr>
    autocmd FileType python nnoremap <buffer> <leader>f :Autopep8<cr>
    autocmd FileType python iabbrev <buffer> ifname if __name__ == "__main__":<esc>o
augroup END
" }}}
" rust file settings {{{
augroup FT_rust
    au!
    autocmd FileType rust let b:mycomment = "//"
    autocmd FileType rust nnoremap <buffer> <leader>rr :Cargo run<cr>
    autocmd FileType rust nnoremap <buffer> <leader>rt :Cargo test<cr>
    autocmd FileType rust nnoremap <buffer> <leader>rc :Cargo check<cr>
augroup END
"}}}
" go file settings {{{
augroup FT_go
    au!
    autocmd FileType go let b:mycomment = "//"
    autocmd FileType go let g:go_info_mode = 'guru'
    autocmd FileType go nnoremap <buffer> <leader>r :!go run %<cr>
    autocmd FileType go nnoremap <buffer> <leader>tr :VimuxRunCommand("go run " . expand("%:p"))<cr>
    autocmd FileType go nnoremap <buffer> <leader>tt :VimuxRunCommand("go test")<cr>
    autocmd FileType go nnoremap <buffer> <leader>gi :GoImports<cr>
    autocmd FileType go nnoremap <buffer> <leader>gt :GoTest<cr>
    autocmd FileType go nnoremap <buffer> <leader>lb :GoBuild<cr>
    autocmd FileType go nnoremap <buffer> <leader>li :GoInfo<cr>
    autocmd FileType go nnoremap <buffer> <leader>ld :GoDescribe<cr>
    autocmd FileType go nnoremap <buffer> <leader>le :GoCallees<cr>
    autocmd FileType go nnoremap <buffer> <leader>la :GoCallers<cr>
    autocmd FileType go nnoremap <buffer> <leader>lv :GoVet<cr>
    autocmd FileType go nnoremap <buffer> <leader>ls :GoDecls<cr>
    autocmd FileType go nnoremap <buffer> <leader>e :!./%<
    autocmd FileType go nnoremap <buffer> K :GoDoc<cr>
    autocmd FileType go nnoremap <buffer> <leader>f :GoFmt<cr>
    autocmd Filetype go setlocal noexpandtab
    autocmd FileType godoc nnoremap <buffer> K :GoDoc<cr>
augroup END
"}}}
" sh file settings {{{
augroup FT_sh
    au!
    autocmd FileType sh let b:mycomment = "#"
    autocmd Filetype sh nnoremap <buffer> <leader>r :!sh %<cr>
augroup END
" }}}
" R file settings {{{
augroup FT_R
    au!
    autocmd FileType r let b:mycomment = "#"
    autocmd FileType r nnoremap <buffer> <leader>r :!Rscript %<cr>
    autocmd FileType r nnoremap <buffer> <leader>in :!R<cr>
    autocmd FileType r nnoremap <buffer> <leader>sp :!xdg-open Rplots.pdf<cr>
augroup END
" }}}
" Vimscript file settings {{{
augroup FT_vim
    au!
    autocmd FileType vim let b:mycomment = "\""
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
" Perl file settings {{{
augroup FT_perl
    au!
    autocmd FileType perl let b:mycomment = "#"
    autocmd FileType perl nnoremap <buffer> <leader>r :!perl %<cr>
augroup END
" }}}
" asm file settings {{{
augroup FT_asm
    au!
    autocmd Bufread *.asm set filetype=nasm
augroup END
" }}}
" Makefile settings {{{
augroup FT_make
    au!
    autocmd FileType make let b:mycomment = "#"
    autocmd Filetype make setlocal noexpandtab
augroup END
"}}}
" Octave (Matlab) settings {{{
augroup FT_matlab
    au!
    autocmd Filetype octave let b:mycomment = "%"
    autocmd FileType octave nnoremap <buffer> <leader>f <nop>
    autocmd FileType octave nnoremap <buffer> <leader>tr :VimuxRunCommand("cd('" . expand("%:p:h") . "');" .   "source('" . expand("%:p") . "')")<cr>
    autocmd BufEnter *.m    compiler mlint
augroup END
" }}}
" LaTeX settings {{{
augroup FT_LaTeX
    au!
    autocmd FileType plaintex set ft = "tex"
    autocmd FileType tex let b:mycomment = "%"
    autocmd Filetype tex setlocal textwidth=79
    autocmd Filetype tex setlocal noautoindent
    autocmd Filetype tex setlocal spell spelllang=en
    autocmd Filetype tex nnoremap <buffer> <leader>f <nop>
    autocmd Filetype tex vnoremap <buffer> <leader>f gq
    autocmd Filetype tex nnoremap <buffer> <leader>r :!pdflatex %<cr>
    autocmd Filetype tex nnoremap <buffer> <leader>s :execute '!gnome-open ' . expand('%<') . '.pdf'<cr>
    autocmd Filetype tex nnoremap <buffer> <leader>l :!texcount -inc %<cr>
augroup END
let g:Tex_FoldedSections = ""
"}}}
" json file settings {{{
augroup FT_json
    au!
    au FileType json setlocal equalprg=python3\ -m\ json.tool
augroup END
"}}}
" xml based file settings {{{
augroup FT_xml
    au!
    autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 3>/dev/null
    " autocmd FileType html setlocal equalprg=tidy -i -
augroup END
" }}}
" Other settings {{{
augroup Other
    au!
    autocmd BufRead ~/.tmux/* set ft=tmux
augroup END
" }}}

" plugin settings {{{

" vundle {{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Bundle 'VundleVim/Vundle.vim'
" Bundle 'Blackrush/vim-gocode'

" The bundles you install will be listed here
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'timonv/vim-cargo'
Plugin 'majutsushi/tagbar'
Plugin 'vim-syntastic/syntastic'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'fatih/vim-go'
Plugin 'benmills/vimux'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'
Plugin 'Valloric/YouCompleteMe'
Plugin 'KabbAmine/zeavim.vim'

call vundle#end()
filetype plugin indent on

" The rest of your config follows here
" }}}
" Python plugins (python-mode){{{
" SETTINGS DESCIRPTION {{{
" install <requires vundle>
" Bundle 'klen/python-mode'
" BundleInstall

" ===SETTINGS===
" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
" }}}
let g:pymode = 1
let g:pymode_warnings = 0
let g:pymode_syntax = 0
let g:pymode_doc = 1
let g:pymode_options_colorcolumn = 0
let g:pymode_motion = 1
let g:pymode_virtualenv = 1
let g:pymode_lint_on_write = 0
let g:pymode_breakpoint = 0
let g:pymode_folding = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_run = 0
let g:pymode_lint = 1

let g:pymode_python = 'python'

let g:pymode_doc_key = 'K'

let g:pymode_quickfix_maxheight = 3

let g:pymode_lint_checker = "pyflakes,pep8"


let g:pymode_breakpoint_bind = '<leader>b'

" Don't autofold code

" }}}
" Go Plugins (vim-go) {{{

let g:go_fmt_autosave = 0

" }}}
" UltiSnip {{{
let g:UltiSnipsJumpForwardTrigger='<c-l>'
let g:UltiSnipsJumpBackwardTrigger='<c-h>'
let g:UltiSnipsExpandTrigger='<c-j>'
" }}}

" }}}

" functions {{{
function! MYgorun()

endfunction

function! MYfindmains()
    let buf = MYgetbuffers()
    let res = []
    for b in buf
        if getbufvar(b,"&ft") != "go"
        endif
        echo(bufname(b))
        echo(getbufline(b,1))
        " if getbufline(b,1)[0] == "package main"
            " :call add(res, b)
        " endif
    endfor
    return res
endfunction

function! MYgetbuffers()
    let buf = []
    let last = bufnr("$")
    let first = 1
    for i in range(first,last)
        if buflisted(i) != 0
            :call add(buf,i)
        endif
    endfor
    return buf
endfunction

"}}}

