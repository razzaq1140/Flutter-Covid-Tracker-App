import 'package:flutter/material.dart';
import 'package:flutter_covid_19_tracker_app/Models/WorldStatesModel.dart';
import 'package:flutter_covid_19_tracker_app/Services/states_services.dart';
import 'package:flutter_covid_19_tracker_app/Views/countries_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat();

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecord(),
                builder: (context, AsyncSnapshot<AutoGenerate> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                            double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                            double.parse(snapshot.data!.deaths.toString())
                          },
                          animationDuration: const Duration(milliseconds: 1400),
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width / 3.0,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          colorList: colorList,
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                              MediaQuery.of(context).size.height * 0.03),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseAbleRow(
                                    title: "Total",
                                    value: snapshot.data!.cases.toString()),
                                ReuseAbleRow(
                                    title: "Deaths",
                                    value: snapshot.data!.deaths.toString()),
                                ReuseAbleRow(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                ReuseAbleRow(
                                    title: "Active",
                                    value: snapshot.data!.active.toString()),
                                ReuseAbleRow(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString()),
                                ReuseAbleRow(
                                    title: "Today Deaths",
                                    value:
                                    snapshot.data!.todayDeaths.toString()),
                                ReuseAbleRow(
                                    title: "Today Recovered",
                                    value: snapshot.data!.todayRecovered
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
                                    builder: ((context) =>
                                    const CountriesList())));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text("Track Countries")),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseAbleRow extends StatelessWidget {
  String title, value;

  ReuseAbleRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
