sudo pacman -Syu
sudo pacman -S --needed git base-devel

# install yay
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si
# yay --version
# yay -Syu

# install packages
yay -Sy curl vim git htop zsh vlc snapd neovim gnome-screenshot wmdocker libreoffice gedit bat micro python3 tmux python3-dev python3-pip python3-pipx python3-setuptools alacritty waybar hyprpaper flatpack gnome-audio-locator gnome-calculator gnome-calendar gnome-clocks gnome-connections gnome-disk-utility gnome-disks gnome-doc-utils gnome-font-viewer gnome-photos gnome-music gnome-software gnome-system-monitor --noconfirm --removemake

sudo pacman -S swaync pipewire wireplumber 


systemctl --user enable pipewire
systemctl --user enable wireplumber
systemctl --user start pipewire wireplumber

loginctl enable-linger $USER

yay -S xdg-desktop-portal-hyprland-git xdg-desktop-portal-gtk --noconfirm --removemake

systemctl --user enable xdg-desktop-portal-hyprland
systemctl --user enable xdg-desktop-portal-gtk
systemctl --user start xdg-desktop-portal-hyprland xdg-desktop-portal-gtk

systemctl --user enable hyprpolkitagent
systemctl --user start hyprpolkitagent

# install moonlight
sudo snap install moonlight
# install drawio
sudo snap install drawio
# install the fuck
pip3 install thefuck --user
# install obsidian
sudo snap install obsidian --classic
# install discord
sudo snap install discord
# install postman
sudo snap install postman
#Install Visual Studio Code
sudo snap install --classic code
#add user to sudo-docker
sudo usermod -aG docker $USER
#install micro
curl https://getmic.ro | bash
sudo mv micro /usr/bin
# install bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat 
# install o nodejs
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
# install o java
sudo apt install -y openjdk-17-jdk
sudo apt install -y maven
#install zsh/vim fonts
git clone --depth=1 https://github.com/powerline/fonts.git
./fonts/install.sh
rm -rf fonts
# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
# install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
echo set nu >> ~/.vim_runtime/my_configs.vim
# instala o Starship
curl -sS https://starship.rs/install.sh | sh

starship preset nerd-font-symbols -o ~/.config/starship.toml

#install oh-my-zsh
yay -S zsh --removemake --noconfirm
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/z-shell/F-Sy-H.git \
${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/MichaelAquilina/zsh-auto-notify.git $ZSH_CUSTOM/plugins/auto-notify

sudo cp -r ../Configs/.config ~/
sudo cp -r ../Configs/.gitconfig ~/
sudo cp -r ../Configs/.tmux ~/
sudo cp -r ../Configs/.tmux.conf ~/
sudo cp -r ../Configs/.zshrc ~/