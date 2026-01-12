# Multi-architecture Dockerfile for ITSD Reminder Bot
# Supports both AMD64 (Intel) and ARM64 (Apple Silicon M1/M2/M3)

FROM python:3.11-slim

# Set build arguments for multi-arch support
ARG TARGETPLATFORM
ARG BUILDPLATFORM

# Labels for container metadata
LABEL maintainer="ITSD Team"
LABEL description="Slack Reminder Bot for ITSD HelpDesk"
LABEL version="1.0.0"

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV TZ=UTC

# Create non-root user for security
RUN groupadd --gid 1000 appgroup && \
    useradd --uid 1000 --gid appgroup --shell /bin/bash --create-home appuser

# Set working directory
WORKDIR /app

# Create data directory for persistent storage
RUN mkdir -p /app/data && chown -R appuser:appgroup /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY --chown=appuser:appgroup main.py .

# Switch to non-root user
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import slack_sdk; print('OK')" || exit 1

# Run the application
CMD ["python", "-u", "main.py"]
