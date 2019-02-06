import 'package:json_annotation/json_annotation.dart';
import 'package:mdb/src/data/model/local/genre.dart';

part 'genres_response.g.dart';

@JsonSerializable()
class GenresResponse {
  GenresResponse(this.genres);

  List<Genre> genres;

  factory GenresResponse.fromJson(Map<String, dynamic> json) => _$GenresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenresResponseToJson(this);
}
