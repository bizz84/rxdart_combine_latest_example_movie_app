class FirestorePath {
  static String movies() => 'movies';
  static String movie(String movieId) => 'movies/$movieId';
  static String userFavourites(String uid) => 'users/$uid/userFavourites';
  static String userFavourite(String uid, String movieId) =>
      'users/$uid/userFavourites/$movieId';
}
