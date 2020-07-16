#!/bin/sh

#Create iPhone archive
xcodebuild \
-workspace Covid19_Internal/Covid19_Internal.xcworkspace \
-scheme Covid19_Internal \
-archivePath "Covid19_Internal/Covid19_Internal.xcarchive" \
PROVISIONING_PROFILE="4c50c90d-d88a-484f-8f23-470d2d8fd524" \
ENABLE_BITCODE=NO \
archive 

# Export the archive to an ipa
xcodebuild \
-exportArchive \
-archivePath "Covid19_Internal/Covid19_Internal.xcarchive" \
-exportOptionsPlist "exportOptions.plist" \
-exportPath "." \
ENABLE_BITCODE=NO

#Change the app name
mv ./Covid19_Internal.ipa ./$APP_NAME.ipa
