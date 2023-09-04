#!/bin/bash
mkdir -p "$HOME/.bootstrap"
cd "$HOME/.bootstrap"
wget --quiet "https://bootstrap.pypa.io/virtualenv.pyz"
if [ $(type -P "python3") ]; then
    PYTHON=python3
elif [ $(type -P "python") ]; then
    PYTHON=python
else
    echo "python not found in path. exiting"
    exit 1
fi
$PYTHON virtualenv.pyz venv
source venv/bin/activate
pip install --upgrade pip setuptools wheel
pip install ansible
pip install dulwich --config-settings "--build-option=--pure"
$PYTHON - <<'____HERE'
from dulwich import porcelain
porcelain.clone('https://github.com/GonzaloAlvarez/infra', 'infra')
____HERE
