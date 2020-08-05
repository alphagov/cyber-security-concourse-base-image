cd /tmp
curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o terraform_${TF_VERSION}_linux_amd64.zip
curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_{$TF_VERSION}_SHA256SUMS -o terraform.sha
if [ $(sha256sum -c terraform.sha 2>/dev/null | grep OK | wc -l) -eq 1 ]; then
    echo 'Terraform file integrity is good'
    unzip terraform_${TF_VERSION}_linux_amd64.zip
    mv terraform /usr/bin/terraform
    rm terraform_${TF_VERSION}_linux_amd64.zip terraform.sha
fi