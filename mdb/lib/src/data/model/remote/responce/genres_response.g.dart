// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genres_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenresResponse _$GenresResponseFromJson(Map<String, dynamic> json) {
  return GenresResponse((json['genres'] as List)
      ?.map(
          (e) => e == null ? null : GenreJo.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$GenresResponseToJson(GenresResponse instance) =>
    <String, dynamic>{'genres': instance.genres};
