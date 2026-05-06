1. Clone this repository:
```bash
git clone git@github.com:silencer2k/acore.git acore
```
2. Configure the modules list in the `config/repos.conf` file.
3. Build AzerothCore:
```bash
acore/scripts/build.sh
```
4. Copy the `Data` folder from the WoW client to the `acore/data` directory.
5. Extract the maps data:
```bash
acore/scripts/extract-maps.sh
```
6. Edit the `*.conf` files in the `acore/etc` directory.
7. Start the services:
```bash
sudo systemctl start ac-authserver
sudo systemctl start ac-worldserver
```
8. Update the worldserver ip address:
```bash
echo "update realmlist set address='$(hostname -I | xargs)' where id=1" | sudo mysql acore_auth
```
9. Enable autostart:
```bash
sudo systemctl enable ac-authserver
sudo systemctl enable ac-worldserver
```
