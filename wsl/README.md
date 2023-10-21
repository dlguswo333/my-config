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


[install-manual]: https://learn.microsoft.com/en-us/windows/wsl/install-manual
[basic-commands]: https://learn.microsoft.com/ko-kr/windows/wsl/basic-commands
