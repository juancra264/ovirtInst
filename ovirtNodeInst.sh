#!/bin/bash
# set variables globables
#
currentUser="$(whoami)"
selinuxPath='/etc/selinux/config'
selinuxBefore='SELINUX=.*'
selinuxAfter='SELINUX=permissive'

echo -e "**********************************************************"
echo -e " Instalacion de Repos y paquetes necesarios"
echo -e "**********************************************************"
yum -y install http://resources.ovirt.org/pub/yum-repo/ovirt-release42.rpm
yum -y update
yum -y install net-tools ncdu ntpdate ntp screen bind-utils mlocate rsync 
yum -y install telnet vim wget iftop nfs-utils
yum -y install vim-enhanced 
yum -y --nogpgcheck install bind-utils traceroute telnet finger wget autoconf 
yum -y --nogpgcheck install automake libtool make gcc tree net-tools perl 
yum -y --nogpgcheck install kernel-headers kernel-devel nano iperf3 iptraf-ng 
yum -y --nogpgcheck install dstat ntpdate nfs-utils samba-client cifs-utils 
yum -y --nogpgcheck install iftop htop python-pip python-dev
yum -y --nogpgcheck install tmux vim-enhanced git
yum -y install cockpit-ovirt-dashboard vdsm-gluster
systemctl start ntpd
systemctl enable ntpd

echo -e "**********************************************************"
echo -e " Ajustes de SElinux a permissive"
echo -e "**********************************************************"
sed -i s/"^${selinuxBefore}"/"${selinuxAfter}"/g ${selinuxPath}

echo -e "**********************************************************"
echo -e " Detencion de servicios Firewalld NetworkManager y Postfix"
echo -e "**********************************************************"
# Apagado de servicios
systemctl stop firewalld
systemctl stop postfix
systemctl stop NetworkManager
# Deshabilitacion de inicio automatico
systemctl disable firewalld
systemctl disable postfix
systemctl disable NetworkManager
