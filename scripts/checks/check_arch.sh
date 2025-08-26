echo "=== Check Arch Linux ==="

# Check Arch Linux (avoid Manjaro/Garuda)
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    case $ID in
    arch | endeavouros | arcolinux | archcraft | artix | archlabs) ;;
    manjaro | garuda)
        print_error "Manjaro and Garuda are not supported."
        exit 1
        ;;
    *)
        if ! command -v pacman >/dev/null; then
            print_error "Not an Arch-based system."
            exit 1
        fi
        ;;
    esac
else
    print_error "Cannot detect distribution."
    exit 1
fi