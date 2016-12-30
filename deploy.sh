DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker network create load_balancing

docker run -d --net load_balancing --name consul -p 8500:8500 consul

docker run -d --net host --name registrator -v /var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator -internal consul://localhost:8500

docker build --tag load_balancing/hostname ${DIR}/hostname

for run in {1..4}
do
  docker run -d --net load_balancing load_balancing/hostname
done

${DIR}/nginx/generateConf.sh
docker build --tag load_balancing/nginx ${DIR}/nginx
docker run -d --net load_balancing --name nginx -p 80:80 load_balancing/nginx
