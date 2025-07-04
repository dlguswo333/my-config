It's vital to set your name and email address in git.

```shell
git config --global user.name dlguswo333
git config --global user.email dlguswo002@gmail.com
```

Unix-like operating systems use LF for end of line by default.
Windows used CRLF rather than LF, but for compatibility and convenience,
Windows have been adopting LF and
modern Windows such as 10 and 11 have no issue with LF EOL (at least in my memories).

So if you are starting a new project you would be happy to force LF EOL in git config.

```shell
git config --global core.eol lf
```

If you want to add files with LF into git
but want them to be converted into CRLF in your working directory,
set `core.autocrlf=true`.

```shell
git config core.autocrlf true
```

If you want to force LF in your projects whether in working directory and commits,
you can choose `core.autocrlf=input`.
This will not convert CRLF when you check out files,
but since it converts CRLF into LF when you commit,
it has the same effect as forcing LF across the project.

```shell
git config core.autocrlf input
```

Note that `core.eol` is [ignored][core-eol-ignore] if `core.autocrlf` is `true` or `ignored`.

# Alias
Aliasing helps you type less.
```
# git co = git commit
git config --global alias.co checkout
```

# Change Editor
```shell
git config --global core.editor <YOUR_EDITOR>
```

It also supports `~` user home directory. For instance, `~/nvim.appimage`.

# Change difftool
Instead of printing git changes in your shell terminal with `git diff`,
you can watch changes inside your favorite tools.
The command is a frontend to `git diff` command and accepts the same options.
```shell
git difftool
```

git supports changing difftool that matches your appetite.
In case you want to neovim to be your difftool add the lines to your git configs:
```shell
git config --global diff.tool nvimdiff
git config --global difftool.nvimdiff.cmd 'nvim -d "$LOCAL" "$REMOTE"'
```

But git might start asking you whether to show each file with the configured difftool.
```
Viewing (2/2): 'nvim/init.lua'
Launch 'nvimdiff' [Y/n]?
```

If you find this behavior annoying, run this command:
```shell
git config --global difftool.prompt false
```

# Sign your Commits
If you want to sign commits, you may follow the following settings.

First set gpg sign flag:
```shell
git config --global commit.gpgsign true
```

Then set your sign key. `<YOUR_SIGN_KEY>` is your GPG key ID or your ssh key file path.
```shell
git config --global user.signingkey <YOUR_SIGN_KEY>
```

In case you want to sign with ssh keys:
```shell
git config --global gpg.format ssh
```

# lazygit
*A simple terminal UI for git commands.*

There is `config.yml` file for lazygit configurations.

<https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation>

# git-delta
*A syntax-highlighting pager for git, diff, and grep output*

Be aware that delta uses git config for its configurations.
I clarified that it also applies to delta outside git (i.e. direct `delta` command).

<https://dandavison.github.io/delta/installation.html>


[core-eol-ignore]: https://git-scm.com/docs/git-config
