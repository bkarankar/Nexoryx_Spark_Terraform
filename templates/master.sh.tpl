#!/bin/bash
apt-get update -y
apt-get install -y docker.io

systemctl enable docker
systemctl start docker

docker network create spark-net || true

docker run -d \
  --name spark-master \
  --network spark-net \
  -p 8080:8080 \
  -p 7077:7077 \
  bitnami/spark:latest \
  /opt/bitnami/spark/bin/spark-class org.apache.spark.deploy.master.Master
