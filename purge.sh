docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq)
docker volume rm $(docker volume ls -q)
chmod 777 -Rv pgadmin-data
rm -rvf pgadmin-data