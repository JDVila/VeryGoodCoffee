# VeryGoodCoffee ☕

## Getting Started 🚀

This repository includes a Flutter Project for both iOS and Android.

The following steps detail how to get started:
1. Clone this repository on the command line, or download the project as a zip file
2. Install VSCode IDE on your Desktop
3. Open up either an iOS Simulator or Android Emulator in VSCode
4. Open the working directory folder in VSCode
5. Run the following command in the working directory through the terminal: `flutter run --flavor development --target lib/main_development.dart`
6. Interact and have fun with the app!

This app was built using BLoC state management, Clean Architecture for concern separation, and Get_it for Dependency Injection and Source Location.

## Using the App in the Simulator / Emulator 📱
1. Open the App manually by clicking on the app icon, or automatically through VSCode if this is a fresh install
2. View a random coffee image
3. If it pleases you, press the outlined heart icon to add it as a favorite image
4. If you no longer want the current image, you can press the red heart icon to un-favorite the image
5. Press the bottom navigation bar button entitled "Favorite Coffees" with the heart icon to see your favorites
6. Don't see your current favorite yet? Swipe down to refresh the list!
7. Scroll through the list to see all of your favorites, even without internet access!
8. Press the bottom navigation bar button entitled "Random Coffee" with the coffee icon to get a new image
9. Press the button entitled "Get New Coffee Image" to receive a new Random Coffee Image from the web

<img src="images/1.png" alt="Random Coffee Tab" width="200"/><img src="images/2.png" alt="Marked Favorite" width="200"/><img src="images/3.png" alt="Favorites Tab" width="200"/><img src="images/4.png" alt="New Random Image" width="200"/>

## Running Tests 🧪
Currently, there are only 3 widget tests, and they are currently not working due to a known issue with mocking the database involving a FakeTimer and SQLite. I encounted the same problem with accessing the API, but faked it with a wrapper class. I could not make a Database wrapper in time due to time constrants. The three tests intend to test:
1. That the app loads as expected
2. That the left bottom navigation bar button works as expected
3. That the right bottom navigation bar button works as expected

## Next Steps 🪜
1. Build a wrapper for the database to fake / mock for tests
2. Add the ability to remove favorites directly from the favorites list
3. Check for internet connectivity, and fail gracefully to account for this
4. Add Email / Text / Social Share capabilities
5. Add more Widget Tests and Unit Tests
