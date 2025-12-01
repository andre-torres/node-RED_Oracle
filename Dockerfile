FROM oraclelinux:8

# Dependências
RUN dnf -y install oracle-nodejs-release-el8 \
    && dnf -y module enable nodejs:18 \
    && dnf -y install nodejs \
    && dnf -y install oracle-instantclient-release-el8 \
    && dnf -y install oracle-instantclient-basiclight \
    && dnf clean all

# Instala Node-RED
RUN npm install -g --unsafe-perm node-red

# Atualiza driver Oracle
RUN npm install -g oracledb@latest

# Usuário não-root
RUN useradd -m node-red
USER node-red

WORKDIR /home/node-red

EXPOSE 1880

CMD ["node-red", "--userDir", "/data"]
