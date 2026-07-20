# Change NetworkManager Backend to iwd
NetworkManager's backend `wpa_supplicant` can be the bottleneck
and there are some reports on the Internet.\
<https://discuss.cachyos.org/t/plasma-panel-freezes-30-90s-on-login-wifi-interaction-ath12k-wcn785x-d-bus-scan-timeout/23346/2>\
<https://discussion.fedoraproject.org/t/howto-replace-wpa-supplicant-with-iwd-a-newer-wireless-daemon/144111>

I also had an issue where wifi scan is really slow up to 15sec
and wpa_supplicant version was `2.11-9.fc44`.
Looking at systemctl logs, it seems the first scan actually takes that much.
The scan is busy, and the wifi GUI panel does not display any point.
The first scan shows all channels available once it's done.
```text
1784041770.492611: phy #0: regulatory domain change (phy): set to KR by a driver request on phy0
1784041770.543861: wlp194s0 (phy #0): scan started
1784041784.095860: wlp194s0 (phy #0): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825 5955 5975 5995 6015 6035 6055 6075 6095 6115 6135 6155 6175 6195 6215 6235 6255 6275 6295 6315 6335 6355 6375 6395 6415 6435 6455 6475 6495 6515 6535 6555 6575 6595 6615 6635 6655 6675 6695 6715 6735 6755 6775 6795 6815 6835 6855 6875 6895 6915 6935 6955 6975 6995 7015 7035 7055 7075 7095 7115,
1784041784.107196: phy #0: regulatory domain change (phy): set to KR by a driver request on phy0
```

After switching the backend to `iwd`, it improved a bit;
it takes 6sec after switching wifi off and on, and 9sec after waking up from sleep.

```shell
sudo dnf install iwd

sudo mkdir -p /etc/NetworkManager/conf.d
sudo tee /etc/NetworkManager/conf.d/iwd.conf >/dev/null <<EOF
[device]
wifi.backend=iwd
EOF

sudo systemctl enable --now iwd

sudo systemctl disable --now wpa_supplicant

sudo systemctl restart NetworkManager
```

This is result log from `iw event -t`.
```text
1784042485.453418: wlan0 (phy #0): scan started
1784042491.755783: wlan0 (phy #0): scan finished: 2412,
```
