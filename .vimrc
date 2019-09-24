" Made by Adam Abrams
"##################### SETTING ######################
"--- General ----------------------------------------
    set nocompatible
    filetype plugin indent on
    set encoding=utf-8
    set mouse=n
    set background=dark
    set noerrorbells
    set novisualbell
    set ruler
    set fileformats=unix,dos,mac
    set history=200
    set autowrite
    set autoread
    set hidden
    set backspace=2
    set wildmenu
    set wildignore+=tags,.pyc,.swp
    set wildmode=longest,list,full
    set path+=**
    set tags+=./.tags;$HOME
    set shell=/bin/zsh
    set iskeyword-=_

"--- Display ----------------------------------------
    syntax enable
    set lazyredraw
    set showmatch
    set title

"--- Status bar -------------------------------------
    set cmdheight=1
    set laststatus=2

"--- Text Formatting --------------------------------
    let TextWidth = "90"
    execute "set textwidth=".TextWidth
    set wrap
    set linebreak
    set formatoptions+=j
    set formatoptions-=o
    autocmd BufWritePre * %s:\s\+$::e
    autocmd BufNewFile,BufRead * setlocal formatoptions -=o

"-------------------- INDENTING ---------------------
    set shiftround
    set autoindent
    set smartindent
    set smarttab
    let g:TabSize = "4"
    execute "set tabstop=".TabSize
    execute "set shiftwidth=".TabSize

"--- Pseudo-Tabs ------------------------------------
    set softtabstop=0
    set expandtab
    function! GetSpaces()
        return repeat(' ', g:TabSize)
    endfunction
    autocmd BufWritePre * %s:\t:\=GetSpaces():ge

"--- Change Indent ----------------------------------
    function! SetIndentLocal(num)
        let &l:tabstop = a:num
        let &l:shiftwidth = a:num
    endfunction
    function! SetIndent(num)
        let g:TabSize = a:num
        let &tabstop = a:num
        let &shiftwidth = a:num
    endfunction

"--- Searching --------------------------------------
    set ignorecase
    set smartcase
    set incsearch
    set nohlsearch

"--- Numbering --------------------------------------
    set number
    set relativenumber

"--- Spelling ---------------------------------------
    set spelllang=en_us
    set spellfile=~/.vim/spell/en.utf-8.add

"--- Completion -------------------------------------
    set complete-=i
    set complete+=.,w,b,u,t,k,kspell
    " set omnifunc=syntaxcomplete#Complete

"--- Folding ----------------------------------------
    set foldenable
    set foldmethod=indent
    set foldlevelstart=99
    set foldnestmax=3

"--- Scrolling --------------------------------------
    set scrolloff=2
    set sidescrolloff=5
    set display+=lastline

"--- Timing Out -------------------------------------
    set timeoutlen=1200
    set ttimeout
    set ttimeoutlen=50

"--- NeoVim ---------------------------------------
    if has("nvim")
        set inccommand=split
        autocmd TermOpen * setlocal nonu nornu
        autocmd TermOpen * IndentLinesDisable
    endif

"################### REMAPPINGS #####################
"--- Should-Be-Defaults -----------------------------
    nnoremap <S-Y> y$
    tnoremap <C-\> <C-\><C-N>
    inoremap <C-V> <C-O>:set paste<CR><C-V><C-O>:set nopaste<CR>
    cnoremap w!!   w !sudo tee > /dev/null %
    cnoremap hh    vert help

"--- Tabbing ----------------------------------------
    function! CleverTab()
        if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
            return "\<Tab>"
        else
            return "\<C-P>"
        endif
    endfunction
    " ^tab when left of cursor blank, else autocomplete

    inoremap <silent> <Tab>         <C-R>=CleverTab()<CR>
    inoremap          <S-Tab>       <C-N>

"--- Splits -----------------------------------------
    nnoremap <C-H> <C-W>h
    nnoremap <C-J> <C-W>j
    nnoremap <C-K> <C-W>k
    nnoremap <C-L> <C-W>l
    tnoremap <C-H> <C-\><C-N><C-W>h
    tnoremap <C-L> <C-\><C-N><C-W>l
    " tnoremap <C-J> <C-\><C-N><C-W>j
    " tnoremap <C-K> <C-\><C-N><C-W>k

"--- Buffers ----------------------------------------
    nnoremap <C-N> :bn<CR>
    nnoremap <C-P> :bp<CR>
    tnoremap <C-N> <C-\><C-N>:bn<CR>
    tnoremap <C-P> <C-\><C-N>:bp<CR>

"### G-Motions ######################################
"--- Black Hole -------------------------------------
    nnoremap gd "_d

"--- Special Mark -----------------------------------
    nnoremap gm /<++><CR>cf>

"--- System Clipboard -------------------------------
    nnoremap gy "+y
    nnoremap gp :set paste<CR>"+p:set nopaste<CR>

"--- Commenting -------------------------------------
    nmap gc gc

"--- Alignment --------------------------------------
    nnoremap ga :Tabularize /
    vnoremap ga :Tabularize /

"--- Surrond ----------------------------------------
    nmap gsc     cs
    nmap gsd     ds
    nmap gss     ys
    nmap gs<S-C> cS
    nmap gs<S-D> dS
    nmap gs<S-S> yS

"### Leader Keys ####################################
    let mapleader = "'"
    nnoremap <Leader><Leader> '
    inoremap <Leader><Leader> '

