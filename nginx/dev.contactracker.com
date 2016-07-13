upstream rails {
  server api:3000 fail_timeout=0;
}

upstream webpack {
  server client:8080 fail_timeout=0;
}

server {
  listen 80;
  server_name api.contactracker.com;

  location / {
    autoindex on;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header CLIENT_IP $remote_addr;
    proxy_redirect off;
    proxy_pass http://rails;
  }
}

server {
  listen 80;
  server_name dev.contactracker.com;

  location / {
    autoindex on;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_redirect off;
    proxy_pass http://webpack;
  }
}
