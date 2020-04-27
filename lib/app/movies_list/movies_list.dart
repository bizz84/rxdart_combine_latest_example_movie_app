import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart_combine_latest_example_movie_app/app/movies_list/movie_list_item.dart';
import 'package:rxdart_combine_latest_example_movie_app/app/movies_list/movies_list_view_model.dart';
import 'package:rxdart_combine_latest_example_movie_app/models/movie_user_favourite.dart';
import 'package:rxdart_combine_latest_example_movie_app/services/firestore_database.dart';

class MoviesList extends StatelessWidget {
  static Widget create(BuildContext context) {
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    return Provider<MoviesListViewModel>(
      create: (_) => MoviesListViewModel(database: database),
      child: MoviesList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MoviesListViewModel>(context, listen: false);
    return StreamBuilder<List<MovieUserFavourite>>(
      stream: viewModel.moviesUserFavouritesStream(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final movies = snapshot.data;
          if (movies == null) {
            return Scaffold(
              body: Center(
                child: Text('Movies list is empty',
                    style: Theme.of(context).textTheme.headline6),
              ),
            );
          }
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, index) => MovieListItem(
              movieUserFavourite: movies[index],
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
