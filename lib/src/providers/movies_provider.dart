import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  
  String _apiKey = '91a9b78afa14d8c2a57c2ae5798a4cde';
  String _url = 'api.themoviedb.org';
  String _language = 'en-EN';
  int _popularsPage = 0;
  List<Movie> _populars = new List();
  final _popularsStreamCtrl = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamCtrl.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamCtrl.stream;

  void disposeStreams() {
    _popularsStreamCtrl?.close();
  }

  Future<List<Movie>> _executeRequest(Uri url) async {
    final data = await http.get(url);
    final decodedData = json.decode(data.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.moviesList;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language
    });
    return await _executeRequest(url);
  }

  Future<List<Movie>> getPopularMovies() async {
    _popularsPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString()
    });

    final response = await _executeRequest(url);
    _populars.addAll(response);
    popularsSink(_populars);
    return response;
  }
}