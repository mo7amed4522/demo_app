#!/bin/bash

# demo_app - iOS TestFlight Build Script
# This script automates the iOS build process for TestFlight deployment

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  demo_app - iOS Build Script${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}Error: pubspec.yaml not found!${NC}"
    echo "Please run this script from the project root directory."
    exit 1
fi

# Function to display menu
show_menu() {
    echo "Select build environment:"
    echo "1) Development (dev)"
    echo "2) Staging (staging) - Recommended for TestFlight"
    echo "3) Production (prod)"
    echo "4) Exit"
    echo -n "Enter choice [1-4]: "
}

# Read user choice
show_menu
read choice

ENV=""
case $choice in
    1)
        ENV="dev"
        echo -e "${YELLOW}Building for DEVELOPMENT environment${NC}"
        ;;
    2)
        ENV="staging"
        echo -e "${YELLOW}Building for STAGING environment${NC}"
        ;;
    3)
        ENV="prod"
        echo -e "${YELLOW}Building for PRODUCTION environment${NC}"
        ;;
    4)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid choice. Exiting.${NC}"
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
echo -e "${GREEN}Step 3: Preparing iOS build environment...${NC}"
cd ios
# Swift Package Manager is now used for iOS plugin and engine integration.
cd ..

echo ""
echo -e "${GREEN}Step 4: Building iOS archive...${NC}"

# Get version from pubspec.yaml
VERSION=$(grep '^version:' pubspec.yaml | sed 's/version: //' | sed 's/+.*//')
BUILD_NUMBER=$(date +%Y%m%d%H%M)

echo -e "${YELLOW}Version: ${VERSION}${NC}"
echo -e "${YELLOW}Build Number: ${BUILD_NUMBER}${NC}"
echo ""

# Build options
echo "Select build method:"
echo "1) Build IPA (flutter build ipa) - Requires code signing"
echo "2) Build Archive Only (flutter build ios --release) - No code signing required"
echo -n "Enter choice [1-2]: "
read build_choice

case $build_choice in
    1)
        echo -e "${YELLOW}Building IPA with automatic code signing...${NC}"
        flutter build ipa \
          --release \
          --dart-define=ENV=$ENV \
          --build-name=$VERSION \
          --build-number=$BUILD_NUMBER
        ;;
    2)
        echo -e "${YELLOW}Building iOS archive without code signing...${NC}"
        flutter build ios \
          --release \
          --dart-define=ENV=$ENV \
          --build-name=$VERSION \
          --build-number=$BUILD_NUMBER \
          --no-codesign
        ;;
    *)
        echo -e "${RED}Invalid choice. Using default (Archive Only).${NC}"
        flutter build ios \
          --release \
          --dart-define=ENV=$ENV \
          --build-name=$VERSION \
          --build-number=$BUILD_NUMBER \
          --no-codesign
        ;;
esac

echo ""
if [ $? -eq 0 ]; then
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  Build Successful! ✓${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    
    if [ "$build_choice" = "1" ]; then
        echo -e "${GREEN}IPA Location:${NC} build/ios/ipa/Runner.ipa"
    else
        echo -e "${GREEN}Archive Location:${NC} build/ios/iphoneos/Runner.app"
    fi
    
    echo -e "${GREEN}Environment:${NC} $ENV"
    echo -e "${GREEN}Version:${NC} $VERSION"
    echo -e "${GREEN}Build Number:${NC} $BUILD_NUMBER"
    echo ""
    echo "Next steps:"
    
    if [ "$build_choice" = "1" ]; then
        echo "1. Open Xcode Organizer: open -a Xcode"
        echo "2. Go to Window → Organizer"
        echo "3. Select your archive and click 'Distribute App'"
        echo "4. Upload to TestFlight"
    else
        echo "1. Open Xcode: open ios/Runner.xcworkspace"
        echo "2. Select 'Any iOS Device' as the target"
        echo "3. Go to Product → Archive"
        echo "4. Sign the archive in Xcode Organizer"
        echo "5. Upload to TestFlight"
    fi
    echo ""
else
    echo -e "${RED}========================================${NC}"
    echo -e "${RED}  Build Failed! ✗${NC}"
    echo -e "${RED}========================================${NC}"
    echo ""
    echo "Common Solutions:"
    echo "1. If you see provisioning profile errors:"
    echo "   - Choose option 2 (Build Archive Only)"
    echo "   - Sign manually in Xcode"
    echo ""
    echo "2. Connect a physical iOS device and register it at:"
    echo "   https://developer.apple.com/account/resources/devices"
    echo ""
    echo "3. Open Xcode and configure signing:"
    echo "   open ios/Runner.xcworkspace"
    echo ""
    exit 1
fi
