# kaizen (for files)

Kaizen is a fairly general program that suggests "improvements" to your messy files.
You curate a collection of repetitive task descriptions, and it suggests which ones could be run on which files.
For example, I use it to extract nested archives from my old, poorly-formatted backups.

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
