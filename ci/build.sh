#!/bin/bash --login -e
xctool -project Truckfeed/TruckFeed.xcodeproj -scheme TruckFeed -sdk iphonesimulator 
xctool -project Truckfeed/TruckFeed.xcodeproj -scheme TruckFeedTests -sdk iphonesimulator 