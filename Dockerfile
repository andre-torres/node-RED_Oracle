# 1. Fase de Construção (Build Stage)
# Usamos uma imagem mais completa que inclui ferramentas de desenvolvimento
FROM nodered/node-red:latest-18-minimal AS builder

# Instala as ferramentas essenciais de compilação e bibliotecas de sistema
# Usamos 'root' para instalar pacotes do sistema
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    # Adicione bibliotecas de sistema específicas se o nó do SAP HANA exigir (ex: libaio1, libstdc++6)
    # Se o erro for *somente* 'async', essas ferramentas já devem bastar.
    # Exemplo: Se for SAP HANA, adicione o que for necessário aqui
    # libaio1 libstdc++6
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Volta ao usuário node-red padrão e seguro
USER node-red

# Copia o package.json e package-lock.json (se existirem) para o diretório de dados
# Isso é útil se você usa um arquivo de lista de módulos

# Instala todos os módulos listados, incluindo o 'node-red-contrib-sap-hana' e suas dependências
# O npm tentará compilar as dependências nativas neste ambiente rico
RUN npm install

# 2. Fase Final (Final Stage)
# Usamos a imagem minimalista e segura para a execução
FROM nodered/node-red:latest-18-minimal

# Copia os módulos e o arquivo package.json da fase de construção
COPY --from=builder /data/node_modules /data/node_modules
COPY --from=builder /data/package.json /data/package.json

# Se você tem seus fluxos e configurações, copie-os aqui
# Certifique-se de que seus arquivos .json de fluxo estão no diretório /data
# COPY settings.js flows.json /data/

# Define o ponto de entrada (já está definido na imagem base, mas é bom manter)
CMD ["npm", "start", "--", "--userDir", "/data"]
