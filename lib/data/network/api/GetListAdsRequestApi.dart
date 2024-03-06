// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilkbizde/data/model/GetListAdsRequestModel.dart';
import 'package:ilkbizde/data/network/services/api_service.dart';

class GetListAdsRequestApi {
  final ApiService _apiService = ApiService();
  Future<Response> getListAds({required GetListAdsRequestModel data}) async {
    try {
      final Response resp = await _apiService.post(
        dotenv.env["GET_LIST_ADS_URL"].toString(),
        data: FormData.fromMap(data.toJson()),
      );
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
