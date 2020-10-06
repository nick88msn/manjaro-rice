# What is this

My personal customization to customize a Manjaro i3 on a Dell XPS 9560.

## 1. Se the right dpi for your monitor 

Change the first row of the .Xresources file from 95 to 125-150 for HiDPI displays.

## 2. Update all packages
sudo pacman -Syu

## 3. Set vim as default EDITOR
export EDITOR=$(which vim)

## 4. Install packages
sudo pacman -S speedtest-cli code docker texlive-most texlive-lang neofetch github-cli noto-fonts-emoji ttf-dejavu feh sxiv zathura zathura-pdf-mupdf ranger

## 5. Add perl extension for urxvt 
sudo pacman -S urxvt-perls

## 6. Add per extension into .Xresources

## 7. Edit vimrc

## 8. Install Plug for vim plugin management
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## 9. Set backgroun
> Download background with curl in Pictures/ and then set it as bg with feh.
