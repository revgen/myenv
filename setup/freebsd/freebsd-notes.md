# My notes about FreeBSD system

## Ports

* Install package: ```pkg install <name>```
* Search package: ```pkg search <name>```
* Remove package: ```pkg delete <name>```



## Notes

### Working with hardware disks

* See all disk in the system: ```geom disk list``` or ```camcontrol devlist``` or ```gpart list```
* Clean all disk information: ```gpart destroy -F <disk>```

