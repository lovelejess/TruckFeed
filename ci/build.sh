#!/bin/bash --login -e
xcodebuild -workspace Truckfeed/TruckFeed.xcworkspace -scheme TruckFeed -sdk iphonesimulator 
xcodebuild -workspace Truckfeed/TruckFeed.xcworkspace -scheme TruckFeedTests -sdk iphonesimulator 
