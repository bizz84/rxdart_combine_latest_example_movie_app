import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart_combine_latest_example_movie_app/models/movie.dart';
import 'package:rxdart_combine_latest_example_movie_app/models/user_favourite.dart';
import 'package:rxdart_combine_latest_example_movie_app/services/firestore_path.dart';
import 'package:rxdart_combine_latest_example_movie_app/services/firestore_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  Future<void> setUserFavourite(UserFavourite userFavourite) =>
      _service.setData(
        path: FirestorePath.userFavourite(uid, userFavourite.movieId),
        data: userFavourite.toMap(),
      );

  Stream<List<Movie>> moviesStream() => _service.collectionStream<Movie>(
        path: FirestorePath.movies(),
        builder: (data, documentId) => Movie.fromMap(data, documentId),
      );

  Stream<List<UserFavourite>> userFavouritesStream() =>
      _service.collectionStream<UserFavourite>(
        path: FirestorePath.userFavourites(uid),
        builder: (data, documentId) => UserFavourite.fromMap(data, documentId),
      );
}
