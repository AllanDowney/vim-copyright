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

if !exists('g:file_copyright_name')
	# g:file_copyright_name = 'Allan Downey'
	g:file_copyright_name = 'Set g:file_copyright_name in $MYVIMRC'
endif

if !exists('g:file_copyright_email')
	g:file_copyright_email = 'Set g:file_copyright_email in $MYVIMRC'
endif

if !exists('g:file_copyright_company')
	g:file_copyright_company = 'Set g:file_copyright_company in $MYVIMRC'
endif

# vim: set fdm=indent
