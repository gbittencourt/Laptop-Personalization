" vim:foldmethod=marker:foldlevel=0

" Basic {{{
	" Ward off unexpected things that your distribution might
	" have made, as well as sanely reset options when re-sourcing .vimrc
	set nocompatible
	
	" Modelines have historically been a source of security vulnerabilities. As
	" such, it may be a good idea to disable them and use the securemodelines
	" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
	set modeline
	set modelines=1
	
	" Stop certain movements from always going to the first character of a line.
	" While this behaviour deviates from that of Vi, it does what most users
	" coming from other editors would expect.
	set nostartofline
	
	" Instead of failing a command because of unsaved changes, instead raise a
	" dialogue asking if you wish to save changed files.
	set confirm
	
	" Use visual bell instead of beeping when doing something wrong
	set visualbell
	
	" And reset the terminal code for the visual bell. If visualbell is set, and
	" this line is also included, vim will neither flash nor beep. If visualbell
	" is unset, this does nothing.
	set t_vb=
	
	" Quickly time out on keycodes, but never time out on mappings
	set notimeout ttimeout ttimeoutlen=100
" }}}
" Display {{{
	" Show partial commands in the bottom right of the screen. 
	set showcmd
	
	" Set the command window height to 2 lines, to avoid many cases of having to
	" 'press <Enter> to continue'
	set cmdheight=2
	
	" Display hybrid line numbers on the left
	set number relativenumber
	augroup numbertoggle
	  autocmd!
	  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu | endif
	  autocmd BufLeave,FocusLost,InsertEnter,WinEnter   * if &nu | set nornu | endif
	augroup END
	
	" Nice colors from mozao
	" colorscheme slate 
	
	" Show file name at the top
	set title
	
	" Enable 'set listchars'
	set list
	
	" Try to always keep the cursor at the middle of the file
	set scrolloff=999
	
	" Display horizontal line over cursor
	set cursorline 
	
	" Indicate width limit at specified number of columns.
	set colorcolumn=80
	
	" Fold automatically based on indentation, for files with more than 10 
	" possible folds, limiting nested folding to 10.
	set foldenable
	set foldlevelstart=10 
	set foldnestmax=10
	set foldmethod=indent
	
" }}}
" Autocompletion and Spelling {{{
	" Attempt to determine the type of a file based on its name and possibly its
	" contents. Use this to allow intelligent auto-indenting for each filetype,
	" and for plugins that are filetype specific.
	filetype indent plugin on
	
	" Enable syntax highlighting
	syntax on
	
	" Visual autocomplete for command menu
	set wildmenu
	
	" Correction based on english dictionary
	"set spell 
" }}}
" Multiple Windows and Tabs {{{
	" Vim with default settings does not allow easy switching between multiple 
	" files in the same editor window. Users can use multiple split windows or 
	" multiple tab pages to edit multiple files, but it is still best to 
	" enable an option to allow easier switching between files.
	
	" One such option is the 'hidden' option, which allows you to re-use the 
	" same window and switch from an unsaved buffer without saving it first. 
	" Also allows you to keep an undo history for multiple files when re-using 
	" the same window in this way. Note that using persistent undo also lets 
	" you undo in multiple files even in the same window, but is less 
	" efficient and is actually designed for keeping undo history after 
	" closing Vim entirely. Vim will complain if you try to quit without saving
	" and swap files will keep you safe if your computer crashes.
	set hidden
	
	" Note that not everyone likes working this way (with the hidden option).
	" Alternatives include using tabs or split windows instead of re-using the 
	" same window as mentioned above, and/or either of the following options:
	" set confirm
	" set autowriteall
" }}}
" Search {{{
	" Highlight searches (use <C-L> to temporarily turn off highlighting)
	set hlsearch
	noremap <C-L> :nohl<CR><C-L>
	
	" Use case insensitive search, except when using capital letters
	set ignorecase
	set smartcase
" }}}
" Indentation {{{
	" When opening a new line and no filetype-specific indenting is enabled, keep
	" the same indent as the line you're currently on. Useful for READMEs, etc.
	set autoindent
	
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

	" Set the representation of whatever key I want
	set listchars=tab:\|\ 
	
