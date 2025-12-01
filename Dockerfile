FROM ghcr.io/baungarten/node-red-oracle:latest

USER root

# Atualiza driver Oracle
RUN npm install oracledb@latest

USER node-red
