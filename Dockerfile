FROM dongsxyz/python-supervisord:latest
USER root

RUN apt update && apt install -y lsb-release vim gnupg
RUN curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
RUN 
RUN echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list
RUN 
RUN apt update && apt install -y redis


RUN mkdir /redis
RUN cd /redis && mkdir -p data log conf cert
COPY redis.conf /redis/redis.conf
COPY users.acl /redis/conf/users.acl
RUN touch /redis/log/redis.log
RUN dos2unix /redis/redis.conf
RUN dos2unix /redis/conf/users.acl
COPY cert.conf /tmp/cert.conf
RUN openssl req -new -x509 -sha256 \
   -newkey rsa:2048 -nodes -days 365 \
   -keyout /redis/cert/key.pem \
   -out /redis/cert/cert.pem \
   -subj /C=US/ST=Oregon/L=Portland/O=The\ Eastwind/OU=IT/CN=dongs.xyz
COPY redis.supervisord.conf /app/_supervisor.d/redis.conf