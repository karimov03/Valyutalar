import 'api_data.dart';

abstract class ApiService {
  Future<List<ApiData>> getAllData();
  Future<ApiData> getData(int id);
  Future<List<ApiData>> getValyuta30day(String valyuta_name);
}
