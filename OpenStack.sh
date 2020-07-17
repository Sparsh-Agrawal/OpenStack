#!/bin/bash
yum install python3 -y
yum install createrepo -y
pip3 install gdown
gdown --id 19ipDIVBsYvgpXJwppMnYXh6inidCr-9J --output RHEL7OSP-13.0-20180628.2-x86_64
gdown --id 1KjIoFuqzNLyo_5_UkfXZdp_FvdtVqAT4 --output rhel-7.5-server-updates-20180628
gdown --id 1c-JguEu8REWm7VnVGs64lLrhoX9N1A7f --output rhel-7-server-additional-20180628
mkdir /RHEL7OSP-13.0
mkdir /rhel-7.5-server-updates
mkdir /rhel-7-server-additional
mkdir /softwares
mount -o loop RHEL7OSP-13.0-20180628.2-x86_64 /RHEL7OSP-13.0
mount -o loop rhel-7.5-server-updates-20180628 /rhel-7.5-server-updates
mount -o loop rhel-7-server-additional-20180628 /rhel-7-server-additional
cp -rfv /RHEL7OSP-13.0 /softwares
cp -rfv /rhel-7.5-server-updates /softwares
cp -rfv /rhel-7-server-additional /softwares
createrepo -v /softwares/.
yum clean all
yum repolist
cat > /etc/yum.repos.d/openstack.repo <<EOF
[OPENSTACK]
baseurl=file:///softwares
gpgcheck=0
EOF
yum install openstack-packstack -y
packstack --gen-answer-file=openstack.txt
packstack --answer-file=openstack.txt
