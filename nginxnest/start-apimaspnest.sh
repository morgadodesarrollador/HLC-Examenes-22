#!/bin/bash
set -e
bash /root/start.sh

config_git(){
    rm -rf /var/www/html/$PROYECTO
    mkdir /var/www/html/$PROYECTO
    cd /var/www/html/$PROYECTO
    git init
    git remote add origin $URL_GIT
    git pull origin master
    npm i -g @nestjs/cli
    npm install --force 

    echo "
    PROYECTO=apiLibreria
    DB_HOST=192.168.16.149
    DB_PORT=5437
    DB_USER=miguel
    PORT=3000
    DB_NAME=incidencias
    DB_PASSWD=usuario
    HOST_API=http://localhost:3000/api" > .env
    sed -i "s/5432/5437/" src/app.module.ts
    npm run start:dev
}


# config_apache(){
#     #sed -i "s/${APACHE_RUN_USER}/\www-data/g" /etc/apache2/apache2.conf
#     #sed -i "s/${APACHE_RUN_DIR}/$/g" /etc/apache2/apache2.conf
#     #asocia las variables del apache2.conf con los valores definidos en /etc/apache2/envars
#     source /etc/apache2/envvars
#     # con apache2 -S veremos los valores del las variables asociadas

#     # Apache gets grumpy about PID files pre-existing
#     #rm -f /var/run/apache2/apache2.pid
# }

main(){
    echo "$PROYECTO, ${DB_USER}, ${USUARIO}" >/root/vars_entry.txt
    config_git
    echo "Iniciando .git ..."
    echo "Anadiendo remoto a origin a partir de URL de github del $USUARIO y bajandonos de origin a main ..." > /home/${USUARIO}/apache.log
}

main
#source /etc/apache2/envvars
#echo "apache funcionando ..." > /home/${USUARIO}/apache.log
# rm -f /var/run/apache2/apache2.pid
# Start Apache in foreground
