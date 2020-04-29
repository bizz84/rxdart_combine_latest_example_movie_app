# RxDart by example: combineLatest and data modeling with Firestore

A simple movie favourites app showcasing how to use `combineLatest` to combine data from two Firestore collections into one stream.

## Running the project with Firebase

To use this project with Firebase, some configuration steps are required.

- Create a new project with the Firebase console.
- Add iOS and Android apps in the Firebase project settings.
- On Android, use `com.example.rxdart_combine_latest_example_movie_app` as the package name.
- then, [download and copy](https://firebase.google.com/docs/flutter/setup#configure_an_android_app) `google-services.json` into `android/app`.
- On iOS, use `com.example.rxdartCombineLatestExampleMovieApp` as the bundle ID.
- then, [download and copy](https://firebase.google.com/docs/flutter/setup#configure_an_ios_app) `GoogleService-Info.plist` into `iOS/Runner`, and add it to the Runner target in Xcode.

Additionally, follow these steps:

- Enable anonymous sign-in in the Firebase authentication settings
- Copy the contents of `firestore.rules` into the Rules page for the Firestore database

See this document for full instructions:

- [https://firebase.google.com/docs/flutter/setup](https://firebase.google.com/docs/flutter/setup) 

## [License: MIT](LICENSE.md)