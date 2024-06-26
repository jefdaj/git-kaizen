# git-kaizen

## Theory

It's like a forward build system (TODO cite) with no predefined end state or
project scope. Instead, the goal is just to make continuous progress wherever
you can...

1. When you find yourself doing something repetitive with files, stop and try to
   codify it as a script. You define the commands to run along with input and
   (optinal) output filename patterns.

2. Later, `git-kaizen` will suggest running the script on other matching files.
   You have a growing menu of "next steps" for various situations.

3. As with a build system, the real magic is in chaining steps together.
   But this is easier! You don't need to start with a plan; pipelines just form
   organically.

## Practice

TODO backup example here

## For users

See `usage.txt` for command line options.

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

You want the latest GHC version supported by both
[nixpkgs-unstable](https://search.nixos.org/packages?channel=unstable) and a
Stack LTS [snapshot](https://www.stackage.org/snapshots). It can be a little
tricky because Niv is broken(?), so I update like this:

1. Find the current `nixpkgs-unstable` git rev [here](https://status.nixos.org/) (should also be the one shown on the github branch)
2. Manually update the rev and url in `nix/sources.json`, try to `nix-shell`, and edit the sha256sum when you get a mismatch.
3. `nix-shell` again, `nix repl`, `:l <nixpkgs>`, tab complete `haskell.compiler.ghc`<tab> to find available GHC versions.
5. Check [Stackage](https://www.stackage.org/) for the latest LTS snapshot that matches one of the Nix-supported GHC versions.
6. Update the resolver in `stack.yaml` and try to `stack build`
7. Correct any remaining issues
