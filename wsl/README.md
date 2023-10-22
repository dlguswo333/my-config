# Install
To install wsl on Windows, first you need to enable wsl feature in the setting.

If you are on **Windows 11 22H2** or newer, you can enable wsl with single command without a distribution.

```shell
wsl --install --no-distribution
```

Otherwise follow [the procedure of installing wsl on old Windows][install-manual].<br>
you need to do steps before the installation of distros.

# Export/Import
To export an image of your wsl instance, do the following on Windows.

```shell
wsl --export <Distribution Name> <FileName>
```

It will make a `tar` file that has an image of your instance.
To export a `tar` file, do this:

```shell
wsl --import <Distribution Name> <InstallLocation> <FileName>
```

You can find more about the basic commands [here][basic-commands].

# wsl.conf
wslconfig lets you config how each wsl instance work.
It requires you write `/etc/wsl.conf` inside your wsl instance.
Note that you need super user privileges to edit the file.

wsl appends useful Windows paths to wsl instances' "PATH" env by default.
If you do not want this behavior, add this to `/etc/wsl.conf` in your wsl instance.
```shell
[interop]
appendWindowsPath = false
```

If you want `systemd`, add this.

```shell
[boot]
systemd=true
```

If you want to edit the default login user, Do this:

```shell
[user]
default=dlguswo333
```

# Useful Config
Add these lines to your shell config if you want vscode and explorer.exe in your Linux shell.
This is particularly useful if you disable `appendWindowsPath` but need some of them.

```shell
# Alias Windows executables for wsl
alias code="/mnt/c/Users/dlguswo/AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe"
alias explorer="/mnt/c/Windows/explorer.exe"
```

[install-manual]: https://learn.microsoft.com/en-us/windows/wsl/install-manual
[basic-commands]: https://learn.microsoft.com/ko-kr/windows/wsl/basic-commands
