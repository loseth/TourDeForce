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
    (Temporary design)
</p>

## Authors and acknowledgment
The app is based on the **Ultimate Portfolio App** course from [Paul Hudson (@twostraws)](https://twitter.com/twostraws) at [Hacking with Swift](https://www.hackingwithswift.com/).  
I would like to thank Paul for not only guiding us through his part of the code, but also for the amazing contributions (in both scope an clarity) that he has made to the Swift community.

All other code is written by the maintainer of this repository, [Tor Rafsol Løseth (@loseth)](https://twitter.com/loseth).

## Project status
Not ready for deployment. More to do:

- Documentation and testing
- Localization (English and Hungarian done, add French, German and Norwegian + ?)
- Multiplatform (iOS, iPadOS, macOS, watchOS)
- New visual design, including awards symbols
	- Make awards more valuable
- Settle on business model, if any	

## Knowledge applied

### Technologies

- **Frameworks**
	- [Core Data](https://developer.apple.com/documentation/coredata)
	- [Foundation](https://developer.apple.com/documentation/foundation)
	- [Swift](https://developer.apple.com/documentation/swift/)
	- [SwiftUI](https://developer.apple.com/documentation/swiftui)
- **Operating Systems**
	- [iOS](https://developer.apple.com/ios/)
	- [iPadOS](https://developer.apple.com/ipados/)
	- [macOS](https://developer.apple.com/macos/)
	- [watchOS](https://developer.apple.com/watchos/)

### Concepts

- **Accessibility** with [VoiceOver](https://www.apple.com/accessibility/vision/).
- **Architecture navigation** with [TabView and NavigationView/NavigationLink](https://developer.apple.com/documentation/swiftui/view-layout-and-presentation).
- **Architecture patterns**
	- **MVC** [:link:](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)
	- **MVVM** [:link:](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel)
- **Archiving objects** with [Codable](https://developer.apple.com/documentation/swift/codable) and [JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder)
- **Dependency Injection (Initializer-based)** [Wikipedia](https://en.wikipedia.org/wiki/Dependency_injection)  
- **Filter and sort objects** with [NSCompundPredicate, NSPredicate, NSSortDescriptor](https://developer.apple.com/documentation/foundation/filters_and_sorting).
- **Internationalization (i18n) and Localization (i10n)** with [LocalizedStringKey](https://developer.apple.com/documentation/xcode/localization).
- **Persistent storage** with [Core Data](https://developer.apple.com/documentation/coredata)
- **SwiftUI data flow and state** with [@Environment, @EnvironmentObject, @Fetchrequest, @ObservedObject, @SceneStorage, @State, @StateObject, and ObservableObject.](https://developer.apple.com/documentation/swiftui/state-and-data-flow)
- **Testing**  with [XCTest](https://developer.apple.com/documentation/xctest).
	- **Performance testing** [:link:](https://en.wikipedia.org/wiki/Software_performance_testing)
	- **UI testing** [:link:](https://en.wikipedia.org/wiki/Graphical_user_interface_testing)
	- **Unit testing** [:link:](https://en.wikipedia.org/wiki/Unit_testing)

### Tools

- **Image editing** with [Acorn](https://flyingmeat.com/acorn/)
- **Integrated development environment** with [Xcode](https://developer.apple.com/xcode/)
- **Markdown viewing** with [Marked](https://marked2app.com/)
- **Project documentation** with [Jazzy](https://github.com/realm/jazzy)
- **Screenshots** with [ControlRoom](https://github.com/twostraws/ControlRoom)
- **Swift style** with [SwiftLint](https://github.com/realm/SwiftLint)
- **Text processing** with [BBEdit](https://www.barebones.com/products/bbedit/)
- **Version control** with [Git](https://git-scm.com/)

## Contributing
Currently not open for contributions.

## License
[MIT](https://choosealicense.com/licenses/mit/)

**Please note**:  
The license applies to the code, but it does not extend to the use of the name or the visual design of the app (custom logos, icons and symbols.)  

Foundation, Swift, SwiftUI, the Swift logo, iOS, iPadOS, macOS, watchOS, are trademarks of Apple Inc., registered in the U.S. and other countries - they have their own licenses.
