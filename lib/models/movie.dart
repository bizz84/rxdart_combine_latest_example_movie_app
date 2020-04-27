import 'dart:ui';

import 'package:flutter/foundation.dart';

class Movie {
  Movie({@required this.id, @required this.title, @required this.description});
  final String id;
  final String title;
  final String description;

  factory Movie.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    return Movie(
        id: documentId, title: data['title'], description: data['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  @override
  int get hashCode => hashValues(id, title, description);

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Movie otherMovie = other;
    return id == otherMovie.id &&
        title == otherMovie.title &&
        description == otherMovie.description;
  }

  @override
  String toString() => 'id: $id, title: $title, description: $description';
}
