# Taxi App

A Flutter-based taxi booking application with interactive map features.

## Prerequisites

- Flutter SDK (version 3.8.1 or higher)
- Dart SDK (version 3.0.0 or higher)
- iOS Simulator or Android Emulator or Android Device

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/your-username/taxi_app.git
cd taxi_app
```
2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```


## Features
- Interactive map interface
- Start and destination point selection
- Distance calculation between points
- Route visualization
- Current location detection
- Responsive design for all screen sizes
- Persian language support


## Dependencies
### Map & Location
- flutter_map : ^8.2.1

  - Interactive map implementation
  - Marker and route visualization
- latlong2 : ^0.9.0
  
  - Geographical coordinate handling
- geolocator : ^10.1.0
  
  - User location detection
  - Location permission handling
  - GPS status management
### UI & Responsiveness
- flutter_screenutil : ^5.9.3
  - Responsive design implementation
### Localization
- flutter_localizations
  - Persian language support
  - RTL layout handling

## Project Structure
```plaintext
lib/
├── core/
│   ├── app_colors.dart         # Color constants
│   └── app_dimensions.dart     # Responsive dimensions
├── pages/
│   └── map/
│       ├── widgets/            # Map-specific widgets
│       └── map_page.dart       # Main map screen
├── utility/
│   └── location_utility.dart   # Location services
├── widgets/
│   ├── custom_bottom_sheet.dart  # Reusable bottom sheet
    └── custom_contained_button.dart  # Reusable button
└── main.dart                   
