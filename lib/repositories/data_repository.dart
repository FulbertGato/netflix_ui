import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../services/api_service.dart';


class DataRepository with ChangeNotifier {
  final ApiService apiService = ApiService();

  final List<Movie> _popularMoviesList = [];

  final List<Movie> _tendanceMovies = [];
  final List<Movie> _moviesComing = [];
  final List<Movie> _moviesAnnimation = [];
  int popularMovieIndex = 1;
  int tendanceMovieIndex = 1;
  int moviesComingIndex = 1;
  int moviesAnnimationIndex = 1;

  List<Movie> get popularMovies => _popularMoviesList;
  List<Movie> get tendanceMovies => _tendanceMovies;
  List<Movie> get moviesComing => _moviesComing;
  List<Movie> get moviesAnnimation => _moviesAnnimation;

  Future<void> getPopularMoviesList() async {
    try {
      
       List<Movie> movies = await apiService.getMovies(pageNumber: popularMovieIndex, type: "popular");
      _popularMoviesList.addAll(movies);
      popularMovieIndex++;
     
      notifyListeners();
    } on Response catch (response) {
      print("error ${response.statusCode}");

      rethrow;
    }
  }

  Future<void> getTendanceMoviesList() async {
    try {
      List<Movie> movies = await apiService.getMovies(
          pageNumber: popularMovieIndex, type: "now_playing");
      _tendanceMovies.addAll(movies);
      tendanceMovieIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("error ${response.statusCode}");

      rethrow;
    }
  }

  Future<void> getMoviesComingList() async {
    try {
      List<Movie> movies = await apiService.getMovies(
          pageNumber: moviesComingIndex, type: "upcoming");
      _moviesComing.addAll(movies);
      moviesComingIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("error ${response.statusCode}");

      rethrow;
    }
  }

  Future<void> getMoviesAnnimationList() async {
    try {
      List<Movie> movies = await apiService.getMoviesByGenre(
          pageNumber: moviesAnnimationIndex, genreId: 16);
      _moviesAnnimation.addAll(movies);

      moviesAnnimationIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("error ${response.statusCode}");

      rethrow;
    }
  }

  Future<void> initData() async {
    await getPopularMoviesList();
    await getTendanceMoviesList();
    await getMoviesComingList();
    await getMoviesAnnimationList();
  }
}
