To install `zsh` on your machine, simply install it from apt:

```shell
sudo apt update && \
sudo apt install zsh
```

Copy and paste the `.zshrc` config file to your root folder.

Change default shell of your account.

```shell
chsh -s $(which zsh)
```


# Powerlevel10k
[powerlevel10k][p10k] is a theme for zsh.
It gives you nice prompts on terminal.
You need a nerd font to use p10k.

Follow their Github README to install it from git repository for easier maintenance and upgrade.

[p10k]: https://github.com/romkatv/powerlevel10k
