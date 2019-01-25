import 'package:flutter/material.dart';
import '../../di/di.dart';
import '../../models/movie.dart';
import 'movie_details_bloc.dart';
import '../../rep/api_configuration.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../utils/arc_image.dart';
import '../utils/stars_rating.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({Key key, this.title, this.id}) : super(key: key);
  final String title;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _Body(
        id: id,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  _Body({Key key, this.id}) : super(key: key);
  final int id;

  @override
  _BodyState createState() => _BodyState(id: id);
}

class _BodyState extends State<_Body> {
  _BodyState({this.id});

  int id;
  MovieDetailsBloc bloc = MovieDetailsBloc(api: DepInj().getMovieApi());

  @override
  void initState() {
    super.initState();
    bloc.loadDetails(id);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.getDetailsStream(),
      builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              _getHeader2(snapshot.data),
              SizedBox(height: 10),
              _getOverview(snapshot.data),
              SizedBox(height: 10),
              _getImages(),
              SizedBox(height: 10),
              _getCast(),
              SizedBox(height: 10),
              _getSimilar()
            ],
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return _getProgressDialog();
      },
    );
  }

  _getProgressDialog() => Center(child: CircularProgressIndicator());

  Widget _getHeader2(Movie m) {
    return Stack(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(bottom: 130),
            child: ArcImage(ApiConfig.apiBackdropPath + m.backdropPath, 100)),
        Positioned(bottom: 0, left: 10, right: 10, child: _getHeader(m))
      ],
    );
  }

  Widget _getHeader(Movie m) {
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
              Text(m.title, textAlign: TextAlign.left),
              Text(m.releaseDate.year.toString(), textAlign: TextAlign.left),
              Text(m.countries.join(", ")),
              Text(m.runtime.toString() + " mins"),
              Text('"' + m.tagLine + '"', textAlign: TextAlign.left),
              StarRating(m.voteAverage),
              Row(
                  children: m.genres.map((genre) {
                return Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: Chip(
                        label: Text(genre), backgroundColor: Colors.black12));
              }).toList())
            ],
          ),
        )
      ],
    );
  }

  Widget _getOverview(Movie m) {
    bloc.loadImages(id);
    bloc.loadCast(id);
    bloc.loadSimilar(id);
    return Text(m.overview);
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
                decoration: BoxDecoration(color: Colors.blue[100]),
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
            return Container(
                height: 200,
                decoration: BoxDecoration(color: Colors.red[100]),
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(3),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                              child: Image.network(
                                  ApiConfig.apiPosterPath +
                                      snapshot.data[index]['poster'],
                                  fit: BoxFit.fill)),
                          Text(snapshot.data[index]['title'])
                        ],
                      );
                    }));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return _getProgressDialog();
        });
  }
}
