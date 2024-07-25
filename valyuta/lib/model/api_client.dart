import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'api_data.dart';
import 'api_service.dart';

var _dio = Dio(BaseOptions(baseUrl: "https://cbu.uz/oz/arkhiv-kursov-valyut/"));

class ApiClient extends ApiService {
  @override
  Future<List<ApiData>> getAllData() async {
    try {
      Response response = await _dio.get('json/');
      List<ApiData> apiList =
          (response.data as List).map((api) => ApiData.fromJson(api)).toList();
      return apiList;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<ApiData> getData(int id) {
    throw UnimplementedError();
  }

  Future<List<ApiData>> getDatabyDate(String date, String currency) async {
    var dateUrl = "https://cbu.uz/oz/arkhiv-kursov-valyut/json/$currency/$date/";
    try {
      Response response = await _dio.get(dateUrl);
      List<ApiData> apiList = (response.data as List)
          .map((api) => ApiData.fromJson(api))
          .toList();
      return apiList;
    } catch (e) {
      return [];
    }
  }

  Future<List<ApiData>> getLast30DaysData() async {
    List<ApiData> allData = [];
    DateTime currentDate = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    for (int i = 0; i < 30; i++) {
      DateTime targetDate = currentDate.subtract(Duration(days: i));
      String formattedDate = dateFormat.format(targetDate);

      List<ApiData> dataForDate = await getDatabyDate(formattedDate, 'USD');
      allData.addAll(dataForDate);
    }

    return allData;
  }
  
  @override
  Future<List<ApiData>> getValyuta30day(String valyuta_name) async {
    List<ApiData> allData = [];
    DateTime currentDate = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    for (int i = 0; i < 30; i++) {
      DateTime targetDate = currentDate.subtract(Duration(days: i));
      String formattedDate = dateFormat.format(targetDate);

      List<ApiData> dataForDate = await getDatabyDate(formattedDate.toString(), valyuta_name);
      allData.addAll(dataForDate);
    }

    return allData;
  }
}
