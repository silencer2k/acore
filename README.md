1. Clone this repo and build AzerothCore:
```
git clone git@github.com:silencer2k/acore.git
cd acore
./acore-build.sh
```
2. Copy whole `Data` folder from WOW client to `data` directory
3. Extract client data:
```
./acore-extract.sh
```
4. Edit `*.conf` files in `etc` directory
5. Start services:
```
sudo systemctl start ac-worldserver
sudo systemctl start ac-authserver
```
6. Update worldserver ip address:
```
echo "update realmlist set address='$(hostname -I | xargs)' where id=1" | sudo mysql acore_auth
```
7. Enable autostart:
```
sudo systemctl enable ac-worldserver
sudo systemctl enable ac-authserver
```
