import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart_combine_latest_example_movie_app/app/movies_list/movies_list.dart';
import 'package:rxdart_combine_latest_example_movie_app/common_widgets/show_exception_alert_dialog.dart';
import 'package:rxdart_combine_latest_example_movie_app/services/firebase_auth_service.dart';

class MoviesListPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final FirebaseAuthService auth =
          Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      await showExceptionAlertDialog(
        context: context,
        title: 'Logout failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: MoviesList.create(context),
    );
  }
}
