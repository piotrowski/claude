FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zsh \
    ripgrep \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user matching your host UID
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd -g $USER_GID claude && \
    useradd -m -u $USER_UID -g $USER_GID -s /bin/zsh claude

# Install Claude Code via native installer (no Node.js needed)
USER claude
RUN curl -fsSL https://claude.ai/install.sh | bash

# Set terminal for proper TUI rendering (color + status line)
ENV TERM=xterm-256color

WORKDIR /home/claude
ENTRYPOINT ["/home/claude/.local/bin/claude"]