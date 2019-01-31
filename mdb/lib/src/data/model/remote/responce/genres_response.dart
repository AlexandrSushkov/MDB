import 'package:mdb/src/data/model/local/genre_jo.dart';
import 'package:json_annotation/json_annotation.dart';


part 'genres_response.g.dart';

@JsonSerializable()
class GenresResponse{

  List<GenreJo> genres;

//  GenresResponse.fromJson(Map<String, dynamic> parsedJson) {
//    print(parsedJson['genres'].length);
//    List<GenreJo> temp = [];
//    for (int i = 0; i < parsedJson['genres'].length; i++) {
//      Genre result = Genre(parsedJson['genres'][i]);
//      temp.add(result);
//    }
//    _genres = temp;
//  }

  GenresResponse(this.genres);

  factory GenresResponse.fromJson(Map<String, dynamic> json) => _$GenresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenresResponseToJson(this);


}
