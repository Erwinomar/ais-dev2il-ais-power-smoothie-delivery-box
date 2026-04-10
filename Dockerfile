FROM debian:bookworm-slim

# Set the working directory
WORKDIR /app

# Install curl and ca-certificates to be able to download uv
RUN apt-get update && apt-get install -y curl ca-certificates && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -Ls https://astral.sh/uv/install.sh | sh

# Just copy this and ignore it for the moment - we are going to talk about this one later!
RUN curl -Ls https://raw.githubusercontent.com/peterrietzler/ais-dev2il-ais-power-smoothie-delivery-box/refs/heads/exercises/scripts/setup-special-smoothie-maker-env.sh | sh

# Add uv to PATH
ENV PATH="/root/.local/bin:$PATH"

# Copy the application code
COPY . .

# Install dependencies
RUN uv sync --frozen

# Set the entrypoint
ENTRYPOINT ["uv", "run", "main.py"]
