import 'dart:convert';
import 'package:corovid19/backend/models/sort_by.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/country.dart';
import '../models/all_details.dart';
import '../storage/storage.dart';

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
        AllDetails data = await compute(parseDetailsThread, response.body);
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
  // A function that converts a response body into a AllDetails instance in an isolated thread which has its own memory to avoid performance issues.
  static AllDetails parseDetailsThread(String responseBody)
  {
    final parsed = json.decode(responseBody);
    return AllDetails.fromJson(parsed);
  }
  //////////////////////////////////////////////////////////



  /// Returns data of all countries that has COVID-19 ///
  // A function that converts a response body into a List<Country>.
  static Future<Map<String, dynamic>> getAllCountries(String sortBy) async
  {
    final String url = "$baseUrl/countries?sort=$sortBy";
    Storage storage = Storage();
    try
    {
      var response = await http.get(url);
      if(response.statusCode == 200)
      {
        List<Country> countries = await compute(parseCountriesThread, response.body);
        if(sortBy == SortBy.parameters[0]) // favorites
          {
            //sort by favs
            for(int i = 0; i < countries.length - 1; i++)
              {
                for(int j = i + 1; j < countries.length; j++)
                  {
                    if(await storage.isFavorite(countries[j].name))
                     {
                       //swap
                       Country temp = countries[i];
                       countries[i] = countries[j];
                       countries[j] = temp;
                     }

                  }
              }

          }
        defaultResponse["isError"] = false;
        defaultResponse["data"] = countries;
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
  // A function that converts a response body into a List<Country> in an isolated thread which has its own memory to avoid performance issues.
   static List<Country> parseCountriesThread(String responseBody)
   {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Country>((json) => Country.fromJson(json)).toList();
   }
  //////////////////////////////////////////////////////////


  /// Returns data of all countries that has COVID-19
 /* static Future<Map<String, dynamic>> getAllCountries() async
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
  }*/


  /// Returns data of a specific country. If an exact name match is desired pass ?strict=true in the query string
  static Future<Map<String, dynamic>> getCountry(String countryName) async
  {
     String url = "$baseUrl/countries/$countryName";
    try
    {
      var response = await http.get(url);
      if(response.statusCode == 200)
      {
        Country data = await compute(parseCountryThread, response.body);
        print("Country data are: ${data.cases}");
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
  // A function that converts a response body into a Country in an isolated thread which has its own memory to avoid performance issues.
  static Country parseCountryThread(String responseBody)
  {
    final parsed = json.decode(responseBody);
    return Country.fromJson(parsed);
  }
  //////////////////////////////////////////////////////////



/////////////////  RUN CODE WITH ISOLATE ( has its own memory thread ) to avoid app lagging.///////////////////////////////
static Future<dynamic> decodeJsonInBackground(dynamic responseBody) async
{
  return compute(backgroundTask, responseBody);
}
static Future<dynamic> backgroundTask(dynamic responseBody) async
{
  //every code inside this function will run in an isolate.
  return await json.decode(responseBody);
}
/////////////////////////////////////////////////////////////////////////////////////////////////

}