
FROM nodered/node-red:3.1.10-debian
#FROM nodered/node-red:latest

ENV NODE_ENV=production \
    NODE_OPTIONS=--max-old-space-size=2048
    
USER root

#RUN apt-get update && apt-get install -y
RUN apt-get install ca-certificates
RUN apt-get install curl
#RUN apt-get install unzip
RUN apt-get install python3
RUN apt-get install make
RUN apt-get install g++
RUN apt-get install libstdc++6
RUN rm -rf /var/lib/apt/lists/*


#USER node-red
RUN npm install 
#--unsafe-perm
RUN npm install async


# ----------------------------------------
# Oracle Instant Client (THICK MODE)
# ----------------------------------------
WORKDIR /opt/oracle

# Copia a pasta inteira (já extraída)
COPY oracle_client/instantclient_11_2 ./instantclient

# Permissões
#RUN chmod -R 755 /opt/oracle/instantclient \
#    && ldconfig

    

# Define o ponto de entrada (já está definido na imagem base, mas é bom manter)
CMD ["npm", "start", "--", "--userDir", "/data"]
