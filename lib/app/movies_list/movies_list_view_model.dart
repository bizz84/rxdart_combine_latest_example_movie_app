import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_combine_latest_example_movie_app/models/movie.dart';
import 'package:rxdart_combine_latest_example_movie_app/models/movie_user_favourite.dart';
import 'package:rxdart_combine_latest_example_movie_app/models/user_favourite.dart';
import 'package:rxdart_combine_latest_example_movie_app/services/firestore_database.dart';

class MoviesListViewModel {
  MoviesListViewModel({@required this.database});
  final FirestoreDatabase database;

  /// returns the entire movies list with user-favourite information
  Stream<List<MovieUserFavourite>> moviesUserFavouritesStream() {
    return Rx.combineLatest2(
        database.moviesStream(), database.userFavouritesStream(),
        (List<Movie> movies, List<UserFavourite> userFavourites) {
      try {
        return movies.map((movie) {
          final userFavourite = userFavourites?.firstWhere(
              (userFavourite) => userFavourite.movieId == movie.id,
              orElse: () => null);
          return MovieUserFavourite(
            movie: movie,
            isFavourite: userFavourite?.isFavourite ?? false,
          );
        }).toList();
      } catch (e) {
        print(e);
        return [];
      }
    });
  }

  /// returns all the user's favourite movies (not the entire list)
  Stream<List<MovieUserFavourite>> userFavouriteMoviesStream() {
    return Rx.combineLatest2(
        database.moviesStream(), database.userFavouritesStream(),
        (movies, userFavourites) {
      try {
        return userFavourites.map((userFavourite) {
          final movie = movies.firstWhere(
              (movie) => userFavourite.movieId == movie.id,
              orElse: () => null);
          return MovieUserFavourite(
            movie: movie,
            isFavourite: userFavourite?.isFavourite ?? false,
          );
        }).toList();
      } catch (e) {
        print(e);
        return [];
      }
    });
  }
}
