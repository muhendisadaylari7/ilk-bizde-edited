// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/model/CreateNewListRequestModel.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class CreateNewListRequestApi {
  final ApiService _apiService = ApiService();
  Future<Response> createNewList(
      {required CreateNewListRequestModel data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["CREATE_NEW_LIST_URL"].toString(),
        data: FormData.fromMap(data.toJson()),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
