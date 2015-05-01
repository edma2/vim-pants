Overview
=========
A vim plugin for [Pants build tool](https://pantsbuild.github.io/).

The core utility provided is the Pants command.
Invoke it like so
```vim
:Pants [goal] [target] ...
```
The default goal is "compile".
The default target is inferred from the current file's parent BUILD file.

When run with one argument, replace the default goal with the given argument.
When run with two arguments, replace the default goal with the first argument,
and default target with the second argument. The target syntax is described
[here](http://pantsbuild.github.io/target_addresses.html); you can use '.' as
an alias for the default target (see the example below). When run with more
than two arguments, set the goal and target as described above using the first
two arguments, and pass the remaining arguments to Pants.

Errors and warnings will be loaded in a quickfix list once Pants finishes
running.

Uses [vim-dispatch](https://github.com/tpope/vim-dispatch) if present. This is
highly recommended (along with tmux) to avoid blocking the entire editor when
Pants runs.

Additionally, a convenience command, ```:Junit```, is provided to run the
current file as a JUnit test suite (only if file ends with Test.scala or
Spec.scala).

Examples
=========
Compile the default target; its sources will include the current file:
```vim
:Pants
```

Run the tests in foobird target (from project root)
```vim
:Pants test foobird:tests
```

Start a new REPL (especially useful as a split window if vim-dispatch is used)
using the classpath of the default target:
```vim
:Pants repl
```

Compile a different target within the parent BUILD file ("foo") instead of
using the default target (the target matching the parent directory's name).
Also pass some additional arguments to Pants.
```vim
:Pants compile .:foo -arg1 -arg2
```

Run current file as JUnit test suite:
```vim
:Junit
```
