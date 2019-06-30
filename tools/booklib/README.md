# [docker-book-library][github-repo]

Repository contains helper scripts and settings to launch [Calibre-Web][calibreweb-site] locally inside a docker container.


# Dependencies

* [Calibre-Web docker image from technosoft2000][calibreweb-hub]


# Usage

Download [booklib helper bash script][booklib-helper-script] and install it into your PATH directory.

```
mkdir -p ~/bin
wget -O ~/bin/booklib https://raw.githubusercontent.com/revgen/docker-book-library/master/bin/booklib
chmod +x wget -O ~/bin/booklib
```

# BookLib Settings

## Environment veriables which you can use before start BookLib container


## Reverse Proxy settings (nginx)

The Calibre-Web was raised on the same host and it is using a port 8083.

```
sudo vim /etc/nginx/site-available/default
```
```
rewrite ^/books$ /books/ permanent;
location /books/ {
    proxy_pass         http://localhost:8083;
    proxy_redirect     off;
    proxy_set_header   Host               $host;
    proxy_set_header   X-Real-IP          $remote_addr;
    proxy_set_header   X-Forwarded-For    $proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Host   $host;
    proxy_set_header   X-Script-Name      /books;
    access_log         /var/log/nginx/site-books.log;
    error_log          /var/log/nginx/site-books-error.log;
}
```
```
sudo service nginx restart 
```

After that you have an ability to open Calibri-Web on the http://<servername>/books


[github-repo]: https://github.com/revgen/docker-repository/docker-book-library/
[calibreweb-site]: https://github.com/janeczku/calibre-web
[calibreweb-hub]: https://hub.docker.com/r/technosoft2000/calibre-web/
[booklib-helper-script]: https://raw.githubusercontent.com/revgen/docker-repository/master/docker-book-library/bin/booklib
