#!/usr/bin/env bash
# Ubuntu Setup Interativo
# Autor: Fernando Coutinho
# Licença: MIT (veja LICENSE)
# Descrição: Script para instalar e configurar ambiente de desenvolvimento no Ubuntu 26.04
set -euo pipefail

echo "🚀 Bem-vindo ao Setup Interativo!"
echo "Você poderá escolher quais programas deseja instalar."
echo "Voce será informado sobre o processo de instalação e em alguns momentos será necessario informar alguns parametros para configuração do sistema"
echo

# Função para reinstalar pacotes (remove se existir e instala de novo)
reinstalar() {
    local pacote=$1
    echo "🔎 Verificando $pacote..."
    if dpkg -l | grep -q "^ii  $pacote "; then
        echo "⚠️ Removendo versão antiga de $pacote (desatualizada ou não necessária)..."
        sudo apt remove -y $pacote
    fi
    echo "📦 Instalando $pacote..."
    sudo apt install -y $pacote
}

# Funções de instalação principais
instalar_node() {
    echo "📦 Instalando Node.js 22.x e npm..."
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
    if dpkg -l | grep -q "^ii  nodejs "; then
        echo "⚠️ Removendo versão antiga do Node.js..."
        sudo apt remove -y nodejs
    fi
    sudo apt install -y nodejs
    echo "🔧 Habilitando Corepack para npm/yarn..."
    sudo corepack enable
    echo "📦 Atualizando npm para última versão..."
    sudo npm install -g npm@latest
    echo "✅ Node.js e npm configurados!"
}

instalar_java() {
    echo "📦 Instalando múltiplas versões do Java (OpenJDK)..."
    reinstalar openjdk-8-jre-headless
    reinstalar openjdk-11-jre-headless
    reinstalar openjdk-17-jre-headless
    reinstalar openjdk-21-jre-headless
    reinstalar default-jdk
    echo "🔧 Configurando JAVA_HOME..."
    echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
    echo "✅ Java configurado!"
}

instalar_docker() {
    echo "📦 Instalando Docker..."
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "🔧 Configurando repositório Docker..."
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    reinstalar docker-ce
    reinstalar docker-ce-cli
    reinstalar containerd.io
    reinstalar docker-buildx-plugin
    reinstalar docker-compose-plugin
    reinstalar util-linux   # garante que o comando newgrp esteja disponível
    sudo groupadd -f docker
    sudo usermod -aG docker $USER
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
    echo "✅ Docker instalado e configurado!"
    echo "⚠️ Para aplicar permissões sem reiniciar, rode: newgrp docker"
}

# Menu interativo único
PS3="👉 Escolha uma opção (ou digite o número): "
options=("Instalar Node.js + npm" "Instalar Java" "Instalar Docker" "Instalar Yarn" "Instalar Expo CLI" "Instalar Android Studio dependências" "Instalar Apache + PHP" "Instalar MySQL" "Instalar PostgreSQL + PgAdmin" "Instalar .NET SDK/Runtime" "Instalar tudo" "Sair")

select opt in "${options[@]}"; do
    case $opt in
        "Instalar Node.js + npm") instalar_node ;;
        "Instalar Java") instalar_java ;;
        "Instalar Docker") instalar_docker ;;
        "Instalar Yarn") instalar_yarn ;;
        "Instalar Expo CLI") instalar_expo ;;
        "Instalar Android Studio dependências") instalar_android_deps ;;
        "Instalar Apache + PHP") instalar_apache_php ;;
        "Instalar MySQL") instalar_mysql ;;
        "Instalar PostgreSQL + PgAdmin") instalar_postgres_pgadmin ;;
        "Instalar .NET SDK/Runtime") instalar_dotnet ;;
        "Instalar tudo")
            instalar_node
            instalar_java
            instalar_docker
            instalar_yarn
            instalar_expo
            instalar_android_deps
            instalar_apache_php
            instalar_mysql
            instalar_postgres_pgadmin
            instalar_dotnet
            ;;
        "Sair")
            echo "👋 Saindo do setup. Obrigado por usar!"
            break
            ;;
        *) echo "⚠️ Opção inválida, tente novamente." ;;
    esac
