server {
  listen 443 ssl http2;
  listen [::]:443 ssl http2;

  server_name api.YOUR_DOMAIN;

  access_log /var/log/nginx/APP_FOLDER/access.log;
  error_log /var/log/nginx/APP_FOLDER/error.log;

  ssl_certificate /etc/letsencrypt/live/api.YOUR_DOMAIN/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/api.YOUR_DOMAIN/privkey.pem;
  ssl_trusted_certificate /etc/letsencrypt/live/api.YOUR_DOMAIN/chain.pem;

  location / {
    proxy_pass http://127.0.0.1:3000;
    include nginxconfig.io/proxy.conf;
  }

  include nginxconfig.io/general.conf;
}

server {
  listen 443 ssl http2;
  listen [::]:443 ssl http2;

  server_name *.api.YOUR_DOMAIN;

  ssl_certificate /etc/letsencrypt/live/api.YOUR_DOMAIN/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/api.YOUR_DOMAIN/privkey.pem;
  ssl_trusted_certificate /etc/letsencrypt/live/api.YOUR_DOMAIN/chain.pem;
  
  return 301 https://api.YOUR_DOMAIN$request_uri;
}

server {
  listen 80;
  listen [::]:80;

  server_name .api.YOUR_DOMAIN;

  include nginxconfig.io/letsencrypt.conf;

  location / {
    return 301 http://api.YOUR_DOMAIN$request_uri;
  }
}
