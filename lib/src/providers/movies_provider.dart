import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  
  String _apiKey = '91a9b78afa14d8c2a57c2ae5798a4cde';
  String _url = 'api.themoviedb.org';
  String _language = 'en-EN';

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language
    });

    final data = await http.get(url);
    final decodedData = json.decode(data.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.moviesList;
  }
}