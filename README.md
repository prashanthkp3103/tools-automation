# tools-automation

Tools provision
github runner
vault
minikube

step1: first checkout the code into workstation vm
step2: run terraform code manually

Github runner provision

first checkout the code into workstation vm
run terraform code
then from workstation run manually
ansible-playbook -i <private ip of github runner 172.31.40.206 or make whatever vm u want to>, tool-setup.yml -e ansible_user=ec2-user -e ansible_password=DevOps321 -e tool_name=github-runner

