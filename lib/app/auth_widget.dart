import 'package:flutter/material.dart';
import 'package:rxdart_combine_latest_example_movie_app/app/movies_list/movies_list_page.dart';
import 'package:rxdart_combine_latest_example_movie_app/app/sign_in/sign_in_page.dart';
import 'package:rxdart_combine_latest_example_movie_app/services/firebase_auth_service.dart';

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.
/// Note: this class used to be called [LandingPage].
class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? MoviesListPage() : SignInPageBuilder();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
