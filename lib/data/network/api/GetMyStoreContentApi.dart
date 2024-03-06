// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/model/GetMyStoreContentRequestModel.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class GetMyStoreContentApi {
  final ApiService _apiService = ApiService();
  Future<Response> getMyStoreContent(
      {required GetMyStoreContentRequesetModel data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["MY_STORE_CONTENT_URL"].toString(),
        data: FormData.fromMap(data.toJson()),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
