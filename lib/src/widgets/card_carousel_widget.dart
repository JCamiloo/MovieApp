import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class CardCarousel extends StatelessWidget {

  final List<Movie> movies;
  final _pageCtrl = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );
  final Function nextPage;

  CardCarousel({@required this.movies, @required this.nextPage});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    _pageCtrl.addListener(() {
      if (_pageCtrl.position.pixels >= _pageCtrl.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        controller: _pageCtrl,
        itemCount: movies.length,
        itemBuilder: (context, i) => _card(context, movies[i]),
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(movie.getPosterImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 160.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title, 
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      )
    );
  }

  List<Widget> _cards(BuildContext context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title, 
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        )
      );
    }).toList();
  }
}