FROM centos:8

ARG TERRAFORM_VERSION="0.12.12"
ARG AZ_FUNCTIONS_VERSION="3.0.2106"

ENV PATH="/root/.local/bin:${PATH}"

# Install the latest version of wget, less, unzip, pip
# Install terraform 
RUN yum -y update && yum -y install wget jq unzip less python3-pip git && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip ./terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    pip3 install --upgrade pip && \
    dnf -y --enablerepo=PowerTools install groff

# Install azure-cli
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    sh -c 'echo -e "[azure-cli] \n\
name=Azure CLI \n\
baseurl=https://packages.microsoft.com/yumrepos/azure-cli \n\
enabled=1 \n\
gpgcheck=1 \n\
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo' && \
    cat /etc/yum.repos.d/azure-cli.repo && \
    yum -y install azure-cli

# Install latest version of kubectl
RUN sh -c 'echo -e "[kubernetes] \n\
name=Kubernetes \n\
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64 \n\
enabled=1 \n\
gpgcheck=1 \n\
repo_gpgcheck=1 \n\
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg" > /etc/yum.repos.d/kubernetes.repo' && \
    cat /etc/yum.repos.d/kubernetes.repo && \
    yum -y install kubectl

# Install azure functions core tools
RUN curl "https://packages.microsoft.com/keys/microsoft.asc" | gpg --dearmor > microsoft.gpg && \
    wget "https://github.com/Azure/azure-functions-core-tools/releases/download/${AZ_FUNCTIONS_VERSION}/Azure.Functions.Cli.linux-x64.${AZ_FUNCTIONS_VERSION}.zip" && \
    unzip Azure.Functions.Cli.linux-x64.*.zip -d /usr/local/bin && \
    rm Azure.Functions.Cli.linux-x64.*.zip && \
    chmod 755 /usr/local/bin/func && \
    echo $(cat /usr/local/bin/func.runtimeconfig.json | jq '.["runtimeOptions"] += {"configProperties": {"System.Globalization.Invariant": true}}') > /usr/local/bin/func.runtimeconfig.json
    
WORKDIR /home
