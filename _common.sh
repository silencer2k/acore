SCRIPT_NAME=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_NAME")

BASE_DIR="$SCRIPT_DIR"

SERVICE_USER=$(whoami)

AC_CODE_DIR="$BASE_DIR/src/azerothcore-wotlk"

COLOR_RESET="\e[0m"
COLOR_GREEN="\e[1;32m"
COLOR_RED="\e[1;31m"
COLOR_YELLOW="\e[1;33m"
COLOR_WHITE="\e[1;37m"

header() {
	echo -ne "${COLOR_YELLOW}====================>${COLOR_RESET}"
	echo -n " "
	echo -ne "${COLOR_WHITE}$1${COLOR_RESET}"
	echo -n " "
	echo -ne "${COLOR_YELLOW}<====================${COLOR_RESET}"
	echo ""
}

step() {
	echo -ne "${COLOR_GREEN}>>>${COLOR_RESET}"
	echo -n " "
	echo -ne "${COLOR_WHITE}$1${COLOR_RESET}"

	if [[ -n "$2" ]]; then
		echo -n " "
		echo -ne "${COLOR_RED}->${COLOR_RESET}"
		echo -n " "
		echo -ne "${COLOR_WHITE}$2${COLOR_RESET}"
	fi

	echo ""
}
