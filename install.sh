RED='\033[0;31m'
GREEN='\033[1;32m'
ORANGE='\033[1;33m'
BOLD_CYAN='\033[1;36m'
NC='\033[0m' # No Color 

banner() {
    msg="| $* |"
    edge="+-$(echo "$*" | sed 's/./-/g')-+"
    echo "$edge"
    echo "$msg"
    echo "$edge"
}

zsh_custom_directory="$HOME/.oh-my-zsh/custom"

cp kaliopt.zsh-theme $zsh_custom_directory/themes
printf "${BOLD_CYAN}\n\n[-] ${NC}Installing Theme...\n\n"

plugins_list=( zsh-autosuggestions zsh-syntax-highlighting )
for plugin in $plugins_list; do
	if [[ ! -d "$zsh_custom_directory/plugins/${plugin}" ]]; then
		git clone https://github.com/zsh-users/${plugin}.git $zsh_custom_directory/plugins/${plugin} --quiet
	else
		printf "${RED}[-] ${NC}${plugin} is alredy installed\n"
	fi
done

printf "\n${GREEN}[✱] ${ORANGE}KALI ZSH Theme ${GREEN}Installed successfully!${NC}\n\n"

banner "Set 'kaliopt' as ZSH_THEME in your .zshrc"
banner "Add '${plugins_list}' to plugins"
