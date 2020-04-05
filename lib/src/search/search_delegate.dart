import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {

 final moviesProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(snapshot.data[i].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain
                ),
                title: Text(snapshot.data[i].title),
                subtitle: Text(snapshot.data[i].overview, overflow: TextOverflow.ellipsis),
                onTap: () {
                  close(context, null);
                  snapshot.data[i].uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: snapshot.data[i]);  
                },
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   final suggestedList = (query.isEmpty) ? 
  //                         recentMovies : 
  //                         movies.where((movie) => movie.toLowerCase().contains(query.toLowerCase())).toList();

  //   return ListView.builder(
  //     itemCount: suggestedList.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(suggestedList[i]),
  //         onTap: () {},
  //       );
  //     },
  //   );
  // }

}