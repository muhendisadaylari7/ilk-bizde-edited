// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/model/AddAdToListRequestModel.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class AddAdToListRequestApi {
  final ApiService _apiService = ApiService();
  Future<Response> addAdToList({required AddAdToListRequestModel data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["ADD_ADS_TO_LIST_URL"].toString(),
        data: FormData.fromMap(data.toJson()),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
