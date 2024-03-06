// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class EditMarketApi {
  final ApiService _apiService = ApiService();
  Future<Response> handleEditMarketApi({dynamic data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["EDIT_MARKET_URL"].toString(),
        data: data,
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
