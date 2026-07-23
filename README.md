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

### Recommended: let your coding agent install it

Beaver is built for AI-agent workflows, so the fastest install is the one your
agent runs. Paste this into Claude Code, Codex, or any coding agent:

```text
Set up beaver (https://github.com/cristianelias/beaver-dist), a git worktree
pool manager, on this machine. Steps must be idempotent.

1. Install the binary, then verify with `beaver --version`. Try in order:
     a. curl -fsSL https://raw.githubusercontent.com/cristianelias/beaver-dist/main/install.sh | sh
     b. npm i -g @cristian-elias/beaver
2. Wire the shell integration for the user's login shell, unless its rc
   file already has a `beaver init` line. zsh — append to ~/.zshrc:
     eval "$(beaver init zsh)"
   (bash: ~/.bashrc and `beaver init bash`.)
3. Run `beaver init-agents`. If your own memory file lives somewhere it
   did not list, run `beaver init-agents <that file>` too. If Claude Code
   is installed, also run `beaver init-agents --claude-hooks`.
4. Report exactly which files changed.
```

### Manual install

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
