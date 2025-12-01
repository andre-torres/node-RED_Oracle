FROM nodered/node-red:latest

USER root

# Dependências sistema
RUN apk add --no-cache libaio unzip curl

# Oracle Instant Client
WORKDIR /opt/oracle

RUN curl -O https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linux.x64-21.11.0.0.0dbru.zip \
    && unzip instantclient-basiclite-linux.x64-21.11.0.0.0dbru.zip \
    && rm -f *.zip \
    && mv instantclient_* instantclient

# Configura bibliotecas compartilhadas
RUN echo "/opt/oracle/instantclient" > /etc/ld.so.conf.d/oracle.conf && ldconfig

# Atualiza driver Oracle
RUN npm install oracledb@latest

USER node-red
