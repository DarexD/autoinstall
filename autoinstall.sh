#!/bin/bash


PACMAN_INSTALL=(git kitty vlc)
PARU_INSTALL=(antigravity visual-studio-code-bin)
FLATPAK_INSTALL=(com.brave.Browser com.discordapp.Discord org.telegram.desktop com.anydesk.Anydesk com.mattjakeman.ExtensionManager org.libreoffice.LibreOffice com.protonvpn.www com.stremio.Stremio net.nokyan.Resources org.flameshot.Flameshot)
SNAP_INSTALL=(android-studio --classic)



#--> snap
#--> paru
#--> flatpak

#--> git

#sudo pacman -S --needed base-devel
#git clone https://aur.archlinux.org/paru.git
#cd paru
#makepkg -si


# instalar gestores de paquetes --> instalar programas --> Instalar personalización



# 1. Instalar administradores de paquetes :

# - snap
# - flatpak
# - paru

# 2. Instalar programas:

# - pacman : [git kitty vlc]
# - paru : [antigravity visual-studio-code-bin ]
# - snap : [android-studio]
# - flatpak : [brave discord telegram virtualbox]


#-------------- Funciones para instalar dependencias -------------------

function installSnap(){
    cd
    echo "Instalando Snap"
    git clone https://aur.archlinux.org/snapd.git
    cd snapd
    makepkg -si
    cd ..
    rm -rf snapd
    sudo systemctl enable --now snapd.socket
}

function installParu(){
    cd
    echo "Instalando Paru"
    sudo pacman -S --needed base-devel # Dependencias de Paru
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ..
    rm -rf paru
}

function installFlatpak(){
    cd
    echo "Instalando Flatpak"
    sudo pacman -S flatpak --noconfirm --needed
}

#-------------- Funciones para instalar programas -------------------

function installWithPacman(){
    sudo pacman -S ${PACMAN_INSTALL[@]} --noconfirm --needed
}

function installWithParu(){
    sudo paru -S ${PARU_INSTALL[@]} --noconfirm --needed
}

function installWithFlatpak(){
    sudo flatpak install ${FLATPAK_INSTALL[@]} -y
}

function installWithSnap(){
    sudo snap install ${SNAP_INSTALL[@]} 
}

function installNode(){

    echo "Instalando Node.js..."
    # Download and install nvm:
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    # in lieu of restarting the shell
    \. "$HOME/.nvm/nvm.sh"
    # Download and install Node.js:
    nvm install 25
    # Verify the Node.js version:
    node -v # Should print "v25.2.1".
    # Verify npm version:
    npm -v # Should print "11.6.2".   
}


function main(){

    sudo pacman -Syu --noconfirm --needed

# Fase 1 - Instalacion de las dependencias:

    installFlatpak
    installParu
    installSnap


# Fase 2 - Instalacion de los programas:

    installWithPacman
    installWithParu
    installWithFlatpak
    installWithSnap
    installNode
# Fase 3 - Instalacion de la personalizacion:

echo "instalando personalizacion de Kitty"

    cp -r source/config/kitty ~/.config/kitty

}

main









