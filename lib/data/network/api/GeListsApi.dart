// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/model/GetListsRequestModel.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class GetListsApi {
  final ApiService _apiService = ApiService();
  Future<Response> getLists({required GetListsRequestModel data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["MY_LISTS_URL"].toString(),
        data: FormData.fromMap(data.toJson()),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
