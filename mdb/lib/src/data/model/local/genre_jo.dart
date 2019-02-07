import 'package:json_annotation/json_annotation.dart';

part 'package:mdb/src/data/model/local/genre_jo.g.dart';

@JsonSerializable()
class GenreJo{

  int id;
  String name;

  GenreJo(this.id, this.name);

  factory GenreJo.fromJson(Map<String, dynamic> json) => _$GenreJoFromJson(json);

  Map<String, dynamic> toJson() => _$GenreJoToJson(this);

}
