import 'package:flutter/material.dart';
import 'package:flutter_covid_app/view/world_states.dart';

class CountryCases extends StatefulWidget {
  String name;
  String image;
  int? totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  CountryCases({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<CountryCases> createState() => _CountryCasesState();
}

class _CountryCasesState extends State<CountryCases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .06),
                      ReusebleRow(
                          title: 'Cases', value: widget.totalCases.toString()),
                      ReusebleRow(
                          title: 'Deaths',
                          value: widget.totalDeaths.toString()),
                      ReusebleRow(
                          title: 'Recovered',
                          value: widget.totalRecovered.toString()),
                      ReusebleRow(
                          title: 'Critical', value: widget.critical.toString()),
                      ReusebleRow(
                          title: 'Active', value: widget.active.toString()),
                      ReusebleRow(
                          title: 'TodayRecovered',
                          value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
