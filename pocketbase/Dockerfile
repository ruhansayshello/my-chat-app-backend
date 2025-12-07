FROM alpine:latest

# Install dependencies
RUN apk add --no-cache ca-certificates wget

# Set working directory
WORKDIR /app

# Download PocketBase directly (Linux version for Docker)
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.22.0/pocketbase_0.22.0_linux_amd64.zip \
    && unzip pocketbase_0.22.0_linux_amd64.zip \
    && rm pocketbase_0.22.0_linux_amd64.zip \
    && chmod +x /app/pocketbase

# Copy your schema file
COPY pb_schema.json /app/pb_schema.json

# Copy start script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Create data directory
RUN mkdir -p /app/pb_data

# Expose port
EXPOSE 8080

# Start command
CMD ["/app/start.sh"]