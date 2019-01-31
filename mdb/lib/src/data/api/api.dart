import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:mdb/src/data/model/remote/responce/discover_response.dart';
import 'package:mdb/src/data/model/remote/responce/genres_response.dart';
import 'package:mdb/src/data/model/remote/responce/popular_movies_responce.dart';
import 'package:mdb/src/utils/constants.dart';

class Api {
  Client client = Client();

  Future<PopularMoviesResponse> fetchPopularMovies() async {
    print("entered");
    final response = await client.get(popularMovies);
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return PopularMoviesResponse.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<DiscoverResponse> fetchDiscover() async {
    print("entered");
    final response = await client.get(discoverMovies);
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return DiscoverResponse.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<GenresResponse> fetchGenres() async {
    print("entered");
    final response = await client.get(genres);
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return GenresResponse.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
