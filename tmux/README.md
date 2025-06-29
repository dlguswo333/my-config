Place `.tmux.conf` file in your home directory.
```shell
ln -s $PWD/tmux/.tmux.conf ~/.tmux.conf
```

If you want to reload the configuration file, do this:
```shell
tmux source-file
```

# tmux plugin manager
This configuration uses tpm. Run the shell command below to install it before using tmux.
```shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
