#!/bin/bash

# Nestlé Congress - Android Release Build Script
# This script automates the Android build process for release deployment

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Nestlé Congress - Android Build Script${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Resolve and enter the project root so the script works from any directory.
PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_ROOT"

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}Error: pubspec.yaml not found!${NC}"
    echo "Please run this script from the project root directory."
    exit 1
fi

# Setup Java - Force set JAVA_HOME for this session
echo -e "${GREEN}Setting up Java environment...${NC}"

# Always try Android Studio's bundled JDK first (most reliable on macOS)
if [ -d "/Applications/Android Studio.app/Contents/jbr/Contents/Home" ]; then
    export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
    export PATH="$JAVA_HOME/bin:$PATH"
    echo -e "${GREEN}Using Android Studio bundled JDK${NC}"
elif [ -d "/Applications/Android Studio.app/Contents/jre/Contents/Home" ]; then
    export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/Contents/Home"
    export PATH="$JAVA_HOME/bin:$PATH"
    echo -e "${GREEN}Using Android Studio bundled JRE${NC}"
elif [ -d "/opt/homebrew/opt/openjdk@17" ]; then
    export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
    export PATH="$JAVA_HOME/bin:$PATH"
    echo -e "${GREEN}Using Homebrew OpenJDK 17${NC}"
elif [ -d "/usr/local/opt/openjdk@17" ]; then
    export JAVA_HOME="/usr/local/opt/openjdk@17"
    export PATH="$JAVA_HOME/bin:$PATH"
    echo -e "${GREEN}Using Homebrew OpenJDK 17 (Intel)${NC}"
else
    echo -e "${RED}Error: No JDK found!${NC}"
    echo "Please install Java 17 or set JAVA_HOME manually."
    echo ""
    echo "Options:"
    echo "1. Install via Homebrew: brew install openjdk@17"
    echo "2. Download from: https://www.oracle.com/java/technologies/downloads/#java17"
    echo "3. Install Android Studio which includes a bundled JDK"
    exit 1
fi

# Verify Java is working
if ! java -version &>/dev/null; then
    echo -e "${RED}Error: Java is not working properly!${NC}"
    echo "JAVA_HOME is set to: $JAVA_HOME"
    exit 1
fi

echo -e "${GREEN}Java version:${NC}"
java -version 2>&1 | head -1
echo ""

# Function to display menu
show_menu() {
    echo "Select build environment:"
    echo "1) Development (dev)"
    echo "2) Staging (staging)"
    echo "3) Production (prod)"
    echo "4) Exit"
    echo -n "Enter choice [1-4]: "
}

ENV="${1:-}"
if [ -z "$ENV" ] && [ -t 0 ]; then
    show_menu
    read -r choice
    case "$choice" in
        1) ENV="dev" ;;
        2) ENV="staging" ;;
        3) ENV="prod" ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice. Exiting.${NC}"
            exit 1
            ;;
    esac
elif [ -z "$ENV" ]; then
    ENV="prod"
fi

case "$ENV" in
    dev)
        echo -e "${YELLOW}Building for DEVELOPMENT environment${NC}"
        ;;
    staging)
        echo -e "${YELLOW}Building for STAGING environment${NC}"
        ;;
    prod)
        echo -e "${YELLOW}Building for PRODUCTION environment${NC}"
        ;;
    *)
        echo -e "${RED}Invalid environment '$ENV'. Use dev, staging, or prod.${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}Step 1: Cleaning previous builds...${NC}"
flutter clean

echo ""
echo -e "${GREEN}Step 2: Getting Flutter dependencies...${NC}"
flutter pub get

echo ""
echo -e "${GREEN}Step 3: Building Android app...${NC}"

# Get version from pubspec.yaml
VERSION=$(grep '^version:' pubspec.yaml | sed 's/version: //' | sed 's/+.*//')
# Build number must be < 2,100,000,000 (Android limit)
# Use Julian day + hour/minute: 1-366 + HHMM
# Example: Day 57 at 15:40 = 0571540 = 571,540 (well under limit)
JULIAN_DAY=$(date +%j)
HOUR_MIN=$(date +%H%M)
BUILD_NUMBER="${JULIAN_DAY}${HOUR_MIN}"

echo -e "${YELLOW}Version: ${VERSION}${NC}"
echo -e "${YELLOW}Build Number: ${BUILD_NUMBER}${NC}"
echo ""

# Build options - Default to AAB
echo "Select build method:"
echo "1) Build App Bundle (AAB) [Default]"
echo "2) Build APK (Universal)"
echo "3) Build APK (Split per ABI)"
build_choice="${2:-}"
if [ -z "$build_choice" ] && [ -t 0 ]; then
    echo -n "Enter choice [1-3] (press Enter for AAB): "
    read -r build_choice
fi

