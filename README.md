# Project Task

A new Flutter an application where a user can track their working hours only within the 10
meter radius from the project site.

## Flutter & Dart version

- Flutter 3.3.9 • channel stable
- Dart 2.18.5 • DevTools 2.15.0

## Package used

[geolocator](https://pub.dev/packages/geolocator) Flutter geolocation plugin which provides easy access to platform specific location services.

- Get the current location of the device
- Get continuous location updates
- Calculate the distance (in meters) between two geocoordinates

## Setup

- Go to lib/utils/app_utils.dart and set you current latitude and longitude (projectLat & projectLong).
- Make sure your current location is on during app testing.

## Gif

<img src="https://github.com/Gursewak-Uppal/Track-Working-Hours/blob/main/gif/Record_2022-11-29-15-47-48.gif?raw=true"  height="420" /> 

## Getting Started
  - If you don't have Flutter SDK installed, please visit official [Flutter](https://flutter.dev/) site.
  - Fetch latest source code from master branch.
 
 ```
 git clone https://github.com/Gursewak-Uppal/Track-Working-Hours.git
 ```  
 - Run the app with Android Studio or Visual Studio. Or the command line.
 
 ```
 flutter pub get
 ```
 ```
 flutter run
 ```
