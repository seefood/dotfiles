dotfiles
========

My collection of dotfiles, maintained through [homesick](https://github.com/technicalpickles/homesick).

## Preparation

* Make sure that your user is able to run `sudo`. This should work out of the box if your user is listed as an administrator of the machine. If not, follow [this guide](http://osxdaily.com/2014/02/06/add-user-sudoers-file-mac/) to add your user to the `/etc/sudoers` file: `sudo visudo`
* Make sure that you have a stable internet connection.
* If you need to use a proxy to access the internet, make sure your terminal is set up to use the proxy (environment variables, etc.).
* Mac users: Install the Xcode Developer Tools: xcode-select --install. This will prompt you to download the Xcode Developer Tools, which include required tools like git. Using this method prevents you from having to download the full 2+GB Xcode installer.

## Installation
------------

### Fast and careless

    curl https://raw.githubusercontent.com/seefood/dotfiles/master/bootstrap.sh | bash

### Slow and Careful

Install homesick first

    sudo gem install homesick

Clone the dotfiles repo

    homesick clone seefood/dotfiles .config/dotfiles

Then symlink the dotfiles to your home directory

    homesick symlink .config/dotfiles

To install additional tools, run the following scripts (in this order):

* `install_bash_it.sh`: This will download and install [my Bash-it fork](https://github.com/nwinkler/bash-it).

MacOS Users:
* `install_homebrew.sh`: This will download and install [Homebrew](https://brew.sh).
* `install_general.sh`: This will install a standard set of tools (command line and UI).
* `install_dev.sh`: Optional file, will install a set of development tools - only run if you plan to use the machine for software development.
* `osx-settings.sh`: Based on [Mathias Bynens' Dotfiles](https://github.com/mathiasbynens/dotfiles), a common set of OS X settings.

Then log out and back in again to apply the changes.

For more cool shell tools, see my [Dev-Env gist](https://gist.github.com/seefood/d70672cccb551935827ece2554592f96), and the dotfiles lovers' page ["GitHub ❤ ~/"](https://dotfiles.github.io/).

Thanks
------

* [homesick](https://github.com/technicalpickles/homesick)
* [Michael J. Smalley](https://github.com/michaeljsmalley/dotfiles) for the _vim_ configuration.
* [Mathias Bynens](https://github.com/mathiasbynens/dotfiles) for the OS X settings.
* [Bash-it](https://github.com/bash-it/bash-it) for the _Bash-it_ framework.
* [dotfiles by Nils Winkler](https://github.com/nwinkler/dotfiles).
* [dotfiles by Lital Natan](https://github.com/smackware/bashprofile).

License
-------

Copyright (c) 2015 Nils Winkler. Licensed under the MIT license.
Various other bits [(cc0)](https://creativecommons.org/share-your-work/public-domain/cc0/)/Public domain 2018 Ira Abramov and random people I borrowed ideas from around the web.
