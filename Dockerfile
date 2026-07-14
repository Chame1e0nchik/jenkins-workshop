FROM jenkins/jenkins:lts-jdk21

USER root

RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://releases.hashicorp.com/terraform/1.13.1/terraform_1.13.1_linux_amd64.zip && \
    unzip terraform_1.13.1_linux_amd64.zip && \
    mv terraform /usr/local/bin/terraform && \
    rm terraform_1.13.1_linux_amd64.zip LICENSE.txt

USER jenkins

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
ENV CASC_JENKINS_CONFIG=/usr/share/jenkins/ref/casc.yaml

COPY jcasc/plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

COPY jcasc/casc.yaml /usr/share/jenkins/ref/casc.yaml