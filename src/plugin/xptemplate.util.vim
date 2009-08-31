if exists("g:__XPTEMPLATE_UTIL_VIM__")
  finish
endif
let g:__XPTEMPLATE_UTIL_VIM__ = 1


runtime plugin/debug.vim


let s:log = CreateLogger( 'debug' )
" let s:log = CreateLogger( 'warn' )



com! XPTutilGetSID let s:sid =  matchstr("<SID>", '\zs\d\+_\ze')
XPTutilGetSID
delc XPTutilGetSID



let s:unescapeHead          = '\v(\\*)\1\\?\V'



fun! g:ClassPrototype(...) "{{{
    let p = {}
    for name in a:000
        let p[ name ] = function( '<SNR>' . s:sid . name )
    endfor

    return p
endfunction "}}}


fun! s:UnescapeChar( str, chars ) "{{{
    " unescape only chars started with several '\' 

    " remove all '\'.
    let chars = substitute( a:chars, '\\', '', 'g' )

    
    let pattern = s:unescapeHead . '\(\[' . escape( chars, '\]-' ) . ']\)'
    call s:log.Log( 'to unescape pattern='.pattern )
    let unescaped = substitute( a:str, pattern, '\1\2', 'g' )
    call s:log.Log( 'unescaped ='.unescaped )
    return unescaped
endfunction "}}}


let g:xptutil =  g:ClassPrototype(
            \    'UnescapeChar', 
            \ )