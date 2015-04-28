" pants.vim - Pants build integration for Vim
" Maintainer:   Eugene Ma <http://github.com/edma2/>
" Version:      0.1

command! -nargs=* -complete=file Pants call pants#Pants(<f-args>)

augroup junit
  autocmd!
  autocmd BufRead,BufNewFile *Test.scala,*Spec.scala command! -buffer Junit :Pants test.junit . --no-suppress-output --test=%:p
augroup END
