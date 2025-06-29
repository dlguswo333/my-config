To install `zsh` on your machine, simply install it from apt:

```shell
sudo apt update && \
sudo apt install zsh
```

Link the `.zshrc` config file to your home directory.
```shell
ln -s $PWD/zsh/.zshrc ~/.zshrc
```

Change default shell of your account.
```shell
chsh -s $(which zsh)
```

# Powerlevel10k
[powerlevel10k][p10k] is a theme for zsh.
It gives you nice prompts on terminal.
You need a nerd font to use p10k.

To install powerlevel10k:
```shell
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```

Follow their Github README for easier maintenance and upgrade.

[p10k]: https://github.com/romkatv/powerlevel10k
