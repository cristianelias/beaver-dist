# Beaver distributions

This public repository contains Beaver installation materials and compiled
release artifacts. It does not contain the Rust application source, tests,
Cargo manifests, or private development history.

Native executables can still be inspected and disassembled. This boundary
prevents publication of the source tree; it is not an anti-reverse-engineering
mechanism.

Product site: [beaver-worktrees.cristian-ricardo-eli.chatgpt.site](https://beaver-worktrees.cristian-ricardo-eli.chatgpt.site)

## Install

macOS and Linux:

```sh
curl -fsSL https://raw.githubusercontent.com/cristianelias/beaver-dist/main/install.sh | sh
```

Or install the same native binary through npm:

```sh
npm i -g @cristian-elias/beaver
```

Enable the optional current-shell `cd` integration:

```sh
printf '\n# beaver — git worktree pool manager\neval "$(beaver init zsh)"\n' >> ~/.zshrc
exec zsh
```

Use `~/.bashrc` and `beaver init bash` for bash.

Beaver is manual-only: installation does not configure coding assistants,
write their instruction files, or wire their lifecycle hooks. Upgrades from
older releases perform a one-way cleanup of artifacts that Beaver itself
previously installed while preserving foreign settings and user content.

Release downloads contain four platform archives plus `SHA256SUMS`. The
installer and `beaver update` both verify the selected archive before replacing
an installed binary.

GitHub's generated source archives contain only this repository's allowlisted
distribution files. They are not Beaver application source.
