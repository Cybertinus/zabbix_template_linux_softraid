# zabbix_template_linux_softraid
A simple Zabbix template, with bash script, to monitor the state of the Linux softraid set with Zabbix

# Installation

1. Import the zabbix template in your Zabbix server
2. Place the zabbix_raidstate.sh on the server you want to monitor
3. Place the file zabbix_raidstate.conf in /etc/zabbix/zabbix_agent.d/
4. Restart the zabbix-agent on the server you want to monitor, to load the new
   config line in the Zabbix Agent
5. Hook up the template in Zabbix to the servers you want to monitor
