ssh_loc := "/home/$USER/.ssh/id_rsa"
n_cpu   := "$(($(grep -c ^processor /proc/cpuinfo)-2))"

_install package:
    #!/usr/bin/env bash
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' {{package}}|grep "install ok installed")
    if [ "" = "$PKG_OK" ]; then
        echo "No {{package}}. Setting up {{package}}."
        sudo apt-get -qy install {{package}}
    fi

git: (_install "git") (_install "stow")
    stow git

rust:
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

mamba: 
    #!/usr/bin/env bash
    curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
    bash Mambaforge-$(uname)-$(uname -m).sh
    rm Mambaforge-$(uname)-$(uname -m).sh
    source ~/mambaforge/bin/activate
    conda init
    
zsh: (_install "zsh") (_install "stow") (_install "fzf")
    sudo chsh -s $(which zsh) $(whoami)
    # oh my zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # pretty theme
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    # syntax highlight
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    # auto suggest
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    # conda completion
    git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion
    # install justfile completions
    mkdir ~/.oh-my-zsh/plugins/just
    just --completions zsh > ~/.oh-my-zsh/plugins/just/_just
    # clean things up
    rm -f ~/.zshrc
    stow zsh

vim: (_install "stow") (_install "vim")
    stow vim
    vim +'PlugInstall --sync' +qa

cloudflared: (_install "gdebi")
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    sudo gdebi -n cloudflared-linux-amd64.deb
    rm cloudflared-linux-amd64.deb

nvim: 
    curl -fLO https://glare.now.sh/neovim/neovim/nvim.appimage
    chmod +x nvim.appimage
    sudo chown root:root nvim.appimage
    sudo mv nvim.appimage /usr/bin/nvim
    stow nvim
    nvim +'PlugInstall --sync' +qa

font myfont="Meslo":
    #!/usr/bin/env bash
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/{{myfont}}.zip
    unzip {{myfont}}.zip -d ~/.fonts
    fc-cache -fv
    rm {{myfont}}.zip

tmux: (_install "stow") (_install "tmux")
    stow tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

nord: (_install "dconf-cli") (_install "uuid-runtime") (_install "gnome-tweaks")
    #!/usr/bin/env bash
    # install terminal theme
    export TERMINAL=gnome-terminal
    bash -c "$(wget -qO- https://raw.githubusercontent.com/Mayccoll/Gogh/master/themes/nord.sh)"
    # install ubuntu theme
    git clone https://github.com/EliverLara/Nordic.git ~/.themes/nordic

obsidian: launcher 
    curl -fLO https://glare.now.sh/obsidianmd/obsidian-releases/.AppImage
    mv .AppImage ~/Applications/Obsidian.AppImage

slack: (_install "gdebi") 
    wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.17.0-amd64.deb
    sudo gdebi -n slack*.deb
    rm slack*.deb

zoom: (_install "gdebi") 
    wget https://zoom.us/client/latest/zoom_amd64.deb
    sudo gdebi -n zoom*.deb
    rm zoom*.deb

zotero:
    curl -sL https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash  
    sudo apt update
    sudo apt install -qy zotero

chrome: (_install "gdebi") 
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

ssh: (_install "stow")
    #!/usr/bin/env bash
    ssh-keygen -t rsa -N "" -f {{ssh_loc}}
    eval `ssh-agent`
    ssh-add {{ssh_loc}}
    cat {{ssh_loc}}.pub
    stow ssh

### Optional ones that aren't ran by default
launcher: (_install "gdebi") 
    curl -fLO https://glare.now.sh/TheAssassin/AppImageLauncher/amd64.deb
    sudo gdebi -n amd64.deb
    rm amd64.deb    
    mkdir -p ~/Applications