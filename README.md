# dotfiles

My collection of dotfiles, maintained through [homesick](https://github.com/technicalpickles/homesick).

## Preparation

- Make sure that your user is able to run `sudo`. This should work out of the box if your user is listed as an administrator of the machine. If not, follow [this guide](http://osxdaily.com/2014/02/06/add-user-sudoers-file-mac/) to add your user to the `/etc/sudoers` file: `sudo visudo`
- Make sure that you have a stable internet connection.
- If you need to use a proxy to access the internet, make sure your terminal is set up to use the proxy (environment variables, etc.).
- Mac users: Install the Xcode Developer Tools: xcode-select --install. This will prompt you to download the Xcode Developer Tools, which include required tools like git. Using this method prevents you from having to download the full 2+GB Xcode installer.

## Installation

### Fast and careless

There's a quick bootstrap included for my personal use, go over it and see it does what you expect.
If it does not, you may prefer to run parts of it manually or fork and tweak
it for yourself. If you come up with good fixes to the problems I bumped into,
please send me a PR.

I repeat: this is for my personal use, it installs several things as root,
expects open sudo access and may be a bit destructive (though idempotent).
Do _NOT_ run it if you didn't go over it and agreed to what it does, and as
a general rule, it's NEVER a good idea to run `curl *URL*|bash` ever ever ever.
having said that, have a ball :-)

    curl https://raw.githubusercontent.com/seefood/dotfiles/master/bootstrap.sh | bash

### Slow and Careful

Install homesick first

    sudo gem install homesick

Clone the dotfiles repo

    homesick clone seefood/dotfiles

Then symlink the dotfiles to your home directory

    homesick symlink dotfiles

### Optional tools installed by my bootstrap.sh

To install additional tools, run the following scripts (in this order):

Install [TheFuck](https://github.com/nvbn/thefuck) by `sudo apt install thefuck`

Install [FZF](https://github.com/junegunn/fzf):

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

Hub from [github](https://github.com/github/hub/) (see code snippet in my bootstrap.sh for a quick setup)

[fd](https://github.com/sharkdp/fd) (smart, fast alternative to find).

Download and install [my Bash-it fork](https://github.com/nwinkler/bash-it).

    ~/.homesick/repos/dotfiles/install_bash_it.sh

Other nice to have (not auto installed) is [progress](https://github.com/Xfennec/progress).

#### MacOS Users

- `~/.homesick/repos/dotfiles/install_homebrew.sh`: This will download and install [Homebrew](https://brew.sh).
- `~/.homesick/repos/dotfiles/install_general.sh`: This will install a standard set of tools (command line and UI).
- `~/.homesick/repos/dotfiles/install_dev.sh`: Optional file, will install a set of development tools - only run if you plan to use the machine for software development.
- `~/.homesick/repos/dotfiles/osx-settings.sh`: Based on [Mathias Bynens' Dotfiles](https://github.com/mathiasbynens/dotfiles), a common set of OS X settings.

Then log out and back in again to apply the changes.

For more cool shell tools, see my [Dev-Env gist](https://gist.github.com/seefood/d70672cccb551935827ece2554592f96), and the dotfiles lovers' page ["GitHub ❤ ~/"](https://dotfiles.github.io/).

## Thanks

- [homesick](https://github.com/technicalpickles/homesick)
- [Michael J. Smalley](https://github.com/michaeljsmalley/dotfiles) for the _vim_ configuration.
- [Mathias Bynens](https://github.com/mathiasbynens/dotfiles) for the OS X settings.
- [Bash-it](https://github.com/bash-it/bash-it) for the _Bash-it_ framework.
- [dotfiles by Nils Winkler](https://github.com/nwinkler/dotfiles).
- [dotfiles by Lital Natan](https://github.com/smackware/bashprofile).
- [dotfiles by Adir Gabay](https://github.com/adirg/dotfiles).
- [dotfiles by Jessica Deen](https://github.com/jldeen/dotfiles),
  mainly for the zsh trickeries, though I have rewrote this entirely for zinit by this point...
- [wezterm config by Kevin Sylvester](https://github.com/KevinSilvester/wezterm-config/)

## License

Copyright (c) 2015 Nils Winkler. Licensed under the MIT license.
Various other bits [(cc0)](https://creativecommons.org/share-your-work/public-domain/cc0/)/Public domain 2018 Ira Abramov and random people I borrowed ideas from around the web.
