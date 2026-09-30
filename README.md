## 📄 README.md

## 🖥️ Exemplo do menu interativo



```markdown
# 🚀 Ubuntu Setup Interativo

Este projeto disponibiliza um **script automatizado e interativo** para configurar um ambiente de desenvolvimento e produção no **Ubuntu 26.04**.  
Ele funciona no estilo **tasksel**, permitindo que o usuário escolha quais programas deseja instalar, sempre com mensagens explicativas sobre o que está sendo instalado ou removido.

---

## 📦 Programas disponíveis para instalação

O menu interativo permite instalar:

- **Node.js 22.x + npm (via Corepack)**
- **Java (OpenJDK 8, 11, 17, 21)**
- **Docker (CE, CLI, Compose, Buildx)**
- **Yarn (última versão estável)**
- **Expo CLI**
- **Dependências do Android Studio (KVM, QEMU, libvirt, bridge-utils)**
- **Apache + PHP (CLI, Xdebug, Curl, Mbstring, Json, Mysql)**
- **MySQL Server**
- **PostgreSQL + PgAdmin 4**
- **.NET SDK e Runtime (10.x)**

---

## ⚙️ Como usar

1. Clone este repositório:
   ```bash
   git clone https://github.com/soufernandocoutinho/ubuntu-setup-dev.git
   cd ubuntu-setup
   ```

2. Dê permissão de execução ao script:
   ```bash
   chmod +x setup.sh
   ```

3. Execute o script:
   ```bash
   ./setup.sh
   ```

4. Escolha no menu interativo os programas que deseja instalar.  
   O script explicará cada ação (instalação ou remoção de pacotes obsoletos).

---

## 🔎 Verificação do ambiente

Após a instalação, você pode rodar o **script de verificação** para garantir que tudo está funcionando.

### check-env.sh

### Como usar

- Dê permissão de execução:
   ```bash
   chmod +x check-env.sh
   ```

- Execute:
   ```bash
   ./check-env.sh
   ```

Ele vai rodar todos os testes e mostrar as versões instaladas. Se algum programa não aparecer, significa que precisa ser reinstalado.

---

## 🎯 Objetivo

Este projeto foi criado para ajudar **usuários entusiastas em programação** a configurar rapidamente um ambiente completo no Ubuntu, sem precisar instalar manualmente cada pacote.  
Ele garante que todas as ferramentas estejam atualizadas e evita conflitos de versões antigas.

---

## ⚠️ Observações

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

---

👨‍💻 Desenvolvido para a comunidade de entusiastas em programação.  
Contribuições são bem-vindas!
```

---

👉 Assim você terá no GitHub:  
- `setup.sh` → menu interativo.  
- `check-env.sh` → validação rápida do ambiente.  
- `README.md` → documentação completa.
