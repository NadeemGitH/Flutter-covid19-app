import 'package:flutter/material.dart';
import 'package:flutter_covid_app/model/WorldStatesModel.dart';
import 'package:flutter_covid_app/services/states_services.dart';
import 'package:flutter_covid_app/view/countries_list.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
                future: statesServices.fetchWorldStatesRecord(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapShot) {
                  if (!snapShot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        controller: _controller,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapShot.data!.cases!.toString()),
                            "Recoverd": double.parse(
                                snapShot.data!.recovered!.toString()),
                            "Deaths":
                                double.parse(snapShot.data!.deaths!.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorlist,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.width * .06),
                          child: Card(
                            child: Column(
                              children: [
                                ReusebleRow(
                                    title: "Total",
                                    value: snapShot.data!.cases.toString()),
                                ReusebleRow(
                                    title: "Deaths",
                                    value: snapShot.data!.deaths.toString()),
                                ReusebleRow(
                                    title: "Recovered",
                                    value: snapShot.data!.recovered.toString()),
                                ReusebleRow(
                                    title: "Active",
                                    value: snapShot.data!.active.toString()),
                                ReusebleRow(
                                    title: "Criticle",
                                    value: snapShot.data!.critical.toString()),
                                ReusebleRow(
                                    title: "Today Deaths",
                                    value:
                                        snapShot.data!.todayDeaths.toString()),
                                ReusebleRow(
                                    title: "Today Recovered",
                                    value: snapShot.data!.todayRecovered
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountriesList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text('Track Contries'),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class ReusebleRow extends StatelessWidget {
  String title, value;
  ReusebleRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
