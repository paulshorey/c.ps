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
-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----