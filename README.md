# davidfstr's dotfiles

These are my customizations for the command line on OS X.

You may find them useful if you use a similar technology stack:

* OS X
* bash
* git+gitx, svn, cvs

For more information about "dotfiles" in general, consider reading [holman's post on dotfiles](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).


## Requirements

* OS X 10.7 (Lion) or later
* `bash` as your default shell


## Installation

* Clone this repository to `~/.dotfiles`.
* Ensure that your `~/.bash_profile` includes at the top:

```
# Execute .bashrc
source ~/.bashrc
```

* Ensure that your `~/.bashrc` includes at the top:

```
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Execute shared bashrc
source "$HOME/.dotfiles/.bashrc_shared"
```

## Design

* Simple.
    * A single monolithic rc file.
    * No special scripts that manage / install the dotfiles.
* Isolated.
    * `.bashrc_shared` is separate from the main `.bashrc`.
        * Installers often attempt to modify `.bashrc` or `.bash_profile`.
          Such modifications should be kept separate from the shared rc files.
* Minimal.
    * Only includes commands and aliases that I actually use on a regular basis.
    * Default place to add new aliases and customizations is still the
      machine-specific `.bashrc`.
        * Customizations are migrated to the shared `.bashrc_shared` only
          after it has proven useful enough to use on multiple machines.
* Portable.
    * Customizations are written for the `bash` shell,
      which seems to be the default shell almost everywhere.

## License

This software is licensed under the [MIT License].

[MIT License]: https://github.com/davidfstr/dotfiles/blob/master/LICENSE.txt
