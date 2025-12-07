#!/bin/sh
if [ ! -f /app/pb_data/data.db ]; then
    echo "Initializing database..."
    /app/pocketbase import /app/pb_schema.json --dir /app/pb_data
fi
/app/pocketbase serve --http=0.0.0.0:8080 --dir /app/pb_data
