echo "=== Check Internet Connection ==="

# Check internet connection (warn only)
if ! ping -c1 archlinux.org &>/dev/null; then
    print_warning "No internet connection detected."
fi
