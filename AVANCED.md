# ⚙️ Instruções Avançadas – Ubuntu Setup Interativo

Este documento complementa o `README.md` principal com instruções avançadas para personalização e ajustes do ambiente.

---

## 🐬 MySQL – Personalização de Usuários

Durante a instalação, o script já cria um usuário e senha conforme solicitado.  
Se você quiser criar manualmente outros usuários ou ajustar permissões:

```bash
sudo mysql -u root -p
```

Dentro do prompt do MySQL:

```sql
CREATE USER 'meuusuario'@'localhost' IDENTIFIED BY 'minhasenha';
GRANT ALL PRIVILEGES ON *.* TO 'meuusuario'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

👉 Isso cria um usuário adicional com permissões completas.

---

## 🐘 PostgreSQL – Personalização de Usuários

Durante a instalação, o script já cria um usuário e senha conforme solicitado.  
Para criar manualmente outros usuários:

```bash
sudo -u postgres psql
```

Dentro do prompt do PostgreSQL:

```sql
CREATE USER meuusuario WITH PASSWORD 'minhasenha';
ALTER ROLE meuusuario CREATEDB;
```

👉 Isso cria um usuário com permissão para criar bancos de dados.

---

## 🌐 Variáveis de Ambiente

Alguns pacotes (Java, .NET, Node.js) precisam de variáveis de ambiente configuradas.  
O script já adiciona ao `~/.bashrc`, mas se quiser ajustar manualmente:

```bash
nano ~/.bashrc
```

Adicione ou edite:

```bash
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
```

Depois aplique:

```bash
source ~/.bashrc
```

---

## 🐳 Docker – Permissões

Após instalar o Docker, é necessário aplicar permissões ao grupo `docker`:

```bash
newgrp docker
```

Se ainda houver problemas, verifique se o usuário está no grupo:

```bash
groups $USER
```

Se não aparecer `docker`, adicione manualmente:

```bash
sudo usermod -aG docker $USER
```

---

## 🔧 Troubleshooting

- **Erro de permissão no Docker**: rode `newgrp docker` ou reinicie a sessão.  
- **Java não encontrado**: confirme se `JAVA_HOME` está correto e rode `source ~/.bashrc`.  
- **Dotnet não encontrado**: confirme se `DOTNET_ROOT` está configurado e rode `source ~/.bashrc`.  
- **MySQL/Postgres não pedem senha**: use `sudo mysql` ou `sudo -u postgres psql` para acessar diretamente e ajustar usuários.  
- **Pacotes obsoletos**: rode `sudo apt autoremove -y && sudo apt autoclean -y`.

---

👨‍💻 Este guia avançado ajuda a personalizar e resolver problemas comuns após a instalação.  
Use junto com o `README.md` principal para ter um ambiente completo e ajustado às suas necessidades.
