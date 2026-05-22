output "spark_master_public_ip" {
  value = aws_instance.spark_master.public_ip
}

output "spark_master_private_ip" {
  value = aws_instance.spark_master.private_ip
}

output "spark_master_ui" {
  value = "http://${aws_instance.spark_master.public_ip}:8080"
}

output "worker_instance_ids" {
  value = aws_instance.spark_workers[*].id
}