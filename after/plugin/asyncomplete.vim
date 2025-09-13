" Use ALE's function for asyncomplete defaults
" Provide your own overrides here.
au User asyncomplete_setup call asyncomplete#register_source(
\   asyncomplete#sources#ale#get_source_options({
\       'priority': 10,
\   })
\)

