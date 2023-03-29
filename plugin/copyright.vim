vim9script

# =========================================================
#   Copyright (C) 2023 AllanDowney. All rights reserved.
#
#   File Name       : copyright.vim
#   Author          : Allan Downey<allandowney@126.com>
#   Version         : 0.1
#   Create          : 2023-03-25 11:13
#   Last Modified   : 2023-03-25 14:37
#   Describe        :
#
# =========================================================

if g:->get('loaded_copyright')
	finish
endif

g:loaded_copyright = 1

command -nargs=0 CopyrightUpdate copyright#UpdateCopyright()

if !hasmapto('CopyrightUpdate')
	nnoremap <F4> <Cmd>CopyrightUpdate<CR>
endif

g:file_copyright_name = 'Allan Downey'
g:file_copyright_email = 'allandowney@126.com'
g:file_copyright_company = 'AllanDowney'

# vim: set fdm=indent
