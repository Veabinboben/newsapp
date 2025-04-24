# newsapp

News Application in flutter

# Description

Application for viewing news feed from https://newsapi.org/.
Following features are implemented
1. Viewing latest news in 3 categories
2. Viewing details, with ability to continue reading on corresponding website
3. Bookmarking news and viewing them in separate tab
4. Ability to load more news when reaching end of live feed
5. Caching last viewd news for viewing in offline mode
6. Checking for internet connection to update feed when getting internet data

 # Structure / Stack
 App is writteng using Flutter framework with implementation of Hive, Retrofit, Bloc and GoRouter
 App structure is divided into 3 parts
 1. __data__: implements method for retreiving data from local storage or server
 2. __domain__ : implements models and methods whish will be displayed in the UI
 3. __presentation__ : implements states and visual representation off all screens.
