SCRIPT_NAME=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_NAME")

SCRIPT_USER=$(whoami)

AC_CODE_DIR="$SCRIPT_DIR/src/azerothcore-wotlk"

COLOR_RESET="\e[0m"
COLOR_GREEN="\e[1;32m"
COLOR_RED="\e[1;31m"
COLOR_YELLOW="\e[1;33m"
COLOR_WHITE="\e[1;37m"

header() {
	echo -e "${COLOR_YELLOW}====================>${COLOR_RESET} ${COLOR_WHITE}$1${COLOR_RESET} ${COLOR_YELLOW}<====================${COLOR_RESET}"
}

step() {
	echo -en "${COLOR_GREEN}>>>${COLOR_RESET} ${COLOR_WHITE}$1${COLOR_RESET}"
	if [[ -n "$2" ]]; then
		echo -en " ${COLOR_RED}->${COLOR_RESET} ${COLOR_WHITE}$2${COLOR_RESET}"
	fi
	echo ""
}
