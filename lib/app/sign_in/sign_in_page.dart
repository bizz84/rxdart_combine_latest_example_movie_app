import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rxdart_combine_latest_example_movie_app/app/sign_in/sign_in_button.dart';
import 'package:rxdart_combine_latest_example_movie_app/app/sign_in/sign_in_view_model.dart';
import 'package:rxdart_combine_latest_example_movie_app/common_widgets/show_exception_alert_dialog.dart';
import 'package:rxdart_combine_latest_example_movie_app/services/firebase_auth_service.dart';

class SignInPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService auth =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(auth: auth),
      child: Consumer<SignInViewModel>(
        builder: (_, SignInViewModel viewModel, __) => SignInPage._(
          viewModel: viewModel,
          title: 'Movie Favourites',
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage._({Key key, this.viewModel, this.title}) : super(key: key);
  final SignInViewModel viewModel;
  final String title;

  Future<void> _showSignInError(
      BuildContext context, PlatformException exception) async {
    await showExceptionAlertDialog(
      context: context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await viewModel.signInAnonymously();
    } catch (e) {
      _showSignInError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(title),
      ),
      backgroundColor: Colors.grey[200],
      body: _buildSignIn(context),
    );
  }

  Widget _buildHeader() {
    if (viewModel.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    // Make content scrollable so that it fits on small screens
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 32.0),
          SizedBox(
            height: 50.0,
            child: _buildHeader(),
          ),
          SizedBox(height: 8),
          SignInButton(
            text: 'Sign in anonymously',
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed:
                viewModel.isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }
}
