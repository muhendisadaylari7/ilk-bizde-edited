// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/model/UpdateMyStoreContentRequestModel.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class UpdateMyStoreContentApi {
  final ApiService _apiService = ApiService();
  Future<Response> updateMyStoreContent(
      {required UpdateMyStoreContentRequestModel data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["UPDATE_MY_STORE_CONTENT_URL"].toString(),
        data: FormData.fromMap(await data.toJson()),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
