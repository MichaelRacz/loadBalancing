(docker ps -qa -f network=load_balancing) | xargs docker stop | xargs docker rm

docker stop registrator
docker rm registrator

docker network rm load_balancing

docker rmi load_balancing/hostname
docker rmi load_balancing/nginx
