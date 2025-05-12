#!/bin/bash
sudo apt update -y
# sudo apt install -y openjdk-17-jdk nginx git

# clone your app repo
cd /home/ubuntu
git clone https://github.com/Aswathysankar05/cloud-servicedesk.git

# backend
cd servicedesk/backend
./gradlew build
nohup java -jar build/libs/*.jar > backend.log 2>&1 &

# frontend
cd ../frontend
npm install
npm run build
cp -r build/* /var/www/html/
