import 'dart:convert';
import 'package:flutter_covid_19_tracker_app/Models/WorldStatesModel.dart';
import 'package:flutter_covid_19_tracker_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices{

  Future<AutoGenerate> fetchWorldStatesRecord() async{
    
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      return AutoGenerate.fromJson(data);
    }
    else{
      throw Exception("Error");
    }
    
  }



  Future<List<dynamic>> countriesLists() async{
    var data;
    var response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode == 200){

      data = jsonDecode(response.body.toString());

      return data;
    }
    else{
      throw Exception("Error");
    }

  }

}