" }}}
" Mappings {{{
	" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
	" which is the default
	map Y y$
	
	" Map <C-n> to open NERDTree
	noremap <C-N> :NERDTreeToggle<Enter>
	
	" Map <C-J> to insert empty line below current, analogous to <S-J> 
	nnoremap <C-J> m`o<Esc>0"_D``
	
	" Allow backspacing over autoindent, line breaks and start of insert action
	set backspace=indent,eol,start

	" The following mappings are not working when NERDTree is opened:
		" " Try to always keep the cursor at the middle of the file
		" set lazyredraw " avoid update the screen before command is complete
		" nnoremap <C-B> 22kzz
		" nnoremap <C-U> 11kzz
		" nnoremap H 22kzz
		" nnoremap { {zz
		" nnoremap k kzz
		" nnoremap # #zz
		" nnoremap N Nzz
		" nnoremap j jzz
		" nnoremap } }zz
		" nnoremap L 22jzz
		" nnoremap <C-D> 11jzz
		" " nnoremap <C-F> 22jzz " This is mapped to the fzf plugin
		" nnoremap n nzz
		" nnoremap * *zz
		" nnoremap G Gzz
		" nnoremap '. '.zz
		" nnoremap '' ''zz
		" nnoremap % %zz
		" nnoremap dd ddzz
" }}}
" Plugins {{{
	" vim-plug {{{
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
		Plug 'junegunn/vim-plug' " Vim-plug itself, to enable its Vim help.
		Plug 'morhetz/gruvbox' " Beautiful colors =]
		Plug 'jiangmiao/auto-pairs' " Create the closing bracket automatically {}[]()
		Plug 'preservim/nerdtree' " Tree explorer
		" Plug 'scrooloose/syntastic' " Correct syntax error automatically when saving.
		Plug 'tpope/vim-surround' " Delete, change, add surroundings easily.
		Plug 'tpope/vim-commentary' " Comment stuff out
		Plug 'Yggdroot/indentLine' " Visually display indent levels.
		Plug 'michaeljsmith/vim-indent-object' " Select a block with same indentation.
		Plug 'vim-airline/vim-airline' " Status line (tab line)
		Plug 'neoclide/coc.nvim', {'branch':'release'} " Conquer of Completion
		Plug 'tpope/vim-fugitive' " Use git inside vim!
		Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Command-line fuzzy finder
		Plug 'junegunn/fzf.vim'
		Plug 'ryanoasis/vim-devicons' " Icons for NERDTree.
		Plug 'airblade/vim-gitgutter' " Shows git diff markers in the sign column.
		call plug#end()
	" }}}
	" gruvbox {{{
		" Correct colors due to xfce terminal
		set termguicolors
		let g:gruvbox_contrast_dark='hard'
		set background=dark
		colorscheme gruvbox
		" }}}
	" " syntastic {{{
	" 	set statusline+=%#warningmsg#
	" 	set statusline+=%{SyntasticStatuslineFlag()}
	" 	set statusline+=%*
	" 	let g:syntastic_always_populate_loc_list = 1
	" 	let g:syntastic_auto_loc_list = 1
	" 	let g:syntastic_check_on_open = 1
	" 	let g:syntastic_check_on_wq = 1
	" 	let g:syntastic_html_checkers=['validator', 'w3']
	" 	let g:syntastic_python_checkers = ['pylint', 'python', 'flake8', 'pyflakes']
	" " }}}
	" indentLine {{{
		let g:indentLine_color_term = 2
	" }}}
	" Conquers of Completion (CoC) {{{ 
		" I had to manually install each CoC extension using 'npm install <extension>'
		"	npm install coc-tsserver (for javascript and typescript)
		"	npm install coc-vimlsp (for vim language)
		"	npm install coc-eslint (lint javascript files)
		"	npm install coc-spell-checker
		"	npm install coc-snippets (create custom snippets to insert patterns)
		"	npm install coc-python 
		"	npm install coc-markdownlint
		"	npm install coc-json
		"	npm install coc-html
		"	npm install coc-css (for css, scss and less)
		"	npm install coc-clangd (for C/C++/Objective-C)

		" Some servers have issues with backup files, see #649.
		set nobackup
		set nowritebackup

		" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
		" delays and poor user experience.
		set updatetime=300

		" Don't pass messages to |ins-completion-menu|.
		set shortmess+=c

		" Always show the signcolumn, otherwise it would shift the text each time
		" diagnostics appear/become resolved.
		set signcolumn=yes

		" Use tab for trigger completion with characters ahead and navigate.
		" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
		" other plugin before putting this into your config.
		inoremap <silent><expr> <TAB>
			  \ pumvisible() ? "\<C-n>" :
			  \ <SID>check_back_space() ? "\<TAB>" :
			  \ coc#refresh()
		inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

		function! s:check_back_space() abort
		  let col = col('.') - 1
		  return !col || getline('.')[col - 1]  =~# '\s'
		endfunction

		" Use <c-space> to trigger completion. NOT WORKING!!!!!!!!!!!!!!!!!!!!
		inoremap <silent><expr> <c-space> coc#refresh()

		" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
		" position. Coc only does snippet and additional edit on confirm.
		" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
		if exists('*complete_info')
		  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
		else
		  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
		endif

		" Use `[g` and `]g` to navigate diagnostics
		nmap <silent> [g <Plug>(coc-diagnostic-prev)
		nmap <silent> ]g <Plug>(coc-diagnostic-next)

		" GoTo code navigation.
		nmap <silent> gd <Plug>(coc-definition)
		nmap <silent> gy <Plug>(coc-type-definition)
		nmap <silent> gi <Plug>(coc-implementation)
		nmap <silent> gr <Plug>(coc-references)

		" Use K to show documentation in preview window.
		nnoremap <silent> K :call <SID>show_documentation()<CR>

		function! s:show_documentation()
		  if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		  else
			call CocAction('doHover')
		  endif
		endfunction

		" Highlight the symbol and its references when holding the cursor.
		autocmd CursorHold * silent call CocActionAsync('highlight')

		" Symbol renaming.
		nmap <leader>rn <Plug>(coc-rename)

		" Formatting selected code.
		xmap <leader>f  <Plug>(coc-format-selected)
		nmap <leader>f  <Plug>(coc-format-selected)

		augroup mygroup
		  autocmd!
		  " Setup formatexpr specified filetype(s).
		  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		  " Update signature help on jump placeholder.
		  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
		augroup end

		" Applying codeAction to the selected region.
		" Example: `<leader>aap` for current paragraph
		xmap <leader>a  <Plug>(coc-codeaction-selected)
		nmap <leader>a  <Plug>(coc-codeaction-selected)

		" Remap keys for applying codeAction to the current line.
		nmap <leader>ac  <Plug>(coc-codeaction)
		" Apply AutoFix to problem on the current line.
		nmap <leader>qf  <Plug>(coc-fix-current)

		" Introduce function text object
		" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
		xmap if <Plug>(coc-funcobj-i)
		xmap af <Plug>(coc-funcobj-a)
		omap if <Plug>(coc-funcobj-i)
		omap af <Plug>(coc-funcobj-a)

		" Use <TAB> for selections ranges.
		" NOTE: Requires 'textDocument/selectionRange' support from the language server.
		" coc-tsserver, coc-python are the examples of servers that support it.
		nmap <silent> <TAB> <Plug>(coc-range-select)
		xmap <silent> <TAB> <Plug>(coc-range-select)

		" Add `:Format` command to format current buffer.
		command! -nargs=0 Format :call CocAction('format')

		" Add `:Fold` command to fold current buffer.
		command! -nargs=? Fold :call     CocAction('fold', <f-args>)

		" Add `:OR` command for organize imports of the current buffer.
		command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

		" Add (Neo)Vim's native statusline support.
		" NOTE: Please see `:h coc-status` for integrations with external plugins that
		" provide custom statusline: lightline.vim, vim-airline.
		set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

		" Mappings using CoCList:
		" Show all diagnostics.
		nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
		" Manage extensions.
		nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
		" Show commands.
		nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
		" Find symbol of current document.
		nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
		" Search workspace symbols.
		nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
		" Do default action for next item.
		nnoremap <silent> <space>j  :<C-u>CocNext<CR>
		" Do default action for previous item.
		nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
		" Resume latest coc list.
		nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
	" }}}
	" vim-devicons {{{
		" Download the font DeJaVuSansMono Nerd Font, place it in ~/.local/share/fonts
		set encoding=UTF-8
		let g:airline_powerline_fonts = 1
		set guifont=DejaVuSansMono\ Nerd\ Font\ Bold\ 9
	" }}}
	" fzf {{{
		map <C-f> <Esc><Esc>:Files!<CR>
		inoremap <C-f> <Esc><Esc>:BLines!<CR>
		map <C-g> <Esc><Esc>:BCommits!<CR>
	" }}}
