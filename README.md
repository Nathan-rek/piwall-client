
# Ajout d'une IP lan (switch)

sudo ip addr add 10.0.0.11/24 dev eth0
sudo ip link set eth0 up

- pour verifier

ip a show eth0
ping 10.0.0.10   # ping vers PC

