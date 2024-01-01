FROM gitpod/workspace-full:latest

# Install AWS CLI tool
RUN cd /workspace \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo /workspace/aws/install

## Install Terraform
RUN cd /workspace \
    &&  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list \
    && sudo apt update && sudo apt install terraform

# Refresh OS and packages
RUN sudo apt update \
    && sudo apt install -y apt-utils --no-install-recommends apt-utils \
    && sudo apt autoremove -y \   
    && npm install -g npm@latest