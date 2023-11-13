#!/usr/bin/bash
sudo iptables -F -t nat
#iptables -F -t mangle
iptables -F
iptables --policy FORWARD DROP
iptables --policy OUTPUT DROP
iptables --policy INPUT DROP
ip6tables -F
ip6tables --policy FORWARD DROP
ip6tables --policy OUTPUT DROP
ip6tables --policy INPUT DROP
#ip6tables -A INPUT -j LOG --log-uid
#ip6tables -A FORWARD -j LOG --log-uid
#ip6tables -A OUTPUT -j LOG --log-uid
ip6tables-save
iptables -A INPUT -i lo -j ACCEPT
#iptables -A INPUT -p udp -j LOG --log-uid
#iptables -A INPUT -i wlan0 -j LOG --log-uid

iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
iptables -A INPUT -p icmp -m icmp --icmp-type 0 -j ACCEPT
iptables -A INPUT -s 192.168.4.123/32 -d 192.168.4.34/32 -i wlan0 -p tcp -m tcp --dport 22 -j ACCEPT
#iptables -A INPUT -p udp ! --sport 5353:17500 -j LOG --log-uid
#iptables -A INPUT -i tun0 -j LOG --log-uid
#iptables -A OUTPUT -o tun0 -j LOG --log-uid


#DALLAS -1 UDP
iptables -A INPUT -p udp --sport 41706 -d 192.168.1.25/32 -s 45.80.159.92 -i eth0 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp --sport 29006 -d 192.168.1.25/32 -s 45.80.159.89 -i eth0 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp --sport 22451 -d 192.168.1.25/32 -s 45.80.159.232 -i eth0 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp --sport 20543 -d 192.168.1.25/32 -s 45.80.159.221 -i eth0 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp --sport 25961 -d 192.168.1.25/32 -s 45.80.159.76 -i eth0 -m state --state ESTABLISHED -j ACCEPT


#UKDO
#iptables -A INPUT -p udp --sport 22482 -d 192.168.1.122/32 -s 185.208.9.5 -i eth0 -m state --state ESTABLISHED -j ACCEPT
#iptables -A INPUT -p udp --sport 44611 -d 192.168.1.22/32 -s 185.208.9.131 -i eth0 -m state --state ESTABLISHED -j ACCEPT
#iptables -A INPUT -p udp --sport 48796 -d 192.168.1.22/32 -s 185.208.9.131 -i eth0 -m state --state ESTABLISHED -j ACCEPT
#iptables -A INPUT -p udp --sport 35355 -d 192.168.1.22/32 -s 185.208.9.129 -i eth0 -m state --state ESTABLISHED -j ACCEPT
#iptables -A INPUT -p udp --sport 39821 -d 192.168.1.22/32 -s 185.208.9.33 -i eth0 -m state --state ESTABLISHED -j ACCEPT


iptables -t nat -A PREROUTING -i wlan0 -s 192.168.4.21 -d 192.168.4.34 -p udp --dport 53 -j DNAT --to-destination 100.64.100.1
iptables -t nat -A PREROUTING -i wlan0 -s 192.168.4.2 -d 192.168.4.34 -p udp --dport 53 -j DNAT --to-destination 100.64.100.1
iptables -A FORWARD -d 192.168.4.21/32 -i tun0 -o wlan0 -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -s 192.168.4.21/32 -i wlan0 -o tun0 -j ACCEPT
iptables -t nat -A POSTROUTING -o tun0 -s 192.168.4.21 -j MASQUERADE
iptables -t nat -A POSTROUTING -o tun0 -s 192.168.4.2 -j MASQUERADE
iptables -t nat -A PREROUTING -i wlan0 -s 192.168.4.3 -d 192.168.4.34 -p udp --dport 53 -j DNAT --to-destination 100.64.100.1
iptables -t nat -A POSTROUTING -o tun0 -s 192.168.4.3 -j MASQUERADE
#iptables -A FORWARD -d 192.168.4.3/32 -i tun0 -o wlan0 -m state --state ESTABLISHED -j ACCEPT
#iptables -A FORWARD -s 192.168.4.3/32 -i wlan0 -o tun0 -j ACCEPT

#iptables -t nat -A POSTROUTING -o tun0 -s 192.168.4.3 -j MASQUERADE
#iptables -t nat -A PREROUTING -i wlan0 -s 192.168.4.3 -d 192.168.4.34 -p udp --dport 53 -j DNAT --to-destination 100.64.100.1
#iptables -A FORWARD -s 192.168.4.2/32 -o eth0 -i wlan0 -p tcp -m tcp --dport 443 -j ACCEPT
#iptables -A FORWARD -d 192.168.4.2/32 -o wlan0 -i eth0 -p tcp -m tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT
#iptables -A FORWARD -s 192.168.4.2/32 -o eth0 -i wlan0 -p tcp -m tcp --dport 80 -j ACCEPT
#iptables -A FORWARD -d 192.168.4.2/32 -o wlan0 -i eth0 -p tcp -m tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
#iptables -A FORWARD -s 192.168.4.2/32 -i wlan0 -o eth0 -p udp -m udp --dport 53 -j ACCEPT
#iptables -A FORWARD -d 192.168.4.2/32 -i eth0 -o wlan0 -p udp -m udp --sport 53 -m state --state ESTABLISHED -j ACCEPT
#iptables -A FORWARD -p icmp -m icmp --icmp-type 8 -j ACCEPT
#iptables -A FORWARD -p icmp -m icmp --icmp-type 0 -j ACCEPT
iptables -A FORWARD -s 192.168.4.2/32 -o tun0 -i wlan0 -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A FORWARD -d 192.168.4.2/32 -o wlan0 -i tun0 -p tcp -m tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -s 192.168.4.2/32 -o tun0 -i wlan0 -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A FORWARD -d 192.168.4.2/32 -o wlan0 -i tun0 -p tcp -m tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -s 192.168.4.2/32 -i wlan0 -o tun0 -p udp -m udp --dport 53 -j ACCEPT
iptables -A FORWARD -d 192.168.4.2/32 -i tun0 -o wlan0 -p udp -m udp --sport 53 -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -p icmp -m icmp --icmp-type 8 -j ACCEPT
iptables -A FORWARD -p icmp -m icmp --icmp-type 0 -j ACCEPT
iptables -A FORWARD -s 192.168.4.3/32 -o tun0 -i wlan0 -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A FORWARD -d 192.168.4.3/32 -o wlan0 -i tun0 -p tcp -m tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -s 192.168.4.3/32 -o tun0 -i wlan0 -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A FORWARD -d 192.168.4.3/32 -o wlan0 -i tun0 -p tcp -m tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -s 192.168.4.3/32 -i wlan0 -o tun0 -p udp -m udp --dport 53 -j ACCEPT
iptables -A FORWARD -d 192.168.4.3/32 -i tun0 -o wlan0 -p udp -m udp --sport 53 -m state --state ESTABLISHED -j ACCEPT


iptables -A OUTPUT -o lo -j ACCEPT
#iptables -A OUTPUT -p tcp ! -s 192.168.2.34 -o eth0 ! --sport 22 -j LOG --log-uid
#iptables -A OUTPUT -p udp -j LOG --log-uid
#iptables -A OUTPUT -o wlan0 -j LOG --log-uid
iptables -A OUTPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
iptables -A OUTPUT -p icmp -m icmp --icmp-type 0 -j ACCEPT
iptables -A OUTPUT -s 192.168.4.34/32 -d 192.168.4.123/32 -o wlan0 -p tcp -m state --state ESTABLISHED -m tcp --sport 22 -j ACCEPT

iptables-save
