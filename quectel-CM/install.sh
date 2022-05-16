YELLOW='\033[1;33m'
RED='\033[0;31m'
SET='\033[0m'

DIR=dirname "$0"
UDHCPC_DIR=/usr/share/udhcpc

echo "${YELLOW}Installing udhcpc${SET}"
apt install udhcpc
echo "denyinterfaces wwan0" >> /etc/dhcpcd.conf
systemctl daemon-reload
systemctl restart dhcpcd

echo "${YELLOW}Copying udhcpc default script${SET}"
mkdir -p $UDHCPC_DIR
cp $DIR/default.script $UDHCPC_DIR/
chmod +x $UDHCPC_DIR/default.script

echo "${YELLOW}Copying quectel-CM_v1.5.5 to user bin${SET}"
cp $DIR/quectel-CM_v1.5.5 /usr/bin
chmod +x /usr/bin/quectel-CM_v1.5.5

echo "${YELLOW}Copying qmi_connect.service to /etc/systemd/system/${SET}"
cp $DIR/qmi_connect.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable qmi_connect.service

echo "done"