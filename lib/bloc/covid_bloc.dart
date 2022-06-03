import 'package:flutter_live_class/models/covid_model.dart';
import 'package:flutter_live_class/repository/repository.dart';

import 'package:rxdart/rxdart.dart';

class CovidBloc {
  Repository _repository = Repository();

  var data = PublishSubject<List<CovidModel>>();

  Stream<List<CovidModel>> covidStream() => data.stream;

  fecthCovidData() async {
    List<CovidModel> covidModelList = await _repository.covidData();
    // logic
    data.sink.add(covidModelList);
  }
}
