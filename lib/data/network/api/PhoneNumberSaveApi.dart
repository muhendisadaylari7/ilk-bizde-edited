// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class PhoneNumberSaveApi {
  final ApiService _apiService = ApiService();
  final GetStorage storage = GetStorage();

  Future<Response> savePhoneNumber({required Map<String, dynamic> data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["PHONE_NUMBER_SAVE_URL"].toString(),
        data: FormData.fromMap(data),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
