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

[core-eol-ignore]: https://git-scm.com/docs/git-config
