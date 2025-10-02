export DEBIAN_FRONTEND=noninteractive

mkdir /home/ubuntu/FAST
echo "FAST directory created" > /home/ubuntu/FAST/setup_log.txt

apt update -y
echo "apt update initiated" >> /home/ubuntu/FAST/setup_log.txt

echo "$TEST_VAR" >> /home/ubuntu/FAST/setup_log.txt