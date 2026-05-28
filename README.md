🏗️ AWS VPC 3-Tier Architecture with Terraform




![Terraform CI](https://github.com/lucaspenhoela-personal/aws-vpc-3tier-terraform/actions/workflows/terraform-validate.yml/badge.svg)
![Terraform](https://img.shields.io/badge/Terraform-1.7+-7B42BC?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Free%20Tier-FF9900?logo=amazon-aws)
![License](https://img.shields.io/badge/license-MIT-blue)

> Infraestrutura 3-tier completa e modular na AWS, provisionada via Terraform.
> ALB público + EC2 Auto Scaling em subnets privadas + RDS MySQL isolado.

Infraestrutura 3-tier completa e modular na AWS, provisionada via Terraform.
ALB público + EC2 Auto Scaling em subnets privadas + RDS MySQL isolado.


ℹ️ Status do projeto

⚠️ A infraestrutura foi destruída (terraform destroy) após validação para
evitar custos com NAT Gateway, ALB e RDS, que não são cobertos pelo Free Tier 24/7.
Todo o código é 100% reprodutível: basta clonar, configurar credenciais AWS
e rodar terraform apply para subir o ambiente em ~12 minutos.


🏛️ Arquitetura
                       ┌──────────────────────────┐
                       │       Internet           │
                       └──────────┬───────────────┘
                                  │
                       ┌──────────▼───────────────┐
                       │  Internet Gateway (IGW)  │
                       └──────────┬───────────────┘
                                  │
   ╔══════════════════════════════▼══════════════════════════════╗
   ║                    VPC (10.0.0.0/16)                         ║
   ║                                                              ║
   ║   ┌─────────── PUBLIC TIER (Web/ALB) ──────────────┐         ║
   ║   │   Subnet Pub AZ-a    │    Subnet Pub AZ-b      │         ║
   ║   │   10.0.1.0/24        │    10.0.2.0/24          │         ║
   ║   │            └── ALB (público) ──┘               │         ║
   ║   │                   NAT GW                       │         ║
   ║   └──────────────────────┬─────────────────────────┘         ║
   ║                          │                                    ║
   ║   ┌────────── PRIVATE APP TIER ─────────────────────┐         ║
   ║   │   Subnet Priv AZ-a   │    Subnet Priv AZ-b     │         ║
   ║   │   10.0.11.0/24       │    10.0.12.0/24          │         ║
   ║   │       EC2 (ASG)            EC2 (ASG)            │         ║
   ║   └──────────────────────┬─────────────────────────┘         ║
   ║                          │                                    ║
   ║   ┌────────── PRIVATE DB TIER ──────────────────────┐         ║
   ║   │   Subnet DB AZ-a     │    Subnet DB AZ-b        │         ║
   ║   │   10.0.21.0/24       │    10.0.22.0/24          │         ║
   ║   │            RDS MySQL 8.0 (privado)              │         ║
   ║   └─────────────────────────────────────────────────┘         ║
   ╚══════════════════════════════════════════════════════════════╝
Componentes

Web Tier (público): Application Load Balancer distribuído em 2 AZs
App Tier (privado): EC2 Auto Scaling Group (min: 1, desired: 2, max: 3)
DB Tier (isolado): RDS MySQL 8.0 sem acesso público
Networking: VPC com 6 subnets (2 públicas, 2 app privadas, 2 DB isoladas)
Security: Defense-in-depth com 3 Security Groups encadeados (ALB → EC2 → RDS)
Hardening: IMDSv2 obrigatório, RDS criptografado, state remoto criptografado


🚀 Stack
CategoriaTecnologiaIaCTerraform 1.7+ (módulos reutilizáveis)CloudAWS (us-east-1)ComputeEC2 (t3.micro), Auto Scaling GroupNetworkVPC, ALB, NAT Gateway, IGW, Route TablesDatabaseRDS MySQL 8.0 (single-AZ, criptografado)StateS3 (versionado) + DynamoDB (locking)CI/CDGitHub Actions (validate + tfsec scan)OSAmazon Linux 2023 + Apache HTTPD

📋 Pré-requisitos

AWS Account com Free Tier ativo
AWS CLI v2 configurado (aws configure)
Terraform >= 1.6
Git


⚡ Quick Start
1. Clonar o repositório
bashgit clone https://github.com/lucaspenhoela-personal/aws-vpc-3tier-terraform.git
cd aws-vpc-3tier-terraform
2. Bootstrap do backend remoto (uma vez)
bash# Crie um bucket S3 (nome único globalmente)
aws s3api create-bucket --bucket meu-tfstate-vpc3tier-$(date +%s) --region us-east-1

# Crie a tabela DynamoDB para locking
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1
Atualize o nome do bucket em environments/dev/backend.tf.
3. Configurar variáveis sensíveis
Crie environments/dev/terraform.tfvars (não commitado):
hclowner         = "seu-nome"
db_username   = "admin"
db_password   = "SuaSenhaForte!2025"
instance_type = "t3.micro"
4. Deploy
bashcd environments/dev
terraform init
terraform plan -out=tfplan
terraform apply tfplan
Após ~12 minutos, acesse o output alb_dns_name no navegador. 🚀
5. ⚠️ Limpar tudo após testar
bashterraform destroy

🗂️ Estrutura do Projeto
aws-vpc-3tier-terraform/
├── .github/workflows/
│   └── terraform-validate.yml   # CI: fmt + validate + tfsec
├── environments/
│   └── dev/                     # Composição do ambiente
│       ├── backend.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── providers.tf
│       └── variables.tf
├── modules/                     # Módulos reutilizáveis
│   ├── vpc/                     # VPC, subnets, IGW, NAT, routing
│   ├── security/                # Security Groups em camadas
│   ├── alb/                     # Application Load Balancer + Target Group
│   ├── compute/                 # Launch Template + Auto Scaling Group
│   └── database/                # RDS MySQL + Subnet Group
└── docs/
    └── ARCHITECTURE.md          # Decisões de arquitetura

💰 Custos
A maioria dos recursos é Free Tier, mas atenção:
RecursoFree Tier?Custo aproximadoEC2 t3.micro✅ 750h/mês$0RDS db.t3.micro✅ 750h/mês$0VPC + Subnets✅ Sempre grátis$0NAT Gateway❌ Não~$32/mês + tráfegoALB❌ Não~$16/mêsElastic IPGrátis se em uso$0 (associado)

⚠️ SEMPRE rode terraform destroy após validar — só de NAT + ALB são ~$48/mês.
Para estudos, suba o ambiente, valide e destrua.


🎯 O que aprendi com esse projeto

Design de arquitetura 3-tier com isolamento de rede em camadas
Terraform modular com composição em ambientes e módulos reutilizáveis
Backend remoto (S3 + DynamoDB locking) para colaboração em equipe
Defense-in-depth com Security Groups encadeados
Alta disponibilidade via Multi-AZ e Auto Scaling
Auto-healing com Health Checks no ALB + ASG
IMDSv2 obrigatório para mitigar SSRF em EC2
CI/CD com GitHub Actions validando código a cada push
FinOps na prática — entender o que é Free Tier e o que cobra


📐 Decisões de arquitetura
Documentação detalhada em docs/ARCHITECTURE.md, incluindo:

Por que 2 AZs (não 3)
Por que 1 NAT Gateway (não 1 por AZ)
Por que single-AZ no RDS (vs Multi-AZ)
Por que IMDSv2 obrigatório
Trade-offs de custo vs resiliência
## 🤝 Contato

Lucas — [LinkedIn](https://linkedin.com/in/seu-perfil)
