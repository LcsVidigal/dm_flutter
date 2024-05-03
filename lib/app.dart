import 'package:dm_flutter/homepage.dart';
import 'package:dm_flutter/tela_login/login_page_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLogged});

  final bool? isLogged;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case LoginPage.routeName:
                return const LoginPage();
              case HomePage.routeName:
                return const HomePage();
              default:
                if (isLogged!) {
                  return const HomePage();
                } else {
                  return const LoginPage();
                }
            }
          },
        );
      },
    );
  }
}
