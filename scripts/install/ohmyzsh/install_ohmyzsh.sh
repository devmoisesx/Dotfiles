echo "=== Installing Oh My Zsh ==="

if [ -d "$HOME/.oh-my-zsh" ]; then
    print_status "Oh My Zsh já está instalado. Pulando a instalação."
else
    print_status "Instalando Oh My Zsh..."
    # A instalação via curl é a mais comum e recomendada
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi