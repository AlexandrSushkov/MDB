import 'package:json_annotation/json_annotation.dart';
import 'package:mdb/src/data/model/local/movie.dart';
import 'package:mdb/src/util/constants.dart';

part 'discover_response.g.dart';

@JsonSerializable()
class DiscoverResponse {
  DiscoverResponse(this.page, this.totalResults, this.totalPages, this.movies);

  int page;
  @JsonKey(name: totalPagesKey)
  int totalResults;
  @JsonKey(name: totalPagesKey)
  int totalPages;
  @JsonKey(name: resultsKey)
  List<Movie> movies;

  factory DiscoverResponse.fromJson(Map<String, dynamic> json) => _$DiscoverResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DiscoverResponseToJson(this);
}
