// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class UpdateAdsApi {
  final ApiService _apiService = ApiService();
  Future<Response> updateAds({required FormData data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["UPDATE_ADS_URL"].toString(),
        data: data,
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
