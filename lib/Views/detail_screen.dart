import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_19_tracker_app/Views/world_states.dart';

class DetailScreen extends StatefulWidget {

  String name , image;
  int totalCase , totalDeath , totalRecovered , active , critical , todayRecovered , test;

   DetailScreen(
  {
    required this.name,
    required this.image,
    required this.totalCase,
    required this.totalDeath,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(CupertinoIcons.left_chevron),onPressed: (){Navigator.pop(context);},),
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child:
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                      ReuseAbleRow(title: "Cases", value: widget.totalCase.toString()),
                      ReuseAbleRow(title: "Deaths", value: widget.totalDeath.toString()),
                      ReuseAbleRow(title: "Recovered", value: widget.totalRecovered.toString()),
                      ReuseAbleRow(title: "Active", value: widget.active.toString()),
                      ReuseAbleRow(title: "Critical", value: widget.critical.toString()),
                      ReuseAbleRow(title: "Today Recovered", value: widget.todayRecovered.toString()),
                      ReuseAbleRow(title: "Test", value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),)

            ],
          ),
        ],
      ),
    );
  }
}
