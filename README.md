# WhatsNext – iOS (SwiftUI)

![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-orange)
![iOS](https://img.shields.io/badge/iOS-17-blue)

**WhatsNext** is a SwiftUI iOS app that lets users browse cities, explore famous landmarks, and view upcoming events. It’s **Dark Mode ready** and designed with a clean, modern UI.

---

## Demo

| Home  | Search Bar | No Results | City Details |
|--------------|-------------|-------------|-------------|
| ![Home]("Screenshots/Home Screen.png") | ![Search Bar](Screenshots/Search.png) | ![No Results]("Screenshots/No Results.png") | ![City Details]("Screenshots/City Details.png")

---

##  Features

- **Search** cities by name
- **City detail view** with image
- **Landmarks** displayed in a horizontal scrollable view
- **Events** in a two-column grid layout
- **Dark Mode** support with adaptive system colors

---

## Roadmap

Planned future updates:
- Live events from a public API (Ticketmaster / Eventbrite)
- Location-based sorting (nearest cities first)
- Favorites with persistence (UserDefaults / Core Data)
- MapKit integration for event locations
- Pull-to-refresh & offline caching

---

## Tech Stack

- Swift 5.x, **SwiftUI**, NavigationStack
- Adaptive system colors for Light/Dark mode
- Target: iOS 17+

---

## Getting Started

1. **Clone the repo**
   ```bash
   git clone https://github.com/AllanConstanza/WhatsNext-iOS.git
   cd WhatsNext-iOS
2. **Open in Xcode**

Open WhatsNext - IOS.xcodeproj in Xcode.

3. **Run**

Select an iPhone simulator (iPhone 15 recommended) and press Run.
