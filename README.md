Overview
=========
A vim plugin for [Pants build tool](https://pantsbuild.github.io/).

The core utility provided is the Pants command.
Invoke it like so
```
:Pants <optional arguments>
```
The default goal is "compile".
The default target is inferred from the nearest parent BUILD file.

When run with one argument, replace the default goal with the given argument.
When run with two arguments, replace the default goal with the first argument,
and default target with the second argument. You can use '.' as an alias for
the default target.

Uses [vim-dispatch](https://github.com/tpope/vim-dispatch) if installed.
