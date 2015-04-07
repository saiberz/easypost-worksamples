EasyPost Work Samples
======================

This repo contains a Vagrantfile and bootstrap script to create
a Virtual Machine that's been configured to run the EasyPost Work Samples with
very little additional setup.

Requirements
-------------

- Virtual Box
- Vagrant
- Vagrant plugin vagrant-hostmanager:

```bash
$ vagrant plugin install vagrant-hostmanager
```

If you choose not to use Virtual Box or the vagrant-hostmanager plugin you may
need to alter the Vagrantfile and setup your own networking.

Installing this VM locally will take ~300 MB of disk space and a few minutes to
download and setup. If you'd prefer to deploy this VM to a cloud host (such
as AWS), look into Vagrant's support for alternate providers.

Getting Started
----------------

1. Clone this, or a fork of this repository.
2. Run 'vagrant up' from the easypost-worksamples directory.
3. Once the VM is ready you can 'vagrant ssh' into it.
3. View the README at the root of the sample you choose to work on for 
instructions.

Submitting A Work Sample
------------------------

1. Fork this repository.
2. Work on the sample of your choice for a few hours until it's presentable.
3. Sawyer at EasyPost dot com's GitHub username is 'sawyer'. Send him an email
and invite him to your private fork, or include a link to your public fork.
4. ...
5. Profit.

