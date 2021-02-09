# Notejam on Azure platform
 
Notejam [Notejam](https://github.com/komarserjio/notejam) is a Python/Flask basen application.
The document describes a proposed approach to migrate monolithic application to containers on Azure with CI/CD processes.
 
## Architecture
 
The application in its original form is built as a monolith having both stateless webserver and SQLite running on the same machine. To provide scalability and development for different areas, the database has been decoupled and replaced by Azure SQL Database. During development, the application is packed to Docker image and sent to DockerHub from where it is being deployed to Azure. When deployed, the application is running on Azure Kubernetes Service which provides better scalability. Logs and events are stored in Azure Table Storage as well as sent to Log Analytics. This data can then be used for monitoring. Keys are stored in a Key Vault.
 
![Architecture](/architecture/architecture.png)
 
## Scalability
 
Having the application set up on a kubernetes cluster, it is easily scalable and can be also done automatically.
 
It is worth considering in case of High Availability (HA) scenario to redesign application and database approach. SQL database can be replaced with NoSQL database which provides scalability in both directions. In case of staying with only SQL database there can be a different approach undertaken with having two database instances with replication, one for read-only purpose as opposed to second one which serves write-only purpose.
 
## Backups
 
Azure provides local, zone and geo-redundancy so in case of the failure the traffic will be rerouted and data replicated.
 
## Continuous integration and deployment
 
CI/CD is done using Azure DevOps. Git repository which is provided within a product gives vast possibilities to branch out for development and tests. Development should follow good practices when working with Git. Pipelines in Azure Devops are used for integrating and deploying the application to Azure services. Docker images are built during the pipeline run and published to DockerHub repository. Deployments can be done for various environments.
 
## Monitoring
 
There are multiple options for monitoring. My proposition here is to use Power Bi to provide dashboard and monitoring for business, technical purposes and Grafana which can be used as a dashboard displayed across company to inform about the status of given metrics, builds, deployments etc.
 
## Deployment
 
ARM template has been provided for deployment and it can be done in various ways either via Azure portal, cli or using a powershell. Pipelines are also added in yaml to be deployed on Azure DevOps as well as kubernetes manifests for AKS.