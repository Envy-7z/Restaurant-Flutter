import 'package:flutter/material.dart';
import 'package:submissionfundamental/data/api/api_service.dart';
import 'package:submissionfundamental/data/model/restauran_response.dart';
import 'package:submissionfundamental/utils/result_state.dart';

class RestoDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestoDetailProvider({required this.apiService, required this.id}) {
    _fetchAllDetailRestaurant(id);
  }

  RestoDetail? _detailRestaurant;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  RestoDetail get detailRestaurant => _detailRestaurant!;

  ResultState get state => _state!;

  Future<dynamic> _fetchAllDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await apiService.restaurantDetail(id);
      if (resto.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = resto;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Oops. Your internet connection is dead :( ...';
    }
  }
}
