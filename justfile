ssh_loc := "/home/$USER/.ssh/id_rsa"
n_cpu   := "$(($(grep -c ^processor /proc/cpuinfo)-2))"

# ------------------- Package Installers ------------------- #

# Install a package using apt
apt +package:
    #!/usr/bin/bash
    for p in {{package}}; do
        PKG_OK=$(dpkg-query -W --showformat='${Status}\n' {{package}}|grep "install ok installed")
        if [ "" = "$PKG_OK" ]; then
            echo "No {{package}}. Setting up {{package}}."
            sudo apt-get -qy install {{package}}
        fi
    done

# Install a package using cargo
cargo +package: (rust)
    #!/usr/bin/bash
    if [ "update" == {{package}} ]; then
        just cargo cargo-update
        cargo install-update -a
        exit 0
    fi
    for p in {{package}}; do
        echo $RESULT
        if [ "" = "$RESULT" ]; then
            cargo binstall {{package}} -y
        fi
    done

git: (apt "git") (apt "stow")
    stow git

rust:
    #!/usr/bin/env bash
    PKG=$(which rustup)
    if [ "" = "$PKG" ]; then
        # rustup / cargo
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        # cargo-binstall
        curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
    fi

zsh: (apt "zsh stow fzf build-essential") (duf) (lazygit) (cargo "eza zoxide bat fd-find yazi-fm yazi-cli tealdeer ripgrep") (node)
    git submodule update --init --recursive
    tldr --update
    stow zsh
    exec zsh
    chsh -s $(which zsh)
    antidote load

vim: (apt "stow") (apt "vim")
    stow vim
    vim +'PlugInstall --sync' +qa


cloudflared: (apt "gdebi")
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    sudo gdebi -n cloudflared-linux-amd64.deb
    rm cloudflared-linux-amd64.deb

nvim: (apt "stow") (cargo "bob-nvim")
    git submodule update --init --recursive
    bob use stable
    stow nvim
    cargo ripgrep
    cargo tree-sitter-cli

node:
    #!/usr/bin/env bash
    PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v1.40.1/install.sh | bash'
    source ~/.nvm/nvm.sh
    nvm install node

font myfont="Meslo":
    #!/usr/bin/env bash
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/{{myfont}}.zip
    unzip {{myfont}}.zip -d ~/.fonts
    fc-cache -fv
    rm {{myfont}}.zip

tmux: (apt "stow") (apt "tmux")
    stow tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

nord: (apt "dconf-cli") (apt "uuid-runtime") (apt "gnome-tweaks")
    #!/usr/bin/env bash
    # install terminal theme
    export TERMINAL=gnome-terminal
    bash -c "$(wget -qO- https://raw.githubusercontent.com/Mayccoll/Gogh/master/themes/nord.sh)"
    # install ubuntu theme
    git clone https://github.com/EliverLara/Nordic.git ~/.themes/nordic

obsidian: launcher 
    curl -fLO https://glare.now.sh/obsidianmd/obsidian-releases/.AppImage
    mv .AppImage ~/Applications/Obsidian.AppImage

lazygit: 
  #!/bin/env bash 
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm lazygit*
  stow lazygit

duf: (apt "gdebi")
  #!/bin/env bash 
  DUF_VERSION=$(curl -s "https://api.github.com/repos/muesli/duf/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  echo $DUF_VERSION
  curl -Lo duf.deb "https://github.com/muesli/duf/releases/latest/download/duf_${DUF_VERSION}_linux_amd64.deb"
  sudo gdebi -n duf.deb
  rm duf.deb

slack: (apt "gdebi") 
    wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.17.0-amd64.deb
    sudo gdebi -n slack*.deb
    rm slack*.deb

zoom: (apt "gdebi") 
    wget https://zoom.us/client/latest/zoom_amd64.deb
    sudo gdebi -n zoom*.deb
    rm zoom*.deb

zotero:
    curl -sL https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash  
    sudo apt update
    sudo apt install -qy zotero

chrome: (apt "gdebi") 
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo gdebi -n google-chrome*.deb
    rm google-chrome*.deb

# From here: https://code.visualstudio.com/docs/setup/linux
vscode: 
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt update
    sudo apt install -qy code

syncthing: 
    curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
    echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
    sudo apt-get update
    sudo apt-get install syncthing
    sudo systemctl enable syncthing@$(whoami).service
    sudo systemctl start syncthing@$(whoami).service

docker: 
    sudo apt-get install ca-certificates gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -qy docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER

ssh: (apt "stow")
    #!/usr/bin/env bash
    ssh-keygen -t rsa -N "" -f {{ssh_loc}}
    eval `ssh-agent`
    ssh-add {{ssh_loc}}
    cat {{ssh_loc}}.pub
    stow ssh

### Optional ones that aren't ran by default
launcher: (apt "gdebi") 
    curl -fLO https://glare.now.sh/TheAssassin/AppImageLauncher/amd64.deb
    sudo gdebi -n amd64.deb
    rm amd64.deb    
    mkdir -p ~/Applications
