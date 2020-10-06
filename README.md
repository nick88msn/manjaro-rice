# What is this

My personal script to customize a fresh Manjaro i3 installation to a working laptop on my Dell XPS 9560 (4k display).

## 1. Se the right dpi for your monitor 

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

## 7. Edit vimrc

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
