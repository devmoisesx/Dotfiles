echo "=== setting up Git ==="

read -p "Digite o seu email para o Git: " email
git config --global user.email "$email"
read -p "Digite o seu usuário para o Git: " user
git config --global user.name "$user"

read -p "Deseja gerar a ssh key para o github? (S/N)" resposta
resposta=$(echo "$resposta" | tr '[:lower:]' '[:upper:]')

if [[ "$resposta" == "S" ]]; then
    echo "Gerando SSH Key"
    ssh-keygen -t ed25519 -C "$email"
else
    echo "SSH Key não gerada"
fi