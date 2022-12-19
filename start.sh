#!/bin/bash
set -e

newUser(){
    mkdir "/var/logs"
    echo "Usuario: ${USUARIO}" > "/var/logs/172.150.10.2.log"
    echo "Passwd: ${PASSWD}" >> "/var/logs/172.150.10.2.log"
    if [ ! -d "/home/${USUARIO}" ]
    then
        useradd -rm -d /home/"${USUARIO}" -s /bin/bash "${USUARIO}" 
        echo "root:${PASSWD}" | chpasswd
        echo "${USUARIO}:${PASSWD}" | chpasswd
    fi
}

config_Sudoers(){
    echo "${USUARIO} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
}

config_ssh(){
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    if [ ! -d /home/${USUARIO}/.ssh ]
    then
        mkdir /home/${USUARIO}/.ssh
        cat /root/id_rsa.pub >> /home/${USUARIO}/.ssh/authorized_keys
    fi
    /etc/init.d/ssh start
}

npmInstalar(){
    npm install -g yarn
    yarn --version
    mkdir "/home/dtg/apidtgnest"
    cd "/home/dtg/apidtgnest"
    git init;
    git clone --branch rama-dani "https://github.com/morgadodesarrollador/IAW-Examenes-22"
    cd IAW-Examenes-22
    npm cache clean --force
    npm install --force
    npm run start:dev
    echo "funcionando"
}


main(){
    if [ ! -d "/home/${USUARIO}" ]
    then
        newUser
        config_Sudoers
        config_ssh
        npmInstalar
    fi
    tail -f /dev/null 

}

main
