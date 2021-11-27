#!/bin/bash

VENV_DIR=/opt/ansible

source "${VENV_DIR}/bin/activate" && ANSIBLE_FORCE_COLOR=1 PYTHONUNBUFFERED=1 ${VENV_DIR}/bin/ansible-playbook "$@"
