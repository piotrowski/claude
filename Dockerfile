FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    jq \
    zsh \
    ripgrep \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user matching your host UID/GID/username
ARG USER_UID=1000
ARG USER_GID=1000
ARG USERNAME=claude
RUN groupadd -g $USER_GID $USERNAME && \
    useradd -m -u $USER_UID -g $USER_GID -s /bin/zsh $USERNAME

# Install Claude Code via native installer (no Node.js needed)
USER $USERNAME
ENV USERNAME=$USERNAME
RUN curl -fsSL https://claude.ai/install.sh | bash

# Install rtk (token-efficient CLI wrapper for Claude Code)
RUN curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/master/install.sh | bash

# Set terminal for proper TUI rendering (color + status line)
ENV TERM=xterm-256color
ENV PATH="/home/${USERNAME}/.local/bin:$PATH"

WORKDIR /home/${USERNAME}
ENTRYPOINT ["sh", "-c", "exec claude \"$@\"", "sh"]