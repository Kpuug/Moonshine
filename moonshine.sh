#!/bin/zsh
Iface="enp0s20f0u5"

while ip netns list | grep sunspace; do
    ip netns delete sunspace
    echo "sunpace already exists, deleting..."
done

if ip addr | grep $Iface >/dev/null; then
    echo "tether found, running as normal"
else 
    echo "tether not found, exiting."
    exit
fi
echo "currently active namespaces: " $(ip netns list)

IP=$(ip route | grep $Iface | awk 'NR==1{print $9}')
Route=$(ip route | grep $Iface | awk 'NR==1{print $3}')

echo $IP
echo $Route

ip netns add sunspace
ip link set $Iface netns sunspace
ip netns exec sunspace ip link set dev $Iface up
ip netns exec sunspace ip link set dev lo up
ip netns exec sunspace ip addr add $IP"/24" dev $Iface
ip netns exec sunspace ip route add default via $Route dev $Iface
xhost +local:
ip netns exec sunspace ping 1.1.1.1 -c 3
clear
ip netns exec sunspace sunshine &
ip netns exec sunspace ip addr
if hyprctl monitors all | grep Virtual-1; then
    echo "Virtual Monitor already present, skipping creation"
else
    hyprctl output create Virtual-1
fi
ip netns exec sunspace sudo -E -u keiran \
  env \
    WAYLAND_DISPLAY=$(echo $WAYLAND_DISPLAY) \
    XDG_RUNTIME_DIR=$(echo $XDG_RUNTIME_DIR) \
    HYPRLAND_INSTANCE_SIGNATURE=$(echo $HYPRLAND_INSTANCE_SIGNATURE) \
    HOME=$(echo $HOME)\
  sunshine