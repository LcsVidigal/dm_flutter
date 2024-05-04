import 'package:dm_flutter/app.dart';
import 'package:dm_flutter/services/preferences.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.clear();

  Preferences pref = Preferences();
  bool login = await pref.verificaLogin();

  runApp(MyApp(
    isLogged: login,
  ));
}

