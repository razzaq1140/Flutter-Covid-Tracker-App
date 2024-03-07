import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_19_tracker_app/Services/states_services.dart';
import 'package:flutter_covid_19_tracker_app/Views/detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.left_chevron),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Search with country name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.countriesLists(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context,index){
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(height: 10,width: 89,color: Colors.white,),
                                subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                leading: Container(height: 50,width: 50,color: Colors.white,),

                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data[index]["country"];
                          if(searchController.text.isEmpty){
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                  name: snapshot.data![index]['country'],
                                  image: snapshot.data[index]["countryInfo"]["flag"],
                                  active: snapshot.data![index]['active'],
                                  critical: snapshot.data![index]['critical'],
                                  test: snapshot.data![index]['tests'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  totalRecovered: snapshot.data![index]['recovered'],
                                  totalDeath: snapshot.data![index]['deaths'],
                                  totalCase: snapshot.data![index]['cases'],
                                )));
                              },
                              child: ListTile(
                                leading: Image(
                                  image: NetworkImage(
                                      snapshot.data[index]["countryInfo"]["flag"]),
                                  height: 50,
                                  width: 50,
                                ),
                                title: Text(snapshot.data[index]["country"]),
                                subtitle:
                                Text(snapshot.data[index]["cases"].toString()),
                              ),
                            );
                          }
                          else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                  name: snapshot.data![index]['country'],
                                  image: snapshot.data[index]["countryInfo"]["flag"],
                                  active: snapshot.data![index]['active'],
                                  critical: snapshot.data![index]['critical'],
                                  test: snapshot.data![index]['tests'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  totalRecovered: snapshot.data![index]['recovered'],
                                  totalDeath: snapshot.data![index]['deaths'],
                                  totalCase: snapshot.data![index]['cases'],
                                )));
                              },
                              child: ListTile(
                                leading: Image(
                                  image: NetworkImage(
                                      snapshot.data[index]["countryInfo"]["flag"]),
                                  height: 50,
                                  width: 50,
                                ),
                                title: Text(snapshot.data[index]["country"]),
                                subtitle:
                                Text(snapshot.data[index]["cases"].toString()),
                              ),
                            );
                          }
                          else{
                            return Container();
                          }

                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
