#!/usr/bin/env bash
set -e

# Instalace balicku net-tools
sudo apt-get install -y net-tools

# Stažení balíčku pro instalaci zabbix repo
sudo wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest+ubuntu22.04_all.deb

# Instalace meta balíčku
sudo dpkg -i zabbix-release_latest+ubuntu22.04_all.deb

# Aktualizace repository
sudo apt-get update

# Instalace meta balíčku
sudo apt-get install -y zabbix-agent2 zabbix-agent2-plugin-*
# Úprava konfigurace
sudo sed -i 's/^Server=.*/Server=192.168.1.2/' /etc/zabbix/zabbix_agent2.conf
sudo sed -i 's/^ServerActive=.*/ServerActive=192.168.1.2/' /etc/zabbix/zabbix_agent2.conf
sudo sed -i 's/^Hostname=.*/Hostname=$(hostname)/' /etc/zabbix/zabbix_agent2.conf
echo "HostMetadata=SPOS" | sudo tee -a /etc/zabbix/zabbix_agent2.conf

# Spuštění agenta
sudo systemctl enable zabbix-agent2
sudo systemctl restart zabbix-agent2



