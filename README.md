# inception
To do:
- Implementar networks;
- Adicionar os 2 volumes;
- proteger para re-link (validar em cada Dockerfile se o software já existe nesse container)


#####
docker stop $(docker ps -aq); docker rm $(docker ps -aq); docker rmi -f $(docker images -aq);
docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q);
