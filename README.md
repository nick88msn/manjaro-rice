# What is this

My personal script to customize a fresh Manjaro i3 installation to a working laptop on my Dell XPS 9560 (4k display).

## 1. Se the right dpi for your monitor 

Change the first row of the .Xresources file from 95 to 125-150 for HiDPI displays.

## 2. Update all packages
sudo pacman -Syu

## 3. Set vim as default EDITOR
export EDITOR=$(which vim)

## 4. Install packages
sudo pacman -S - < pkglist.txt

## 4.1 Install yay for AUR packages
`
$ cd $HOME && \
$ git clone https://aur.archlinux.org/yay.git && \
$ cd yay && \
$ makepkg -si
`
## 5. Add perl extension for urxvt 
sudo pacman -S urxvt-perls

## 6. Add per extension into .Xresources

## 7. Edit vimrc

## 8. Install Plug for vim plugin management
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## 9. Set background
> Download background image with curl. Set download folder to Pictures/ and then set it as bg with feh.

## 10. Setup python environment and global packages
pip3 install pipenv pyautogui

## 11. Add trim support (only if you use an SSD)
sudo systemctl enable fstrim.timer && systemctl start fstrim.timer 

## 12. Add CPU microcode for firmware updates

Install intel-ucode if cpu is intel

`
$ cpu_vendor=$(lscpu | grep Vendor | awk -F ': +' '{print $2}')  
$ if [[ $cpu_vendor == "GenuineIntel" ]]; then  
$	pacman -S intel-ucode  
$ fi  
`
