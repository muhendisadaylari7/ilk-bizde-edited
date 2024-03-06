// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class OpenMarketApi {
  final ApiService _apiService = ApiService();
  Future<Response> handleOpenMarketApi(
      {Map<String, dynamic>? data,
      bool isMultipart = false,
      dynamic formData}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["OPEN_MARKET_URL"].toString(),
        data: isMultipart ? formData : FormData.fromMap(data!),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
