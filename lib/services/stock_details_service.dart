import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:nepse_data_app/models/companies.dart';

class StockDetailsService {
  late CompaniesModel companiesModel;
  getAllStockDetails(String endPoint) async {
    Response response = await get(Uri.parse(endPoint))
        .timeout(const Duration(seconds: 6), onTimeout: () {
      throw TimeoutException("Server request timeout");
    });
    switch (response.statusCode) {
      case 200:
        var responseBody = response.body;
        var jsonData = jsonDecode(responseBody);
        companiesModel = CompaniesModel.fromJson(jsonData);
        return companiesModel;
      default:
        throw Exception("An error occured try again");
    }
  }
}
