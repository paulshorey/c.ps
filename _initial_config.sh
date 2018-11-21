# first, install Node and NPM

sudo apt update;
sudo apt install nginx;
sudo systemctl enable nginx
sudo systemctl start nginx

echo "
server {
    listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;

    server_name c.paulshorey.com;
    root /www/c.ps/app;

    index index.html;

    location / {
            try_files $uri $uri/ =400;
    }
    
    location ~ /\.well-known/acme-challenge {
		default_type 'text/plain';
		root /www/sslcert; #or wherever dir
		try_files /$uri /;
	}
}
" >> /etc/nginx/sites-available/default

sudo nginx -t
sudo systemctl restart nginx


###
# /etc/crontab
###
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
# m h dom mon dow user  command
17 *    * * *   root    cd / && run-parts --report /etc/cron.hourly
25 6    * * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
47 6    * * 7   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6    1 * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )
# now served by Nginx:
#@reboot root bash /www/ps/_cron/app.sh
@reboot root bash /www/ps/_cron/deploy.sh
#



###
# ~/.zprofile
###
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/newssh
cd /www/c.ps;
git reset HEAD -\-hard;
git pull
source ~/.aliases.sh;
alias sublime='rsub';
EDITOR=ne;
echo ""
echo "TIPS:"
echo "rsub ./filename"
echo ""
#



###
# /etc/nginx/sites-available/default
###
server {
        listen 80;
        listen [::]:80;

        #listen 443 ssl;
        #listen [::]:443 ssl;

        root /www/ps/www/paulshorey;

        #ssl_certificate /etc/letsencrypt/live/paulshorey.com/fullchain.pem;
        #ssl_certificate_key /etc/letsencrypt/live/paulshorey.com/privkey.pem;

        #location ~ /html {
        #        root /www; #this will serve from /www/html
        #        allow all;
        #}

        #location ~ /.well-known {
        #        root /www/html;
        #        allow all;
        #}
        #location ~ /.well-known/acme-challenge {
        #        root /www/html;
        #        allow all;
        #}

        #location /node {
        #        proxy_set_header   X-Forwarded-For $remote_addr;
        #        proxy_set_header   Host $http_host;
        #        proxy_pass         "http://127.0.0.1:2080";
        #}

        #location /api {
        #        proxy_set_header   X-Forwarded-For $remote_addr;
        #        proxy_set_header   Host $http_host;
        #        proxy_pass         "http://127.0.0.1:1080";
        #}
}
server {
    server_name carteblanchejazzband.com carteblanchejazzband.paulshorey.com;
    listen 80;
    root /www/ps/www/carteblanchejazzband;
    try_files $uri $uri/ index.html /index.html =404;
    allow all;
    autoindex on;
}
server {
    server_name luxul.paulshorey.com;
    listen 80;
    root /www/ps/www/luxul;
    try_files $uri $uri/ index.html /index.html =404;
    allow all;
    autoindex on;
}
server {
    server_name beyond.paulshorey.com;
    listen 80;
    root /www/ps/www/beyond;
    try_files $uri $uri/ index.html /index.html =404;
    allow all;
    autoindex on;
}
server {
    server_name corrosion.paulshorey.com;
    listen 80;
    root /www/ps/www/beyond/bp-corrosion;
    try_files $uri $uri/ index.html /index.html =404;
    allow all;
    autoindex on;
}



###
# ~/.ssh/newssh
###
echo "" >> ~/.ssh/newssh