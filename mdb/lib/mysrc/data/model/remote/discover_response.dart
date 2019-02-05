import 'package:json_annotation/json_annotation.dart';
import 'package:mdb/mysrc/data/model/local/movie.dart';

part 'discover_response.g.dart';

@JsonSerializable()
class DiscoverResponse{

  DiscoverResponse(this.page, this.total_results, this.total_pages, this.movies);

  int page;
  int total_results;
  int total_pages;
  @JsonKey(name: 'results')
  List<Movie> movies;

  factory DiscoverResponse.fromJson(Map<String, dynamic> json) => _$DiscoverResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DiscoverResponseToJson(this);

}
