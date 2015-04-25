" pants.vim - Pants build integration for Vim
" Maintainer:   Eugene Ma <http://github.com/edma2/>
" Version:      0.1

function! s:Pants(...)
  let pants = findfile('pants', '.;')
  if strlen(pants) == 0
    echoerr "pants not found"
    return 1
  end
  let pants = fnamemodify(pants, ':p')
  if !executable(pants)
    echoerr pants . " not executable"
    return 1
  end

  execute 'cd' fnameescape(fnamemodify(pants, ':h'))

  let build = findfile('BUILD', '.;')
  let target = fnamemodify(build, ':h')

  let args = ""
  if a:0 == 0
    let goal = "compile"
  elseif a:0 == 1
    let goal = a:1
  else
    let goal = a:1
    let target = substitute(a:2, "\\.", target, "")
    let args = join(a:000[2:])
  endif

  let makeprg_old=&makeprg
  let errorformat_old=&errorformat
  let &makeprg = "./pants --no-colors " . goal . " " . args . " " . target
  let &errorformat = "%E %#[error] %f:%l: %m,%C %#[error] %p^,%-C%.%#,%Z,%-G%.%#"

  try
    if exists("g:loaded_dispatch")
      Make
    else
      make
    endif
  finally
    let &makeprg=makeprg_old
    let &errorformat=errorformat_old
    cd -
  endtry
endfunction

function! s:EditBuild()
  execute "edit" findfile('BUILD', '.;')
endfunction

command! -nargs=* -complete=file Pants call s:Pants(<f-args>)

augroup junit
  autocmd!
  autocmd BufRead,BufNewFile *Test.scala,*Spec.scala command! -buffer Junit :Pants test.junit . --no-suppress-output --test=%:p
augroup END

command! BUILD call s:EditBuild()
