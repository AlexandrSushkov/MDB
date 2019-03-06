import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdb/src/bloc/base/block_provider.dart';
import 'package:mdb/src/data/repository/genre_repository.dart';
import 'package:mdb/src/data/repository/movie_repository.dart';
import 'package:mdb/src/data/repository/repository_factory.dart';
import 'package:mdb/src/ui/ios/home_screen_ios.dart';
import 'package:mdb/src/ui/screen/discover/discover_screen.dart';
import 'package:mdb/src/ui/screen/discover/discover_screen_bloc.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _setUpPlatform();
  }

  _setUpPlatform() {
    if(Platform.isAndroid){
      return _buildMaterialApp();
    } else if (Platform.isIOS){
      return _buildCupertinoApp();
    }
  }

  _buildMaterialApp() {
    return MaterialApp(
      home: BlocProvider(
          bloc: DiscoverScreenBloc(RepositoryFactory.provide<MovieRepository>(), RepositoryFactory.provide<GenreRepository>()), child: DiscoverScreen()),
    );
  }

  _buildCupertinoApp() {
    return CupertinoApp(
      home: BlocProvider(
          bloc: DiscoverScreenBloc(RepositoryFactory.provide<MovieRepository>(), RepositoryFactory.provide<GenreRepository>()), child: HomeScreenIos()),
    );
  }
}
