import 'package:flutter/material.dart';
import 'package:submissionfundamental/data/db/database_helper.dart';
import 'package:submissionfundamental/data/model/restauran_response.dart';
import 'package:submissionfundamental/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  DatabaseProvider({required this.databaseHelper}) {
    getFavorites();
  }
  late ResultState _state;
  String _message = '';

  String get message => _message;
  ResultState get state => _state;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void getFavorites() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      _favorites = await databaseHelper.getFavorites();
      if (_favorites.isNotEmpty) {
        _state = ResultState.hasData;
      } else {
        _state = ResultState.noData;
        _message = 'Empty Data';
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  void addFavorite(Restaurant resto) async {
    try {
      await databaseHelper.insertFavorite(resto);
      getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Oops. Your internet connection is dead :( ...';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedResto = await databaseHelper.getFavoriteById(id);
    return favoritedResto.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Oops. Your internet connection is dead :( ...';
      notifyListeners();
    }
  }
}
