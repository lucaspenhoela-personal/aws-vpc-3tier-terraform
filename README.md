![Terraform CI](https://github.com/lucaspenhoela-personal/aws-vpc-3tier-terraform/actions/workflows/terraform-validate.yml/badge.svg)
![Terraform](https://img.shields.io/badge/Terraform-1.7+-7B42BC?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Free%20Tier-FF9900?logo=amazon-aws)
![License](https://img.shields.io/badge/license-MIT-blue)

> Infraestrutura 3-tier completa e modular na AWS, provisionada via Terraform.
> ALB público + EC2 Auto Scaling em subnets privadas + RDS MySQL isolado.

## 🎬 Demo

![Demo](docs/images/demo.gif)

## 🏛️ Arquitetura

![Arquitetura](docs/images/architecture.png)

### Componentes

- **Web Tier (público):** Application Load Balancer em 2 AZs
- **App Tier (privado):** EC2 Auto Scaling Group (min: 1, max: 3)
- **DB Tier (isolado):** RDS MySQL 8.0 sem acesso público
- **Networking:** VPC com 6 subnets (2 públicas, 2 app privadas, 2 DB privadas)
- **Security:** Defense-in-depth com 3 Security Groups encadeados

## 🚀 Stack

| Categoria | Tecnologia |
|---|---|
| IaC | Terraform 1.7+ |
| Cloud | AWS (us-east-1) |
| Compute | EC2 (t3.micro), Auto Scaling Group |
| Network | VPC, ALB, NAT Gateway, IGW |
| Database | RDS MySQL 8.0 |
| State | S3 + DynamoDB locking |
| CI/CD | GitHub Actions |

## 📋 Pré-requisitos

- AWS Account com Free Tier
- AWS CLI v2 configurado
- Terraform >= 1.6
- Git

## ⚡ Quick Start

```bash
git clone https://github.com/SEU-USER/aws-vpc-3tier-terraform.git
cd aws-vpc-3tier-terraform/environments/dev

terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

Depois acesse o output `alb_dns_name` no navegador.

📖 Guia detalhado em [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md)

## 🗂️ Estrutura do Projeto

```
.
├── environments/dev/    # Composição do ambiente
└── modules/             # Módulos Terraform reutilizáveis
    ├── vpc/             # VPC, subnets, routing
    ├── security/        # Security Groups em camadas
    ├── alb/             # Application Load Balancer
    ├── compute/         # EC2 + Auto Scaling
    └── database/        # RDS MySQL
```

## 💰 Custos

Praticamente Free Tier, mas **atenção**:
- NAT Gateway: ~$32/mês (não é grátis)
- ALB: ~$16/mês

📊 Análise completa em [docs/COSTS.md](docs/COSTS.md)

⚠️ **SEMPRE rode `terraform destroy` após testes.**

## 📸 Screenshots

| Aplicação rodando | Resource Map AWS |
|---|---|
| ![App](docs/images/app-running.png) | ![Map](docs/images/aws-resource-map.png) |

## 🎯 O que aprendi com esse projeto

- Design de arquitetura 3-tier com isolamento de rede
- Terraform com módulos reutilizáveis e composição em ambientes
- Estratégia de backend remoto (S3 + DynamoDB locking)
- Security Groups encadeados (defense-in-depth)
- Health checks de ALB e Auto Scaling
- Custos AWS e estratégias de Free Tier

## 🚧 Roadmap

- [ ] HTTPS no ALB com ACM
- [ ] Session Manager para acesso SSH sem bastion
- [ ] CloudWatch Dashboards
- [ ] Secrets Manager para credenciais RDS
- [ ] Multi-environment (staging, prod)

## 📄 License

[MIT](./LICENSE)

## 🤝 Contato

Lucas — [LinkedIn](https://linkedin.com/in/seu-perfil)
