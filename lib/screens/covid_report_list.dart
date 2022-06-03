import 'package:flutter/material.dart';

import '../bloc/covid_bloc.dart';
import '../models/covid_model.dart';

class CovidReportList extends StatefulWidget {
  const CovidReportList({Key? key}) : super(key: key);

  @override
  State<CovidReportList> createState() => _CovidReportListState();
}

class _CovidReportListState extends State<CovidReportList> {
  CovidBloc covidBloc = CovidBloc();
  @override
  void initState() {
    covidBloc.fecthCovidData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<CovidModel>>(
        stream: covidBloc.covidStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data![index].country.toString()),
                      subtitle:
                          Text(snapshot.data![index].totalConfirmed.toString()),
                      trailing: Text(
                        snapshot.data![index].totalDeaths.toString(),
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                });
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
