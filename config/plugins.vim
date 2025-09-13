" =============================================================================
" PLUGIN MANAGEMENT (vim-plug)
" =============================================================================

" Auto-install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Turn off filetype detection temporarily as recommended by vim-plug.
filetype off                        

call plug#begin('~/.vim/plugged')

" Essential plugins that work in restricted environments
Plug 'tpope/vim-sensible'           " Sensible defaults
Plug 'tpope/vim-commentary'         " Easy commenting
Plug 'tpope/vim-surround'           " Surround text objects
Plug 'tpope/vim-repeat'             " Better repeat functionality
Plug 'tpope/vim-unimpaired'         " Handy bracket mappings

" File and project navigation
Plug 'preservim/nerdtree'           " File tree explorer
Plug 'ctrlpvim/ctrlp.vim'           " Fuzzy file finder
Plug 'MLackner/ctrlsf.vim'          " Search tool that works with egrep

" Fixing, linting, hover, and auto completion
Plug 'dense-analysis/ale'               " Driving fixing, lintink and autocompletion
Plug 'prabirshrestha/asyncomplete.vim'  " Autocompletion
Plug 'andreypopp/asyncomplete-ale.vim'  " For integration with ALE

" Python-specific plugins
Plug 'vim-python/python-syntax'     " Enhanced Python syntax
Plug 'vim-scripts/indentpython.vim' " Better Python indentation

" General development
Plug 'jiangmiao/auto-pairs'           " Auto close brackets/quotes
Plug 'vim-airline/vim-airline'        " Status line
Plug 'vim-airline/vim-airline-themes' " Status line themes
Plug 'airblade/vim-gitgutter'         " Git diff in gutter
Plug 'tpope/vim-fugitive'             " Git integration

" Syntax highlighting for various file types
Plug 'vim-syntastic/syntastic'     " Syntax checking
Plug 'plasticboy/vim-markdown'     " Better markdown support
Plug 'elzr/vim-json'               " JSON support
Plug 'stephpy/vim-yaml'            " YAML support

" Color Themes
Plug 'catppuccin/vim', { 'as': 'catppuccin' }  " Catppuccin color scheme

call plug#end()

" enable filetype detection again after plugins are handled.
filetype plugin indent on

