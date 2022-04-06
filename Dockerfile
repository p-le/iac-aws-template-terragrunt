FROM hashicorp/terraform AS terraform-bin

FROM ubuntu:focal

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG TERRAGRUNT_VERSION=v0.36.6

RUN apt-get update \
  && apt-get install -y \
    wget \
    zip \
    ca-certificates \
    openssh-client \
    less \
    jq \
  && rm -rf /var/lib/apt/lists/*

# Create the user, update folder permissions
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash

COPY --from=terraform-bin /bin/terraform /usr/local/bin/terraform

RUN wget -O awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip && \
  unzip awscliv2.zip && \
  ./aws/install

RUN wget -O /usr/local/bin/terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 \
  && wget -O /usr/local/bin/kubectl https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl \
  && wget https://github.com/weaveworks/eksctl/releases/download/v0.90.0/eksctl_Linux_amd64.tar.gz -O /tmp/eksctl_Linux_amd64.tar.gz \
  && tar -xf /tmp/eksctl_Linux_amd64.tar.gz -C /usr/local/bin


RUN chmod a+x /usr/local/bin/*

USER $USERNAME
