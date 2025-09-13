" =============================================================================
" CUSTOM KEY MAPPINGS
" =============================================================================

" Set leader key
let mapleader = " "

" Clear search highlighting
nnoremap <leader>/ :nohlsearch<CR>

" Better window navigation
nnoremap <leader>w <C-w>

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Toggle paste mode
nnoremap <leader>p :set paste!<CR>

" Python-specific mappings
nnoremap <leader>r :w<CR>:!python %<CR>
nnoremap <leader>m :w<CR>:!python -m
nnoremap <leader>t :w<CR>:!python -m pytest %<CR>

" Git mappings (using vim-fugitive)
nnoremap <leader>Gs :Gstatus<CR>
nnoremap <leader>Gc :Gcommit<CR>
nnoremap <leader>Gd :Gdiff<CR>

" Quick edit vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR> :echo "Sourced: " . $MYVIMRC<CR>

" ALE specific mappings for linting/fixing/code completion
nnoremap K :ALEHover<CR>
nnoremap <leader>F :ALEFix<CR>
nnoremap <leader>gd <Plug>(ale_go_to_definition)
nnoremap <leader>gD <Plug>(ale_go_to_type_Definition)
nnoremap <leader>gi <Plug>(ale_go_to_implementation)

" Asyncomplete specific settings
inoremap <expr> <C-@> pumvisible() ? asyncomplete#close_popup() : asyncomplete#force_refresh()
" Accept completion and close popup with Enter, or just newline if popup not visible
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"
" Cancel the autocomplete
inoremap <expr> <Esc> pumvisible() ? asyncomplete#cancel_popup() . "\<Esc>" : "\<Esc>"

" NERDTree specific mappings
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>E :NERDTreeExplore<CR>

" CtrlP specific mappings
nnoremap <leader>ff :CtrlP<CR>

" CtrlSF specific mappings
nnoremap <leader>fg :CtrlSF -R 

