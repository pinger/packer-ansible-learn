#!/bin/bash -eux

packer build file_name.pkr.hcl
cd vagrant/
mv ../output-dafault/package.box ./
vagrant up
cd ../