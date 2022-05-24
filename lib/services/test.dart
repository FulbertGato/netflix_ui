import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie.dart';

class Test{

   static Future<List<Movie>> fetchAlbum() async {
    //use http package
    print("popular 8");
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=1234&language=fr-FR&page=2'));
    print("popular tre");
    if (response.statusCode == 200) {
     
     final List<dynamic> results = json.decode(response.body)["results"];
     return results.map((e) => Movie.fromJson(e)).toList();
    }
    throw response;
          
    }
  }
