# `.bashrc`:
In `.bashrc`, I put the things that are related to interactive Bash usage. You'll also find a lot of references that configure environment variables like PATH in `.bashrc`, but I prefer to put these in `.profile` (see lower). `.bashrc` should be loaded when opening a new interactive Bash shell.

# `.bash_aliases`
I use a separate file `.bash_aliases` for my favorite Bash aliases, to keep things more tidy. This file is "sourced" by `.bashrc` (see higher).

# `.profile`
I put the "run time modifying" stuff (PATH and friends) in .profile, so that these things are also easily available outside interactive Bash sessions, like non-interactive Bash sessions, other command line shells sessions and even the graphical shell/desktop environment. The `.profile` file should be loaded on login on Linux setups.

