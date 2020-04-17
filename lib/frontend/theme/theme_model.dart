import '../../backend/storage/storage.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';


class ThemeModel extends ChangeNotifier {
  Storage storage = new Storage();

  ThemeData currentTheme = lightTheme;
  ThemeModel()
  { 
    storage.isDark().then((isDark)
    {
      currentTheme = isDark ?? false ? darkTheme : lightTheme;
      notifyListeners();
    });
  }

  static ThemeType _currentThemeType = ThemeType.Dark;

  static bool isCurrentThemeDark()
  {
    return _currentThemeType == ThemeType.Dark;
  } 



  toggleTheme() 
  {
    if (_currentThemeType == ThemeType.Dark) 
    {
      currentTheme = lightTheme;
      _currentThemeType = ThemeType.Light;
      return notifyListeners();
    }

    if (_currentThemeType == ThemeType.Light) 
    {
      currentTheme = darkTheme;
      _currentThemeType = ThemeType.Dark;
      return notifyListeners();
    }
  }
}

