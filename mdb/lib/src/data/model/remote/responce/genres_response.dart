import 'package:mdb/src/data/model/local/genre_jo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genres_response.g.dart';

@JsonSerializable()
class GenresResponse{

  List<GenreJo> genres;

  GenresResponse(this.genres);

  factory GenresResponse.fromJson(Map<String, dynamic> json) => _$GenresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenresResponseToJson(this);

}
