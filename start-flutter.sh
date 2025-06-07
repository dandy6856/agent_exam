#!/bin/bash

echo "📱 Starting Flutter Items App..."
cd /Users/dantepsing/Documents/agent_exam/flutter_items_app

# Clean and get dependencies
echo "Cleaning Flutter project..."
flutter clean

echo "Getting dependencies..."
flutter pub get

if [ $? -eq 0 ]; then
    echo "✅ Dependencies ready!"
    echo "🚀 Starting Flutter app on macOS..."
    
    # Run the Flutter app
    flutter run -d macos
else
    echo "❌ Failed to get dependencies!"
    exit 1
fi
