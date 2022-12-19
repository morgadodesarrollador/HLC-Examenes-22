#!/bin/bash
set -e
bash /root/start.sh > dev/null &

variables_entorno() {
    # DIR_DFILES=${DIR_DFILES}
    # USUARIO=${USUARIO}
    # PASSWD=${PASSWD}
    # TZ=${TZ}
    # GIT=${GIT}
    # PROYECTO=${PROYECTO}
    # DB_USER=${DB_USER}
    # DB_PORT=${DB_PORT}
    # PORTSSH=${PORTSSH}
    # PUERTO=${PUERTO}

    echo "DB_HOST=${DB_HOST}" >> /var/www/html/pbfIncidencias/.env
    echo "DB_PORT2=${DB_PORT2}" >> /var/www/html/pbfIncidencias/.env
    echo "DB_USERNAME=${DB_USERNAME}" >> /var/www/html/pbfIncidencias/.env
    echo "DB_NAME=${DB_NAME}" >> /var/www/html/pbfIncidencias/.env
    echo "DB_PASSWORD=${DB_PASSWORD}" >> /var/www/html/pbfIncidencias/.env
    echo "PORT=${PORT}" >> /var/www/html/pbfIncidencias/.env
    echo "HOST_API=${HOST_API}" >> /var/www/html/pbfIncidencias/.env
    echo "JWT_SECRET=${JWT_SECRET}" >> /var/www/html/pbfIncidencias/.env
    
}

config_git(){
    mkdir /var/www/html/pbfIncidencias
    cd /var/www/html/pbfIncidencias
    git config --global user.name "PedritoBF03"
    git config --global user.email "pedrobf2003@gmail.com"
    git init
    git remote add origin ${GIT}
    git branch -M master
    git pull origin master
    npm install --force 
#  && npm run start:dev
    # yarn install
}

config_nginx() {
    cp /etc/nginx/nginx.conf /root/nginx.conf
}

main(){
    config_nginx
    config_git
    variables_entorno

    tail -f /dev/null
}

main