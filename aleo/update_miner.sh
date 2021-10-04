#!/bin/bash

#add ufw rules
curl -s https://raw.githubusercontent.com/razumv/helpers/main/tools/install_ufw.sh | bash

sudo apt install wget -y
rustup update
sudo systemctl stop miner
cd $HOME/snarkOS
git fetch
git checkout v1.3.16
cargo build --release --verbose
#rm -rf $HOME/.snarkOS/snarkos_testnet1
#rm -rf $HOME/.snarkOS/snarkos_testnet1_secondary
#cd

#update snapshot
#block=403000
#wget 167.99.215.126/backup_snarkOS_$block.tar.gz
#tar xvf backup_snarkOS_$block.tar.gz
#mv backup_snarkOS_$block/.snarkOS/* $HOME/.snarkOS/
#rm -rf backup_snarkOS_*

sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
sudo systemctl restart systemd-journald

sudo systemctl start miner

version=`$HOME/snarkOS/target/release/snarkos help | grep snarkOS | head -n 1`
echo 'Current version' $version
