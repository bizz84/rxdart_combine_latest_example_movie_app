import 'package:flutter/foundation.dart';
import 'package:rxdart_combine_latest_example_movie_app/models/movie.dart';

class MovieUserFavourite {
  MovieUserFavourite({@required this.movie, @required this.isFavourite});

  final Movie movie;
  final bool isFavourite;
}
