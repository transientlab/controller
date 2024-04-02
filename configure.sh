# _ t r a n s i e n t l a b
# Author: Paweł Kreis
# pawel@transientlab.net
# 
# THIS CODE IS COPYRIGHTED 
# YOU ARE NOT ALLOWED TO COPY OR USE THE CODE WITHOUT DISCUSSING IT WITH THE AUTHOR
#
# Show controller system for EIDOTECH
# : configure.sh : server software installation
sudo apt-get install git netcat-openbsd &&
sudo apt-get install npm nodejs mosquitto-clients &&
sudo npm install express


# add key to github repo
cd ~/.ssh
ssh-keygen -t ed25519 -C "kreispawel@gmail.com" -f github-key
ssh-add github-key
cat github-key.pub # >> [http://github.com -> Account/Settings/SSH and GPG/ -> Add new key]
