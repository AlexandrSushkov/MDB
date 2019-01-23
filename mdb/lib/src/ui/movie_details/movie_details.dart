import 'package:flutter/material.dart';
import '../../di/di.dart';
import '../../models/movie.dart';
import 'movie_details_bloc.dart';
import '../../rep/api_configuration.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    bloc.getDetails(id);
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
              _getHeader(snapshot.data),
              _getOverview(snapshot.data),
              _getImages()
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

  Widget _getHeader(Movie m) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image.network(ApiConfig.apiPosterPath + m.posterPath,
              fit: BoxFit.fill),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(m.title, textAlign: TextAlign.left),
              Text(m.genres.join(", ")),
              Text(m.releaseDate.year.toString(), textAlign: TextAlign.left),
              Text(m.countries.join(", ")),
              Text(m.runtime.toString() + " mins"),
              Text('"' + m.tagLine + '"', textAlign: TextAlign.left)
            ],
          ),
        )
      ],
    );
  }

  Widget _getOverview(Movie m) {
    bloc.getImages(id);
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
              viewportFraction: 0.8,
              items: List<Widget>.generate(snapshot.data.length, (int i) {
                return Image.network(ApiConfig.apiPosterPath + snapshot.data[i],
                    fit: BoxFit.fill);
              }),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return _getProgressDialog();
        });
  }
}
