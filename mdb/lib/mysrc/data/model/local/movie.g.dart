// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
      json['vote_count'] as int,
      json['id'] as int,
      json['video'] as bool,
      json['vote_average'],
      json['title'] as String,
      (json['popularity'] as num)?.toDouble(),
      json['poster_path'] as String,
      json['original_language'] as String,
      json['original_title'] as String,
      (json['genre_ids'] as List)?.map((e) => e as int)?.toList(),
      json['backdrop_path'] as String,
      json['adult'] as bool,
      json['overview'] as String,
      json['release_date'] as String);
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'vote_count': instance.voteCount,
      'id': instance.id,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'title': instance.title,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'genre_ids': instance.genreIds,
      'backdrop_path': instance.backdropPath,
      'adult': instance.adult,
      'overview': instance.overview,
      'release_date': instance.releaseDate
    };
