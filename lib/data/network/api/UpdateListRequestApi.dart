// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/model/UpdateListRequestModel.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class UpdateListRequestApi {
  final ApiService _apiService = ApiService();
  Future<Response> updateList({required UpdateListRequestModel data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["UPDATE_LIST_NAME_URL"].toString(),
        data: FormData.fromMap(data.toJson()),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
