#!/bin/bash
yum update -y
yum install -y httpd mariadb105

systemctl enable httpd
systemctl start httpd

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head><title>VPC 3-Tier Demo</title></head>
<body style="font-family: sans-serif; padding: 40px;">
  <h1>🚀 VPC 3-Tier funcionando!</h1>
  <p><strong>Instance ID:</strong> $INSTANCE_ID</p>
  <p><strong>Availability Zone:</strong> $AZ</p>
  <p><strong>DB Endpoint:</strong> ${db_endpoint}</p>
  <p>Servido por uma EC2 em subnet privada via ALB.</p>
</body>
</html>
EOF