#!/bin/bash

# TODO..

# " Disable compatibility with vi wich can cause unexpected issues
# set nocompatible

# " Enable mouse (might not work without UI)
# set mouse=a

# " Enable syntax highlighting
# syntax on

# " Cursor
# " set cursorline      " Highlight cursor line underneath the cursor horizontally
# " set cursorcolumn    " Highlight cursor line underneath the cursor vertically
# set scrolloff=10    " Do not let cursor scroll below or above N numbers of lines when scrolling

# " Lines
# " set number            " Enable line numbers
# " set numberwidth=2     " Change gutter column width for numbers
# " set cpoptions+=n      " Text wrapping for line numbers
# set nowrap          " Do not wrap lines

# " Toggle comment for the current line or selected lines with CTRL+/
# nnoremap <C-/> I# <Esc>^
# vnoremap <C-/> :s/^#\?/#/<CR>

# " General tab and indentation
# set tabstop=4       " Number of columns that a <Tab> counts for
# set shiftwidth=4    " Number of spaces to use for autoindent
# set autoindent      " Automatically indent the next line
# set expandtab       " Use space characters instead of tabs

# " Backup
# set nobackup        " Do not save backup files

# " History
# set history=1000    " Set the commands to save in history (default number is 20)

# " Search
# set incsearch       " While searching through a file, incrementally highlight matching characters as we type
# set ignorecase      " Ignore capital letters during search
# set smartcase       " Override ignorecase option if searching specifically for capital letters
# set showmatch       " Show matching words during a search
# set hlsearch        " Use highlighting when doing a search

# "
# set showcmd         " Show partial command we type in the last line of the screen
# set showmode        " Show the mode we are on the last line

# " Autocompletion (type :help <command> for more info on specific commands)
# set wildmenu                " Enable auto completion menu after pressing TAB
# set wildmode=list:longest   " Make wildmenu behave similar to Bash completion

# " Filetype-specific settings

# " Ignore files we do not want to edit with Vim
# set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

# " File type detection and plugins
# filetype on         " Enable filetype detection
# filetype plugin on  " Enable plugins and load plugin for the detected file type
# filetype indent on  " Load an indent file for the detected file type

# " YAML settings (.yml files, e.g., docker-compose.yml)
# autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 expandtab
# " autocmd FileType yaml setlocal noautoindent " Disable autoindent
# autocmd FileType yaml setlocal indentexpr=  " Avoid extra indentation on Enter

# " Makefile settings (Makefiles should use tabs, not spaces)
# autocmd FileType make setlocal noexpandtab

# " C and C++ settings (use 4-space tabs instead of spaces)
# autocmd FileType c,cpp setlocal noexpandtab tabstop=4 shiftwidth=4


# " ******************************************************************************

# " *** To make the changes take effect ***
# " Save the .vimrc file      -> :w
# " Source the .vimrc file    -> :source ~/.vimrc
