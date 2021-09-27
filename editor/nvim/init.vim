" Plugins {{{
        call plug#begin("~/.config/nvim/plugged")

        " UI
        Plug 'bluz71/vim-nightfly-guicolors'
        Plug 'altercation/vim-colors-solarized'
        Plug 'joshdick/onedark.vim'
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'hoob3rt/lualine.nvim'
        Plug 'kyazdani42/nvim-web-devicons'
        Plug 'cespare/vim-toml'
        Plug 'lewis6991/gitsigns.nvim'
		Plug 'airblade/vim-rooter'

        " Go Lang
        Plug 'fatih/vim-go'
        Plug 'buoto/gotests-vim'
        Plug 'godoctor/godoctor.vim'

        " Latex
        Plug 'lervag/vimtex'

        " Terraform
        Plug 'hashivim/vim-terraform'

        " Powershell
        " Plug 'PProvost/vim-ps1'

        Plug 'godlygeek/tabular'
        Plug 'tpope/vim-fugitive'
        Plug 'junegunn/gv.vim'

        " File navigation
        Plug 'nvim-lua/popup.nvim'
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'
        Plug 'akinsho/nvim-bufferline.lua'
        Plug 'mcchrish/nnn.vim'

        " Syntactic Language Support
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'dense-analysis/ale'
        call plug#end()

        lua require('lualine').setup()
        lua require('bufferline').setup()
        lua require('gitsigns').setup()
        

" }}}

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF


