#!/bin/bash
echo "--[Begin: $(basename "${0}")]-----------------"
echo "Install duf tool"

echo "Looking to the latest release on https://github.com/muesli/duf/releases..."
url=$(curl -s https://github.com/muesli/duf/releases | grep "linux_x86_64.tar.gz" | grep "/muesli/duf/releases" | head -n 1 | cut -d"\"" -f2)
echo "Found url ${url}. Downloading..."

curl -sL "https://github.com${url}" > /tmp/duf_linux_x86_64.tar.gz
echo "Save it into the /tmp/duf_linux_x86_64.tar.gz file"
file /tmp/duf_linux_x86_64.tar.gz || exit 1
tar -xzvf /tmp/duf_linux_x86_64.tar.gz --directory /tmp duf || exit 1
chmod +x /tmp/duf || exit 1

echo "Move duf file into the /usr/local/bin. Need a root permission for that."
sudo mv /tmp/duf /usr/local/bin/
which duf || echo "Error: duf not found"

echo "--[End: $(basename "${0}")  ]-----------------"
