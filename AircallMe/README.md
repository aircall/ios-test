# AircallMe  : my test app for Aircall
## Introduction

This app is produced as part of a technical test for the Aircall company

## Prerequisites
- Xcode 12.4
- swiftlint (not mandatory to compil)

... nothing else 😁

## Features of the app:
- The application presents **all the use cases requested** by the test (display of the filtered item list, display of the detail of an item, possibility of archiving an item in the list screen (by swipe) and in the detail screen (by a button))
- **Dark Mode** compatibility
- Use of **Dynamic Type** for accessibilty purpose
- Several **unit test and 2 UI tests**
- **Localized string**

## Features not implemented in the app 😭
- **Offline support**
- **Voice Over support**
- iPad display compatibility
- UI/UX additions such as specific empty list screen, actions indications, refresh control ...
- Try to implement `UITableViewDiffableDataSource` ?

So I think that this app is 70% completed, it would take me between one and two whole days to do everything maybe (diffable data source and voice over are challenges)

## Architecture
This app uses the following principles:
- **MVVM-C** : Model View ViewModel architecture with Coordinator pattern -> allows to have a better division of responsibilities between the application layers
- **Dependency Injection** (with Swinject library) -> good level of implementation abstraction and useful for unit testing
- **Modules** / framework -> The app is divided into functional module, each module has its specific unit tests and can be easily reused in an extension or another app

## Third party libraries (Swift Package Manager integration)
- `Swinject` : Very good helper for dependency injection 🚀
- `R.Swift`: Usefull for resources access, even more when resources can be present in different modules

I also use swiflint during the build phase but the tool is not included in the app configuration (by cocoapods for example).

## Unit Testing
Almost all cases are covered by unit test.✔️

## UI Testing
Two UI test cases : a case that demontrate all usage cases of the app and one case with network popup error

UI test can be improved by using specific identifiers on UI components.🤫

## Difficult part of the challenge ?
The hard part of the challenge was trying to have the most efficient breaking down into modules possible to demonstrate the huge value of having modules.

## Regrets 😞
I am currently using a project build tool named tuist.io, this test app could have shown you the value of this tool. I was afraid to take too long with the tool at the beginning.