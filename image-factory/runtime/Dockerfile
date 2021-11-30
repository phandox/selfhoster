FROM python:3.9.7 AS compile-ansible-stage
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        gcc
RUN python -m venv --copies /opt/ansible
RUN /opt/ansible/bin/pip install ansible-core==2.11.6

# ubuntu:focal-20211006
FROM ubuntu@sha256:7cc0576c7c0ec2384de5cbf245f41567e922aab1b075f3e8ad565f508032df17 AS packer-from-apt

# Setup locale for software-properties-common and lsb-release
RUN apt-get update && apt-get install -y locales && \
    sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

# Install basic tools for adding repository
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        lsb-release \
        gnupg2 \
        software-properties-common && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get remove -y \
        curl \
        lsb-release \
        gnupg2 \
        software-properties-common && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* 

RUN apt-get update && apt-get install -y --no-install-recommends \
        packer=1.7.8 && \
    rm -rf /var/lib/apt/lists/*

FROM python:3.9.7

# Install Ansible
COPY --from=compile-ansible-stage /opt/ansible /opt/ansible
COPY --from=packer-from-apt /bin/packer /bin/packer
COPY provision_with_ansible.sh /provision_with_ansible.sh
COPY packer_wrapper.sh /bin/packer_wrapper.sh
ENTRYPOINT [ "/bin/packer_wrapper.sh" ]
