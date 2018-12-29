#Create the service file
sudo touch /etc/systemd/system/pybot.service

#Edit the service file, adding the contents of pybot.service here
sudo nano /etc/systemd/system/pybot.service

#Enable the service (this will cause it to start on boot)
sudo systemctl enable pybot

#Start the service so it starts running now
sudo service pybot start

#If you make a change to your code, restart the service so the changes are picked up
sudo service pybot restart