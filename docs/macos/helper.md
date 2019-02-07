# Mac OS cheats and notes


### Install XCode Command Line Tool
```bash
xcode-select --install
sudo xcodebuild -license accept
```
## Time Machine

Exclude path from the Time Machine backup:
```bash
sudo tmutil addexclusion -p <path>
```

Check if path excluded in the Time Machine backup:
```bash
sudo tmutil isexcluded <path>
```

## System

Show mac OS version
```bash
sw_vers
```

### Mac OS Software updates

Show a list of all appropriate updates:
```bash
softwareupdate -l
```

Install all current updates for the system:
```bash
softwareupdate -ia
```


### Logs

Write to the system log from the terminal
```bash
logger -s -p alert "User alert message"
logger -s "User custom information message"
```

Show logs for th past 3 minutes with a filter
```bash
log show --last 3m | grep "logger:"
```
