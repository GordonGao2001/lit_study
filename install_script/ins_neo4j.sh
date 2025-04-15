#!/bin/bash
# Updates and add source
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install openjdk-21-jre-headless
wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/neotechnology.gpg
echo 'deb [signed-by=/etc/apt/keyrings/neotechnology.gpg] https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list
sudo add-apt-repository universe
sudo apt-get update
apt list -a neo4j

sudo apt install neo4j=1:2025.01.0 -y
# Choose the neo4j you would like to install.
# Set up pwd for neo4j before start!
neo4j-admin dbms set-initial-password <password>
# Set neo4j start with system boot
sudo systemctl enable neo4j

# add $NEO4J_HOME 
echo 'export NEO4J_HOME=/var/lib/neo4j' >> ~/.bashrc
source ~/.bashrc

# Move apoc-*.jar to plugins
sudo mv $NEO4J_HOME/labs/apoc-*.jar $NEO4J_HOME/plugins/

# edit NEO4J’s setting so apoc is enabled
sudo echo 'dbms.security.procedures.unrestricted=apoc.*' >> /etc/neo4j/neo4j.conf

# restart neo4j service
sudo systemctl restart neo4j
sudo systemctl status neo4j

echo 'NEO4J VERSION IS 1:2025.01.0 AND HAS IT'S ACCORDINGLY CONF, NOT FUTUREPROOF!!!!'
