# localiza-lab
Da forma como está, o custo da stack é:

GCP = 2,503.89 p/ mês
- 1 App Engine Flexible
- 2 Instancias - Mig
- 1 Load Balancer
- 1 VPN
- 1 Cloud SQL

AWS = 355,08.00 p/ mês
- 1 Instancia
- 1 VPN

Provisionei os recursos para rodar uma aplicação teste, mas poderia ser escalado.


Anotei também algumas melhorias de antemão:

- Impersonate no lugar de SA.
- Criar uma pipeline para quando forem feitas alterações, serem aplicadas automaticamente.
- Polimento do código, remover alguns parâmetros que estão default.

![alt text](https://github.com/ramboXX/localiza-lab/blob/master/Localiza-Lab-Topology.drawio.png?raw=true)
