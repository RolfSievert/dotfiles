# [The woes of dual-booting Manjaro/Windows](https://forum.manjaro.org/t/howto-get-your-time-timezone-right-using-manjaro-windows-dual-boot/89359) [^link to manjaro forum]

Windows defaults to setting the (RTC) real-time-clock to local-time and Linux sets RTC in UTC (universal-time).

This makes your time/timezone floating in space where it may be in doubt what time it actually is.

## Manjaro configuration

The best approach to keep both working is to set your RTC (hardware clock) to UTC

``` bash
sudo timedatectl set-local-rtc 0
```

And enable a network-time-daemon on Linux.

``` bash
sudo systemctl enable --now systemd-timesyncd
```

Ensure your timezone is correct linking it to your /etc/localtime e.g for Jerusalem (Replace in the command below Continent/City case sensitive location)

``` bash
sudo ln -sf /usr/share/zoneinfo/Asia/Jerusalem /etc/localtime
```

## Windows configuration

Next step is to boot into Windows and instruct Windows to handle the hardware clock in UTC as described by @gohlip in this post 149.

The basics from the above post is to add an entry to the system registry. To avoid messing with the Registry Editor (regedit.exe) creating a file to import is the safest method.

Create a file on your Windows system using Notepad (notepad.exe) and name it utc.txt and save it on your desktop.

Rightclick your desktop → New → Text document

Copy/Paste below content as you need absolutely no errors.

Depending on your version of Windows this may work.

Older versions of Windows may import the file without complaints

```
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation]
"RealTimeIsUniversal"=dword:00000001
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient]
"Enabled"=dword:00000000
```
Newer versions presumably Windows 10 requires the registry editor version and an empty line

Windows Registry Editor Version 5.00
```
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation]
"RealTimeIsUniversal"=dword:00000001
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient]
"Enabled"=dword:00000000
```
When you have saved the file, open a command prompt and navigate to your Desktop folder and rename the file to utc.reg.

``` batch
C:\Users\username> cd Desktop
C:\Users\username\Desktop> move utc.txt utc.reg
```

When you have renamed the file it can be imported into the registry by double clicking the .reg file found on your desktop.

Accept the disclaimer to import the keys and reboot your system.

The end result
Besides letting Windows use the systems RTC the registry keys also disables the Windows NTP client - so only Manjaro will adjust your clock.
