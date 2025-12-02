FROM oraclelinux:8

# Dependências base
RUN dnf -y install oracle-nodejs-release-el8 \
    && dnf -y module enable nodejs:18 \
    && dnf -y install nodejs \
    && dnf -y install oracle-instantclient-release-el8 \
    && dnf -y install oracle-instantclient-basiclight \
    && dnf -y install ca-certificates \
    && dnf clean all

# Copia os certificados da SAP
#COPY sap-root.crt /etc/pki/ca-trust/source/anchors/
#COPY sap-intermediate.crt /etc/pki/ca-trust/source/anchors/

# Atualiza o truststore Linux
#RUN update-ca-trust extract

# Node-RED e driver Oracle
RUN npm install -g --unsafe-perm node-red oracledb

# Usuário não-root
RUN useradd -m node-red
USER node-red

WORKDIR /home/node-red

EXPOSE 1880
CMD ["node-red", "--userDir", "/data"]
