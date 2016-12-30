DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker run --net load_balancing --rm > ${DIR}/nginx.conf python python -c '
import sys, json, urllib.request;

services_response = urllib.request.urlopen("http://consul:8500/v1/catalog/service/hostname");
services = json.loads(services_response.read().decode("utf-8"));
service_addresses = [service["ServiceAddress"] for service in services]
server_entries = ["  server {};".format(address) for address in service_addresses];

config = """upstream service {{
{}
}}

server {{
  listen 80;

  location / {{
    proxy_pass http://service;
  }}
}}""".format("\n".join(server_entries));

print(config);
'
