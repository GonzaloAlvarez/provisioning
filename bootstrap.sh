#!/bin/bash
mkdir -p "$HOME/.bootstrap" && cd "$_"
$(command -v wget) --quiet "https://bootstrap.pypa.io/virtualenv.pyz"
$(command -v python3 || command -v python) virtualenv.pyz venv || exit 1
source venv/bin/activate
python -m pip install --upgrade pip setuptools wheel
[[ -d "$HOME/provisioning" ]] || python -m  install dulwich --config-settings "--build-option=--pure"
[[ -d "$HOME/provisioning" ]] || python -c "from dulwich import porcelain;porcelain.clone('https://github.com/GonzaloAlvarez/provisioning', 'provisioning')"
cp -Rv "$HOME/provisioning" . && cd provisioning
python -m pip install ansible
ansible-galaxy install -r requirements.yml
ansible-playbook --connection=local --inventory=localhost --limit 127.0.0.1 playbooks/main.yml
