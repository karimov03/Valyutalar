import 'package:intl/intl.dart';

class ApiData {
  final int id;
  final String Code;
  final String Ccy;
  final String CcyNm_RU;
  final String CcyNm_UZ;
  final String CcyNm_EN;
  final String Nominal;
  final String Rate;
  final String Diff;
  final DateTime Date; // Change from String to DateTime

  ApiData({
    required this.id,
    required this.Code,
    required this.Ccy,
    required this.CcyNm_RU,
    required this.CcyNm_UZ,
    required this.CcyNm_EN,
    required this.Nominal,
    required this.Rate,
    required this.Diff,
    required this.Date,
  });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      id: json['id'],
      Code: json['Code'],
      Ccy: json['Ccy'],
      CcyNm_RU: json['CcyNm_RU'],
      CcyNm_UZ: json['CcyNm_UZ'],
      CcyNm_EN: json['CcyNm_EN'],
      Nominal: json['Nominal'],
      Rate: json['Rate'],
      Diff: json['Diff'],
      Date: DateFormat("dd.MM.yyyy").parse(json['Date']), // Parse the date string
    );
  }
}
