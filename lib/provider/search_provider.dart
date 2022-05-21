import 'package:flutter/material.dart';
import 'package:submissionfundamental/data/api/api_service.dart';
import 'package:submissionfundamental/data/model/restauran_response.dart';

enum SearchState { Loading, NoData, HasData, Error, NoQuery }

class SearchRestoProvider extends ChangeNotifier {
  final ApiService apiService;

  // final String query;

  SearchRestoProvider({required this.apiService}) {
    fetcSearchResto();
  }

  late RestoSearch _searchResult;
  late SearchState _state;
  String _message = '';
  String query = '';

  String get message => _message;
  RestoSearch get result => _searchResult;
  SearchState get state => _state;

  Future<dynamic> fetcSearchResto() async {
    if (query != "") {
      try {
        _state = SearchState.Loading;
        final search = await apiService.searchRestaurant(query);
        if (search.restaurants.isEmpty) {
          _state = SearchState.NoData;
          notifyListeners();
          return _message = 'The restaurant you were looking for was not found';
        } else {
          _state = SearchState.HasData;
          notifyListeners();
          return _searchResult = search as RestoSearch;
        }
      } catch (e) {
        _state = SearchState.Error;
        notifyListeners();
        return _message = 'Oops. Your internet connection is dead :( ...';
      }
    } else {
      _state = SearchState.NoQuery;
      notifyListeners();
      return _message = 'No query';
    }
  }

  void addQuery(String query) {
    this.query = query;
    fetcSearchResto();
    notifyListeners();
  }
}
