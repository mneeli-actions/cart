FROM node:20.20.2-alpine3.23 AS builder
WORKDIR /app
COPY package.json .
COPY *.js .
RUN npm install


FROM node:20.20.2-alpine3.23
WORKDIR /app
EXPOSE 8080
COPY --from=builder /app /app
# This env is going to be handled in configmap in k8
ENV CATALOGUE_HOST="catalogue" \
    CATALOGUE_PORT="8080" \
    REDIS_HOST="redis"
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
RUN chown -R roboshop:roboshop /app
USER roboshop
CMD ["server.js"]
ENTRYPOINT ["node"]




#FROM node:20
#
#WORKDIR /app
#
#COPY package*.json ./
#COPY *.js ./
#
#RUN npm install
#
#ENV CATALOGUE_HOST="catalogue" \
#    CATALOGUE_PORT="8080" \
#    REDIS_HOST="redis"
#
#CMD ["node", "server.js"]


