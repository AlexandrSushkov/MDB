import 'package:flutter/material.dart';
import 'package:mdb/src/bloc/base/block_provider.dart';
import 'package:mdb/src/data/repository/genre_repository.dart';
import 'package:mdb/src/data/repository/movie_repository.dart';
import 'package:mdb/src/data/repository/repository_factory.dart';
import 'package:mdb/src/ui/screen/discover/discover_screen.dart';
import 'package:mdb/src/ui/screen/discover/discover_screen_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: BlocProvider(
          bloc: DiscoverScreenBloc(RepositoryFactory.provide<MovieRepository>(), RepositoryFactory.provide<GenreRepository>()), child: DiscoverScreen()),
    );
  }
}