# Default to AAB if no input
if [ -z "$build_choice" ]; then
    build_choice=1
    echo -e "${YELLOW}Using default: App Bundle (AAB)${NC}"
fi

case $build_choice in
    1)
        echo -e "${YELLOW}Building App Bundle (AAB)...${NC}"
        echo -e "${YELLOW}Target: $ENV environment${NC}"
        echo ""
        
        # Build AAB with Play Store optimizations.
        if flutter build appbundle \
          --release \
          --dart-define=ENV=$ENV \
          --build-name=$VERSION \
          --build-number=$BUILD_NUMBER \
          --target-platform android-arm,android-arm64,android-x64; then
            BUILD_STATUS=0
        else
            BUILD_STATUS=$?
        fi
        echo ""
        if [ $BUILD_STATUS -eq 0 ]; then
            AAB_PATH="build/app/outputs/bundle/release/app-release.aab"
            
            echo -e "${GREEN}========================================${NC}"
            echo -e "${GREEN}  Build Successful! ✓${NC}"
            echo -e "${GREEN}========================================${NC}"
            echo ""
            echo -e "${GREEN}AAB Location:${NC} $AAB_PATH"
            
            # Show file size
            if [ -f "$AAB_PATH" ]; then
                AAB_SIZE=$(ls -lh "$AAB_PATH" | awk '{ print $5 }')
                echo -e "${GREEN}File Size:${NC} $AAB_SIZE"
            fi
            
            echo -e "${GREEN}Environment:${NC} $ENV"
            echo -e "${GREEN}Version:${NC} $VERSION"
            echo -e "${GREEN}Build Number:${NC} $BUILD_NUMBER"
            echo ""
            echo -e "${YELLOW}Signing note:${NC} Android release builds currently use the debug signing config."
            echo "Configure a production release keystore in android/app/build.gradle.kts before publishing."
            echo ""
            echo -e "${YELLOW}Or open the folder:${NC}"
            echo "   open build/app/outputs/bundle/release/"
        else
            echo -e "${RED}========================================${NC}"
            echo -e "${RED}  Build Failed! ✗${NC}"
            echo -e "${RED}========================================${NC}"
            echo ""
            echo "Check the Flutter and Java setup, then try: cd android && ./gradlew clean"
            exit 1
        fi
        ;;
    2)
        echo -e "${YELLOW}Building Universal APK...${NC}"
        if flutter build apk \
          --release \
          --dart-define=ENV=$ENV \
          --build-name=$VERSION \
          --build-number=$BUILD_NUMBER; then
            BUILD_STATUS=0
        else
            BUILD_STATUS=$?
        fi

        echo ""
        if [ $BUILD_STATUS -eq 0 ]; then
            echo -e "${GREEN}========================================${NC}"
            echo -e "${GREEN}  Build Successful! ✓${NC}"
            echo -e "${GREEN}========================================${NC}"
            echo ""
            echo -e "${GREEN}APK Location:${NC} build/app/outputs/flutter-apk/app-release.apk"
            echo -e "${GREEN}Environment:${NC} $ENV"
            echo -e "${GREEN}Version:${NC} $VERSION"
            echo -e "${GREEN}Build Number:${NC} $BUILD_NUMBER"
            echo ""
            echo "Next steps:"
            echo "1. Install on device: flutter install"
            echo "2. Or use: adb install build/app/outputs/flutter-apk/app-release.apk"
        else
            echo -e "${RED}Build Failed! ✗${NC}"
            exit 1
        fi
        ;;
    3)
        echo -e "${YELLOW}Building Split APKs per ABI...${NC}"
        if flutter build apk \
          --release \
          --split-per-abi \
          --dart-define=ENV=$ENV \
          --build-name=$VERSION \
          --build-number=$BUILD_NUMBER; then
            BUILD_STATUS=0
        else
            BUILD_STATUS=$?
        fi

        echo ""
        if [ $BUILD_STATUS -eq 0 ]; then
            echo -e "${GREEN}========================================${NC}"
            echo -e "${GREEN}  Build Successful! ✓${NC}"
            echo -e "${GREEN}========================================${NC}"
            echo ""
            echo -e "${GREEN}APKs Location:${NC} build/app/outputs/flutter-apk/"
            echo -e "${GREEN}Environment:${NC} $ENV"
            echo -e "${GREEN}Version:${NC} $VERSION"
            echo -e "${GREEN}Build Number:${NC} $BUILD_NUMBER"
            echo ""
            echo "Generated APKs:"
            ls -lh build/app/outputs/flutter-apk/*.apk 2>/dev/null || echo "Check build/app/outputs/flutter-apk/ directory"
        else
            echo -e "${RED}Build Failed! ✗${NC}"
            exit 1
        fi
        ;;
    *)
        echo -e "${RED}Invalid choice. Exiting.${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}Build completed successfully!${NC}"
