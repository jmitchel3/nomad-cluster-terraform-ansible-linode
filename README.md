# Nomad Cluster with Terraform and Ansible on Linode


## Watching the course?

The final code is on the `main` branch. The `webinar` branch is from the live webinar.

```bash
git clone https://github.com/jmitchel3/nomad-cluster-terraform-ansible-linode.git
cd nomad-cluster-terraform-ansible-linode
```

Now you need to setup `infra/terraform.tfvars` with your `linode_api_token` from the [linode](https://linode.com/justin) dashboard.

```
echo "linode_api_tokn=\"your_api_token\"" >> infra/terraform.tfvars
```

Run terraform

```
cd infra
terraform init
terraform apply
```

Now you can configure Nomad and Consul via Ansible. 


Create a Python 3 virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate
```
> Windows users: `c:\Python312\python -m venv venv` and `venv\Scripts\activate`

Install Ansible
```bash
pip install ansible pip --upgrade
```

```
cd ../config
ansible-playbook main.yaml
```

Configured! 


## Watching the live webinar?

The final code is on the `webinar` branch. The current `main` branch is from the course.

```bash
git clone https://github.com/jmitchel3/nomad-cluster-terraform-ansible-linode.git
cd nomad-cluster-terraform-ansible-linode
```

View remote branches
```bash
git branch -r
```
Yields
- origin/1-vpc
- origin/2-instances
- origin/3-ansible-inventory
- origin/4-ansible-ping-playbook
- origin/5-ansible-configure-nomad
- origin/6-sample-configs
- origin/7-sample-jobs


Get started
```bash
git checkout 1-vpc
```
