#!/bin/bash
#galera_install.sh
#Crée par : Mehdi B.
#Version : v1.0
#Date : 02/06/2022

#Mise à jour des paquets disponible sur le système
apt update -y

apt install mariadb-server -y

mariadb -v

mysql_secure_installation


cat << EOF > /etc/mysql/mariadb.conf.d/60-galera.cnf
[galera]
#Mandatory settings
wsrep_on                    = ON
wsrep_provider              = /usr/lib/galera/libgalera_smm.so
wsrep_cluster_name          = "TTT_GALERA_CLUSTER"
wsrep_cluster_address       = gcomm://
binlog_format               = row
default_storage_engine      = InnoDB
innodb_autoinc_lock_mode    = 2
innodb_force_primary_key    = 1

#Allo server to accept connections on all interfaces.
bind-address = 0.0.0.0

log_error = /var/log/mysql/galera_errors.log

EOF