
FROM nodered/node-red:3.1.10-debian
#FROM nodered/node-red:latest

ENV NODE_ENV=production \
    NODE_OPTIONS=--max-old-space-size=2048
    
USER root

#RUN apt-get update && apt-get install -y
RUN apt-get install ca-certificates
RUN apt-get install curl
RUN apt-get install unzip
RUN apt-get install python3
RUN apt-get install make
RUN apt-get install g++
RUN apt-get install libstdc++6
RUN rm -rf /var/lib/apt/lists/*

# ----------------------------------------
# Oracle Instant Client (THICK MODE)
# ----------------------------------------
WORKDIR /opt/oracle

RUN curl -L https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linux.x64-21.11.0.0.0dbru.zip \
    -o instantclient.zip \
    && unzip instantclient.zip \
    && rm instantclient.zip \
    && ln -s instantclient_* instantclient

    
    
#USER node-red
RUN npm install --unsafe-perm
RUN npm install async

# Define o ponto de entrada (já está definido na imagem base, mas é bom manter)
CMD ["npm", "start", "--", "--userDir", "/data"]
