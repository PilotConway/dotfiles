autocmd Filetype gitcommit setlocal textwidth=72
autocmd Filetype gitcommit setlocal wrap
match ErrorMsg /\%>72v.\+/
