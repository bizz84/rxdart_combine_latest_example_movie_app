import 'dart:ui';

import 'package:flutter/foundation.dart';

class UserFavourite {
  UserFavourite({@required this.movieId, @required this.isFavourite});
  final String movieId;
  final bool isFavourite;

  factory UserFavourite.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    return UserFavourite(movieId: documentId, isFavourite: data['isFavourite']);
  }

  Map<String, dynamic> toMap() {
    return {
      'isFavourite': isFavourite,
    };
  }

  @override
  int get hashCode => hashValues(movieId, isFavourite);

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final UserFavourite otherFavourite = other;
    return movieId == otherFavourite.movieId &&
        isFavourite == otherFavourite.isFavourite;
  }

  @override
  String toString() => 'movieId: $movieId, isFavourite: $isFavourite';
}
