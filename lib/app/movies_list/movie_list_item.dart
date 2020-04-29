import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart_combine_latest_example_movie_app/models/movie_user_favourite.dart';
import 'package:rxdart_combine_latest_example_movie_app/models/user_favourite.dart';
import 'package:rxdart_combine_latest_example_movie_app/services/firestore_database.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem(
      {Key key, this.movieUserFavourite, this.onFavouriteToggle})
      : super(key: key);
  final MovieUserFavourite movieUserFavourite;
  final VoidCallback onFavouriteToggle;

  Future<void> _toggleFavourite(BuildContext context) async {
    try {
      final database = Provider.of<FirestoreDatabase>(context, listen: false);
      await database.setUserFavourite(UserFavourite(
        isFavourite: !movieUserFavourite.isFavourite,
        movieId: movieUserFavourite.movie.id,
      ));
    } catch (e) {
      // TODO: handle exceptions
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(movieUserFavourite.movie.title),
        subtitle: Text(movieUserFavourite.movie.description),
        trailing: IconButton(
          icon: Icon(
            Icons.favorite,
            color:
                movieUserFavourite.isFavourite ? Colors.red : Colors.grey[300],
          ),
          onPressed: () => _toggleFavourite(context),
        ),
      ),
    );
  }
}
