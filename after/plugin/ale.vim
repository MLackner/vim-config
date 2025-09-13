" =============================================================================
" ALE FIXER AND LINTER SETUP
" =============================================================================

let g:ale_linters_explicit = 1    " Run only explicitly configured linters
let g:ale_floating_preview = 1    " Show the hover information in a floating window
let g:ale_completion_enabled = 1  " Enable ALE's own autocompletion
if g:ale_completion_enabled
    set nopaste                   " ALE conflicts with `set paste`
endif

let g:ale_fixers = {}
let g:ale_linters = {}

" PYTHON: Black Formatter | ISort Import Sorting
let g:ale_fixers.python = ['isort', 'black']
let g:ale_python_black_executable = 'python'
let g:ale_python_black_options = '-m black'
let g:ale_python_black_use_global = 1
let g:ale_python_isort_executable = 'python'
let g:ale_python_isort_options = '-m isort'
let g:ale_python_isort_use_global = 1

" PYTHON: Pylint Linter
let g:ale_linters.python = ['pyright']
let g:ale_python_mypy_executable = 'python'
let g:ale_python_mypy_options = '-m mypy'
let g:ale_python_mypy_use_global = 1
let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_python_pylint_executable = 'python'
let g:ale_python_pylint_options = '-m pylint'
let g:ale_python_pylint_use_global = 1
let g:ale_python_pyright_executable = expand('~/.vim/pyright-langserver')
let g:ale_python_pyright_options = ''
let g:ale_python_pyright_use_global = 1

" Set the floating window border style
let g:ale_floating_window_border = ['│', '─', '┌', '┐', '┘', '└', '│', '─']

" =============================================================================
" ALE COLORS AND VISUALS
" =============================================================================
let g:ale_set_highlights = 0
