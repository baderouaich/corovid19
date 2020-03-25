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
}