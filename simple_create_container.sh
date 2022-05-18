CONTAINER_NAME="ora_19_ee"
IMAGE_NAME="container-registry.oracle.com/database/enterprise:19.3.0.0"
DB_PORT="1521"
OEM_PORT="500"

docker container create \
    --name $CONTAINER_NAME \
    -p $DB_PORT:1521 \
    -p $OEM_PORT:500 \
    -e ORACLE_PWD=oracle \
    $IMAGE_NAME
