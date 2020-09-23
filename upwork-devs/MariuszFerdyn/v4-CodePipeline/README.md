### RELEASE Candidate 1 AWS Code Pipeline CI/CD Concept with GitHub integration

This AWS Pipeline is using previously created GitHub Code Deploy.

The definition included in pipeline.json, but you need to go To AWS Pipeline:
- create New Pipeline
- source GitHub
- skip build stage
- deploy using existing  Code Deploy

**To Do**

Step by Step creating it via command line.


**Troubleshooting**

On destination instances:

``` bash
tail -f /var/log/aws/codedeploy-agent/codedeploy-agent.log
```

``` bash
cd /opt/reverse-proxy/upwork-devs/MariuszFerdyn/v3-CodeDeploy/reverse-proxy-codedeploy/reverse-proxy-icap-docker
sudo docker-compose ps
```

