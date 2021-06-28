# Feedback

## Architecture

### Networking
This is a very basic yet thoughtfully tailored networking stack. It takes the rodeo-assumption that all requests' responses will be coming from the same source, and therefore be formatted homogeneously. It uses the power of abstraction combined with the `Codable` protocol to ease the parsing of each requests. 

Each request must comply `Requestable`, that eases the creation of each new request, and simplyfies the readability of the network layer. 

Each request's output must comply to `OutputDecodable` protocol that assumes homogenity of the API.

There's a very basic default retry strategy in case a request fails for some reason.

### Models
Models tailored to the API's output. Nothing more.

### Views
Everything that is UI related: storyboards, view controllers and cells. Nothing more.

### View Models
View models (supposedly) tied to each and individual view controllers. It has been identified as kind of "*over-engineered*" to split the existing view model into 2 separate view models. Indeed, the need of having a way to archive the same object from 2 different contexts led into "simplifying" and keeping a common view model, that shares privately the `rawData` of entities. 

We could have however split, by creating a common protocol for shared attributes, and dedicated protocols to expose only the needed methods through dependency inversion.

### Presenters
Presenters tied to each and individual view controllers. They consist of routing the app to its new state. They "present" a new state (therefore the naive naming).

## Third parties
*I did not use any third party for this app.*

I strongly think that including a third party should always be deeply thought by the whole team. It happened way too often that an app got broken because of a third party. However, there are some very great and stable third parties that one can blindly use (i.e Alamofire, Kingfisher...), but I didn't think it was needed for such a simple app.

## Challenges
- One interesting challenge was to create a single view model, shared accross 2 view controllers, without breaking too much the **S**OLID principles. Indeed, sharing a single view model that serves 2 different view controllers might look kind of hacky, but in fact simplifies greatly the understanding and the codebase. I consider it is an important part of our job to know when to "break" the rules.
- One other challenge I faced was the UI architecture. I initially thought that this app would be perfect if based on a `UISplitViewController`. I did everything as so, including neat UI details, with the default Xcode settings. Once I got back to the specs, I realised the app needed to be supported on iOS 13+, thus I changed the settings accordingly. Some parts of the code got broken and I had to use @available because I initially used iOS 14 `UISplitViewController`'s API. I already invested a lot of time in re-discovering the split view controller, I thought it would have cost me too much to support all those differences. For the sake of efficiency, I decided to migrate to a basic boring `UINavigationController`.
- One last challenge was that `GET /activities` request does not return a json object, but an array of objects instead. It took me a while to come up with this formulation
```
typealias ActivityListOutput = [Activity]
extension ActivityListOutput: OutputDecodable {}
```

## What's next?
- The UI could be greatly improved.
- Dynamic font type is not supported, it could be.
- Cells are pretty much all the same, they could be homogeneised into a single `HStack(ImageView | VStack(Label | Label))` with hidden / visible outlets.
- Noticed that the usage of `GET /activities/:id` was returning the same content as in `GET /activities/`. Therefore if the content was richer, no big deal since we share a common view model. It would simply be adding a request at detail level, that is fired only if the content does not exist, and that updates the common view model afterwards.
- At detail level, the view pops if the archive button is tapped. This is clearly not needed and is a personal choice. It could have just been an icon update.
- UI test automation hasn't been done at all. The way the project is architectured, injecting a mocked view model to the view controllers would lead in a very simple implementation of the UI tests. We would need to add accessibility labels to all UI elements, and then update the state of the view model to check the UI is properly displayed. Definitely not scary, impossible nor complex.

## Estimated completion and time
- UI
	- More complex design - Far from being finalized, and it's impossible to estimated the remaining work without an mockup of the desired layout ;
	- Homogeneous cells - 2h ;
	- Different archive behaviour on detail view - 30 min ;
- Dynamic font type - With custom fonts, 1h ; with system fonts, 15min
- If the content of `GET /activities/:id` was richer than `GET /activities/` - 3h
- UI tests - 2h

**I estimate the completion to be near 75%, and the time needed to finish a bit lower than 1d**