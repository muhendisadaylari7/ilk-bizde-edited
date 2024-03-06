// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class CategoryAdvertisementApi {
  final ApiService _apiService = ApiService();
  Future<Response> getCategoryAdvertisements(
      {required Map<String, dynamic> data}) async {
    try {
      final Response resp = await _apiService.get(
          dotenv.env["CATEGORY_ADVERTISEMENT_URL"].toString(),
          queryParameters: data);
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
