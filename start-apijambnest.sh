#!/bin/bash
set -e

main(){
    server
    config_git
    tail -f /dev/null 
}

config_git{
    git init
    git clone https://github.com/morgadodesarrollador/ApiIncidenciasNest
    npm install --force && npm run start:dev
}

server{
    listen 80;
    listen [::]:80;

    root /var/www/your_domain/html;
    index index.html index.htm index.nginx-debian.html;

    server_name your_domain www.your_domain;

    location / {
        try_files $uri $uri/ =404
    }
}

main



