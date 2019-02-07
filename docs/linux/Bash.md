# Linux CLI: Bash specific notes and cheats

## Sorting

Sort numbers in bash
```bash
cat /etc/group | sort -t : -k 3 -g
# -t separator
# -k key/column
# -g general numeric sort
```

## Read user input

Reaction on Y and y in one command in bash
```bash
if [[ ${REPLY} =~ ^[Yy]$ ]]; then
...
```

## Manipulations with files and directories

Copy with sync
```bash
rsync --exclude ".git/" --exclude "README.md" -av <source path> <target path>
```

Copy path and preserve directory tree
```bash
rsync -avR ./ <destination>
```


## JSON parsing and creating

Select multiple values using jq
```bash
echo '{"z":{"a":1,"b":2,"c":3},"z2":{"a":1,"b":2,"c":3}}' | jq '[.z.a,.z2.b]'
# output
# [ 1, 2 ]
```




## Bash best practices

* Ty to use 'set -e' in every bash scripts
[Best practice with “set -e” and etc](https://www.davidpashley.com/articles/writing-robust-shell-scripts/#id2382181)

* Use '$(echo "Hi")' insted of `echo "Hi"` - `...` - it is an obsolete, $(...) allow you use nesting without a problem $(...$(...$(...) ) ) and can work on every modern shell 
  (see: [`` vs $()](http://tldp.org/LDP/abs/html/commandsub.html#COMMANDSUBREF))

