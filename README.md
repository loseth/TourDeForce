<p align="center">
    <img src="https://www.infovital.no/tourdeforce/logo.png" alt="TourDeForce logo" width="614" maxHeight="171" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/iOS-14.0+-blue.svg" />
    <img src="https://img.shields.io/badge/Swift-5.0-brightgreen.svg" />
    <a href="https://twitter.com/loseth">
        <img src="https://img.shields.io/badge/Contact-@loseth-lightgrey.svg?style=flat" alt="Twitter: @loseth" />
    </a>
</p>

**TourDeForce** is a portfolio to-do list app.
It uses [Gamification](https://en.wikipedia.org/wiki/Gamification) through awards, to make completion of projects and their items more compelling. 

<br>

<p align="center">
    <img src="https://www.infovital.no/tourdeforce/promo.png" alt="TourDeForce logo" width="800" maxHeight="171" />
</p>

## Authors and acknowledgment
The app is based on the **Ultimate Portfolio App** course from [Paul Hudson (@twostraws)](https://twitter.com/twostraws) at [Hacking with Swift](https://www.hackingwithswift.com/).  
I would like to thank Paul for not only guiding me through his part of the code, but also for the amazing contributions (in both scope an clarity) that he has made to the Swift community.

All other code is written by the maintainer of this repository, [Tor Rafsol Løseth (@loseth) / Twitter](https://twitter.com/loseth).

## Project status
Not ready for deployment. More to do:

- Multiplatform (iOS, macOS, watchOS)
- New visual design, including awards symbols
- Make awards more valuable
- Documentation and testing
- Localization (French, German and Norwegian at least)

## Knowledge applied

### Technologies

- iOS (macOS and watchOS will follow)
- Swift and SwiftUI

### Tools

- **Integrated development environment** with [Xcode](https://developer.apple.com/xcode/)
- **Markdown viewing** with [Marked](https://marked2app.com/)
- **Project documentation** with [Jazzy](https://github.com/realm/jazzy)
- **Screenshots** with [ControlRoom](https://github.com/twostraws/ControlRoom)
- **Swift style** with [SwiftLint](https://github.com/realm/SwiftLint)
- **Text processing** with [BBEdit](https://www.barebones.com/products/bbedit/)
- **Version control** with [Git](https://git-scm.com/)

### Concepts

- **Accessibility** with [VoiceOver](https://www.apple.com/accessibility/vision/).
- **Architecture navigation** with TabView and NavigationView/NavigationLink.
- **Archiving objects** with [Codable](https://developer.apple.com/documentation/swift/codable) and [JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder)
- **Filter and sort objects** with NSCompundPredicate, NSPredicate, NSSortDescriptor.
- **Localization** (English and Hungarian so far) with LocalizedStringKey.
- **Persistent storage** with [Core Data](https://developer.apple.com/documentation/coredata)
- **SwiftUI data flow and state** with [@Environment, @EnvironmentObject, @Fetchrequest, @ObservedObject, @SceneStorage, @State, @StateObject, and ObservableObject.](https://developer.apple.com/documentation/swiftui/state-and-data-flow)
- **Unit testing** with [XCTest](https://developer.apple.com/documentation/xctest).

## Contributing
Currently not open for contributions.

## License
[MIT](https://choosealicense.com/licenses/mit/)

<!--
- **App Architecture**
    - Launching
    - Onboarding
    - Loading
    - Modality
        - Fullscreen
        - Sheet
    - Navigation
        - Content/Experience-Driven
        - Flat
        - Hierarchical
    - Requesting Permission
    - Settings
- **User Interaction**
    - 3D Touch
    - Apple Pencil and Scribble
    - Audio
    - Authentication
    - Data Entry
    - Drag and Drop
    - Feedback
    - File Handling
    - Game Controllers
    - Gestures
    - Haptics
    - Near Field Communication
    - Pointers (iPadOS)
    - Undo and Redo
- **System Capabilities**
    - Augmented Reality
    - Home Screen Actions
    - Multitasking
    - Multiple Windows
    - Notifications
    - Printing
    - Quick Look
    - Ratings and Reviews
    - Screenshots
    - TV Providers
    - Widgets
- **Visual Design**
    - Adaptivity and Layout
    - Animation
    - Branding
    - Color
    - Dark Mode
    - Launch Screen
    - Materials
    - Terminology
    - Typography
    - Video
- **Icons and Images**
    - Image Size and Resolution
    - App Icon
    - Custom Icons
    - System Icons
- **Bars**
    - Navigation
    - Search
    - Sidebar
    - Status
    - Tab
    - Toolbar
- **Views**
    - Action
    - Activity/Share
    - Alert
    - Collection
    - Image
    - Page
    - Popover
    - Scroll
    - Split
    - Table
    - Text
    - Web
- **Controls**
    - Button
    - Color Well
    - Context Menu
    - Edit Menu
    - Label
    - Page
    - Picker
    - Progress Indicator
    - Pull-Down Menu
    - Refresh Content
    - Segmented
    - Slider
    - Stepper
    - Switch
    - Text Field
- **Application Navigation**
    - SwiftUI
        - NavigationView :white_check_mark:
        - TabView :white_check_mark:
- Design Patterns
-->