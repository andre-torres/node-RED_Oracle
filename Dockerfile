# Usa a imagem oficial do Node-RED baseada em Node.js (Alpine ou Debian, dependendo da versão)
FROM nodered/node-red:latest-18

# Define o diretório de trabalho
WORKDIR /usr/src/node-red

# Variáveis de ambiente para o Oracle Instant Client
ENV ORACLE_HOME=/opt/oracle/instantclient_12_2
ENV LD_LIBRARY_PATH=$ORACLE_HOME:$LD_LIBRARY_PATH
ENV TNS_ADMIN=/usr/src/node-red/data

# --- Etapa 1: Instalação das dependências e Instant Client ---

# Instala pacotes necessários (ajuste para a sua base, aqui assumimos Debian/Ubuntu)
#RUN apk update
    # Remove a limpeza de cache explícita com 'rm -rf' 
    # e confia no '--no-cache' do 'apk add' para evitar problemas de permissão
    # no processo de build.
    #&& rm -rf /var/cache/apk/*

# Copia os arquivos do Instant Client para a imagem.
#RUN mkdir -p $ORACLE_HOME
#COPY oracle_client/instantclient_12_2/ $ORACLE_HOME/

# Configura links simbólicos (necessário para o node-oracledb encontrar as bibliotecas)
#RUN ln -s $ORACLE_HOME/libclntsh.so.* $ORACLE_HOME/libclntsh.so && \
#    ln -s $ORACLE_HOME/libocci.so.* $ORACLE_HOME/libocci.so

# --- Etapa 2: Instalação do Nó Oracle (Exemplo) ---

# Instala o nó node-oracledb, que usará o Instant Client instalado
# Nota: Você pode precisar instalar outros nós Oracle, como node-red-contrib-oracledb
#RUN npm install node-oracledb --unsafe-perm

# Limpa o cache npm
#RUN npm cache clean --force

# Define o usuário padrão e o comando de inicialização do Node-RED
USER node-red
CMD ["npm", "start"]