"------------------- INSERT MODE --------------------
"--- Autocomplete -----------------------------------
    inoremap <Leader>f <C-X><C-F>
    inoremap <Leader>l <C-X><C-L>
    inoremap <Leader>o <C-X><C-O>
    " <C-X><C-P> block complete (hit repeatedly: fuzzy line complete)
    inoremap <Leader>b <C-X><C-P>
    inoremap <C-B>     <C-X><C-P>

"--- Matching ---------------------------------------
    inoremap <Leader>[ <CR>}<C-O><S-O><Tab>
    inoremap <Leader>] <CR>},<C-O><S-O><Tab>

"--- Special Mark -----------------------------------
    inoremap <Leader>mm <Esc>/<++><CR>cf>
    inoremap <Leader>mi <++>

"--- Insert Tab -------------------------------------
    execute "inoremap <Leader><Tab> <Esc>".TabSize."a<Space><Esc>a"

"------------------- NORMAL MODE --------------------
"--- Extra Register ---------------------------------
    nnoremap <Leader>ry "Ey
    nnoremap <Leader>rd "Ed
    nnoremap <Leader>re :call setreg('e', [])<CR>
    nnoremap <Leader>pa a<C-R>e<ESC>kJx
    nnoremap <Leader>pi i<C-R>e<ESC>kJx
    nnoremap <Leader>pp "ep

"--- Toggle -----------------------------------------
    nnoremap <silent> <Leader>h  :set hlsearch!<CR>
    nnoremap <silent> <Leader>l  :IndentLinesToggle<CR>
    nnoremap <silent> <Leader>n  :setlocal nu! rnu!<CR>
    nnoremap <silent> <Leader>ft :setlocal formatoptions+=a spell<CR>
    nnoremap <silent> <Leader>ff :setlocal formatoptions-=a nospell<CR>
    nnoremap          <Leader>wt :setlocal textwidth=0<CR>
    execute "nnoremap <Leader>wf :setlocal textwidth=".TextWidth."<CR>"

"--- Indenting --------------------------------------
    nnoremap <Leader>ii :call SetIndent()<Left>
    nnoremap <Leader>il :call SetIndentLocal()<Left>

"--- ALE Linting ------------------------------------
    nnoremap <silent> <Leader>aa :ALENext<CR>
    nnoremap <silent> <Leader>ag :ALEFirst<CR>
    nnoremap <silent> <Leader>an :ALENextWrap<CR>
    nnoremap <silent> <Leader>ap :ALEPreviousWrap<CR>
    nnoremap <silent> <Leader>ao :lopen<CR>
    nnoremap <silent> <Leader>ac :lclose<CR>
    nnoremap <silent> <Leader>af :ALEFix<CR>
    nnoremap <silent> <Leader>a8 :e ~/.config/flake8<CR>
    let g:ale_fixers = {'python': ['black'], 'vue': ['prettier'], 'javascript': ['prettier']}

"### LocalLeader ####################################
    let maplocalleader = "\<Space>"

"--- Scrolling --------------------------------------
    nnoremap <LocalLeader>j 5j
    nnoremap <LocalLeader>k 5k

"--- Splits -----------------------------------------
    nnoremap <silent> <LocalLeader>t :term<CR>a
    nnoremap <silent> <LocalLeader>v :vsp<CR><C-W>l:bn<CR>
    nnoremap <silent> <LocalLeader>= :exe "vertical resize " . (winwidth(0) * 6/5)<CR>
    nnoremap <silent> <LocalLeader>- :exe "vertical resize " . (winwidth(0) * 4/5)<CR>

"--- Substitute -------------------------------------
    nnoremap <LocalLeader>s :%s:

"--- FZF --------------------------------------------
    let g:fzf_layout = { 'down': '~60%' }

    command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    command! -bang -nargs=? GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

    nnoremap <silent> <LocalLeader><LocalLeader> :Buffers<CR>
    nnoremap <silent> <LocalLeader>b             :BLines<CR>
    nnoremap <silent> <LocalLeader>c             :GFiles?<CR>
    nnoremap <silent> <LocalLeader>f             :Files<CR>
    nnoremap <silent> <LocalLeader>g             :GFiles<CR>
    nnoremap <silent> <LocalLeader>hh            :History<CR>
    nnoremap <silent> <LocalLeader>h:            :History:<CR>
    nnoremap <silent> <LocalLeader>l             :Lines<CR>
    nnoremap <silent> <LocalLeader>m             :Maps<CR>
    nnoremap <silent> <LocalLeader>r             :Rg<CR>
    nnoremap          <LocalLeader>~             :Files ~
    nnoremap <silent> <LocalLeader>:             :Commands<CR>
    nnoremap <silent> <LocalLeader>?             :Helptags<CR>

"###################### THEME #######################
    set t_Co=256
    try
        colorscheme solarized
    catch
    endtry

    hi StatusLine ctermbg=Black ctermfg=LightBlue
    hi StatusLineNC ctermbg=Black ctermfg=Blue
    hi User1 ctermbg=Black ctermfg=Magenta
    hi User2 ctermbg=Black ctermfg=Red
    hi User3 ctermbg=Black ctermfg=LightBlue
    set statusline=%3*%.60f
    set statusline+=%2*%M
    set statusline+=%1*\ B:
    set statusline+=%2*%n%*
    set statusline+=%1*%=
    set statusline+=\ [L:%l/%L\ C:%v\ D:%b\ H:%B]%<

