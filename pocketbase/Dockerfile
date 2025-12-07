FROM alpine:latest

# Install dependencies
RUN apk add --no-cache ca-certificates wget unzip

# Set working directory
WORKDIR /app

# Download PocketBase
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.22.0/pocketbase_0.22.0_linux_amd64.zip \
    && unzip pocketbase_0.22.0_linux_amd64.zip \
    && rm pocketbase_0.22.0_linux_amd64.zip \
    && chmod +x /app/pocketbase

# Copy configuration files
COPY pb_schema.json /app/pb_schema.json

# Create start.sh directly in Dockerfile (instead of copying)
RUN echo '#!/bin/sh' > /app/start.sh && \
    echo 'if [ ! -f /app/pb_data/data.db ]; then' >> /app/start.sh && \
    echo '    echo "Initializing database..."' >> /app/start.sh && \
    echo '    /app/pocketbase import /app/pb_schema.json --dir /app/pb_data' >> /app/start.sh && \
    echo 'fi' >> /app/start.sh && \
    echo '/app/pocketbase serve --http=0.0.0.0:8080 --dir /app/pb_data' >> /app/start.sh && \
    chmod +x /app/start.sh

# Create data directory
RUN mkdir -p /app/pb_data

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/api/health || exit 1

# Expose port
EXPOSE 8080

# Start command
CMD ["/app/start.sh"]
