# Aircall - iOS Technical test

## Write a brief outline of the architecture of your app

I used a MVVM approach, it allows to divide the application very easily between **Model** and  **View**.

In the MVVM design pattern, **Model** is the same as in MVC pattern, it represents simple data.
**View** is represented by the UIView or UIViewController objects, accompanied with their .xib and .storyboard files, which should only display prepared data.
**ViewModel** hides all asynchronous networking code, data preparation code for visual presentation, and code listening for Model changes.

Since **ViewModel** is pure `NSObject` or `struct` and is not coupled with the UIKit code, it can be tested more easily in unit tests without affecting the UI code.

## Explain why you decided to use each third party libraries.

I didn't use any libraries because I feel have more control on what I'm doing and everything that was requested in the task was possible to do without any additional libraries. 

## What was the most difficult part of the challenge?

I didn't face any technical difficulty so I took the time to work on the design part. It was important for me to demonstrate my skills in UI in addition to those in architecture and code quality.

## Estimate your percentage of completion and how much time you would need to finish

I believe that ~ 80% of the work is done and I think I would need 4 hours to finish it completely.

Here are the elements that might be useful to add:
- Use a new uitableview diffable data source
- Handle network error (UI friendly)
- UI Tests
- Accessibility (Dynamic type)
