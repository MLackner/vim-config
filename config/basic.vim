" =============================================================================
" BASIC SETTINGS
" =============================================================================

set nocompatible            " Disable Vi compatibility mode

" Editor behavior
set number                  " Show line numbers
set relativenumber          " Show relative line numbers
set cursorline              " Highlight current line
set showmatch               " Show matching brackets
set hlsearch                " Highlight search results
set incsearch               " Incremental search while typing
set ignorecase              " Case insensitive search
set smartcase               " Case sensitive if uppercase present
set wildmenu                " Enhanced command completion (`:e <Tab>`)
set wildmode=list:longest,full
set scrolloff=8             " Keep n lines visible when scrolling
set sidescrolloff=16        " Keep n columns visible when scrolling

" Indentation and formatting
set autoindent              " Auto indent new lines
set smartindent             " Smart indent for code
set expandtab               " Use spaces instead of tabs
set tabstop=4               " Defines how many spaces a tab character displays as
set shiftwidth=4            " Number of spaces to use for indentation when shifting (`<<` / `>>`)
set softtabstop=4           " Number of spaces to insert when pressing `<Tab>` in insert mode
set nowrap                  " Do not wrap long lines. Use `set wrap` to wrap long lines.
set linebreak               " Break lines at word boundaries if wrapping is on
set textwidth=80            " Auto wrapping at n characters if wrapping is on

" File handling
set autoread                " Auto reload changed files
set backup                  " Create backup files
set backupdir=~/.vim/.backup " Backup directory
set directory=~/.vim/.swap   " Swap file directory
set undofile                " Persistent undo
set undodir=~/.vim/.undo     " Undo directory

" Create directories if they don't exist
if !isdirectory($HOME."/.vim/.backup")
    call mkdir($HOME."/.vim/.backup", "p", 0700)
endif
if !isdirectory($HOME."/.vim/.swap")
    call mkdir($HOME."/.vim/.swap", "p", 0700)
endif
if !isdirectory($HOME."/.vim/.undo")
    call mkdir($HOME."/.vim/.undo", "p", 0700)
endif

" UI improvements
set laststatus=2                   " Always show status line
set signcolumn=yes                 " Always show the signcolumn. No text moving around which becomes annoying.
set showcmd                        " Show command in status line
set ruler                          " Show cursor position
set backspace=indent,eol,start     " Better backspace behavior
set clipboard=unnamed              " Use system clipboard
set encoding=utf-8                 " UTF-8 encoding
set termencoding=utf-8             " Terminal encoding
set title                          " Set file name in the terminal title
" Disable flashing of screen on error
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


" =============================================================================
" Git Bash Windows Path Fix for Vim + ALE + LSP
" =============================================================================
" Problem: When using Vim in Git Bash on Windows with ALE's LSP features
" (like :ALEGoToTypeDefinition), paths returned by language servers contain
" malformed Windows-style paths like "/c:/Users/..." instead of the proper
" Git Bash format "/c/Users/...". This causes two issues:
"   1. Files fail to open (shown as [New DIRECTORY])
"   2. Malformed paths pollute the jump list, breaking Ctrl-O navigation
"
" Solution: This autocmd intercepts attempts to open malformed paths, fixes
" the path format, opens the correct file, and cleans up jump list entries
" that contain the malformed paths.
"
" Compatibility: Git Bash (MSYS2), Windows with unix-like environment
" Dependencies: ALE plugin with LSP support
" =============================================================================
if has('win32unix') || exists('$MSYSTEM')
    function! s:FixPathAndOpen()
        let l:fixed_path = substitute(expand('<afile>'), '^/c:', '/c', '')

        " Open the fixed path
        execute 'edit' l:fixed_path

        " Force filetype detection
        filetype detect

        " Clean malformed jumps after a short delay to let everything settle
        call timer_start(100, function('s:CleanMalformedJumps'))
    endfunction

    function! s:CleanMalformedJumps(timer_id)
        try
            let l:jumps = getjumplist()
            let l:jumplist = l:jumps[0]

            " Only proceed if we have malformed entries
            let l:has_malformed = 0
            for l:jump in l:jumplist
                let l:bufname = bufname(l:jump.bufnr)
                if l:bufname =~ '^/c:/'
                    let l:has_malformed = 1
                    break
                endif
            endfor

            if !l:has_malformed
                return
            endif

            " Store current position
            let l:current_buf = bufnr('%')
            let l:current_pos = getpos('.')

            " Clear and rebuild jump list
            clearjumps

            " Re-add only valid entries
            for l:jump in reverse(copy(l:jumplist))
                let l:bufname = bufname(l:jump.bufnr)
                if l:bufname !~ '^/c:/' && bufexists(l:jump.bufnr)
                    try
                        execute 'keepjumps buffer' l:jump.bufnr
                        call setpos('.', [l:jump.bufnr, l:jump.lnum, l:jump.col + 1, 0])
                        " Force a jump entry
                        normal! m'
                    catch
                        " Skip invalid buffers
                    endtry
                endif
            endfor

            " Return to original position
            execute 'keepjumps buffer' l:current_buf
            call setpos('.', l:current_pos)

        catch
            " Silently ignore any errors in cleanup
        endtry
    endfunction

    autocmd BufReadCmd /c:/* call s:FixPathAndOpen()
endif

