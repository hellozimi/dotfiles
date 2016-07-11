" Set up CtrlP mappings
let g:ctrlp_map="<c-p>"
let g:ctrlp_cmd="CtrlP"
let g:ctrlp_custom_ignore = 'venv\|node_modules\|DS_Store\|*.pyc' " custom ignore

" Gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_diff_args = '-w'
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = ':'

hi clear SignColumn
hi GitGutterAdd ctermfg=green guifg=darkgreen
hi GitGutterChange ctermfg=yellow guifg=darkyellow
hi GitGutterDelete ctermfg=red guifg=darkred
hi GitGutterChangeDelete ctermfg=yellow guifg=darkyellow

" Airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#virtualenv#enabled=1
let g:Powerline_symbols = 'fancy'
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#left_alt_sep='|'

" NERDTreeIgnore
let NERDTreeIgnore=['.*\.pyc$', '^\.git$', '^\.$', '^\.\.$', '^\.sass-cache$', '^__pycache__$']

let python_highlight_all=1

py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

