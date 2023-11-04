ansible-playbook 00-uninstall-agent.yaml -i ./inventory/01-inventory.yaml
ansible-playbook 00-uninstall-controller.yaml -i ./inventory/01-inventory.yaml 
ansible-playbook 00-rebootAll.yaml -i ./inventory/01-inventory.yaml 
