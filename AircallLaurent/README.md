# Aircall technical test

iOS technical test. This document explains the creation of the application.

# Requirement ⚠️

iOS 13

# How it works 👨🏾‍🏫

When the application starts, a date sorted list of all the available call is displayed.

When an item is selected its details are showed in the detail view.

Call can be archived on both view by taping information details button on list view or archived icon (top right) in details view.

The application works on iPad and iPhone (and almost in landcaspe mode). Feel free to try it on different devices.

# More technical Details 🤓

The project is splitted in few parts:

* Network is where all the Aircal api calls are made. I used my custom pattern that promises to "create an API Rest in less than 2 minutes" and enable to test network part.
It will be soon open sourcered so feel free to comment 😄
* Database is the persistent part of the app
* Root is the entry point for are all the controllers used for the app.
* Shared folder for several extensions, protocol or handy class used in the application, especially a custom TableView pattern used in the details view. The purpose is to abstract a lot of TableView stuff and can handle multiple cell type. Soon opensourced too.


# Tests 🛠

Unit tests are focused on the sorting, filtering and fetching part of the applicaiton.

Functional tests have been made on iPhone SE 2020.

# Dificulties 🤯

CoreData with NSFetchedResultController. I wanted to avoid external database like Realm for this project (I used it and find it great for cross platform target but is to huge for this project), however I don't NSFetchedResultController and CoreData are what they are... Not really friendly to use 🙃


# Known issues 😅

* Landscap UI has some glitches
* Some actions are not linked (Add notes, assign, and so on...)
* Some data are not well displayed, come from the API Rest.

# Improvements 💪

* Add swipe action for history list table view.
* Use right icon images related to the information (USA flag for the US phone provider)

# 😈