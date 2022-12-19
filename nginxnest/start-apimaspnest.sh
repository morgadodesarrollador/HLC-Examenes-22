#!/bin/bash
set -e
bash /root/start.sh

config_git(){
    mkdir /var/www/html/$PROYECTO
    cd /var/www/html/$PROYECTO
    git init
    git remote add origin $URL_GIT
    git pull origin main
    npm i -g @nestjs/cli
    npm install --force && npm run start:dev

    echo "
    DB_HOST=172.150.10.2
    DB_PORT=5435
    DB_USER=ma
    PORT=3000
    DB_NAME=incidencias
    DB_PASS=pswIncidencias
    HOST_API=http://localhost:3000/api" > .env
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
