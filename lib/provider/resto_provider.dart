import 'package:flutter/material.dart';
import 'package:submissionfundamental/data/api/api_service.dart';
import 'package:submissionfundamental/data/model/restauran_response.dart';
import 'package:submissionfundamental/utils/result_state.dart';

class RestoProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoProvider({required this.apiService}) {
    fetchRestoFull();
  }

  late RestoList _resto;

  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestoList get result => _resto;

  ResultState get state => _state;

  Future<dynamic> fetchRestoFull() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await apiService.restaurantList();
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _resto = restaurantList;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Oops. Your internet connection is dead :( ...';
    }
  }
}
