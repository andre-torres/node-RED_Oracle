
FROM nodered/node-red:latest-18-minimal

USER root

RUN npm install
RUN npm install async

# Define o ponto de entrada (já está definido na imagem base, mas é bom manter)
CMD ["npm", "start", "--", "--userDir", "/data"]
