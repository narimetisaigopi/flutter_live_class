import 'package:flutter_live_class/apis/doctors_data.api.dart';

import '../apis/covid_data_api.dart';
import '../models/covid_model.dart';

class Repository {
  Future<List<CovidModel>> covidData() => CovidDataApi().getCovidData();
  Future<List<CovidModel>> doctorData() => DoctorsDataApi().getDoctorsData();
}
