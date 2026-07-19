# Beaver distributions

This public repository contains Beaver installation materials and compiled
release artifacts. It does not contain the Rust application source, tests,
Cargo manifests, or the private development history.

Native executables can still be inspected and disassembled. This distribution
boundary prevents publication of the source tree; it is not an anti-reverse-
engineering mechanism.

Product site: [beaver-worktrees.cristian-ricardo-eli.chatgpt.site](https://beaver-worktrees.cristian-ricardo-eli.chatgpt.site)

Launch feedback: [Beaver v0.9.4 feedback](https://github.com/cristianelias/beaver-dist/issues/1)

## Install

macOS and Linux:

```sh
curl -fsSL https://raw.githubusercontent.com/cristianelias/beaver-dist/main/install.sh | sh
```

Or install the same native binary through npm:

```sh
npm i -g @cristian-elias/beaver
```

Release downloads contain four platform archives plus `SHA256SUMS`. The
installer and `beaver update` both verify the selected archive before replacing
an installed binary.

GitHub's automatically generated source archives contain only this repository's
four allowlisted distribution files. They are not Beaver application source.
