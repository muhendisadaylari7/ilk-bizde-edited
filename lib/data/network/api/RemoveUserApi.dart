// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/model/RemoveUserRequestModel.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class RemoveUserRequestApi {
  final ApiService _apiService = ApiService();
  Future<Response> removeUser({required RemoveUserRequestModel data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["REMOVE_USER_URL"].toString(),
        data: FormData.fromMap(data.toJson()),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
