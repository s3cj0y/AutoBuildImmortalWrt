#!/bin/sh

# WAN 配置 (eth0)
uci set network.wan=interface
uci set network.wan.device='eth0'
uci set network.wan.proto='dhcp'

# LAN 配置 (静态 IP)
uci set network.lan.proto='static'
uci set network.lan.ipaddr='192.168.50.1'
uci set network.lan.netmask='255.255.255.0'

# 绑定除 eth0 外的所有接口到 LAN
uci -q delete network.@device[0].ports
for iface in $(ls /sys/class/net/ | grep -E '^eth|^en' | grep -v '^eth0$'); do
    uci add_list network.@device[0].ports="$iface"
done

uci commit network
exit 0
