if exists("g:loaded_jsxcomments")
    finish
endif
let g:loaded_jsxcomments = 1
lua require("jsxcomments")
