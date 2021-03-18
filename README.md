# Aircall - iOS Technical test

## Write a brief outline of the architecture of your app

I used a MVVM approach, it's allow to divide the application very easily between **Model** and the **View**.

In the MVVM design pattern, **Model** is the same as in MVC pattern, it represents simple data.
**View** is represented by the UIView or UIViewController objects, accompanied with their .xib and .storyboard files, which should only display prepared data.
**ViewModel** hides all asynchronous networking code, data preparation code for visual presentation, and code listening for Model changes.

Since **ViewModel** is pure `NSObject` or `struct`, and it’s not coupled with the UIKit code, it can be test it more easily in unit tests without affecting the UI code.

## Explain why you decided to use each third party libraries.

I didn't used any libraries, the reasons is in my current & past company it was forbidden to use external libraries and I feel have more control.

## What was the most difficult part of the challenge?

From a technical perspective I didn't face any difficulty in this test but in the the other side I spent too much time on the design part. I know for the design part I shouldn't be paying attention but for me it's important to demostrate my skill on the design side too, not only on architecture & quality of code.

## Estimate your percentage of completion and how much time you would need to finish

I believe about 75 ~ 80% of work is done and to finish completely I think I need 4 hours .

Here is the followings things must be nice to have :
- Use new uitableview diffable data source
- Handle network error (UI friendly)
- UI Tests
