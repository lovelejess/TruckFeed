#!/bin/bash --login -e
cd TruckFeed 
pod install
xcodebuild -workspace TruckFeed.xcworkspace -scheme TruckFeed -sdk iphonesimulator 
xcodebuild -workspace TruckFeed.xcworkspace -scheme TruckFeedTests -sdk iphonesimulator 
cd - 
