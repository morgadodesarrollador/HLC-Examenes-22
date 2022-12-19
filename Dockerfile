
FROM ub-base


RUN apt-get update -y && apt install -yq --no-install-recommends \
    ca-certificates \
    gnupg2 \
    nginx

RUN mkdir -p /var/www/your_domain/html

WORKDIR /var/www/your_domain/html

#añadimos sourcelist
COPY ./nodesource.list /etc/apt/sources.list.d/
ARG USUARIO
ARG PASSWD
ARG TZ

# ARG

ENV USUARIO=${USUARIO}
ENV PASSWD=${PASSWD}
ENV TZ=${TZ}


RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

COPY ./nginx.conf /etc/nginx/conf.d/nginx.conf
COPY ./nginx.conf /etc/nginx/conf.d/nginx.conf
COPY ./start-apijlpmnest.sh /root
RUN chmod +x /root/start-apijlpmnest.sh
RUN dos2unix /root/start-apijlpmnest.sh

EXPOSE 8090

RUN apt-get install nodejs nginx npm -y

ENTRYPOINT [ "/root/start-apijlpmnest.sh" ]


