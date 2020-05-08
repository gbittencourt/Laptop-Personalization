" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.
"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.
 
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
 
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
 
" Enable syntax highlighting
syntax on
 
 
"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.
 
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden
 
" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall
 
" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
 
 
"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.
 
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" Enable use of the mouse for all modes
" set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
 
" Display hybrid line numbers on the left
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinEnter   * if &nu | set nornu | endif
augroup END
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
 
" Nice colors from mozao
colorscheme slate 

" Show file name at the top
set title

" Correction based on english dictionary
"set spell 

" Enable 'set listchars'
set list

" Set the representation of whatever key I want
set listchars=tab:\|\ 

" Display vertical and horizontal lines over cursor
set cursorcolumn 
set cursorline 

" Try to keep a margin from the cursor to the file top and bottom:
set scrolloff=10

" Display width limit at specified number of columns.
set colorcolumn=80
"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.
 
" How many columns a tab counts for. Affect how existing text will be
" displayed.
set tabstop=4

" expandtab: When hitting TAB in insert mode, automatically produces the 
" appropriate number of spaces set in tabstop.
set noexpandtab

" How many columns text is indented with the reindent operations (<< and >>).
set shiftwidth=4

" When expandtab is set, vim will ignore this, and use tabstop value. When is
" not set, if softtabstop is less than tabstop, vim will use a combination of
" tabs and spaces to make up the desired spacing. When softtabstop equals
" tabstop, vim will use only tabs.
set softtabstop=4

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

"==============================================================================
"==============================================================================
"===================  __               ___             __  ====================
"=================== |  \ |    |    | /   \  * |\  |  /  \ ====================
"=================== |__/ |    |    | |  ___ | | \ |  \__  ====================
"=================== |    |    |    | |   |  | |  \|     \ ====================
"=================== |    |___  \__/  \___/  | |   \   __/ ====================
"==============================================================================
"==============================================================================

"------------------------------- Vim-plug -------------------------------------
" Automatically install Vim-plug (if notalready installed):
if empty(glob('~/.vim/autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

" Enter "Plug 'githubUser/repositoryName'", 
" Save this file, re-open vim and run ':PlugInstall'
" Run ':PlugUpgrade' and ':PlugUpdate' whenever you want
" To remove a plugin, remove from this list, save and run ':PlugClean'
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug' "vim-plug itself, to enable its Vim help.
Plug 'jiangmiao/auto-pairs' " Create the closing bracket automatically {}[]()
Plug 'preservim/nerdtree' " Tree explorer
Plug 'scrooloose/syntastic' " Correct syntax error automatically when saving.
Plug 'tpope/vim-surround' " Delete, change, add surroundings easily.
Plug 'tpope/vim-commentary' " Comment stuff out
Plug 'Yggdroot/indentLine' " Visually display indent levels.
Plug 'michaeljsmith/vim-indent-object' " Select a block with same indentation.
Plug 'vim-airline/vim-airline' " Status line (tab line)
Plug 'neoclide/coc.nvim', {'branch':'release'} "Conquer of completion (autocompletion)
call plug#end()

"------------------------------ Syntastic -------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_html_checkers=['validator', 'w3']
let g:syntastic_python_checkers = ['pylint', 'python', 'flake8', 'pyflakes']

"------------------------------ indentLine ------------------------------------
let g:indentLine_color_term = 2
