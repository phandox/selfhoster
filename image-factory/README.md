# Image Factory

Here are the tools needed to create "golden VM images", running on Digital Ocean.

`runtime/` contains Dockerfile, where Packer is ran, together with Ansible (used in CI)
`images/` contains Packer templates and Ansible playbook to create a "golden VM image"
