# Claude Code Docker

Run [Claude Code](https://claude.ai) in a containerized environment. 

To make it seamless and compatible with your local hooks and config Docker will run with the same user directory as your local environment.

> Disclaimer: This project was created for my personal use and everything in this repo was tested against my Linux setup. Things may not work for your setup out of the box.

## Build

```bash
make build
```

## Run

```bash
docker run -it --rm \
  -v "$HOME/.claude:/home/$(whoami)/.claude" \
  -v "$HOME/.claude.json:/home/$(whoami)/.claude.json" \
  -v "$HOME/.gitconfig:/home/$(whoami)/.gitconfig:ro" \
  -v "$HOME/.ssh:/home/$(whoami)/.ssh:ro" \
  -v "$SSH_AUTH_SOCK:/tmp/ssh-agent.sock" \
  -e SSH_AUTH_SOCK=/tmp/ssh-agent.sock \
  -v "$HOME/.config/rtk:/home/$(whoami)/.config/rtk" \
  -v "$HOME/.local/share/rtk:/home/$(whoami)/.local/share/rtk" \
  -v "$(pwd):/work" \
  -w /work \
  claude-code
```

This mounts your Claude credentials, Git config, SSH keys, and RTK config into the container and opens Claude Code in the current directory.

## RTK (Token Killer)

The container includes [rtk](https://github.com/rtk-ai/rtk), a CLI proxy that reduces token usage by 60-90% on common dev operations.

See the [RTK installation guide](https://github.com/rtk-ai/rtk/blob/master/INSTALL.md) for full setup details.

> **Important:** RTK relies on Claude Code hooks to intercept commands. You must install the hooks in your Claude Code settings for RTK to work inside the container. Since `~/.claude` is mounted from your host, configure the hooks on your host machine and they will be available inside the container automatically.

## Alias

Add this to your `~/.bashrc` or `~/.zshrc`:

```bash
alias cclaude='docker run -it --rm \
  -v "$HOME/.claude:/home/$(whoami)/.claude" \
  -v "$HOME/.claude.json:/home/$(whoami)/.claude.json" \
  -v "$HOME/.gitconfig:/home/$(whoami)/.gitconfig:ro" \
  -v "$HOME/.ssh:/home/$(whoami)/.ssh:ro" \
  -v "$SSH_AUTH_SOCK:/tmp/ssh-agent.sock" \
  -e SSH_AUTH_SOCK=/tmp/ssh-agent.sock \
  -v "$HOME/.config/rtk:/home/$(whoami)/.config/rtk" \
  -v "$HOME/.local/share/rtk:/home/$(whoami)/.local/share/rtk" \
  -v "$(pwd):/work" \
  -w /work \
  claude-code'
```

Then run from any project directory:

```bash
cclaude
```