set termguicolors
"   set background=dark
colorscheme onedark
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
"set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator
set listchars=nbsp:¬,extends:»,precedes:«,trail:• " Show hidden characters

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
function! ResCur()
if line("'\"") <= line("$")
    silent! normal! g`"
    return 1
endif
endfunction

augroup resCur
autocmd!
autocmd BufWinEnter * call ResCur()
augroup END

" Setting up the directories {{{
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif
" }}}

" Add exclusions to mkview and loadview
" eg: *.*, svn-commit.tmp
let g:skipview_files = [
    \ '\[example pattern\]'
    \ ]
" }}}

" Map escape for insert mode
imap jk <Esc>
imap kj <Esc>

" UI {{{
        set tabpagemax=15               " Only show 15 tabs
        set showmode                    " Display the current mode

        set cursorline                  " Highlight current line

        highlight clear SignColumn      " SignColumn should match background
        highlight clear LineNr          " Current line number row will have same background color in relative mode
        "highlight clear CursorLineNr    " Remove highlight color from current line number

        if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                        " Selected characters/lines in visual mode
        endif

        set backspace=indent,eol,start  " Backspace for dummies
        set linespace=0                 " No extra spaces between rows
        set number                      " Line numbers on
        set relativenumber
        set ruler
        set showmatch                   " Show matching brackets/parenthesis
        set incsearch                   " Find as you type search
        set hlsearch                    " Highlight search terms
        set inccommand=split
        set winminheight=0              " Windows can be 0 line high
        set ignorecase                  " Case insensitive search
        set smartcase                   " Case sensitive when uc present
        set wildmenu                    " Show list instead of just completing
        set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
        set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
        set scrolljump=5                " Lines to scroll when cursor leaves screen
        set scrolloff=3                 " Minimum lines to keep above and below cursor
        set foldenable                  " Auto fold code
        set list
        set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" }}}


" Formatting {{{
        set timeout
        set timeoutlen=100
        set encoding=utf8
        set colorcolumn=80,120          " Add vertical lines to columns
        set infercase                   " Case inference search
        set magic                       " For regular expressions turn magic on
        set lazyredraw                  " Don't redraw while executing macros
        set showmatch                   " Show matching pair
        set mat=2

        set noerrorbells
        set novisualbell
        set t_vb=
        set tm=500

        set title
        " set updatetime=100

        set nrformats=octal,hex

        set nowrap                      " Do not wrap long lines
        set autoread
        set autoindent                  " Indent at the same level of the previous line
        set smartindent                 " enable smart indentation
        set shiftwidth=4                " Use indents of 4 spaces
        set expandtab                   " Tabs are spaces, not tabs
        set tabstop=4                   " An indentation every four columns
        set softtabstop=4               " Let backspace delete indent
        set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
        set splitright                  " Puts new vsplit windows to the right of the current
        set splitbelow                  " Puts new split windows to the bottom of the current
        "set matchpairs+=<:>             " Match, to be used with %
        set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

        autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql,coffee,ruby autocmd BufWritePre <buffer> call StripTrailingWhitespace()
        autocmd FileType haskell,puppet,ruby,yml,javascript setlocal expandtab shiftwidth=2 softtabstop=2
        autocmd FileType tex set wrap spell
        autocmd FileType markdown set wrap textwidth=80
" }}}
" Key (re)Mappings {{{
        " Search results centered please
        nnoremap <silent> n nzz
        nnoremap <silent> N Nzz
        nnoremap <silent> * *zz
        nnoremap <silent> # #zz
        nnoremap <silent> g* g*zz

        map <C-J> <C-W>j
        map <C-K> <C-W>k
        map <C-L> <C-W>l
        map <C-H> <C-W>h

        " Move between buffers with Shift + arrow key...
        nnoremap <S-Left> :bprevious<cr>
        nnoremap <S-Right> :bnext<cr>

        " ... but skip the quickfix when navigating
        augroup qf
        autocmd!
        autocmd FileType qf set nobuflisted
        augroup END

        let mapleader = ','
        let maplocalleader = '_'

        " Wrapped lines goes down/up to next row, rather than next line in file.
        noremap j gj
        noremap k gk

        " End/Start of line motion keys act relative to row/wrap width in the
        " presence of `:set wrap`, and relative to line for `:set nowrap`.
        " Default vim behaviour is to act relative to text line in both cases

        " Same for 0, home, end, etc
        function! WrapRelativeMotion(key, ...)
        let vis_sel=""
        if a:0
            let vis_sel="gv"
        endif
        if &wrap
            execute "normal!" vis_sel . "g" . a:key
        else
            execute "normal!" vis_sel . a:key
        endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $      :call WrapRelativeMotion("$")<CR>
        noremap <End>  :call WrapRelativeMotion("$")<CR>
        noremap 0      :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^      :call WrapRelativeMotion("^")<CR>

        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>

        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

        " The following two lines conflict with moving to top and
        " bottom of the screen
        map <S-H> gT
        map <S-L> gt
        " Stupid shift key fixes
        if has("user_commands")
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>
        endif

        cmap Tabe tabe

        " Yank from the cursor to the end of the line, to be consistent with C and D.
        nnoremap Y y$

        " Code folding options
        nmap <leader>f0 :set foldlevel=0<CR>
        nmap <leader>f1 :set foldlevel=1<CR>
        nmap <leader>f2 :set foldlevel=2<CR>
        nmap <leader>f3 :set foldlevel=3<CR>
        nmap <leader>f4 :set foldlevel=4<CR>
        nmap <leader>f5 :set foldlevel=5<CR>
        nmap <leader>f6 :set foldlevel=6<CR>
        nmap <leader>f7 :set foldlevel=7<CR>
        nmap <leader>f8 :set foldlevel=8<CR>
        nmap <leader>f9 :set foldlevel=9<CR>

        " Enable/Disable search highlighting
        nmap <silent> <leader>/ :set invhlsearch<CR>

        " Find merge conflict markers
        map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

        " Shortcuts
        " Change Working Directory to that of the current file
        cmap cwd lcd %:p:h
        cmap cd. lcd %:p:h

        " Visual shifting (does not exit Visual mode)
        vnoremap < <gv
        vnoremap > >gv

        " Allow using the repeat operator with a visual selection (!)
        " http://stackoverflow.com/a/8064607/127816
        vnoremap . :normal .<CR>

        " For when you forget to sudo.. Really Write the file.
        cmap w!! w !sudo tee % >/dev/null

        " Some helpers to edit mode
        " http://vimcasts.org/e/14
        cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
        map <leader>ew :e %%
        map <leader>es :sp %%
        map <leader>ev :vsp %%
        map <leader>et :tabe %%

        " Adjust viewports to the same size
        map <Leader>= <C-w>=

        " Map <Leader>ff to display all lines with keyword under cursor
        " and ask which one to jump to
        nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

        " Easier horizontal scrolling
        map zl zL
        map zh zH

        " Easier formatting
        nnoremap <silent> <leader>q gwip

" }}}
" Coc {{{
        " 'Smart' nevigation
        " Use tab for trigger completion with characters ahead and navigate.
        " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
        " other plugin before putting this into your config.
        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()

        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <c-.> to trigger completion.
        inoremap <silent><expr> <c-.> coc#refresh()

        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
        " position. Coc only does snippet and additional edit on confirm.
        if exists('*complete_info')
          inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        else
          imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        endif

        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " GoTo code navigation.
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use K to show documentation in preview window.
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction

        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Symbol renaming.
        nmap <leader>rn <Plug>(coc-rename)

        " Introduce function text object
        " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
        xmap if <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap if <Plug>(coc-funcobj-i)
        omap af <Plug>(coc-funcobj-a)

        " Use <TAB> for selections ranges.
        nmap <silent> <TAB> <Plug>(coc-range-select)
        xmap <silent> <TAB> <Plug>(coc-range-select)

        " Find symbol of current document.
        nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

        " Search workspace symbols.
        nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

        " Implement methods for trait
        nnoremap <silent> <space>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

        " Show actions available at this location
        nnoremap <silent> <space>a  :CocAction<cr>
" }}}
" Functions {{{

        " Initialize directories {{{
        function! InitializeDirectories()
            let parent = $HOME
            let prefix = 'vim'
            let dir_list = {
                        \ 'backup': 'backupdir',
                        \ 'views': 'viewdir',
                        \ 'swap': 'directory' }

            if has('persistent_undo')
                let dir_list['undo'] = 'undodir'
            endif

            let common_dir = parent . '/.' . prefix

            for [dirname, settingname] in items(dir_list)
                let directory = common_dir . dirname . '/'
                if exists("*mkdir")
                    if !isdirectory(directory)
                        call mkdir(directory)
                    endif
                endif
                if !isdirectory(directory)
                    echo "Warning: Unable to create backup directory: " . directory
                    echo "Try: mkdir -p " . directory
                else
                    let directory = substitute(directory, " ", "\\\\ ", "g")
                    exec "set " . settingname . "=" . directory
                endif
            endfor
        endfunction
        call InitializeDirectories()

        function! StripTrailingWhitespace()
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endfunction
        " }}}
" Misc {{{
        " Automatically rebalance windows on vim resize
        autocmd VimResized * :wincmd =

        " zoom a vim pane, <C-w>= to rebalance
        nnoremap <leader>- :wincmd _<CR>:wincmd \|<CR>
        nnoremap <leader>= :wincmd =<CR>

        let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
                \ 'p:package',
                \ 'i:imports:1',
                \ 'c:constants',
                \ 'v:variables',
                \ 't:types',
                \ 'n:interfaces',
                \ 'w:fields',
                \ 'e:embedded',
                \ 'm:methods',
                \ 'r:constructor',
                \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
                \ 't' : 'ctype',
                \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
                \ 'ctype' : 't',
                \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
        \ }

        noremap <leader><Space> :call StripTrailingWhitespace()<CR>

        let g:multi_cursor_next_key='<C-n>'
        let g:multi_cursor_skip_key='<C-b>'
" }}}

" Plugins {{{
    " nnn {{{
        nnoremap <leader>n NnnPicker
    " }}}
    " Vim-Rooter {{{
        let g:rooter_manual_only = 1
        let g:rooter_targets = '*.go'

    " }}}
    " Vimtex {{{
        let g:vimtex_fold_enabled = 1

    " }}}
    " Telescope {{{
        " Find files using Telescope command-line sugar.
        nnoremap <leader>ff <cmd>Telescope find_files<cr>
        nnoremap <leader>fg <cmd>Telescope live_grep<cr>
        nnoremap <leader>fb <cmd>Telescope buffers<cr>
        nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    " }}}
    " Ale {{{
        let g:ale_sign_error = '✘'
        let g:ale_sign_warning = '⚠'
        highlight ALEErrorSign ctermbg=NONE ctermfg=red
        highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
        let g:ale_linters = {
        \    'javascript': ['eslint'],
        \    'go': ['revive']
        \}
    " }}}

    " GoLang {{{
        let g:go_doc_window_popup_window = 1
        let g:go_highlight_types = 1
        let g:go_highlight_fields = 1
        let g:go_highlight_functions = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_structs = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_build_constraints = 1
        let g:go_highlight_extra_types = 1
        let g:go_fmt_command = "goimports"
        let g:go_snippet_engine = "neosnippet"
        " Show the progress when running :GoCoverage
        let g:go_echo_command_info = 1

        " Show type information
        let g:go_auto_type_info = 1

        " Highlight variable uses
        let g:go_auto_sameids = 1

        " Fix for location list when vim-go is used together with Syntastic
        let g:go_list_type = "quickfix"

        " Add the failing test name to the output of :GoTest
        let g:go_test_show_name = 1

        " gometalinter configuration
        let g:go_metalinter_autosave_enabled = 1
        let g:go_metalinter_command = ""
        let g:go_metalinter_deadline = "5s"
        let g:go_metalinter_enabled = [
            \ 'golangci-lint',
        \]
        let g:go_debug_windows = {
              \ 'vars':       'rightbelow 60vnew',
              \ 'stack':      'rightbelow 10new',
        \ }


        " Set whether the JSON tags should be snakecase or camelcase.
        let g:go_addtags_transform = "camelcase"

        au FileType go set noexpandtab
        au FileType go set shiftwidth=4
        au FileType go set softtabstop=4
        au FileType go set tabstop=4
        au FileType go nmap <Leader>s <Plug>(go-implements)
        au FileType go nmap <Leader>i <Plug>(go-info)
        au FileType go nmap <Leader>e <Plug>(go-rename)
        au FileType go nmap <leader>r <Plug>(go-run)
        au FileType go nmap <leader>b <Plug>(go-build)
        au FileType go nmap <leader>t <Plug>(go-test)
        au FileType go nmap <Leader>gd <Plug>(go-doc)
        au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
        au FileType go nmap <leader>co <Plug>(go-coverage)
        au FileType go nmap <leader>ct <Plug>(go-coverage-toogle)
        au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
        au FileType go nmap <silent><Leader>dt :GoDebugTestFunc<CR>
		au FileType go nmap <leader>ds <Plug>(go-debug-step)
		au FileType go nmap <leader>dq <Plug>(go-debug-stop)
		au FileType go nmap <leader>dn <Plug>(go-debug-next)
		au FileType go nmap <leader>db <Plug>(go-debug-breakpoint)
		au FileType go nmap <leader>do <Plug>(go-debug-stepout)
		au FileType go nmap <leader>dc <Plug>(go-debug-continue)
		au FileType go nmap <F8> <Plug>(go-debug-continue)

        let g:delve_backend = "native"
    " }}}
    " Tabularize {{{
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
        vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
        nmap <Leader>a=> :Tabularize /=><CR>
        vmap <Leader>a=> :Tabularize /=><CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a,, :Tabularize /,\zs<CR>
        vmap <Leader>a,, :Tabularize /,\zs<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }}}
    " Fugitive {{{
        nnoremap <silent> <leader>gs :Git<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Gread<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        " Mnemonic _i_nteractive
        nnoremap <silent> <leader>gg :SignifyToggle<CR>
    " }}}
