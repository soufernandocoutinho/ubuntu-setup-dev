![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Ubuntu](https://img.shields.io/badge/Ubuntu-26.04-orange)
![Status](https://img.shields.io/badge/Setup-Automated-success)

# 🚀 Ubuntu Setup Interativo

Este projeto disponibiliza um **script automatizado e interativo** para configurar um ambiente de desenvolvimento e produção no **Ubuntu 26.04**.  
Ele funciona no estilo **tasksel**, permitindo que o usuário escolha quais programas deseja instalar, sempre com mensagens explicativas sobre o que está sendo instalado ou removido.

---

## 📦 Programas disponíveis para instalação

O menu interativo permite instalar:

- **Node.js 22.x + npm (via Corepack)**
- **Java (OpenJDK 8, 11, 17, 21)**
- **Docker (CE, CLI, Compose, Buildx)**  
  ⚠️ Inclui dependência `util-linux` para garantir funcionamento do comando `newgrp`.
- **Yarn (última versão estável)**
- **Expo CLI**
- **Dependências do Android Studio (KVM, QEMU, libvirt, bridge-utils)**
- **Apache + PHP (CLI, Xdebug, Curl, Mbstring, Json, Mysql)**
- **MySQL Server**  
  ⚠️ Remove configurações inseguras e cria usuário/senha personalizados.
- **PostgreSQL + PgAdmin 4**  
  ⚠️ Cria usuário/senha personalizados com permissões de banco.
- **.NET SDK e Runtime (10.x)**

---

## ⚙️ Como usar

Clone este repositório e execute o script:

```bash
git clone https://github.com/soufernandocoutinho/ubuntu-setup-dev
cd ubuntu-setup-dev
chmod +x setup.sh
./setup.sh
```

Escolha no menu interativo os programas que deseja instalar.  
O script explicará cada ação (instalação ou remoção de pacotes obsoletos).

---

## 🖥️ Exemplo do menu interativo

Ao executar o script `setup.sh`, você verá um menu parecido com este:

👉 Escolha uma opção (ou digite o número):

1) Instalar Node.js + npm  
2) Instalar Java  
3) Instalar Docker  
4) Instalar Yarn  
5) Instalar Expo CLI  
6) Instalar Android Studio dependências  
7) Instalar Apache + PHP  
8) Instalar MySQL  
9) Instalar PostgreSQL + PgAdmin  
10) Instalar .NET SDK/Runtime  
11) Instalar tudo  
12) Sair  

Digite o número da opção desejada e pressione **Enter**.  
O script então mostrará mensagens como:

- `📦 Instalando Node.js 22.x e npm...`  
- `⚠️ Removendo versão antiga do npm porque está desatualizada...`  
- `✅ Node.js e npm configurados!`  

---

## 🔎 Verificação do ambiente

Após a instalação, você pode rodar o **script de verificação** para garantir que tudo está funcionando.

### Como usar

```bash
chmod +x check-env.sh
./check-env.sh
```

Ele vai rodar todos os testes e mostrar as versões instaladas.  
Se algum programa não aparecer, significa que precisa ser reinstalado.

---

## ⚠️ Observações importantes

- Após instalar o Docker, rode:
  ```bash
  newgrp docker
  ```
  para aplicar permissões sem reiniciar.  

- Após instalar Java ou .NET, rode:
  ```bash
  source ~/.bashrc
  ```
  para aplicar variáveis de ambiente.  

- Durante a instalação do **MySQL** e do **PostgreSQL**, o script pedirá para você digitar **nome de usuário e senha**.  
  Esses usuários serão criados automaticamente com permissões adequadas.

---

👨‍💻 Desenvolvido para a comunidade de entusiastas em programação.  
Contribuições são bem-vindas!
