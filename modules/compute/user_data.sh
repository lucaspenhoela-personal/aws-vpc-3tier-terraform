#!/bin/bash
yum update -y
yum install -y httpd mariadb105

systemctl enable httpd
systemctl start httpd

# IMDSv2: primeiro pega um token, depois usa o token para consultar
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)

AZ=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/placement/availability-zone)

cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
  <title>VPC 3-Tier Demo</title>
  <style>
    body { font-family: sans-serif; padding: 40px; background: #f5f5f5; }
    .card { background: white; padding: 30px; border-radius: 8px; max-width: 700px; margin: auto; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
    h1 { color: #232F3E; }
    .field { padding: 10px; background: #f9f9f9; border-left: 4px solid #FF9900; margin: 10px 0; }
  </style>
</head>
<body>
  <div class="card">
    <h1>🚀 VPC 3-Tier funcionando!</h1>
    <div class="field"><strong>Instance ID:</strong> $INSTANCE_ID</div>
    <div class="field"><strong>Availability Zone:</strong> $AZ</div>
    <div class="field"><strong>DB Endpoint:</strong> ${db_endpoint}</div>
    <p>Servido por uma EC2 em subnet privada via ALB.</p>
  </div>
</body>
</html>
EOF