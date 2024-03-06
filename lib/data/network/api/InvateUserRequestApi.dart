// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/model/InvateUserRequestModel.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class InvateUserRequestApi {
  final ApiService _apiService = ApiService();
  Future<Response> invateUser({required InvateUserRequestModel data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["CANCEL_USER_INVITATION_URL"].toString(),
        data: FormData.fromMap(data.toJson()),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
