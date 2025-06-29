[neovim][neovim] is kind of like yet another vim.

# Install
To install neovim on your machine, you can install it from apt,
but neovim on apt is not up to date as of now.

So on Linux, I recommend to download neovim *AppImage* file
and alias it in your shell config file.
Refer to https://github.com/neovim/neovim/wiki/Installing-Neovim#linux
for recent and more information.

```shell
cd ~
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
```

```shell
# In your shell config
alias ~/nvim.appimage nvim
```

If you want the appimage available globally (e.g. super user),
you can do that by creating a link file in bin folder.

```shell
sudo ln -s ~/nvim.appimage /usr/local/bin/nvim
```

You may also put the appimage file into the folder,
but then you need to type `nvim.appimage` command.
Linux commands are expected to be single word.
You will end up linking or aliasing anyway.

# Configure
## init.vim
If you do not want package manager and additional plugins,
what you need is `init.vim`.
Link `init.vim` file to the designated path.
According to [neovim docs][neovim-config]:
```
A file containing initialization commands is generically called
a "vimrc" or config file.  It can be either Vimscript ("init.vim") or
Lua ("init.lua"), but not both. E5422
See also vimrc-intro and base-directories.

The config file is located at: <br>
Unix			~/.config/nvim/init.vim		(or init.lua) <br>
Windows			~/AppData/Local/nvim/init.vim	(or init.lua)
$XDG_CONFIG_HOME  	$XDG_CONFIG_HOME/nvim/init.vim	(or init.lua)
```

Thus if you are on Unix (Linux):

```shell
mkdir -p ~/.config/nvim/
ln -s $PWD/nvim/init.vim ~/.config/nvim/init.vim
```

# init.lua
If you like to install additional features, what you need is `init.lua`.
```shell
mkdir -p ~/.config/nvim/
ln -s $PWD/nvim/init.lua ~/.config/nvim/init.lua
```

You need to install ripgrep to use telescope's features, including searching for keywords.
ripgrep needs to be accessible through PATH env.
Run the following commands on Linux. Use brew to install ripgrep on Mac.
```shell
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.0.3/ripgrep_14.0.3-1_amd64.deb
sudo dpkg -i ripgrep_14.0.3-1_amd64.deb
```

Also, `init.lua` has some basic LSP features.
To enable it, you need to install LSP or linters such things by [mason][mason],
a package manager for LSP. Run the following command within nvim command mode.
```shell
:MasonInstall <PACKAGE>
```

[neovim]: https://github.com/neovim/neovim
[neovim-config]: https://neovim.io/doc/user/starting.html#initialization
[mason]: https://github.com/williamboman/mason.nvim
