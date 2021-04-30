# Aircall technical test

iOS technical test. This document explains the creation of the application.

# Requirement ⚠️

iOS 13

# How it works 👨🏾‍🏫

When the application starts, a date sorted list of all the available call is displayed.

When an item is selected its details are showed in the detail view.

Call can be archived on both view by taping information details button on list view or archived icon (top right) in details view.

When a call is archived, it is not visible anymore on the screen. We can reset the archive state of all the call by taping the refresh icon on the right top part of the list view.

The application works on iPad and iPhone (and almost in landcaspe mode). Feel free to try it on different devices.

# More technical Details 🤓

The project is splitted in few parts:

* Network is where all the Aircal api calls are made. I used my custom pattern that promises to "create an API Rest in less than 2 minutes" and enable to test network part.
It will be soon open sourcered so feel free to comment 😄
* Database is the persistent part of the app
* Root is the entry point for are all the controllers used for the app.
* Shared folder for several extensions, protocol or handy class used in the application, especially a custom TableView pattern used in the details view. The purpose is to abstract a lot of TableView stuff and can handle multiple cell type. Soon opensourced too. All theses extension are my own code (no "copy pasta" without understand 🤓)

`Call` endpoint is not used since the split view pass data between master and details. I would be usefull if this controller wouldn't have been here and where at each tap of a cell a call to get the Call (passing data as I do would have been the same tho). `Activity` and `Call` endpoints seems to send the same data for a Call object (think) 🤔

# Tests 🛠

Unit tests are focused on the model testing for basic stuff or on protocol (with HistoryDetailsViewModelProtocol) for more advanced tests. I present only one test but the pattern could be used in all the classes, the HistoryDetailsViewModelProtocol was the simpler to demonstrate.

Functional tests have been made on iPhone SE 2020.

# Dificulties 🤯

CoreData with NSFetchedResultController. I wanted to avoid external database like Realm for this project (I used it and find it great for cross platform target but is to huge for this project), however I don't NSFetchedResultController and CoreData are what they are... Not really friendly to use 🙃


# Known issues 😅

* Landscap UI has some glitches.
* Some actions are not linked (Add notes, assign, and so on...).
* Some data are not well displayed, come from the API Rest.

# Improvements 💪

* Add swipe action for history list table view.
* Use right icon images related to the information (USA flag for the US phone provider)
* Add UI Unit tests
* Maybe use `NSDiffableDataSource`

The time to finish it would depend of the requirement of the differents feature lik the unactive buttons. What should do "assign action" ? What icon to display for phone operator? Generic or localized? The format to display on each cells which seems to be custom and not a copy of the call object from the api rest.
Also we should improve the code coverage.
I think a day for finishing it would be needed.

# 😈