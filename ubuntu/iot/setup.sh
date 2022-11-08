cd ~/iot/mqtt
 sudo nano docker-compose.yml
echo "services:
        mqtt:
                container_name: mosquitto
                image: eclipse-mosquitto
                restart: always
                ports:
                        - "1883:1883"
                        - "9001:9001"
                volumes:
                        - /var/rootdirs/home/root/mqtt/config:/mosquitto/config
                        - /var/rootdirs/home/root/mqtt/data:/mosquitto/data
                        - /var/rootdirs/home/root/mqtt/log:/mosquitto/log
volumes:
        config:
        data:
        log:" > docker-compose.yml
docker-compose up -d

echo "persistence true
persistence_location /mosquitto/data/
log_dest file /mosquitto/log/mosquitto.log" > ~/iot/mqtt/config/mosquitto.config
