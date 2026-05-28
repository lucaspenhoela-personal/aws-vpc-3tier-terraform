# Decisões de Arquitetura (ADR)

## ADR-001: Por que 2 AZs?
**Decisão:** Deploy em 2 Availability Zones.
**Justificativa:** RDS exige mínimo de 2 AZs para subnet group, e
2 AZs já fornecem alta disponibilidade adequada para o caso de uso.

## ADR-002: Por que 1 NAT Gateway em vez de 2?
**Decisão:** Apenas 1 NAT Gateway compartilhado.
**Trade-off:** Em caso de falha da AZ-a, as EC2 da AZ-b perdem acesso
à internet. Em produção, usar 1 NAT por AZ.
**Motivo:** Economia de ~$32/mês em ambiente de estudo.