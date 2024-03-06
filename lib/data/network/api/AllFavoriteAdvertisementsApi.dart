// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class AllFavoriteApi {
  final ApiService _apiService = ApiService();
  Future<Response> allFavoriteAdvertisement(
      {required Map<String, dynamic> data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["ALL_FAVORITE_URL"].toString(),
        data: FormData.fromMap(data),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
