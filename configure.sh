sudo apt-get install git netcat-openbsd &&
sudo apt-get install npm nodejs mosquitto-clients &&
sudo npm install express


# add key to github repo
cd ~/.ssh
ssh-keygen -t ed25519 -C "kreispawel@gmail.com" -f github-key
ssh-add github-key
cat github-key.pub # >> [http://github.com -> Account/Settings/SSH and GPG/ -> Add new key]
