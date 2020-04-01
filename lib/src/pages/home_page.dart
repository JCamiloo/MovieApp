import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movies'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _cardsSwiper()
          ]
        ),
      )
    );
  }

  Widget _cardsSwiper() {
    final moviesProvider = new MoviesProvider();
    moviesProvider.getNowPlaying();
    return CardSwiper( movies: [1, 2, 3, 4] );
  }
}