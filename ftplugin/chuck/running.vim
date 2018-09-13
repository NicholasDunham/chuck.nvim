if !exists("g:chuck_command")
    let g:chuck_command = "chuck"
endif

function! ChuckStatus()
  call jobstart(g:chuck_command.' ^')
endfunction

function! ChuckAddShred()
  call jobstart(g:chuck_command.' + '.expand('%'))
endfunction

function! ChuckRemoveShreds()
  let a:shred = input('Shred(s) to remove: ')
  call jobstart(g:chuck_command.' - '.a:shred)
  redraw
endfunction

function! ChuckClearShreds()
  call jobstart('chuck --remove.all')
endfunction

function! ChuckReplaceShred()
  let a:shred = input('Shred to replace: ')
  call jobstart(g:chuck_command.' = '.a:shred.expand('%'))
  redraw
endfunction
