export DEBIAN_FRONTEND=noninteractive

mkdir /home/ubuntu/FAST
echo "FAST directory created" > /home/ubuntu/FAST/setup_log.txt

apt update -y
echo "apt update initiated" >> /home/ubuntu/FAST/setup_log.txt

sudo wget -O splunk-9.3.0-51ccf43db5bd-linux-2.6-amd64.deb "https://download.splunk.com/products/splunk/releases/9.3.0/linux/splunk-9.3.0-51ccf43db5bd-linux-2.6-amd64.deb" 
echo "Splunk download initiated" >> /home/ubuntu/FAST/setup_log.txt

sudo dpkg -i /home/ubuntu/splunk-9.3.0-51ccf43db5bd-linux-2.6-amd64.deb
echo "Splunk installation initiated" >> /home/ubuntu/FAST/setup_log.txt

cd /opt/splunk/bin
echo "Location set to Splunk binaries directory" >> /home/ubuntu/FAST/setup_log.txt

sudo ./splunk enable boot-start --accept-license
FASTsplunk
$TEST_VAR
$TEST_VAR
echo "Splunk configured to start on boot and user account created" >> /home/ubuntu/FAST/setup_log.txt

sudo ./splunk start
echo "Splunk started" >> /home/ubuntu/FAST/setup_log.txt
