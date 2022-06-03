import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/covid_model.dart';

class CovidDataApi {
  Future<List<CovidModel>> getCovidData() async {
    http.Response response =
        await http.get(Uri.parse("https://api.covid19api.com/summary"));

    if (response.statusCode == 200) {
      List<CovidModel> covidModelList =
          (jsonDecode(response.body)["Countries"] as List)
              .map((e) => CovidModel.fromJson(e))
              .toList();
      return covidModelList;
    } else {
      throw Exception("Data Not Fetched.");
    }
  }

  Future<List<CovidModel>> getCovidData2() async {
    http.Response response =
        await http.get(Uri.parse("https://api.covid19api.com/summary"));

    if (response.statusCode == 200) {
      List<CovidModel> covidModelList =
          (jsonDecode(response.body)["Countries"] as List)
              .map((e) => CovidModel.fromJson(e))
              .toList();
      return covidModelList;
    } else {
      throw Exception("Data Not Fetched.");
    }
  }
}
