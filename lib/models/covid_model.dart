class CovidModel {
  String? country;
  int? totalConfirmed;
  int? totalDeaths;
  String? date;

  CovidModel({this.country, this.totalConfirmed, this.totalDeaths, this.date});

  CovidModel.fromJson(Map map) {
    country = map["Country"];
    totalConfirmed = map["TotalConfirmed"];
    totalDeaths = map["TotalDeaths"];
    date = map["Date"];
  }
}
