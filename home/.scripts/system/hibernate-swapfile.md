
# [How to hibernate using swapfile](https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate
)

**Load swapfile with refind**

```
"Boot with standard options"  "ro resume=/dev/nvme0n1p6 resume_offset=34816 root=/dev/nvme0n1p6"
```

Default looks like:

```
"Boot with standard options"  "ro root=/dev/nvme0n1p6"
```

For `resume=`, use the same value as `root=value`.

Get resume offset with `filefrag -v /swapfile | awk '{ if($1=="0:"){print $4} }'`, but exclude the dots.

All previous info should be sufficient given a previously created and enabled swap file, and the use of refind.

## Activate swapfile

**To check if a swapfile is active**

```bash
swapon -s
```

**Get swapfile offset**

Following code extracts offset:

```bash
filefrag -v /swapfile | awk '{ if($1=="0:"){print $4} }'
```

Or use following:

```bash
filefrag -v /swapfile
```

This will give something like:

Filesystem type is: ef53
File size of /swapfile is 4294967296 (1048576 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       0:      **38912**..     38912:      1:
   1:        1..   22527:      38913..     61439:  22527:             unwritten
   2:    22528..   53247:     899072..    929791:  30720:      61440: unwritten
...

where the bold text is the file offset.

**Find swap device of swapfile**

```bash
findmnt -no UUID -T /swapfile
```

**fstab configuration**

In fstab, to point to this device, use `resume=UUID=[findmnt command]`


## creating a swapfile

```bash
sudo mkswap /swapfile
sudo swapon /swapfile
```

## Set power button and lid switch actions

Available options: *hibernate*, *suspend*, *poweroff*

```
HandlePowerKey=hibernate
HandleLidSwitch=hibernate
```
