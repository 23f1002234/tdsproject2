
FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install uv
RUN pip install uv

# Copy project files
COPY . .

# Install dependencies
RUN uv sync

# Install Playwright browsers
RUN uv run playwright install chromium --with-deps

# Expose port
EXPOSE 7860

# Start the application
CMD ["uv", "run", "main.py"]