#!/bin/bash
/root/start.sh > dev/null &
set -e

fichLogs="/var/logs/apiNest.log"

echo "$USUARIO, $PROYECTO, $DB_NAME" > /home/datos_entry.txt

config_nginx(){
   
    echo "---- nginx --------" >  ${fichLogs}
    sed -i "s/your_domain/$PROYECTO/g" /root/nginx.conf
    cat /root/nginx.conf >> ${fichLogs}
    echo "-----------" >>  ${fichLogs}
    mv /root/nginx.conf /root/$PROYECTO
    mv /root/$PROYECTO /etc/nginx/sites-available/
    ln -s /etc/nginx/sites-available/"$PROYECTO" /etc/nginx/sites-enabled/
    echo "<h1>Nest Nginx- ${PROYECTO}</h1>" > /var/www/html/index.html
    /etc/init.d/nginx start
}

config_git(){
    mkdir /var/www/html/${PROYECTO}
    cd /var/www/html/${PROYECTO}
    rm -rf .git
    
    git config --global init.defaultBranch master
    git config --global http.sslverify false
    git init
    git remote add origin ${URL_Repo_GIT}
    git branch -m master
    git pull origin master
}


config_nest(){
    
    # sed -i "s/DB_HOST=localhost/DB_HOST=${DB_HOST}/g" ./.env
    echo "DB_HOST=${DB_HOST}" > ./.env
    echo "DB_PORT=5432" >> ./.env
    echo "DB_USERNAME=${DB_USERNAME}" >> ./.env
    echo "DB_PASSWORD=${DB_PASSWORD}" >> ./.env
    echo "DB_NAME=${DB_NAME}" >>./.env

    npm install --force && npm run start:dev
    #npm run start:prod
    # nginx dist/main
}

main(){
    
    config_nginx
    config_git
    config_nest
    tail -f /dev/null 
}
main
