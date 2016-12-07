# dev

Quickly initialise development environments.


## About

`dev` is a cli tool which runs user-defined shell commands to set up a development environment. It can be used to:

- `cd` to the correct directory
- set environment variables
- activate a `virtualenv`
- do anything else which can be scripted


## Usage

```shell
$ echo "echo 'Initialising my environment'" > ~/.devfiles/myenv
$ dev myenv
Initialising my environment
```


## API

```
$ dev
Usage: dev [-h] [-v] environment

Positional arguments:
  environment   The environment to set up.

Optional arguments:
  -h            Help. Display this message and quit.
  -v            Version. Print version number and quit.
```


## Install

With git, for BASH:
```shell
$ git clone git://github.com/jamesroutley/dev.git ~/.dev
$ echo 'source ~/.dev/dev.sh' >> .bashrc
```

With git, for ZSH:
```shell
$ git clone git://github.com/jamesroutley/dev.git ~/.dev
$ echo 'source ~/.dev/dev.sh' >> .zshrc
```


## Configuration

A new environment, `<env>`, can be added by by creating the file `$DEVFILE_HOME/<env>`. This file is sourced when the command `dev <env>` is run, executing any shell commands stored in the file.

`$DEVFILE_HOME` is defaulted to `~/.devfiles`, but this location can be customised by setting the environment variable `$DEVFILE_HOME` before sourcing `dev.sh`.
