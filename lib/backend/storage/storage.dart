import '../models/sort_by.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage
{
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  void addFavorite(final String countryName) async
  {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(countryName, countryName);
  }

  Future<bool> isFavorite(final String countryName) async
  {
    final SharedPreferences prefs = await _prefs;
    return  prefs.containsKey(countryName);
  }

  void removeFavorite(final String countryName) async
  {
    final SharedPreferences prefs = await _prefs;
    if(prefs.containsKey(countryName))
      prefs.remove(countryName);
  }

  ///
  void removeSortByParam() async
  {
    final SharedPreferences prefs = await _prefs;
    prefs.remove("SortBy");
  }

  void setSortByParam(final String param) async
  {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("SortBy", param);
  }

  Future<String> getSortByParam() async
  {
    final SharedPreferences prefs = await _prefs;
    for(String param in SortBy.parameters)
      if(prefs.getString("SortBy") == param)
        return param;
    return SortBy.parameters[0];
  }


  //theme
  void setIsDark(bool v) async
  {
     final SharedPreferences prefs = await _prefs;
     prefs.setBool("isDark", v);
  }
  Future<bool> isDark() async
  {
     final SharedPreferences prefs = await _prefs;
     return prefs.getBool("isDark") ?? false == true;
  }
}