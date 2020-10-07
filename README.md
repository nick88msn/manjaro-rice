# What is this

My personal script to customize a fresh Manjaro i3 installation to a working laptop on my Dell XPS 9560 (4k display).

## 1. Set the right dpi for your monitor 

Change the first row of the .Xresources file from 95 to 125-150 for HiDPI displays.

## 2. Update all packages
```Shell
sudo pacman -Syu
```
## 3. Set vim as default EDITOR
```Shell
export EDITOR=$(which vim)
```
## 4. Install packages
```Shell
sudo pacman -S - < pkglist.txt
```
## 4.1 Install yay for AUR packages
```Shell
cd $HOME && \
git clone https://aur.archlinux.org/yay.git && \
cd yay && \
makepkg -si
```

## 5. Install perl extension for urxvt 
```Shell
sudo pacman -S urxvt-perls
```
## 6. Add perl extension into .Xresources

```Perl
! adding extensions
URxvt.perl-ext-common: font-size,clipboard,default,matcher,url-select,keyboard-select

! url-select options
URxvt.colorUL:			  #4682B4
URxvt.keysym.M-u:		  perl:url-select:select_next
URxvt.url-select.launcher: 	  /usr/bin/xdg-open
URxvt.url-select.underline:	  true

! keyboard-select options
URxvt.keysym.M-Escape: 		  perl:keyboard-select:activate
! for 'fake' transparency (without Compton) uncomment the following three lines
! URxvt*inheritPixmap:            true
! URxvt*transparent:              true
! URxvt*shading:                  138

! Normal copy-paste keybindings without perls
URxvt.iso14755:                   false
URxvt.keysym.Shift-Control-V:     eval:paste_clipboard
URxvt.keysym.Shift-Control-C:     eval:selection_to_clipboard
!Xterm escape codes, word by word movement
URxvt.keysym.Control-Left:        \033[1;5D
URxvt.keysym.Shift-Control-Left:  \033[1;6D
URxvt.keysym.Control-Right:       \033[1;5C
URxvt.keysym.Shift-Control-Right: \033[1;6C
URxvt.keysym.Control-Up:          font-size:increase
URxvt.keysym.Shift-Control-Up:    font-size:incglobal
URxvt.keysym.Control-Down:        font-size:decrease
URxvt.keysym.Shift-Control-Down:  font-size:decglobal

URxvt.clipboard.autocopy: 	  true

URxvt.keysym.M-c:     		  perl:clipboard:copy
URxvt.keysym.M-v:		      perl:clipboard:paste
```
## 7. Edit vimrc

```Shell
" FINDING FILES

" - Search down into subfolders
"   This provides tab-completion for all file related tasks
set path+=**

" - Display all matching files when we tab complete
set wildmenu

" Now we can hit tab to :find by partial match
" using * to make it fuzzy
" Things to consider:
"  - :b lets you autocomplete any open buffer
"  - :ls lists all open buffers

" FILE BROWSING
" Tweaks for browsing files inside vim
let g:netrw_banner=0		"disable annoying banner
let g:netrw_browse_split=4	"open in prior window
let g:netrw_altv=1		"open splits to the right
let g:netrw_liststyle=3		"tree view

" Now we can:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split tab
" - check |netrw-browse-maps| for more mappings

syntax on
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=$HOME/.vim/undodir
set undofile
set incsearch

" 

"set colorcolumn=80
"highlight ColorColumn ctermgb=0 guibg=lightgrey

" =====================================================
"			REMAPPING
" =====================================================

" split navigation
" use :sp or :vs to open a file in horizontal or vertical view
" user ctrl+j, k, l, h to move among panes

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

autocmd BufNewFile,BufRead *.md set filetype=markdown
"autocmd FileType markdown nnoremap <C-P> :!pandoc % -f markdown -t html -s -o README.html && google-chrome-stable README.html & disown<enter>
autocmd FileType markdown nnoremap <C-P> :!google-chrome-stable % & disown <CR>

autocmd BufNewFile,BufRead *.tex set filetype=latex
autocmd FileType latex nnoremap <C-P> :!pdflatex -output-directory=. -jobname=document % && zathura document.pdf & disown <CR>
autocmd FileType latex nnoremap <C-B> :!pdflatex -output-directory=. -jobname=document % <CR>

" =====================================================
"			PLUGINS
" =====================================================
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Initialize plugin system
call plug#end()
```

## 8. Install Plug for vim plugin management
```Shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
## 9. Set background
> Download background image with curl. Set download folder to Pictures/ and then set it as bg with feh.

## 10. Setup python environment and global packages
```Shell
pip3 install pipenv pyautogui
```
## 11. Add trim support (only if you use an SSD)
```Shell
sudo systemctl enable fstrim.timer && systemctl start fstrim.timer 
```
## 12. Add CPU microcode for firmware updates

Install intel-ucode if cpu is intel

```Shell
cpu_vendor=$(lscpu | grep Vendor | awk -F ': +' '{print $2}')  
if [[ $cpu_vendor == "GenuineIntel" ]]; then  
    pacman -S intel-ucode  
fi
```

## 13. Customize the prompt generator in .bashrc
```Shell
# get current branch in git repo

function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="[\u@\h \W]\`parse_git_branch\`\$ "
```
