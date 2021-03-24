#!/bin/bash
echo "--[Begin: $(basename "${0}")]-----------------"

echo "Installing light web server 'lighttpd'..."
sudo apt-get install lighttpd
sudo mkdir -p /var/www/cgi-bin 2>/dev/null

# Generate test pages
echo "<h1>It's work.</h1>" | sudo tee /var/www/index.html
echo -e '#!/bin/sh
echo "Content-type: text/html"
echo ""
echo "<html><head><title>Sample CGI Output</title></head>"
echo "<body>"
echo "<h1>Welcome to the $(hostname) server</h1>"
echo "<hr/>"
echo "<h2>System environment</h2>"
echo "<pre>"
env
echo "</pre>"
echo "</body></html>"
echo ""
echo ""
' | sudo tee /var/www/cgi-bin/env
sudo chmod +x /var/www/cgi-bin/env
sudo chown -R www-data:www-data /var/www


[ ! -f "/etc/lighttpd/lighttpd.conf.orig" ] && sudo mv /etc/lighttpd/lighttpd.conf /etc/lighttpd/lighttpd.conf.orig

cat /etc/lighttpd/lighttpd.conf.orig \
    | sed 's/"\/var\/www\/html"/"\/var\/www"/g' \
    > /etc/lighttpd/lighttpd.conf
chown root:root /etc/lighttpd/lighttpd.conf
chmod 644 /etc/lighttpd/lighttpd.conf

sudo ln -s /etc/lighttpd/conf-available/10-cgi.conf /etc/lighttpd/conf-enabled/

sudo service lighttpd stop
sudo service lighttpd start

echo "--[End: $(basename "${0}")  ]-----------------"
