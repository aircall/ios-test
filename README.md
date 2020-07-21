## Prerequisite

- Cocoapods (pods are committed so no need to install it if you don't)
- Xcode 11 (iOS 13)

## Completion

Completion: ~80%. Remaing part would be handling archiving when dealing with cache. Most challening part was caching: it is tedious to do something not too complicated (also see Known Bugs).

## Improvements

- Write a lot more tests (especially on Data layer)
- Handle loading/failing cases in UI
- Handling archiving while using cache
- Dependency injection (here dependencies are hardcoded using default argument values)
- DTO models for Data layer
- Better design 🤷

### Known Bugs

- When deactiving/activing internet and archiving call, call is still visible in list (mostly Reachability considering device is still offline).

## Libraries

Project rely on very few libraries:
- `Reusable`; `SwiftGen` for compile checking on resources (less crashes because of mispelling/renaming)
- `Cache`; `ReachabilitySwift` for cache
- `Combine` for Rx programming. Not familiar with it yet so be please be lenient :D

## Architecture
Architecture relies on:
- 3-tier layer (presentation, business, data)
- MVVM
- Domain driven design

### Domain

Domain contain our app models and also api to access/get domain data (`Repository` protocols). Model is domain oriented so it should have high readability.

### Presentation
Presentation is contained into `UIViewController`/`UIView` classes.

Small "reusable" views content are made inside `*Component` classes which allow to reuse same view logic across app. Obviously in SwiftUI those would just be custom View but in UIKit refactoring hierarchy is hard and it avoid UIKit subclassing issue (making a UILabel subclass is not ideal, but wrapping it inside a view to hide it is heavy).

Formatting/converting is done using Converter classes. This allow to easily test formatting with unit test while reusing same code across the app (which make formatting uniform around the whole app).

### Business

Business logic is handled by `ViewModel`. ViewModel will handle "logic" rules (what can be done or not in the app)

Data is pulled from `Repository` classes which are providing a domain Api.

### Data

`DataSource` classes handle retrieving/storing data from Rest api or cache. Here Cache is a superset of AircallRestDataSource allowing us to use it transparently inside our application.

There is no DTO in this project as domain/data models were quite similar. It would be however nicer to have DTO for Data layer although it add a lot of complexity.

## Testing
Testing are written using Gherkin syntax (Given-When-Then). As such tests try to describe expected behaviour and are a documentation about how the code should behave.
