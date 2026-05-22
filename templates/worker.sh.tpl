#!/bin/bash
apt-get update -y
apt-get install -y docker.io

systemctl enable docker
systemctl start docker

docker run -d \
  --name spark-worker \
  --network host \
  bitnami/spark:latest \
  /opt/bitnami/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://${master_ip}:7077
