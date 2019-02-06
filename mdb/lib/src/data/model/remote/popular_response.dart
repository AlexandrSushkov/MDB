import 'package:json_annotation/json_annotation.dart';
import 'package:mdb/src/data/model/local/movie.dart';
import 'package:mdb/src/util/constants.dart';

//part 'popular_response.g.dart';

@JsonSerializable()
class PopularResponse {
  PopularResponse();
//  PopularResponse(this.page, this.totalResults, this.totalPages, this.movies);

  int page;
  @JsonKey(name: totalPagesKey)
  int totalResults;
  @JsonKey(name: totalPagesKey)
  int totalPages;
  @JsonKey(name: resultsKey)
  List<Movie> movies = [];

//  factory PopularResponse.fromJson(Map<String, dynamic> json) => _$PopularResponseFromJson(json);
//
//  Map<String, dynamic> toJson() => _$PopularResponseToJson(this);
}
