# kaizen (for files)

It's kind of like a build system with no predefined end state.
Instead, the goal is just to make continuous progress!

Whenever you find youreslf doing something repetitive, stop and try to codify
it as a script. You define the commands to run along with input and output
filename patterns. There are optional fancier things like preconditions and
error handling too. Based on your description, `kaizen` will suggest
appropriate ways to re-use the script later.

I find there are 3 major benefits to working this way:

1. It starts slow, but builds speed as you delegate more work.

2. Defining how and when commands can run safely clarifies your thinking,
   helping you remember to be similarly careful the rest of the time.

3. Once you know your scripts are reliable you can launch them quickly
   and get back to other things with minimal switching cost.

## Usage

See `usage.txt` for all the command line options.

## For developers

### Build

This project provides a non-invasive Stack+Nix integration.
See [the Tweag blog](https://www.tweag.io/blog/2022-06-02-haskell-stack-nix-shell/) for details.

```shell
$ nix-shell
[nix-shell]$ stack build
```

### Update Docs

### Update Dependencies

You want the latest GHC version supported by both [nixpkgs-unstable][1] and a Stack LTS [snapshot][2].
It can be a little tricky because Niv is broken(?), so I update like this:

1. Find the hash of the latest commit on the nixos/nixpkgs unstable branch.
2. Manually update the rev and url it in `nix/sources.json`.
3. `nix-shell`, `nix repl`, `:l <nixpkgs>`, tab complete `haskell.compiler.ghc`<tab> to find available GHC versions.
5. Check the Stackage site for the latest LTS snapshot that matches one of the Nix-supported GHC versions.
6. Update the resolver in `stack.yaml` and try to `stack build`
7. Correct any remaining issues

[1][https://search.nixos.org/packages?channel=unstable]
[2][https://www.stackage.org/snapshots]
