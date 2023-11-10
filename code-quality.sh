#!/bin/bash
mkdir s3
aws s3 cp s3://devex-deploy/springboot-demo-app.zip /root/.jenkins/workspace/custom-actions/Sonartest-copilot-1/s3
unzip s3/springboot-demo-app.zip -d /root/.jenkins/workspace/custom-actions/Sonartest-copilot-1/s3
cd s3/springboot-demo-app
echo "running mvn command"
export JAVA_HOME=/usr/lib/jvm/msopenjdk-17-amd64
export M2_HOME=/opt/apache-maven-3.9.3
export PATH=${M2_HOME}/bin:${PATH}
mvn sonar:sonar -Dsonar.projectKey=aws-elb-java -Dsonar.host.url=http://ey-devex.eastus.cloudapp.azure.com:9000 -Dsonar.login=33807d41f57376c8f2e9959abc3d3575dfea9fe4
