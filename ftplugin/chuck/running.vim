if !exists("g:chuck_command")
    let g:chuck_command = "chuck"
endif

function! ChuckStatus()
  call jobstart(g:chuck_command.' ^')
endfunction

function! ChuckAddShred()
  call jobstart(g:chuck_command.' + '.expand('%'))
endfunction

function! ChuckRemoveShred()
  let a:shred = input('Shred(s) to remove: ')
  call jobstart(g:chuck_command.' - '.a:shred)
  redraw
endfunction

function! ChuckClearShreds()
  call jobstart('chuck --remove.all')
endfunction

" TODO: Write a shred replace function.
" It should take a shred number and replace it with
" the current buffer.
" If ChucK allows replacing multiple shreds with a
" single shred, the replace function should allow
" that as well.
