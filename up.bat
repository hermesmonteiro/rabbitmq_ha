docker swarm init

docker network create --scope=swarm --attachable rabbitHA_network

docker image  build --no-cache -t rabbitmq-cluster-base C:\HM\rabbit_cluster\rabbitmq

docker compose -f C:\HM\rabbit_cluster\rabbit_docker-compose.yml up --force-recreate -d

TIMEOUT 3

docker exec rabbitmq1 sh -c "rabbitmqctl stop_app; rabbitmqctl reset; rabbitmqctl start_app"

TIMEOUT 3

docker exec rabbitmq2 sh -c "rabbitmqctl stop_app; rabbitmqctl reset; rabbitmqctl join_cluster rabbit@rabbitmq1; rabbitmqctl start_app"

docker exec rabbitmq3 sh -c "rabbitmqctl stop_app; rabbitmqctl reset; rabbitmqctl join_cluster rabbit@rabbitmq1; rabbitmqctl start_app"

docker stack deploy -c C:\HM\rabbit_cluster\haproxy_docker-compose.yml haproxyStack

pause