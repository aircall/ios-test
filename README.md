
## - Write a brief outline of the architecture of your app.

I decided to challenge myself and to use SwiftUI with a MVVM architecture. I also tried to use Combine for fetching api data, to approach declarative development in swift.

In order to have a better control of the loadable object I created a View that handle different states: loading, idle, failure and loaded (with data and with empty data).
For archiving calls I decided to show a confirmation popup to the user, because it is a good practice in terms of UX.

I also decided to extend my model to implement mock data, for testing purposes and to show previews canvas with SwiftUI.

## Explain why you decided to use each third party libraries.
I did not use third party libraries because for this project I did not think it was necessary, moreover I try to avoid third party librairies when possible.

## What was the most difficult part of the challenge ?

To be honest it was a really challenging project because I decided to use SwiftUI, which was almost new to me. I took this decision for several reasons: I know that at Aircall you are using SwiftUI, and I wanted to prove to myself and to the company that I can learn and use a "new" framework in a few days.

I am aware that my project is not perfect and have some flaws, and maybe trying SwiftUI almost for the first time in a technical test was not a bright idea, nevertheless I really enjoyed the experience and I am eager to learn and to share my knowledges in other areas. That motivates me even more to use SwiftUI in a real world application.

Because it was almost my first app with SwiftUI, I also spent a lot of time refactoring my code, and I think the most difficult part in this project was the implementation of my LoadableView, but at the end I'm satisfied with the result because I reached my goal of creating a reusable view that allows a better control of loading states and prevent code duplication.

If you want, [here](https://github.com/MaxenceChantome/LePetitCoin) you can look at my technical test for Leboncoin using UIKit, which is a better representation of my current iOS experience (even thought the project had to be compatible with iOS12 so I did not use UITableViewDiffableDataSource).

## Estimate your percentage of completion and how much time you would need to finish

I did the project requirement, nevertheless my tests can be more specific for different states.
I estimate that I have finished 90% of the project, and maybe 2 more days would have allows me to write better tests.
In the total the project took me 7 days, but I could only give 3/4 hours per day for the project due to a tight schedule.
