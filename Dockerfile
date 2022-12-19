
FROM ub-base


RUN apt-get update -y && apt install -yq --no-install-recommends \
    software-properties-common \
    ca-certificates \
    gnupg2 \
    nginx

RUN mkdir -p /var/www/your_domain/html

WORKDIR /var/www/your_domain/html

COPY ./nginx.conf /etc/nginx/conf.d/nginx.conf

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

COPY ./start-apijlpmnest.sh /root
RUN chmod +x /root/start-apijlpmnest.sh
RUN dos2unix /root/start-apijlpmnest.sh

EXPOSE 3000

RUN apt-get install nodejs nginx php npm yarn -y

ENTRYPOINT [ "/root/start-apijlpmnest.sh" ]


