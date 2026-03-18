# Claude Code Docker

Run [Claude Code](https://claude.ai) in a containerized environment.

## Build

```bash
docker build -t claude-code .
```

## Run

```bash
docker run -it --rm \
  -v "$HOME/.claude:/home/claude/.claude" \
  -v "$HOME/.claude.json:/home/claude/.claude.json" \
  -v "$HOME/.gitconfig:/home/claude/.gitconfig:ro" \
  -v "$HOME/.ssh:/home/claude/.ssh:ro" \
  -v "$SSH_AUTH_SOCK:/tmp/ssh-agent.sock" \
  -e SSH_AUTH_SOCK=/tmp/ssh-agent.sock \
  -v "$(pwd):/work" \
  -w /work \
  claude-code
```

This mounts your Claude credentials, Git config, and SSH keys into the container and opens Claude Code in the current directory.
