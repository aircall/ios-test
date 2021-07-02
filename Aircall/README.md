# TestAircall

Hi guys !
Thanks for reviewing my test

Here is some information about my code. If you have any question feel free to contact me at [garcia.delphine@gmail.com](mailto:garcia.delphine@gmail.com)

I hope to hear from you soon :)

## Technical stack

- iOS 13+
- MVVM-Coordinator
- UIKit: no storyboard, autoLayout (with Dynamic Font)
- No third-party libraries (This is a deliberate choice. I avoid using third-party library as much as possible)
- Unit tests coverage: 74.2 %

### Focus

- MVVM-C. No reactive programming here. I think Combine really makes sense with SwiftUI (and I'd love to use it)
- Coordinator to manage the navigation
- Model:
  - 3 layers : Network / Business / UI
  - A repository to retrieve the data from a provider and provide a consistent model 
- ViewModel: shared (in Coordinator) between list and details views. I made this choice because in this particular case the details is just a subset of the list.
- View: split into ViewController, View, TableViewProvider, etc. to avoid massive ViewController
- Use of dependency injection and Protocols to facilitate testing
- Design System: 
  - Reusable components
  - Colors (Dark mode)
  - Images (SFSymbols)
- Localizable.string (for i18n)

### Network layer

- In a separate framework to structure the project
- Based on URLSession
- Unit tests coverage: 80.5 %

## App

### List View

- Shimmering for loading
- Pull down to refresh => calls reset API to facilitate the test (only if there is at least one call because this is a pull-down...)
- "Error" view if needed (no internet connection for instance)
- "No data" view when all the calls has been archived.
- Swipe left from a cell to archive a call 

### Details View

- Right button in the NavigationBar to archive the call (alertView in case of error)
- Error view (should not happen because the model is shared but just to be exhaustive)
- As the API [https://aircall-job.herokuapp.com/activities/id](https://aircall-job.herokuapp.com/activities/:id:) doesn't return any additionnal information other than the list, I chose not to call it. 

## Conclusion

### With more time

- UITests
- Use Combine. Even better with SwiftUI but i was not comfortable enough for the test.
- A local mechanism to archive calls when offline (with server synchonization in background)
- A nice animation to reload the cells when archive by swiping left in the TableView
- A better error and loading management (Reachability, better UI, ...)
- Accessibility
- ...

### Challenges

- I spent time on the architecture and splitting of my code. I tried to do some clean stuff here.
- I tried to do some clean UI too (reusable components, animations, design system, icon, launch screen, dynamic font, ...)
- For a better user experience i think archive action should not depend on the API response but this implies a much greater complexity. I don't have enough time to process this and to be honest the web service responds quickly enough ;)