done

# Funções adicionais de instalação

instalar_yarn() {
    echo "📦 Instalando Yarn..."
    sudo rm -f /etc/apt/sources.list.d/yarn.list
    sudo rm -f /usr/share/keyrings/yarn.gpg
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/yarn.gpg
    echo "deb [signed-by=/usr/share/keyrings/yarn.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    reinstalar yarn
    echo "✅ Yarn instalado!"
}

instalar_expo() {
    echo "📦 Instalando Expo CLI..."
    echo "⚠️ Removendo versões antigas do expo-cli se existirem..."
    sudo npm uninstall -g expo-cli || true
    sudo npm install -g expo-cli --force
    echo "✅ Expo CLI instalado!"
}

instalar_android_deps() {
    echo "📦 Instalando dependências do Android Studio..."
    reinstalar cpu-checker
    reinstalar qemu-system-x86
    reinstalar libvirt-daemon-system
    reinstalar libvirt-clients
    reinstalar bridge-utils
    sudo adduser $USER kvm
    echo "✅ Dependências do Android Studio instaladas!"
}

instalar_apache_php() {
    echo "📦 Instalando Apache + PHP..."
    reinstalar apache2
    reinstalar php-cli
    reinstalar php-xdebug
    reinstalar php-curl
    reinstalar php-mbstring
    reinstalar php-json
    reinstalar php-mysql
    echo "✅ Apache + PHP instalados!"
}

instalar_mysql() {
    echo "📦 Instalando MySQL..."
    reinstalar mysql-server
    echo "🔧 Configurando segurança do MySQL..."
    sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
    sudo mysql -e "DROP DATABASE IF EXISTS test;"
    sudo mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    sudo mysql -e "FLUSH PRIVILEGES;"
    echo "👤 Criando usuário MySQL..."
    read -p "Digite o nome do usuário MySQL: " mysql_user
    read -s -p "Digite a senha para $mysql_user: " mysql_pass
    echo
    sudo mysql -e "CREATE USER IF NOT EXISTS '$mysql_user'@'localhost' IDENTIFIED BY '$mysql_pass';"
    sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$mysql_user'@'localhost' WITH GRANT OPTION;"
    sudo mysql -e "FLUSH PRIVILEGES;"
    echo "✅ MySQL configurado com usuário '$mysql_user'."
}

instalar_postgres_pgadmin() {
    echo "📦 Instalando PostgreSQL + PgAdmin..."
    reinstalar postgresql
    curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
    echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" | sudo tee /etc/apt/sources.list.d/pgadmin4.list
    sudo apt update
    reinstalar pgadmin4
    echo "👤 Criando usuário PostgreSQL..."
    read -p "Digite o nome do usuário PostgreSQL: " pg_user
    read -s -p "Digite a senha para $pg_user: " pg_pass
    echo
    sudo -u postgres psql -c "CREATE USER $pg_user WITH PASSWORD '$pg_pass';"
    sudo -u postgres psql -c "ALTER ROLE $pg_user CREATEDB;"
    echo "✅ PostgreSQL configurado com usuário '$pg_user'."
}

instalar_dotnet() {
    echo "📦 Instalando .NET SDK e Runtime..."
    wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
    chmod +x ./dotnet-install.sh
    ./dotnet-install.sh --version latest
    sudo add-apt-repository -y ppa:dotnet/backports
    sudo apt update
    reinstalar dotnet-sdk-10.0
    reinstalar aspnetcore-runtime-10.0
    reinstalar dotnet-runtime-10.0
    echo 'export DOTNET_ROOT=$HOME/.dotnet' >> ~/.bashrc
    echo 'export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools' >> ~/.bashrc
    echo "✅ .NET SDK e Runtime instalados!"
}

# Limpeza final
echo "🧹 Limpando pacotes obsoletos..."
sudo apt autoremove -y && sudo apt autoclean -y
echo "✅ Setup concluído!"
echo "⚠️ Rode 'source ~/.bashrc' para aplicar variáveis de ambiente."
echo "⚠️ Rode 'newgrp docker' para aplicar permissões do Docker."
