#!/usr/bin/env bash
set -e

PYTHON_VERSION='3.14.4'
ENV_NAME='myenv'

echo "=== Install Python ${PYTHON_VERSION} ==="
pyenv install -s "$PYTHON_VERSION"

echo "=== Create virtualenv ${ENV_NAME} ==="
pyenv virtualenv -f "$PYTHON_VERSION" "$ENV_NAME"

echo "=== Set global environment ==="
pyenv global "$ENV_NAME"

echo "=== Python version ==="
python --version

echo "=== Pip version ==="
pip --version

echo "=== Done ==="
