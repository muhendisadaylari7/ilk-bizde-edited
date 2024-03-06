// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/model/GetBillingRequestModel.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class GetBillingApi {
  final ApiService _apiService = ApiService();
  Future<Response> getBilling({required GetBillingRequestModel data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["MY_BILLING_URL"].toString(),
        data: FormData.fromMap(data.toJson()),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
