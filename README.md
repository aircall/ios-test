


# Aircall - iOS Technical test

##### Where to focus

1. We will pay attention on the architecture of your app

2. The quality of your tests

3. The clarity and documentation of your code

4. Don't pay too much attention on design stuff, it's not a criteria for us. After all, you are a developer not a designer !


### Write a brief outline of the architecture of your app.

I separeted my code in layers:
- user interface layer
- data access layer
- business logic layer

i created framework so that it's easier to see the separations and this allow us to make public only what we need to make public.

I choose to have a repository between my viewModels and network layer, so the viewModel won't depend on the network layer and it will be easier to have a persistent layer in the future that may be used to have a local repository.

### Explain why you decided to use each third party libraries.

I decided to use Quick and Nimble to improve readability in my tests.
I would have used SwiftLint for a long-term project

### What was the most difficult part of the challenge ?

The most difficult part of this challenge is to decide when it's enough. Since software can be always be improved and this is a technical test, it was hard form me to decide if what i'm doing it's overkill for a little project or it's what's expected.


### Estimate your percentage of completion and how much time you would need to finish

What's missing:
CallsView UI
CallDetail UI
DateFormatter

I would say 1 day to finish all this.
The percentage of complition i would say it's 60%

### Wrapping Up

I like this kind of technical test, since i think it's better than small and faster technical tests.
Although i regret not having consecutive hours to do this tests.
Hopefully we can have a talk about my test, since it's the best part.
