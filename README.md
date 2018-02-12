# count-items.sh
Shell script to count files or directories within a specified location

# Features
- Count items within a specific location
- Count items with their Name containing a keyword
- Count specific Type (`file`/`directory`)
- Supports `maxdepth` (Descend at most levels (a non-negative integer) levels of directories below the starting-points. `-maxdepth 0` means only apply the tests and actions to the starting-points themselves.)

# Usage
```
USAGE:
    count-items.sh [OPTION]...

OPTIONS:
    -l, --location      Source directory (default is working directory: ${LOCATION})
    -n, --name          Name of file/directory (default is: ${NAME})
    -t, --type          Type of item, f for File, d for Directory (default: ${TYPE})
    -d, --depth         Maximum depth (default: ${MAXDEPTH})
    -h, --help,-?       Prints this usage

EXAMPLE:
    count-items.sh -w /path/to/dir -n some-name -t f -d 2
```
