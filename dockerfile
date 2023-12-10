FROM ubuntu:18.04

# コンテナ内でパッケージの更新を行い、Apache2をインストールするためのaptコマンドを実行
RUN apt-get update && \
 apt-get -y install apache2

# /var/www/html/index.htmlというファイルに "Hello World!" というテキストを書き込むためのechoコマンドを実行
RUN echo 'nginx container!' > /var/www/html/index.html

# Configure apache
RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh && \
 echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh && \
 echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh && \ 
 echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh && \ 
 chmod 755 /root/run_apache.sh

# コンテナが使用するポートを80で指定して、HTTP通信をしている
EXPOSE 80

# コンテナ実行時に動かすコマンドを指定、webサーバを起動するシェルスクリプトを指定している。
CMD /root/run_apache.sh