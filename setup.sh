#!/bin/bash

echo "LANG=en_US.utf-8" > /etc/environment
echo "LC_ALL=en_US.utf-8" > /etc/environment

source /etc/environment

yum install -y vim git scl-utils
rpm -Uvh https://www.softwarecollections.org/en/scls/rhscl/python33/epel-7-x86_64/download/rhscl-python33-epel-7-x86_64.noarch.rpm
yum install -y python33

cat >/etc/profile.d/enablepython33.sh <<EOL
#!/bin/bash
source /opt/rh/python33/enable
EOL

chmod +x /etc/profile.d/enablepython33.sh
source /etc/profile

wget https://raw.githubusercontent.com/pypa/pip/master/contrib/get-pip.py
python get-pip.py

pip install requests
pip install arrow
pip install gunicorn
pip install flask

# Allow incomming connections to port 8000
iptables -A IN_public_allow -p tcp --dport 8000 -j ACCEPT
