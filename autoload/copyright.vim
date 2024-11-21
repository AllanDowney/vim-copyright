vim9script

# ==========================================================
#   Copyright (C) 2023 AllanDowney. All rights reserved.{{{1
#
#   File Name       : copyright.vim
#   Author          : Allan Downey<allandowney@126.com>
#   Version         : 0.1
#   Create          : 2023-03-25 11:23
#   Last Modified   : 2024-11-21 23:56
#   Describe        :
#   }}}1
# ==========================================================

var cr_comment = {
	vim: ['"', 0],
	vim9: ['#', 1],
	sh: ['#', 1],
	shell: ['#', 1],
	zsh: ['#', 1],
	rust: ['//', 0],
	c: ['//', 0],
	h: ['//', 0],
	cpp: ['//', 0]
}

export def UpdateCopyright(): bool
	var flty: string = CheckFiletype()
	if flty == ''
		return v:false
	endif

	var is_update: bool = CheckUpOrAdd()
	var is_succ: bool = false

	execute 'normal ml'
	if is_update
		is_succ = UpCopyright()
	else
		is_succ = AddCopyright(cr_comment[flty][1], cr_comment[flty][0])
	endif

	execute 'normal `l'
	execute 'delmarks l'
	execute 'nohlsearch'

	if is_succ
		execute 'write'
		UpMessage(is_update)
		return v:true
	else
		return v:false
	endif
enddef

def CheckFiletype(): string
	var filetp: string = &ft
	var firstline: string = getline(1)
	if &ft == 'vim' && firstline =~? 'vim9script'
		filetp = 'vim9'
	endif
	return filetp
enddef

def CheckUpOrAdd(): bool
	if match(getline(1, 10), 'Last Modified') > -1
		return v:true
	else
		return v:false
	endif
enddef

def AddCopyright(lline: number, prex: string): bool
	var flty: string = CheckFiletype()
	var startline = lline
	if startline > 0
		append(startline, '')
	else
		startline = -1
	endif
	append(startline + 1, prex ..
		' ===========================================================')
	append(startline + 2, prex ..
		'   Copyright (C) ' .. strftime('%Y') ..
		' ' .. g:file_copyright_company ..
		'. All rights reserved.' ..
		((flty =~ 'vim') ? '{{{1' : ''))
	append(startline + 3, prex)
	append(startline + 4, prex ..
        '   File Name       : ' .. expand('%:t'))
	append(startline + 5, prex ..
		'   Author          : ' .. g:file_copyright_name ..
		'<' .. g:file_copyright_email .. '>')
	append(startline + 6, prex ..
		'   Version         : 0.1')
	append(startline + 7, prex ..
		'   Create          : ' .. strftime('%Y-%m-%d %H:%M'))
	append(startline + 8, prex ..
		'   Last Modified   : ' .. strftime('%Y-%m-%d %H:%M'))
	append(startline + 9, prex ..
		'   Describe        :')
	append(startline + 10, prex ..
		((flty =~ 'vim') ? '   }}}1' : ''))
	append(startline + 11, prex ..
		' ===========================================================')
	append(startline + 12, '')
	return v:true
enddef

def UpCopyright(): bool
	execute ': /File\sName/s@\s\+:\s\zs.*$@\=expand("%:t")@'
	execute ': /Last\sModified/s@\s\+:\s\zs.*@\=strftime("%Y-%m-%d %H:%M")@'
	return v:true
enddef

def UpMessage(update: bool): bool
	echohl Statement
	echo 'Copyright was successfully'
	echohl WarningMsg
	if update
		echon ' UPDATED'
	else
		echon ' ADDED'
	endif
	echohl Statement
	echon '!!!'
	echohl None
	return v:true
enddef

# vim: set fdm=indent
