#!/bin/bash

RED='\033[0;31m'
GREEN='\033[1;32m'
ORANGE='\033[1;33m'
BOLD_CYAN='\033[1;36m'
NC='\033[0m' # No Color 


# Manage MacOS and Linux (sed is different)
myOS=$(uname -s)
if [[ $myOS == "Darwin" ]]; then
    sedParam="-i ''"
else
    sedParam="-i"
fi

# Check if zsh git and curl are installed
prerequisite=(zsh git curl)
errorMessage="${RED}Please install '${prerequisite[*]}' before continuing${NC}"
for tool in ${prerequisite[*]}; do
    if [[ ! -f $(which ${tool}) ]]; then
        echo $errorMessage
        exit 1
    fi
done

zsh_directory="$HOME/.oh-my-zsh"
zsh_custom_directory="$zsh_directory/custom"
zsh_conf_file="$HOME/.zshrc"

# Check if ohmyzsh is installed
if [[ ! -d $zsh_directory ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sed -r -e 's/(--unattended\)).*/\1 RUNZSH=no ;;/') --unattended"
fi

cp kaliopt.zsh-theme $zsh_custom_directory/themes
printf "${BOLD_CYAN}\n\n[-] ${NC}Installing Theme...\n\n"

sed ${sedParam} -r -e 's/(^ZSH_THEME=).*/\1"kaliopt"/' $zsh_conf_file

plugins_list=(zsh-autosuggestions zsh-syntax-highlighting)
for plugin in ${plugins_list[*]}; do
	if [[ ! -d "$zsh_custom_directory/plugins/${plugin}" ]]; then
		git clone https://github.com/zsh-users/${plugin}.git $zsh_custom_directory/plugins/${plugin} --quiet
	else
		printf "${RED}[-] ${NC}${plugin} is already installed\n"
	fi

    if [[ -z $(grep -e "^plugins.*${plugin}" $zsh_conf_file) ]]; then
        sed ${sedParam} -r -e "s/(^plugins=\()/\1${plugin} /" $zsh_conf_file
    fi
done

printf "\n${GREEN}[✱] ${ORANGE}KALI ZSH Theme ${GREEN}Installed successfully!${NC}\n\n"
