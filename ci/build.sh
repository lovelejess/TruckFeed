#!/bin/bash --login -e
xcodebuild -project Truckfeed/TruckFeed.xcodeproj -scheme TruckFeed -sdk iphonesimulator 
xcodebuild -project Truckfeed/TruckFeed.xcodeproj -scheme TruckFeedTests -sdk iphonesimulator 
