1. Clone this repo:
```
git clone git@github.com:silencer2k/acore.git acore
```
2. Build AzerothCore:
```
acore/scripts/build.sh
```
3. Copy `Data` folder from WoW client to `acore/data` directory
4. Extract maps data:
```
acore/scripts/extract-maps.sh
```
5. Edit `*.conf` files in `acore/etc` directory
6. Start services:
```
sudo systemctl start ac-authserver
sudo systemctl start ac-worldserver
```
7. Update worldserver ip address:
```
echo "update realmlist set address='$(hostname -I | xargs)' where id=1" | sudo mysql acore_auth
```
8. Enable autostart:
```
sudo systemctl enable ac-authserver
sudo systemctl enable ac-worldserver
```
