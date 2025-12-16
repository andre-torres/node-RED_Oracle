
#FROM nodered/node-red:3.1.10-debian
FROM nodered/node-red:latest

ENV NODE_ENV=production \
    NODE_OPTIONS=--max-old-space-size=2048
    
USER root

#RUN apt-get update && apt-get install -y
#    ca-certificates \
#    curl \
#    unzip \
#    python3 \
#    make \
#    g++ \
#    libstdc++6
#    && rm -rf /var/lib/apt/lists/*

#USER node-red

RUN npm install --unsafe-perm \
    node-red-contrib-sap-hana

#RUN npm install
#RUN npm install async

# Define o ponto de entrada (já está definido na imagem base, mas é bom manter)
CMD ["npm", "start", "--", "--userDir", "/data"]
