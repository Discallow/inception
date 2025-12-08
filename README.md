#####
docker stop $(docker ps -aq); docker rm $(docker ps -aq); docker rmi -f $(docker images -aq);
docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q);
sudo rm -rf /home/discallow/data/wordpress/* /home/discallow/data/mysql/*
