# Ubuntu wsl Dotfiles

My personal set-up scripts. 

## Included `scripts/`

- `apt-update-upgrade.sh` does what its name implies
- `symlink.sh` sets up symbolic links in `$HOME`
- `git.sh` adds ppa git repo and updates its version
- `zsh.sh` install zsh
- `oh-my-zsh.sh` install oh my zsh and the plugins I like to use
- `sdkman.sh` downloads sdkman and packages that it depends on
- `go.sh` downloads latest version of go
- `setup.sh` runs all scripts at once

## Instalation

```sh
git clone https://github.com/patrickovm/dotfiles.git ~/.dotfiles
```

## Usage

```sh
cd ~/.dotfiles/scripts
```

```sh
chmod +x ./setup.sh
```

running all scripts at once:

```sh
./setup.sh
```

example of running an individual script:

```sh
chmod +x ./go.sh
```

```sh
./go.sh
```