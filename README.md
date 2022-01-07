# Chat Central

[![iOS](https://img.shields.io/static/v1?label=iOS&message=15.0&color=000000)](https://www.apple.com/ios/ios-15/)
[![Swift](https://img.shields.io/static/v1?label=Swift&message=5.5&color=F05138)](https://developer.apple.com/swift/)
[![Xcode](https://img.shields.io/static/v1?label=Xcode&message=13.2&color=147EFB)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/static/v1?label=License&message=MIT&color=blue)](LICENCE)

<p> <img src="repository_banner.png" align="center"/> </p>

Chat room messaging app. Build with UIKit, MVC and [Firebase](https://firebase.google.com) as backend.

## Features

- Login and register a new user with email and password.
- Login and register form validation.
- Logout current user.
- Chat messages with sender email and body.
- App name with typing animation.
- Splash screen.
- Light mode.
- Localization (English/Spanish).

## Development

- [UIKit](https://developer.apple.com/documentation/uikit)
- MVC
- [CocoaPods](https://cocoapods.org)
- [Firebase](https://firebase.google.com)
- Development Target **15.0**
- Swift **5.5**
- Xcode **13.2**

### Dependencies

- [SwiftLint](https://cocoapods.org/pods/SwiftLint)
- [CLTypingLabel](https://cocoapods.org/pods/CLTypingLabel)
- [Firebase/Auth](https://cocoapods.org/pods/FirebaseAuth)
- [Firebase/Firestore](https://cocoapods.org/pods/FirebaseFirestore)
- [IQKeyboardManagerSwift](https://cocoapods.org/pods/IQKeyboardManagerSwift)

### Build

1. [Setup](https://firebase.google.com/docs/ios/setup) a new Firebase project and register iOS app.
2. Add `GoogleService-Info.plist` file into the root of Xcode project.
3. Enable email sign-in on Firebase Authentication console.
4. Enable Firestore Database on Firebase console.
5. Run the project!

# License

```xml
MIT License

Copyright (c) 2022 Anibal Ventura
```
