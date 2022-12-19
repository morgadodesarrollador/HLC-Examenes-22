#!/bin/bash

set -e

bash /root/start.sh

main(){
    rm -rf /var/www/your_domain/html
    mkdir /var/www/your_domain/html
    cd /var/www/your_domain/html
    git init
    git remote add origin https://github.com/morgadodesarrollador/ApiIncidenciasNest.git
    git pull origin master
    
    npm i -g @nestjs/cli
    npm install
    

    echo "
        DB_HOST=192.168.48.128
        DB_PORT=5435
        DB_USERNAME=postgres
        DB_NAME=Incidencias
        DB_PASSWORD=pswIncidencias

        PORT=3000
        HOST_API=http://localhost:3000/api

        JWT_SECRET=incidencias" > .env


        # yarn start:dev
        npm run start:dev
}

main