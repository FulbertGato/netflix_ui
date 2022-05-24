import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import 'api.dart';

class ApiService {
  late Dio dio = Dio();
  init() {
    BaseOptions options = BaseOptions(
      baseUrl: api.baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  final Api api = Api();
  //final Dio dio = Dio(options);

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    //init();
    String url = api.baseUrl + path;
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'fr-FR',
    };

    if (params != null) {
      query.addAll(params);
    }

    final Response response = await dio.get(url, queryParameters: query);
    if (response.statusCode == 200) {
     // print("echo");
      return response;
    } else {
      print(response.statusCode);
    }

    throw response;
  }

  Future<List<Movie>> getMovies(
      {required int pageNumber, required String type}) async {
    final Response response = await getData('/movie/' + type, params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      final List<dynamic> results = response.data['results'];
      //print('results');
      return results.map((e) => Movie.fromJson(e)).toList();
    }

    throw response;
  }

  Future<List<Movie>> getMoviesByGenre(
      {required int pageNumber, required int genreId}) async {
    final Response response = await getData('/discover/movie', params: {
      'page': pageNumber,
      'with_genres': genreId,
    });

    if (response.statusCode == 200) {
      final List<dynamic> results = response.data['results'];
      return results.map((e) => Movie.fromJson(e)).toList();
    }
    throw response;
  }

  }

