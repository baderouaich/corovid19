import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/country.dart';

class Api
{
  static const String baseUrl = "https://corona.lmao.ninja";
  static Map<String, dynamic> defaultResponse =
  {
    "isError": false,
    "message": "",
    "data": ""
  };

  /// Returns all total cases, recovery, and deaths.
  static Future<Map<String, dynamic>> getAll() async
  {
    const String url = "$baseUrl/all";
    try
    {
      var response = await http.get(url);
      if(response.statusCode == 200)
      {
        var data = await decodeJsonInBackground(response.body);
        defaultResponse["isError"] = false;
        defaultResponse["data"] = data;
      }
      else
      {
        defaultResponse["isError"] = true;
        defaultResponse["message"] = "Failed to get data from the API, please try again later.\nAPI Error Staus Code: ${response.statusCode}";
      }
    }
    catch(error)
    {
      defaultResponse["isError"] = true;
      defaultResponse["message"] = error.toString();
    }
    return defaultResponse;
  }



  /// Returns data of all countries that has COVID-19
  static Future<Map<String, dynamic>> getAllCountries() async
  {
    const String url = "$baseUrl/countries";
    try
    {
      var response = await http.get(url);
      if(response.statusCode == 200)
      {
        var data = await decodeJsonInBackground(response.body);
        defaultResponse["isError"] = false;
        defaultResponse["data"] = data;
      }
      else
      {
        defaultResponse["isError"] = true;
        defaultResponse["message"] = "Failed to get data from the API, please try again later.\nAPI Error Staus Code: ${response.statusCode}";
      }
    }
    catch(error)
    {
      defaultResponse["isError"] = true;
      defaultResponse["message"] = error.toString();
    }
    return defaultResponse;
  }


  /// Returns data of a specific country. If an exact name match is desired pass ?strict=true in the query string
  static Future<Map<String, dynamic>> getCountry(final String countryName) async
  {
    final String url = "$baseUrl/countries/$countryName";
    try
    {
      var response = await http.get(url);
      if(response.statusCode == 200)
      {
        var data = await decodeJsonInBackground(response.body);
        defaultResponse["isError"] = false;
        defaultResponse["data"] = data;
      }
      else
      {
        defaultResponse["isError"] = true;
        defaultResponse["message"] = "Failed to get data from the API, please try again later.\nAPI Error Staus Code: ${response.statusCode}";
      }
    }
    catch(error)
    {
      defaultResponse["isError"] = true;
      defaultResponse["message"] = error.toString();
    }
    return defaultResponse;
  }




/////////////////  RUN CODE WITH ISOLATE ( has its own memory thread ) to avoid app lagging.///////////////////////////////
static Future<dynamic> decodeJsonInBackground(dynamic responseBody) async
{
  return compute(backgroundTask, responseBody);
}
static  Future<dynamic> backgroundTask(dynamic responseBody) async
{
  //every code inside this function will run in an isolate.
  return await json.decode(responseBody);
}
/////////////////////////////////////////////////////////////////////////////////////////////////

}