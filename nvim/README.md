[neovim][neovim] is kind of like yet another vim.
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

If you do not want package manager and additional plugins,
what you need is `init.vim`.
Copy and paste the `init.vim` file to the designated path.
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
cp nvim/init.vim ~/.config/nvim/
```

If you like to install additional features, what you need is `init.lua`.
You need to install ripgrep to use telescope's features, including searching for keywords.
ripgrep needs to be accessible through PATH env.

```shell
mkdir -p ~/.config/nvim/
cp nvim/init.lua ~/.config/nvim/

# Run the following commands on Linux. Use brew to install ripgrep on Mac.
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.0.3/ripgrep_14.0.3-1_amd64.deb
sudo dpkg -i ripgrep_14.0.3-1_amd64.deb
```

[neovim]: https://github.com/neovim/neovim
[neovim-config]: https://neovim.io/doc/user/starting.html#initialization
