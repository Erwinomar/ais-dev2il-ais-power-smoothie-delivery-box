FROM debian:bookworm-slim
# Set the working directory
WORKDIR /app
LABEL authors="saave"
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
# Install uv
RUN curl -Ls https://astral.sh/uv/install.sh | sh
# Add uv to PATH
ENV PATH="/root/.local/bin:$PATH"
RUN curl -Ls https://raw.githubusercontent.com/peterrietzler/ais-dev2il-ais-power-smoothie-delivery-box/refs/heads/exercises/scripts/setup-special-smoothie-maker-env.sh | sh
# Copy the application code
COPY . .
# Install dependencies
RUN uv sync --frozen
ENTRYPOINT ["uv", "run", "main.py"]
