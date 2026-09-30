#!/usr/bin/env bash
# Ubuntu Setup Interativo
# Autor: Fernando Coutinho
# Licença: MIT (veja LICENSE)
# Descrição: Script para instalar e configurar ambiente de desenvolvimento no Ubuntu 26.04
set -euo pipefail

echo "🔎 Iniciando verificação do ambiente..."

# Função para testar comandos
testar() {
    local comando=$1
    echo -n "➡️ Testando $comando... "
    if command -v $comando &> /dev/null; then
        $comando --version || $comando -v || $comando -V
    else
        echo "❌ $comando não encontrado"
    fi
}

# Testes principais
testar node
testar npm
testar yarn
testar expo
testar java
testar dotnet
testar docker
testar mysql
testar psql
testar apache2
testar php

echo "✅ Verificação concluída!"
echo "Se todos os comandos acima retornaram versão, o ambiente está pronto."
