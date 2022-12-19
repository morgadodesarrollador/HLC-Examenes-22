FROM ub-base

ARG TZ

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY ./start.apijambnest.sh /root
COPY ./nodesource.list /etc/apt/sources.list.d/

RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN apt-get update && apt-get install -y nodejs

RUN chmod +x /root/start-apijambnest.sh
RUN mkdir /var/logs

RUN apt update && apt install -yq --no-install-recommends \
    ca-certificates \
    gnupg2 \
    nginx
RUN 

RUN dos2unix /root/start-apijambnest.sh
ENTRYPOINT [ "/root/start.apijambnest.sh" ]
