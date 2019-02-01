import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../di/di.dart';
import '../../models/movie.dart';
import '../../rep/api_configuration.dart';
import '../utils/arc_image.dart';
import '../utils/stars_rating.dart';
import 'movie_details_bloc.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails({Key key, this.id, this.title}) : super(key: key);
  final int id;
  final String title;

  @override
  _BodyState createState() => _BodyState(id: id, title: title);
}

class _BodyState extends State<MovieDetails> {
  _BodyState({this.id, this.title});

  final String title;
  final int id;
  MovieDetailsBloc bloc = MovieDetailsBloc(api: DepInj().getMovieApi());
  List<Map<String, String>> _similar = [];
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  Movie _movie;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    bloc.loadDetails(id);
  }

  @override
  void dispose() {
    bloc.dispose();
    _similar.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.web), onPressed: _onWeb),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _onShare,
            )
          ],
        ),
        body: _getMain());
  }

  void _onWeb() async {
    var url = Uri.encodeFull(_movie.homePage);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext c) {
            return AlertDialog(
              title: new Text("App dialog"),
              content: new Text("Can't launch browser."),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  void _onShare() {
    Share.share(_movie.homePage);
  }

  Widget _getMain() {
    return StreamBuilder(
      stream: bloc.getDetailsStream(),
      builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
        if (snapshot.hasData) {
          _movie = snapshot.data;
          return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _getHeader2(_movie, Theme.of(context)),
                  SizedBox(height: 10),
                  _getOverview(_movie, Theme.of(context).textTheme),
                  SizedBox(height: 10),
                  _getImages(),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text("Cast",
                          style: Theme.of(context).textTheme.subhead.copyWith(
                              color: Theme.of(context).colorScheme.secondary))),
                  SizedBox(height: 5),
                  _getCast(),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text("Similar movies",
                          style: Theme.of(context).textTheme.subhead.copyWith(
                              color: Theme.of(context).colorScheme.secondary))),
                  SizedBox(height: 5),
                  _getSimilar()
                ],
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              scrollDirection: Axis.vertical);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return _getProgressDialog();
      },
    );
  }

  _getProgressDialog() => Center(child: CircularProgressIndicator());

  Widget _getHeader2(Movie m, ThemeData themeData) {
    return Stack(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(bottom: 170),
            child: ArcImage(ApiConfig.apiBackdropPath + m.backdropPath, 140)),
        Positioned(
            bottom: 0, left: 10, right: 10, child: _getHeader(m, themeData))
      ],
    );
  }

  Widget _getHeader(Movie m, ThemeData themeData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image.network(ApiConfig.apiPosterPath + m.posterPath,
              fit: BoxFit.fill),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(m.title, style: themeData.textTheme.title),
              Text(m.countries.join(", "), style: themeData.textTheme.body1),
              Text(
                  m.releaseDate.year.toString() +
                      " | " +
                      m.runtime.toString() +
                      " mins",
                  style: themeData.textTheme.body1),
              Text('"' + m.tagLine + '"', style: themeData.textTheme.body1),
              StarRating(m.voteAverage),
              Row(
                  children: m.genres.map((genre) {
                return Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Chip(
                        label: Text(genre),
                        backgroundColor: themeData.accentColor,
                        labelStyle: themeData.textTheme.caption));
              }).toList())
            ],
          ),
        )
      ],
    );
  }

  Widget _getOverview(Movie m, TextTheme textTheme) {
    bloc.loadImages(id);
    bloc.loadCast(id);
    bloc.newSimilar.add(id);
    return Padding(
        padding: const EdgeInsets.all(2),
        child: Text(m.overview, style: textTheme.body1));
  }

  Widget _getImages() {
    return StreamBuilder(
        stream: bloc.getImagesStream(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              height: 150,
              autoPlay: false,
              viewportFraction: 0.5,
              items: List<Widget>.generate(snapshot.data.length, (int i) {
                return Padding(
                  child: ClipRRect(
                      child: Image.network(
                          ApiConfig.apiPosterPath + snapshot.data[i],
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(2)),
                  padding: const EdgeInsets.all(3),
                );
              }),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return _getProgressDialog();
        });
  }

  Widget _getCast() {
    return StreamBuilder(
        stream: bloc.getCastStream(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, String>>> snapshot) {
          if (snapshot.hasData) {
            return Container(
                height: 200,
//                decoration: BoxDecoration(color: Colors.blue[100]),
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(3),
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.network(
                                        ApiConfig.apiPhotoPath +
                                            snapshot.data[index]['photo'],
                                        fit: BoxFit.fill)),
                              ),
                              Text(snapshot.data[index]['name'])
                            ],
                          ));
                    }));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return _getProgressDialog();
        });
  }

  Widget _getSimilar() {
    return StreamBuilder(
        stream: bloc.getSimilarStream(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, String>>> snapshot) {
          if (snapshot.hasData) {
            _similar.addAll(snapshot.data);
            return Container(
                height: 200,
//                decoration: BoxDecoration(color: Colors.red[100]),
                child: ListView.builder(
                    itemCount: _similar.length,
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    padding: const EdgeInsets.all(3),
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Image.network(
                                          ApiConfig.apiPosterPath +
                                              _similar[index]['poster'],
                                          fit: BoxFit.fill))),
                              Text(_similar[index]['title'])
                            ],
                          ));
                    }));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return _getProgressDialog();
        });
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      bloc.newSimilar.add(id);
    }
  }
}
