#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Instaling Ubuntu requirements and ZSH ...PLEASE WAIT!!!"
    
    sudo apt-get update -qq && \
    sudo apt-get install -y -qq \
      apt-transport-https \
      build-essential \
      curl \
      file \
      git \
      openssh-server \
      procps \
      socat \
      software-properties-common \
      wget \
      zsh;
      
      if [[ "$SHELL" != *"zsh" ]]; then 
        echo "Current Shell: $SHELL"
        echo "Defining default shell to zsh"
        chsh -s $(which zsh);
      fi
fi

# Installing oh-my-zsh
echo ""
echo "Installing oh-my-zsh"
echo 
#############################################
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# "Instaling oh-my-zsh plugins..."
echo ""
echo "Installing oh-my-zsh plugins and auto-completions"
echo 
#############################################
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
curl https://raw.githubusercontent.com/nosarthur/gita/master/.gita-completion.zsh --output ~/.zsh/plugins/gita-completion.zsh --silent
curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh --output ~/.zsh/plugins/git.plugin.zsh

# Instaling oh-my-zsh powerlevel10k theme
echo ""
echo "Instaling oh-my-zsh powerlevel10k theme"
echo 
#############################################
#git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/themes/powerlevel10k/
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
#sed -i '' -e "s/ZSH_THEME=.*/ZSH_THEME\=\"powerlevel10k\/powerlevel10k\"/g" ~/.zshrc

# Instaling homebrew
echo ""
echo "Instaling homebrew"
echo 
#############################################
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo ""
echo "Loading Brew"
echo 
#############################################
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo >> /Users/juranir/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew -v

echo ""
echo "Instaling additional packages with brew"
echo 
#############################################

brew tap cantino/mcfly
brew tap hashicorp/tap

brew install \
  ansible \
  alfred \
  aws-iam-authenticator \
  aws-vault \
  awscli \
  azure-cli \
  exa \
  fzf \
  git \
  helm \
  helmfile \
  httpie \
  jq \
  k9s \
  kubecm \
  kubectx \
  kubernetes-cli \
  mcfly \
  ncurses \
  packer \
  tfk8s \
  tldr \
  warrensbox/tap/tfswitch \
  yadm \
  wget \
  font-meslo-lg-nerd-font \
  1password-cli \
  hashicorp/tap/terraform \
  sops


brew install --cask 1password \
    dbeaver-community \
    fig
    
brew install --cask font-fira-code-nerd-font
brew install --cask google-chrome
brew install --cask grammarly-desktop
brew install --cask iterm2
brew install --cask lens
brew install --cask monitorcontrol
brew install --cask pocket-casts
brew install --cask rancher
brew install --cask rectangle
brew install --cask slack
brew install --cask spotify
brew install --cask postman
brew install --cask visual-studio-code

#echo ""
#echo "Enable zsh theme"
#echo 
#############################

#git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
#sed -i '' -e "s/ZSH_THEME=.*/ZSH_THEME\=\"powerlevel10k\/powerlevel10k\"/g" ~/.zshrc

echo ""
echo "Instaling Helm plugins"
echo 
#############################

helm plugin install https://github.com/databus23/helm-diff

echo ""
echo "Cloning Dotenv project to /tmp"
echo 

# Removing temp files
#rm -rf ~/.zshrc ~/.p10k.zsh

# Cloning dotfiles
cd /tmp
git clone git@github.com:juranir/dotfiles.git
cat dotfiles/.zshrc > ~/.zshrc
cat dotfiles/.p10k.zsh > ~/.p10k.zsh

sudo -k

echo "Apple Terminal: Open Terminal → Preferences → Profiles → Text, click Change under Font and select MesloLGS NF family."

echo "Instalation process is now complete!"
exit 0
