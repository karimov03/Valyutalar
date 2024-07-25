import 'package:flutter/material.dart';
import 'package:valyuta/model/api_client.dart';
import 'package:valyuta/model/api_data.dart';

class DataProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _iscurrencyLoading = true;
  bool _isallLoading = true;

  List<ApiData> _data = [];
  List<ApiData> _currencydata = [];
  List<ApiData> _alldata = [];

  bool get isLoading => _isLoading;
  bool get iscurrencyLoading => _iscurrencyLoading;
  bool get isallLoading => _isallLoading;

  List<ApiData> get data => _data;
  List<ApiData> get currencydata => _currencydata;
  List<ApiData> get alldata => _alldata;

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();
    _data = await ApiClient().getLast30DaysData();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> allData() async {
    _isallLoading = true;
    notifyListeners();
    _alldata = await ApiClient().getAllData();
    _isallLoading = false;
    notifyListeners();
  }

  Future<void> fetchCurrencyData(String currency) async {
    _iscurrencyLoading = true;  
    notifyListeners();
    _currencydata = await ApiClient().getValyuta30day(currency);
    _iscurrencyLoading = false;
    notifyListeners();
  }
}
