#!/bin/bash

echo "🚀 Starting Items API Server..."
cd /Users/dantepsing/Documents/agent_exam/ItemsApi

# Build the project first
echo "Building project..."
dotnet build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "🌐 Starting server on http://localhost:5160"
    
    # Run the API server
    ASPNETCORE_URLS="http://localhost:5160" ASPNETCORE_ENVIRONMENT="Development" dotnet run
else
    echo "❌ Build failed!"
    exit 1
fi
